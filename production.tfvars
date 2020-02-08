aws_region = "ap-southeast-1"

# Bot
bot_function_name = "bot"
bot_function_memory_size = 1600
bot_role_name_prefix     = "bot-role-"

# Bot event
bot_event_prefix            = "bot-event-"
bot_event_schedule          = "cron(0 0 ? * * *)"
bot_event_permission_prefix = "bot-event-"

# Chrome AWS Lambda layer
chrome_layer_bucket_prefix = "chrome-layer"
chrome_layer_name          = "chrome_layer"