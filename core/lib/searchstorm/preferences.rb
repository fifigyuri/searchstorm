require 'configliere'

#default settings
Settings.use :commandline

Settings({
  :max_number_of_articles_per_newsupdate => 10,
  :max_size_of_a_mail_in_characters => 20000,
  :newsupdate_recent_number_of_days => 2,
  :query_augment_partial => '',
  :email_sender_address => 'sender@example.com',
  :prod_bcc_control_address => nil,
  :testing_email_recipient_address => 'testingrecipient@example.com',
  :delivery_of_recent_news_needs_approval => false
})
