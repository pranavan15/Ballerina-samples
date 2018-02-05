package SOAPEndpointToJSON;

import SOAPEndpointToJSON.util;
import ballerina.net.http;

const string soapHost = "http://webservicex.net";
const string soapReqPath = "/globalweather.asmx";
const string soapReqAction = "http://www.webserviceX.NET/GetCitiesByCountry";
xml soapReqBody;

// Service to get cities by country name
// This service calls a SOAP/XML backend to get the cities for a specified country
// The users only see a JSON endpoint - Users send a JSON request to our service and get a JSON response
service<http> citiesByCountryService {
    resource getCities (http:Request request, http:Response response) {
        // Get the JSON payload from the user request
        json reqPayload = request.getJsonPayload();
        string country = reqPayload["Country"].toString();
        // Construct the SOAP request body
        soapReqBody, _ = <xml>("<GetCitiesByCountry xmlns=\"http://www.webserviceX.NET\"><CountryName>" +
                               country + "</CountryName></GetCitiesByCountry>");
        // Make SOAP request call
        xml resPayload = util:callSoapEndpoint(soapHost, soapReqPath, soapReqAction, soapReqBody);
        json jsonResPayload = util:xmlToJson(resPayload);
        // Send the JSON response to the user
        response.setJsonPayload(jsonResPayload);
        _ = response.send();
    }
}
