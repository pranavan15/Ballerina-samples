import ballerina.net.http;
                     import SOAPEndpointToJSON.util;

const string soapHost = "http://webservicex.net";
const string soapReqPath = "/globalweather.asmx";
const string soapReqAction = "http://www.webserviceX.NET/GetCitiesByCountry";
xml soapReqBody;

// Service to get cities by country name
// This service calls a SOAP/XML backend to get the cities for a specified country
// The users only see a JSON endpoint - Users send a JSON request to our service and get a JSON response
service<http> getCitiesByCountry {
    resource getCities (http:Request request, http:Response response) {
        // Get the JSON payload from the user request
        json reqPayload = request.getJsonPayload();
        string country = reqPayload["Country"].toString();
        // Construct the SOAP request body
        soapReqBody, _ = <xml>("<GetCitiesByCountry xmlns=\"http://www.webserviceX.NET\"><CountryName>" +
                               country + "</CountryName></GetCitiesByCountry>");
        // Make SOAP request call
        json resPayload = util:soapToJson(soapHost, soapReqPath, soapReqAction, soapReqBody);
        // Send the JSON response to the user
        response.setJsonPayload(resPayload);
        _ = response.send();
    }
}
