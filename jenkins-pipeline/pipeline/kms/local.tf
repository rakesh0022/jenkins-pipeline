data "google_project" "project" {
    project_id = var.project_id
  
}

locals {
  
  purpose = var.purpose != "" ? var.purpose : ENCRYPT_DECRYPT
  rotation_period = local.purpose == "ENCRYPT_DECRYPT" ? var.rotation_period : null


iam_additive_pairs = flatten ([
    for role in keys(var.iam_role_members) : [
     for member in lookup(var.iam_role_members, role, []) :
     { role = role, member = member}
    
]
])

iam_additive = {
    for pair in local.iam_additive_pairs :
    "${pair.role}-${pair.member}" => pair

}


default_algorithms = {
    ENCRYPT_DECRYPT = "GOOGLE_SYMETRIC_ENCRYPTION",
    ASYMMETRIC_SIGN = "EC_SIGN_P256_SHA256",
    ASYMMETRIC_DECRYPT = "RSA_DECRYPT_OAEP_3072_SHA256"
    
}

algorithm = var.algorithm == null ? local.default_algorithms[local.purpose] : var.algorithm

labels = merge(data.google_projecr.project.labels, var.labels)

}