resource "google_kms_crypto_key" "crypto_key" {
    name = var.key_name
    key_ring = var.key_ring
    destroy_Schedule_Duration = var.destroy_Schedule_Duration

    purpose = var.purpose

    version_template {
        algorithm = local.algorithm
        protection_level = var.protection_level
    

    }

    rotation_period = var.rotation_period

    lifecycle {
      prevent_destroy = false
    }
    labels = local.labels

}

 

 resource "google_kms_crypto_key_iam_member" "iam_member" {
     for_each = var.use_iam_binding ? {} : local.iam_additive
     crypto_key_id = google_kms_crypto_key.crypto_key.self_link
     role = each.value["role"]
     member = each.value["member"]

   
 }

 resource "google_kms_crypto_key_iam_binding" "owners" {

     for_each = var.use_iam_binding ? var.iam_role_member : {}
     crypto_key_id = google_kms_crypto_key.crypto_key.self_link
     role = each.key
     members = each.value

   
 }