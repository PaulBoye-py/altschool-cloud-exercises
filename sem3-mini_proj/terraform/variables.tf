# variable "access_key" {
#     default = "AKIA46KPWTQWBVH3JWOD"
# }

# variable "secret_key" {
#     default = "/7GYmPPm0ibyyFXJ+ty4lr8d4WzulFy9LxUAdRkF"
# }

variable "key_pair" {
  sensitive = true
  type = string
}