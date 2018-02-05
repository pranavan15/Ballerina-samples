package SOAPEndpointToJSON.util;

import ballerina.test;

const string soapHost = "http://webservicex.net";
const string soapReqPath = "/globalweather.asmx";
const string soapReqAction = "http://www.webserviceX.NET/GetCitiesByCountry";
const string soapReqBody = "<GetCitiesByCountry xmlns=\"http://www.webserviceX.NET\"><CountryName>Sri Lanka" +
                           "</CountryName></GetCitiesByCountry>";

function testSoapToJson () {
    var xmlReqBody, _ = <xml>soapReqBody;
    // Make SOAP request call
    xml resPayload = callSoapEndpoint(soapHost, soapReqPath, soapReqAction, xmlReqBody);
    json jsonResPayload = xmlToJson(resPayload);
    string stringPayload = jsonResPayload.toString();
    test:assertTrue((stringPayload != null) && stringPayload.contains("{\"Country\":\"Sri Lanka\","
                                                                      + "\"City\":\"Anuradhapura\"}"),
                    "Output mismatch!");
}
