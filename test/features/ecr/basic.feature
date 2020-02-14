Feature: Typical successful instances of the ecr module.
    Background:
        Given the following variables
            | key | value |
            #--|--|
            | name | behave-test-ecr-${random:10} |

    Scenario: Simple Configuration
        Given terraform module 'ecr'
            | key    | value               |
            #--------|---------------------|
            | name   | "${var.name}" |
        
        When we run terraform plan
        #This step should be run by the step below
        #  print this table in debug mode in below step
        #  essentially make this a substep to below step
        #Then terraform performed these resource actions
        #    | action    | count |
        #    #-----------|-------|
        #    | created   | 1     |
        #    | updated   | 0     |
        #    | destroyed | 0     |
        
        Then terraform plans to perform these exact resource actions
            | action | resource                 | name    | count |
            #--------|--------------------------|---------|-------|
            | create | aws_ecr_repository       | default |       |
            |        | aws_ecr_lifecycle_policy | default |       |
            
        Then terraform resource 'aws_ecr_repository' 'default' has changed attributes
            | key  | value             |
            #------|-------------------|
            | name | ${var.name} |
            
        # diff output (subset?)
        Then terraform resource 'aws_ecr_lifecycle_policy' 'default' 'policy' JSON equals file '../../../lifecycle.json'
    
    
    Scenario: Disable lifecycle policy
        Given terraform module 'ecr'
            | key                      | value               |
            #--------------------------|---------------------|
            | name                     | "${var.name}" |
            | disable_lifecycle_policy | "true"          |
        
        When we run terraform plan
        Then terraform plans to perform these exact resource actions
            | action | resource                 | name    | count |
            #--------|--------------------------|---------|-------|
            | create | aws_ecr_repository       | default |       |
        
        Then terraform resource 'aws_ecr_repository' 'default' has changed attributes
            | key  | value             |
            #------|-------------------|
            | name | ${var.name} |
        
    
    Scenario: Alternative lifecycle policy path/file
        Given terraform module 'ecr'
            | key | value |
            #--------------------------|---------------------|
            | name                     | "${var.name}" |
            | lifecycle_policy_path    | "alt_policy.json"   |
        
        Given terraform file paths
            | src             | dst             |
            #-----------------|-----------------|
            | alt_policy.json | alt_policy.json |
        
        When we run terraform plan
        Then terraform resource 'aws_ecr_lifecycle_policy' 'default' 'policy' JSON equals file 'alt_policy.json'
        Then terraform plans to perform these exact resource actions
            | action | resource                 | name    | count |
            #--------|--------------------------|---------|-------|
            | create | aws_ecr_repository       | default |  |
            |        | aws_ecr_lifecycle_policy | default |  |
        

    Scenario Outline: Add readers OR writers
        Given terraform module 'ecr'
            | key                      | value               |
            #--------------------------|---------------------|
            | name                     | "${var.name}" |
        
        # Write to tfvars as you go

        Given terraform list '<list_name>'
            | value                            |
            #----------------------------------|
            | "arn:aws:iam::224588347132:root" |
            | "arn:aws:iam::378517677616:root" |
        
        When we run terraform plan

        Then terraform plans to perform these exact resource actions
            | action | resource                 | name    | count |
            #--------|--------------------------|---------|-------|
            | create | aws_ecr_repository       | default |       |
            |        | aws_ecr_lifecycle_policy | default |       |
            |        | aws_ecr_repository_policy| <list_name> |       |
        
        Then terraform resource 'aws_ecr_repository_policy' '<list_name>' 'policy' JSON equals file '<list_name>.json'
        
        Examples: placeholder text
            | list_name |
            #-----------|
            | readers   |
            | writers   |
    
    
    Scenario: Add readers AND writers
        Given terraform module 'ecr'
            | key                      | value               |
            #--------------------------|---------------------|
            | name | "${var.name}" |
        
        # Write to tfvars as you go

        Given terraform list 'readers'
            | value                            |
            #----------------------------------|
            | "arn:aws:iam::224588347132:root" |
            | "arn:aws:iam::378517677616:root" |

        Given terraform list 'writers'
            | value                            |
            #----------------------------------|
            | "arn:aws:iam::224588347132:root" |
            | "arn:aws:iam::378517677616:root" |
        
        When we run terraform plan

        Then terraform plans to perform these exact resource actions
            | action | resource                 | name    | count |
            #--------|--------------------------|---------|-------|
            | create | aws_ecr_repository       | default |       |
            |        | aws_ecr_lifecycle_policy | default |       |
            |        | aws_ecr_repository_policy| readers_writers |       |
        
        Then terraform resource 'aws_ecr_repository_policy' 'readers_writers' 'policy' JSON equals file 'readers_writers.json'
        
