module "shared_vars" {
    source = "../shared_vars"
    
}


# resource "aws_wafv2_regex_pattern_set" "LanguagesDRT" {
#   name  = "LanguagesDRT"
#   scope = "REGIONAL"

#   regular_expression {
#     regex_string = "/[en|ar|fr|fa|de|it|ru|es|tr]{2}"
#   }
# }

resource aws_wafv2_web_acl tf_waf {
  name        = "project-${module.shared_vars.env_suffix}"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "sample"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWS-AWSManagedRulesAnonymousIpList"
    priority = 3

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesAnonymousIpList"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesAmazonIpReputationList"
    priority = 4

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesAmazonIpReputationList"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 5

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
    priority = 6

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 7

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
        excluded_rule {
          name = "SizeRestrictions_BODY"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }
#   rule {
#     name     = "DRT-HTTPFloodRuleLang"
#     priority = 1

#     action {
#       block {}
#     }

#     statement {
#       rate_based_statement {
#         limit              = 300
#         aggregate_key_type = "IP"

#         scope_down_statement {
#           regex_pattern_set_reference_statement {
#             arn = aws_wafv2_regex_pattern_set.LanguagesDRT.arn

#             field_to_match {
#               uri_path {
                
#               }
#             }

#             text_transformation {
#               priority = 0
#               type     = "NONE"
#             }
#           }
          
#         }     
#       }
#     }
#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "DRT-HTTPFloodRuleLang"
#       sampled_requests_enabled   = true
#     }
# }
}
