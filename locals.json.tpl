{
    "environment": "${lower(environment)}",
    "prefix": "${lower(prefix)}",
    "application": "${lower(application)}",
    %{~ if length (project)>0 ~}"project_name": "${lower(project)}",%{~ endif ~}
    "custom_name": "${lower(custom_name)}",
    "name_prefix": "${lower(join(s,[prefix,location_code, environment]))}${s}${length(custom_name) > 0 ? lower(join(s, [application, custom_name])) : lower(application) }",
    "global_tags": {
      "ORG:ApplicationName": "${application}",
      %{~ if length (customer)>0 ~}"ORG:Customer": "${customer}",%{~ endif ~}
      %{~ if length (businessunit)>0 ~}"ORG:BusinessUnit": "${businessunit}",%{~ endif ~}
      %{~ if length (project)>0 ~}"ORG:ProjectName": "${project}",%{~ endif ~}
      %{~ if length (owner)>0 ~}"ORG:Owner": "${owner}",%{~ endif ~}
      %{~ if length (dcl_class)>0 ~}"SEC:DCL": "${dcl_class}",%{~ endif ~}
      %{~ if length (costcenter)>0 ~}"ORG:CostCenter": "${costcenter}",%{~ endif ~}
      "OPS:Environment": "${upper(environment)}",
      "OPS:State": "${productive ? "PROD" : "NONPROD"}"
    }
}
