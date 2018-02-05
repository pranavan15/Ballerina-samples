package SOAPEndpointToJSON;

import SOAPEndpointToJSON.util;
import ballerina.log;
import ballerina.net.http;
import ballerina.net.soap;

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
        json jsonResPayload;

        try {
            TypeConversionError typeConversionErr;
            // Construct the SOAP request body
            soapReqBody, typeConversionErr = <xml>("<GetCitiesByCountry xmlns=\"http://www.webserviceX.NET\"><CountryName>" +
                                                   country + "</CountryName></GetCitiesByCountry>");
            if (typeConversionErr != null) {
                throw typeConversionErr;
            }
            // Make SOAP request call
            xml resPayload = util:callSoapEndpoint(soapHost, soapReqPath, soapReqAction, soapReqBody);
            jsonResPayload = util:xmlToJson(resPayload);
            // Send the JSON response to the user
        } catch (TypeConversionError conversionErr) {
            log:printError("Eror while performing type conversion: " + conversionErr.msg);
            jsonResPayload = {"Msg":"Internal server error"};
            response.setStatusCode(500);
        } catch (soap:SoapError soapErr) {
            log:printError("Eror while connecting to soap backend: " + soapErr.msg);
            jsonResPayload = {"Msg":"Internal server error"};
            response.setStatusCode(500);
        }
        response.setJsonPayload(jsonResPayload);
        http:HttpConnectorError connectionErr = response.send();
        if (connectionErr != null) {
            log:printError("Error while connecting to the client: " + connectionErr.msg);
        }
    }
}
