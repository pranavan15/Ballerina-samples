# Twitter Summary Service
This usecase example explains how to write a service whose integration and service logic are separated.

This service consumes Twitter API by using Ballerina Twitter Connector. This is where the integration is handled. A connector allows you to interact mainly with third-party APIs. This enables you to connect and interact with APIs such as Twitter, Gmail, and Facebook easily. 

Service logic is separately handled in `twitterSummaryService.bal` file. 

This implementation allows a user to do perform several twitter actions through TwitterSummaryService written using Ballerina language. 

## What You Will Build
You'll build a service, which can be consumed by users to get his/her twitter account summary.  
Service has three resources, which are consumable through HTTP POST requests. 
Eg:
```
http://localhost:9090/twitterSummary/getTweetsByTime
```

When initiating these requests, user needs to send his Access Token, Access Token Secret in the request body with Application/JSON content type.

# How to Deploy
1) Go to http://www.ballerinalang.org and click Download.
2) Download the Ballerina Tools distribution and unzip it on your computer. Ballerina Tools includes the Ballerina runtime plus
the visual editor (Composer) and other tools.
3) Add the <ballerina_home>/bin directory to your $PATH environment variable so that you can run the Ballerina commands from anywhere.
4) After setting up <ballerina_home>, navigate to the folder containing `songLyricsService.bal` file and run: `$ ballerina run twitterSummaryService.bal` 

5) How to interact with this web service, 
* To get tweets with time                         - POST `localhost:9090/twitterSummary/getTweetsWithTime`
* To get all your followers                       - POST `localhost:9090/twitterSummary/getFollowers`
* To get all the people whom you are following    - POST `localhost:9090/twitterSummary/getFollowingFriends`

6) Responses for above requst will be in application/json format


