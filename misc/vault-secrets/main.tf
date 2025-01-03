module "create-secrets" {
  for_each = var.secrets
  source   = "./create-secrets"
  kv_path  = each.key
  secrets  = each.value
}




variable "secrets" {
  default = {
    infra = {
      ssh = {
        admin_username = "roboshop-ansible",
        admin_password = "DevOps@123456"
      }
    }
    roboshop-dev = {
      frontend = {
        catalogue_endpoint = "http://catalogue-dev.azdevopsb82.online:8080"
        cart_endpoint      = "http://cart-dev.azdevopsb82.online:8080"
        user_endpoint      = "http://user-dev.azdevopsb82.online:8080"
        payment_endpoint   = "http://payment-dev.azdevopsb82.online:8080"
        shipping_endpoint  = "http://shipping-dev.azdevopsb82.online:8080"
      }
      catalogue = {
        MONGO     = "true"
        MONGO_URL = "mongodb://mongodb-dev.azdevopsb82.online:27017/catalogue"
      }
      user = {
        MONGO     = "true"
        REDIS_URL = "redis://redis-dev.azdevopsb82.online:6379"
        MONGO_URL = "mongodb://mongodb-dev.azdevopsb82.online:27017/users"
      }
      cart = {
        REDIS_HOST     = "redis-dev.azdevopsb82.online"
        CATALOGUE_HOST = "catalogue-dev.azdevopsb82.online"
        CATALOGUE_PORT = "8080"
      }
      shipping = {
        CART_ENDPOINT = "cart-dev.azdevopsb82.online:8080"
        DB_HOST       = "mysql-dev.azdevopsb82.online"
      }
      payment = {
        CART_HOST = "cart-dev.azdevopsb82.online"
        CART_PORT = "8080"
        USER_HOST = "user-dev.azdevopsb82.online"
        USER_PORT = "8080"
        AMQP_HOST = "rabbitmq-dev.azdevopsb82.online"
        AMQP_USER = "roboshop"
        AMQP_PASS = "roboshop123"
      }
      mysql = {
        MYSQL_ROOT_PASSWORD = "RoboShop@1"
      }
      rabbitmq = {
        AMQP_USER = "roboshop"
        AMQP_PASS = "roboshop123"
      }
    }
  }
}


