import ballerina.net.http;
import ballerina.log;

public function main (string[] args) {
    http:HttpClient httpClient = create http:HttpClient("http://localhost:9090", {});
    // Call the service endlessly
    while (true) {
        callService(httpClient);
    }
}

// Method to call the service and log the response
public function callService (http:HttpClient httpClient) {
    endpoint<http:HttpClient> httpEndpoint {
        httpClient;
    }
    http:Request request = {};
    http:Response response = {};
    // Initiate a get request
    response, _ = httpEndpoint.get("/helloService/hello", request);
    json jsonResponse = response.getJsonPayload();
    log:printInfo(jsonResponse.toString());
}
