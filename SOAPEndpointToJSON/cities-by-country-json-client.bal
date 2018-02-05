package SOAPEndpointToJSON;

import ballerina.log;
import ballerina.net.http;

// Client to consume Cab booking service
public function main (string[] args) {
    endpoint<http:HttpClient> httpEndpoint {
        create http:HttpClient("http://localhost:9090", {});
    }

    http:Request request = {};
    http:Response response = {};
    http:HttpConnectorError connectionErr;
    // Request body
    json requestBody = {"Country":"Sri Lanka"};
    request.setJsonPayload(requestBody);
    // Initiate a POST request
    response, connectionErr = httpEndpoint.post("/citiesByCountryService/getCities", request);
    if (connectionErr != null) {
        log:printError("Error while connecting to the cities by country service: " + connectionErr.msg);
        return;
    }
    // Get the JSON response
    json jsonResponse = response.getJsonPayload();
    log:printInfo(jsonResponse.toString());
}
