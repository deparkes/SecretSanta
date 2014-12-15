#secret santa in python

import random
import smtplib
import time



#You have to fill this bit in yourself
testfile = './namesandemails.txt'
santamail = 'secret.santa@gmail.com'
year = 2015
username = 'secret.santa@gmail.com'
password = 'hohoho'



#Define functions
def loadpeople(loadtarget):

    f = open(loadtarget)

    rawresult = f.read()

    stringresult = rawresult.split('\n')
    #stringresult = rawresult.split(' ')

    names = []
    emails = []

    for i in stringresult:
        [name, email] = i.split(' ')
        names.append(name)
        emails.append(email)


    return [names, emails]


def matchsantas(names, emails):

    shrinknames = names
    shrinkemails = emails

    
    selected = False
    while selected == False:
        indexes = range(len(names))
        emaillist = []
        givers = []
        for i in range(len(names)):
            
            
            
            theseindexes = indexes
            
            #this is where we randomise who gets who
            random.shuffle(theseindexes)



            if theseindexes[0] == i:
                #if you randomly get yourself go to the next person
                #in the list
                if len(theseindexes) != 1:
                    givers.append(names[theseindexes[1]])
                    emaillist.append(emails[theseindexes[1]])
                    indexes.remove(theseindexes[1])
                else:
                    #If the last person in the list get's themselves
                    #void the list and try again
                    emaillist.append('Void')
            else:
                givers.append(names[theseindexes[0]])
                emaillist.append(emails[theseindexes[0]])
                indexes.remove(theseindexes[0])


        #if the last person on the list did'nt get themselves break
        #out of the while loop
        if 'Void' not in emaillist:
            selected = True

    return [names, givers, emaillist]

def createemails(secretsantaemail, year, recevers, givers, giversemails):

    msgs = []

    for i in range(len(recevers)):
         msg = "\r\n".join(["From: " + secretsantaemail,
                            "To: " + giversemails[i],
                            "Subject: Physics secret santa " + repr(year),
                            "",
                            "Ho Ho Ho " + givers[i] + " you'll be buying a present for " + recevers[i] + "!",
                            "MERRY CHRISTMAS!!!",
                            "Santa xox"
                            ])
         msgs.append(msg)

    return msgs
    

def sendemails(msgs, giversemails, username,password):

    for i in range(len(msgs)):

        # The actual mail send
        server = smtplib.SMTP('smtp.gmail.com:587')
        server.ehlo()
        server.starttls()
        server.login(username,password)
        #print 'connected'
        server.sendmail(username, giversemails[i], msgs[i])
        #print 'sent'
        server.quit()





#This should all be ok for you to just ignore
[names, emails] = loadpeople(testfile)
print 'Checking lists...'
time.sleep(2)

[recevers ,givers, giversemails] = matchsantas(names, emails)
print 'Whipping elves...'
time.sleep(3)

mesgs = createemails(santamail, year, recevers, givers, giversemails)
print 'Muzzelling reindeer...'

time.sleep(2)

print 'Distributing coal...'
sendemails(mesgs, giversemails, username, password)


#time.sleep(2)


msgs = []
giversemails= []
givers = []
recevers = []
print 'Covering tracks...'

time.sleep(3)

print 'All done, Tis\' sherry o\'clock'
