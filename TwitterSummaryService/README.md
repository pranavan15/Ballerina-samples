# Twitter Summary Service build using Twitter Connector
Following guide walks you through the steps of creating a service, which consumes Twitter API by using Ballerina Twitter Connector. A connector allows you to interact mainly with third-party APIs. This enables you to connect and interact with APIs such as Twitter, Gmail, and Facebook easily.

## What you'll build
You'll build a service, which can be consumed by users to get his/her twitter account summary.  
Service has three resources, which are consumable through HTTP POST requests. 
Eg:
```
http://localhost:9090/twitterSummary/getTweetsByTime
```

When initiating these requests, user needs to send his Access Token, Access Token Secret in the request body with Application/JSON content type.


## Before you begin:  What you'll need
- About 15 minutes
- A favorite text editor or IDE
- JDK 1.8 or later
- Ballerina Distribution (Install Instructions:  https://ballerinalang.org/docs/quick-tour/quick-tour/#install-ballerina)
- You can import or write the code straight on your text editor/Ballerina Composer


### Running Service in Composer
Start Composer https://ballerinalang.org/docs/quick-tour/quick-tour/#run-the-composer
Navigate to File -> Open Program Directory, and pick the project folder (hello-ballerina).

Click on **Run**(Ctrl+Shift+R) button in the tool bar.


### Running in Intellij IDEA
<TODO>

### Running in VSCode
<TODO>


## Test the Service

## Writing Test cases

## Creating Documentation

## Run Service on Docker

## Run Service on Cloud Foundry

