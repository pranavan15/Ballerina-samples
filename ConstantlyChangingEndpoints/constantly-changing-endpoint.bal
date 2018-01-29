package ConstantlyChangingEndpoints;

import ballerina.net.http;
import ConstantlyChangingEndpoints.util;

// Service that consumes a constantly changing endpoint
service<http> helloService {
    endpoint<http:HttpClient> httpEndpoint {
    }

    resource hello (http:Request request, http:Response response) {
        // Get a random httpClient
        http:HttpClient httpClient = util:getRandomHttpClient();
        // Bind the randomly selected httpClient with httpEndpoint
        bind httpClient with httpEndpoint;
        http:Request requestToEP = {};
        http:Response responseFromEP = {};
        // Consume a resource from the randomly selected endpoint
        responseFromEP, _ = httpEndpoint.get("/say-hello", requestToEP);
        // Forward the response to the helloService clients
        _ = response.forward(responseFromEP);
    }
}