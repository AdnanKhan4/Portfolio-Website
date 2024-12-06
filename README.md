# portfolio_web

A new Flutter project.



## Setup Instructions

To run Contact Form EmailJS, you need to set up your environment variables. Follow these steps:

1. Create a file named `env_config.dart` in the `lib` folder.
2. Copy the content from `env_config_template.dart` and paste it into your new `env_config.dart` file.
3. Replace the placeholder values with your actual keys:
   - `serviceId`: Your EmailJS service ID.
   - `templateId`: Your EmailJS template ID.
   - `userId`: Your EmailJS user ID.

   Example:
   ```dart
   const String serviceId = "your_service_ID";
   const String templateId = "your_template_ID";
   const String userId = "your_user_ID";
