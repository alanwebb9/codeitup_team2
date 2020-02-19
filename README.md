# codeitup_team2

### Description
So we have tried making a kind of a public safety mobile application. The functionality of the application includes showing most government services around you (The csv we got from the site had only dublin data and some facilities had weird coordinates so data may not be as proper as we had hoped).

We also have an emergency button that when you press and hold for 3 seconds shows an alert about the message being broadcasted. (Ideally we will have the garda taking a look at their database or somewhere for new requests)

What we have done is that in the mobile app we have some static data that initially renders everything. In the background we will hit the rest api from the server to get updated data if any exists. (Again, right now we are fetching all the data and ideally we will have only the changes)
