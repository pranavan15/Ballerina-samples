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
    json requestBody = {Source:"Colombo", Destination: "Kandy", Vehicle: "Car", PhoneNumber: "0777123123"};
    request.setJsonPayload(requestBody);
    // Initiate a get request
    response, _ = httpEndpoint.get("/cabBookingService/placeOrder", request);
    // Get the JSON response
    json jsonResponse = response.getJsonPayload();
    log:printInfo(jsonResponse.toString());
}
