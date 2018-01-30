# Service That Consumes a Constantly Changing Endpoint

This web service, which is written in Ballerina language demonstrates how to write a service that consumes a constantly 
changing endpoint. As Ballerina has built-in supports to handle HTTP Connections, Endpoint definitions and connector 
to endpoint direct binding options, it's very easy for a user to write a service that is required to communicate with
a constantly changing backend. 

In this example, file `constantly-changing-endpoint.bal` initiates a service that consumes a constantly changing 
endpoint each time.  File util:`get-random-endpoint.bal` randomly select an endpoint from a map that consists of 5 
different backend URIs. 5 mock endpoints created for this purpose using `postman` application. 
Service calls a randomly selected endpoint and forward the response to the client. File `hello-service-client.bal` 
contains the implementation of a client, which calls the hello service continuously.

## How to Run
1) Go to https://ballerinalang.org and click Download.
2) Download the Ballerina Tools distribution and unzip it on your computer. Ballerina Tools includes the Ballerina 
runtime plus the visual editor (Composer) and other tools.
3) Add the `<BALLERINA_HOME>/bin` directory to your $PATH environment variable so that you can run the Ballerina 
commands from anywhere.
4) After setting up <BALLERINA_HOME>, navigate to the `ConstantlyChangingEndpoints` folder and run:
 `$ ballerina run constantly-changing-endpoint.bal` to run the hello service.
5) To run the hello service client, run: `$ ballerina run hello-service-client.bal` 

#### How to interact with this web service
* GET `localhost:9090/helloService/hello`

Response for the above request will be in Application/Json format

To check the above service, either you can send the above mentioned GET request multiple times or simply run the 
hello service client, which will initiate the GET request to the service again and again until an external 
interruption made, and log the responses from the server.

#### Sample Response
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
