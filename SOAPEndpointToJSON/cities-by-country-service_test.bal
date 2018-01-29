package SOAPEndpointToJSON;

import ballerina.net.http;
import ballerina.test;

function testCitiesByCountryService () {
    endpoint<http:HttpClient> httpEndpoint {
        create http:HttpClient("http://localhost:9090", {});
    }

    http:Request request = {};
    http:Response response = {};
    // Set request body
    json requestBody = {"Country":"Sri Lanka"};
    request.setJsonPayload(requestBody);
    // Start citiesByCountryService
    _ = test:startService("citiesByCountryService");
    // Send a POST request to citiesByCountryService
    response, _ = httpEndpoint.post("/citiesByCountryService/getCities", request);
    string stringResponse = response.getJsonPayload().toString();
    // Assert part of the response
    test:assertTrue((stringResponse != null) && stringResponse.contains("{\"Country\":\"Sri Lanka\","
                                                                        + "\"City\":\"Anuradhapura\"}"),
                    "Response is null / not appropriate");
}
