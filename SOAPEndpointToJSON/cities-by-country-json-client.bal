package SOAPEndpointToJSON;

import ballerina.net.http;
import ballerina.log;

// Client to consume Cab booking service
public function main (string[] args) {
    endpoint<http:HttpClient> httpEndpoint {
        create http:HttpClient("http://localhost:9090", {});
    }

    http:Request request = {};
    http:Response response = {};
    // Request body
    json requestBody = {"Country":"Sri Lanka"};
    request.setJsonPayload(requestBody);
    // Initiate a POST request
    response, _ = httpEndpoint.post("/citiesByCountryService/getCities", request);
    // Get the JSON response
    json jsonResponse = response.getJsonPayload();
    log:printInfo(jsonResponse.toString());
}
