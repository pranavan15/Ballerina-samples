package ConstantlyChangingEndpoints;
import ballerina.test;
import ballerina.net.http;

// Unit test for constantly-changing-endpoint service
function testHelloService () {
    endpoint<http:HttpClient> httpEndpoint {
        create http:HttpClient("http://localhost:9090", {});
    }

    http:Request request = {};
    http:Response response = {};
    // Start helloService
    _ = test:startService("helloService");
    // Send a GET request to helloService
    response, _ = httpEndpoint.get("/helloService/hello", request);
    string stringResponse = response.getJsonPayload().toString();
    // Remove the integer part from the response, which is likely to change every time
    string results = stringResponse.replaceAll(" \\d", "");
    // Assert Response
    test:assertStringEquals(results, "{\"Msg\":\"Hello from Backend\"}",
                            "Response mismatch!");
}
