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
    json resPayload = soapToJson(soapHost, soapReqPath, soapReqAction, xmlReqBody);
    string stringPayload = resPayload.toString();
    test:assertTrue((stringPayload != null) && stringPayload.contains("{\"Country\":\"Sri Lanka\","
                                                                      + "\"City\":\"Anuradhapura\"}"),
                    "Output mismatch!");
}
