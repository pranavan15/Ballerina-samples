# Transaction Processing Using Ballerina
This is a usecase exampe that explains How to manage transactions in Ballerina language (https://ballerinalang.org).

# About This Service 
This is a sample application, which is written using Ballerina language. This application will demonstrate the usage of 
ballerina language to handle SQL transactions easily.

# How to Deploy
1) Go to http://www.ballerinalang.org and click Download.
2) Download the Ballerina Tools distribution and unzip it on your computer. Ballerina Tools includes the Ballerina runtime plus
the visual editor (Composer) and other tools.
3) Add the <ballerina_home>/bin directory to your $PATH environment variable so that you can run the Ballerina commands from anywhere.
4) After setting up <ballerina_home>, navigate to the folder containing `songLyricsService.bal` file and run: `$ ballerina run UserRegistration.bal` 

# Response You Will Get

```
2018-01-08 23:34:40,469 INFO  [transactions] - 'Alice' and 'Bob' have succesfully registered 
2018-01-08 23:34:40,471 INFO  [transactions] - Transaction committed 
2018-01-08 23:34:40,665 INFO  [transactions] - Registered users: [{"USERNAME":"Alice"},{"USERNAME":"Bob"}] 
2018-01-08 23:34:40,666 INFO  [transactions] - Expected Results: You should see 'Alice' and 'Bob'
 
2018-01-08 23:34:40,684 ERROR [transactions] - Transaction failed 
2018-01-08 23:34:40,685 INFO  [transactions] - Above error occured as expected: username 'Alice' is already taken 
2018-01-08 23:34:40,686 INFO  [transactions] - Registered users: [{"USERNAME":"Alice"},{"USERNAME":"Bob"}]
Expected Results: You shouldn't see 'charles'. Attempt to reuse username 'Alice' is a DB constraint violation. Therefore, Charles was rolled back in the same TX
 
2018-01-08 23:34:40,691 ERROR [transactions] - Transaction failed 
2018-01-08 23:34:40,691 INFO  [transactions] - Above error occured as expected: username is too big (Atmost 10 characters) 
2018-01-08 23:34:40,692 INFO  [transactions] - Registered users: [{"USERNAME":"Alice"},{"USERNAME":"Bob"}]
Expected Results: You shouldn't see 'Dias' and 'UserWhoLovesCats'. 'UserWhoLovesCats' violated DB constraints, and 'Dias' was rolled back in the same TX
```
