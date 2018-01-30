# Transaction Processing Using Ballerina
This is a usecase example that explains How to manage transactions in Ballerina language (https://ballerinalang.org).

# About This Service 
This is a sample application, which is written using Ballerina language. This application will demonstrate the usage of 
ballerina language to handle SQL transactions easily.

# How to Deploy
1) Go to http://www.ballerinalang.org and click Download.
2) Download the Ballerina Tools distribution and unzip it on your computer. Ballerina Tools includes the Ballerina runtime plus
the visual editor (Composer) and other tools.
3) Add the <ballerina_home>/bin directory to your $PATH environment variable so that you can run the Ballerina commands from anywhere.
4) After setting up <ballerina_home>, navigate to the folder containing `UserRegistration.bal` file and run: `$ ballerina run UserRegistration.bal` 

# Response You Will Get

```
2018-01-30 10:01:27,870 INFO  [] - ---------------------------------- Transaction 1 ---------------------------------- 
2018-01-30 10:01:27,887 INFO  [] - 'Alice' and 'Bob' have succesfully registered 
2018-01-30 10:01:27,889 INFO  [] - Transaction committed 
2018-01-30 10:01:28,087 INFO  [] - Registered users: [{"USERNAME":"Alice"},{"USERNAME":"Bob"}] 
2018-01-30 10:01:28,088 INFO  [] - Expected Results: You should see 'Alice' and 'Bob'
 
2018-01-30 10:01:28,088 INFO  [] - ---------------------------------- Transaction 2 ---------------------------------- 
2018-01-30 10:01:28,103 ERROR [] - Transaction failed 
2018-01-30 10:01:28,105 INFO  [] - Above error occured as expected: username 'Alice' is already taken 
2018-01-30 10:01:28,109 INFO  [] - Registered users: [{"USERNAME":"Alice"},{"USERNAME":"Bob"}]
Expected Results: You shouldn't see 'charles'. Attempt to reuse username 'Alice' is a DB constraint violation. Therefore, Charles was rolled back in the same TX
 
2018-01-30 10:01:28,110 INFO  [] - ---------------------------------- Transaction 3 ---------------------------------- 
2018-01-30 10:01:28,119 ERROR [] - Transaction failed 
2018-01-30 10:01:28,120 INFO  [] - Above error occured as expected: username is too big (Atmost 10 characters) 
2018-01-30 10:01:28,123 INFO  [] - Registered users: [{"USERNAME":"Alice"},{"USERNAME":"Bob"}]
Expected Results: You shouldn't see 'Dias' and 'UserWhoLovesCats'. 'UserWhoLovesCats' violated DB constraints, and 'Dias' was rolled back in the same TX
```
