SecretSanta
===========
Do you enjoy Secret Santa, but are concerned about people finding out which present you bought? 

Then add some security to your festive fun with the Double Blind Secret Santa Code for Matlab!


Requirements
-----------
- Matlab
- Internet access
- Novelty gmail account

How to use
----------
Set up a suitable novelty gmail account, such as santa_loves_christmas@gmail.com

Make a text file called "email_login.txt" which contains your novelty account username and password, like this:

username password

Create a text file called secret_santa_list.txt which contains the names an email addresses of your secret santas, like this:

name email_address

Run secret_santa.m to unleash festive cheer on your santas.

The code will delete all record of the randomisation, so there is no way anyone can find out who is buying for whom!*


Known Issues:
------------
There are sometimes problems with connecting to the email account through proxy networks.

* Actually, yes they can - the sent items log will show the messages sent out to your santas.

# About
Original Code by Mark Patton. Modifications and publication by Duncan Parkes.
