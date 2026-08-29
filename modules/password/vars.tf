variable password_name {
  description = "The name of the generated password."
  type        = string
}

variable password_length {
  description = "The length of the generated password."
  type        = number
  default     = 16
}

variable password_special_characters {
  description = "The special characters to include in the generated password."
  type        = string
  default     = "!@#$%^&*()-_=+[]{}|;:,.<>?/"
}
