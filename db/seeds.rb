user1 = User.create({email: "virgifp@yahoo.es",city: "Madrid", cp: 28042,password: "AriSele2015"})
  conversation1 = Conversation.create({title: "javascript",body: "exchange for the Madrid areaMadrid"})
    comment1 = Comment.create({body: "tell me when is ok for you to meet"})
    comment3 = Comment.create({body: "speak to you soon"})

conversation1.comments << comment1 
conversation1.comments << comment3 
user1.conversations << conversation1 


user2 = User.create!(email: "tonip@toni.es",city: "Madrid", cp: 28042,password: "tonitoni")
  comment2 = Comment.create(body: "for me would be perfect next friday")

user2.comments << comment2 
conversation1.comments << comment2

