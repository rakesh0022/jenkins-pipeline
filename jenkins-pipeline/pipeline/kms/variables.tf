variable "project_id" {
    description = "project_id"
    type = string
}

variable "key_ring" {
    type = string
  
}

variable "key_name" {
    type = string
  
}

variable "iam_role_member" {
    type = map(list(string))
    default = {}
  
}

variable "use_iam_binding" {
    type = bool
    default = true
  
}

variable "purpose" {
  type = string
  default = "ENCRYPT_DECRYPT"

}

variable "rotation_period" {
    type = string
    default = "7776000s"
  
}

variable "algorithm" {
    type = string
    default = "null"
  
}
variable "protection_level" {
    type = string
    default = "HSM"
  
}

variable "labels" {
    type = map(string)
    default = {}
  
}

variable "destroy_Schedule_Duration" {

    type = number
    default = 14
  
}