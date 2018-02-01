package ConstantlyChangingEndpoints;

import ballerina.log;
import ballerina.net.http;

// Hello-service-client to test the constantly-changing-endpoint service
public function main (string[] args) {
    http:HttpClient httpClient = create http:HttpClient("http://localhost:9090", {});
    // Call the service endlessly
    while (true) {
        try {
            json jsonResponse = callService(httpClient);
            log:printInfo(jsonResponse.toString());
        } catch (http:HttpConnectorError err) {
            log:printError("Connection error: " + err.msg);
        }
    }
}

// Method to call the service
// throws http:HttpConnectorError
function callService (http:HttpClient httpClient) (json) {
    endpoint<http:HttpClient> httpEndpoint {
        httpClient;
    }
    http:Request request = {};
    http:Response response = {};
    http:HttpConnectorError connectionError;
    // Initiate a get request
    response, connectionError = httpEndpoint.get("/helloService/hello", request);
    if (connectionError != null) {
        throw connectionError;
    }
    json jsonResponse = response.getJsonPayload();
    // Return the json payload
    return jsonResponse;
}
