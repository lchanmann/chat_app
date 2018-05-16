# README

This is a simple real-time chat application featuring public chatroom where Bob bot, a message responder, lives and private messaging to user.

This application use [Action Cable](https://github.com/rails/rails/tree/master/actioncable) for real-time messaging and [Vue.js](https://vuejs.org/) for frontend chat view interface.


## Bot bot

Bot bot is a message responder bot that reply with canned responses as follow:
- Bob answers 'Sure.' if you ask him a question.
- He answers 'Woah, chill out!' if you yell at him (ALL CAPS).
- He says 'Fine. Be that way!' if you address him without actually saying anything.
- He answers 'Whatever.' to anything else.

`BobBot` class can be found at `lib/bob_bot.rb`. It uses [Visitor pattern](https://en.wikipedia.org/wiki/Visitor_pattern) to decide which response to give instead of hard-coded using condition expressions (`if`, `unless` or `case`).

## Public chatroom

A public chatroom does not require user to login to use. When joining a numbered username (e.g. User1234) will be assigned the browser session and messages send by the user will be prefixed with the assigned username (e.g. User1234: hello).

Bob bot is listening to public chatroom and will respond to any message sent to the chatroom.

![Public Lobby](https://github.com/lchanmann/chat_app/raw/master/doc/resources/public_lobby.gif)

## Private conversation (user <-> user)

A private conversation requires login and allows for user to user messaging. A user can also send private message to Bot bot.

![Public Lobby](https://github.com/lchanmann/chat_app/raw/master/doc/resources/private_message.gif)

## Running the app

Clone the repo:

    git clone https://github.com/lchanmann/chat_app.git
    cd chat_app

Install dependencies

    bundle install
    yarn install

Setup database

    rake db:setup

Compile client app

    bin/webpack

Run server app

    rails s


## Running tests

All tests can be found in `spec` directory.

To run all server-side tests in `models`, `lib`, `channels` and `controllers`, run:

    rspec

To run client-side tests in `javascript`, run:

    yarn test
