variable "bitgouel_access_key" {
    type = string
    default = "bitgouel_access_key"
}

variable "bitgouel_secret_key" {
    type = string
    default = "bitgouel_secret_key"
}

variable "db_password" {
    description = "rds root user password"
    type = string
}

variable "user_name" {
    type = string
}

