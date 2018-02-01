package ConstantlyChangingEndpoints;

import ConstantlyChangingEndpoints.util;
import ballerina.log;
import ballerina.net.http;

// Service that consumes a constantly changing endpoint
service<http> helloService {
    endpoint<http:HttpClient> httpEndpoint {
    }

    resource hello (http:Request request, http:Response response) {
        // Get a random httpClient
        http:HttpClient randomHttpClient = util:getRandomHttpClient();
        // Bind the randomly selected httpClient with httpEndpoint
        bind randomHttpClient with httpEndpoint;
        http:Request requestToEP = {};
        http:Response responseFromEP = {};
        http:HttpConnectorError connectionError;
        // Consume a resource from the randomly selected endpoint
        responseFromEP, connectionError = httpEndpoint.get("/say-hello", requestToEP);
        if (connectionError != null) {
            log:printError("Error while connecting to the endpoint: " + connectionError.msg);
            responseFromEP.setStatusCode(500);
        }
        // Forward the response to the helloService clients
        http:HttpConnectorError clientConnectionError = response.forward(responseFromEP);
        if (clientConnectionError != null) {
            log:printError("Error while connecting to the client: " + clientConnectionError.msg);
        }
    }
}
