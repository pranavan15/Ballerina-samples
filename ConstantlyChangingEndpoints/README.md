# Writing a Service that Consumes a constantly changing endpoint

This is a use-case example written in Ballerina language (https://ballerinalang.org) that explains How to write a service 
that consumes a constantly changing endpoint. 

# About This Service 
This is a sample web service, which is written using Ballerina language. This service will demonstrate the usage of 
ballerina language to write a service that a constantly changing endpoint. Since Ballerina has built-in 
supports to handle HTTP Connection and Endpoint definition, we can achieve the above requirement easier than other languages. 
File `hello-service-dynamic-endpoints.bal` initiates a service that consumes a constantly changing endpoint each time.  File util:`endpoint-selector.bal`
randomly select an endpoint from a map that consists of 5 different backend URIs. Service then call that endpoint and forward the response to the client.

# How to Deploy
1) Go to http://www.ballerinalang.org and click Download.
2) Download the Ballerina Tools distribution and unzip it on your computer. Ballerina Tools includes the Ballerina runtime plus
the visual editor (Composer) and other tools.
3) Add the <ballerina_home>/bin directory to your $PATH environment variable so that you can run the Ballerina commands from anywhere.
4) After setting up <ballerina_home>, navigate to the folder containing `hello-service-dynamic-endpoints.bal` file and run: `$ ballerina run hello-service-dynamic-endpoints.bal` 
5) How to interact with this web service, 
* GET `localhost:9090/helloService/hello`
6) Responses for above requst will be in application/json format
7)To check the dynamic endpoint consumption, either you can send the above mentioned GET request multiple times or simple run: `$ ballerina run client.bal`
* `client.bal` will initiate the GET request to the service again and again until an external interruption made. This will also log the responses from the server 

# Sample Response
```
2018-01-11 18:08:42,251 INFO  [] - {"Msg":"Hello from Backend 5"} 
2018-01-11 18:08:43,459 INFO  [] - {"Msg":"Hello from Backend 2"} 
2018-01-11 18:08:44,761 INFO  [] - {"Msg":"Hello from Backend 3"} 
2018-01-11 18:08:46,097 INFO  [] - {"Msg":"Hello from Backend 1"} 
2018-01-11 18:08:47,583 INFO  [] - {"Msg":"Hello from Backend 5"} 
2018-01-11 18:08:49,568 INFO  [] - {"Msg":"Hello from Backend 3"} 
2018-01-11 18:08:50,818 INFO  [] - {"Msg":"Hello from Backend 2"} 
2018-01-11 18:08:52,147 INFO  [] - {"Msg":"Hello from Backend 2"} 
2018-01-11 18:08:53,492 INFO  [] - {"Msg":"Hello from Backend 1"} 
2018-01-11 18:08:54,850 INFO  [] - {"Msg":"Hello from Backend 1"} 
2018-01-11 18:08:56,564 INFO  [] - {"Msg":"Hello from Backend 4"}
```
