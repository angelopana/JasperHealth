variable "access_key" {
  type = string
  sensitive = true
}

variable "secret_access_key" {
    type = string
    sensitive = true
}

variable "lambda_function_name" {
  default = "lambda_jasper_function"
}