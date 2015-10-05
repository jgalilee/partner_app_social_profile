# Heroku Connect &mdash; Social Login

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Configuration

Getting the application running on Heroku is relatively straight forward however there are two parts to it. First, you will need to configure Heroku Connect. Second you will need to setup your Facebook development application.

### Part 1

Setting up Heroku Connect is relatively straight forward. The demo application does not require you to create any additional fields. The Salesforce object that you need to synchronise is the **Contact** model with the following fields.

1.  Birthdate
2.  Email
3.  FirstName
4.  LastName
5.  MailingCity
6.  MailingCountry
7.  MailingPostalCode
8.  MailingState
9.  MailingStreet
10. Name

_**Note**: The application makes the assumption that you're going to define your Salesforce Heroku Connect schema as `salesforce`._

### Part 2

Setting up your Facebook development application is reasonably straight forward. Assuming you've managed to get Part 1 completed successfully when you visit your Heroku application for the first time it will walk you through setting up your Facebook application for use with the demo application.

## Development

### Heroku Connect Sync

Since Heroku Connect is a black box it can be difficult to write tests for code that utilizes it. In order to get around this limitation it is possible to dump the data to local storage and create a local database.

The logic for doing this is encapsulated within the `rake heroku:sync` task. The only dependencies are that you have postgres installed locally and you can login to `psql` with your local user (`whoami`). If your local user is secured you may need to modify the script.

### Requirements

As of the time of writing the following dependencies were used for development:

- Ruby 2.2.3p173
- Rails 4.2.4
- PostgreSQL 9.4.4