import ballerina.net.http;
import util;

string soapHost = "http://webservicex.net";
string soapReqPath = "/globalweather.asmx";
string soapReqAction = "http://www.webserviceX.NET/GetCitiesByCountry";
xml soapReqBody;

service<http> getCitiesByCountry {
    resource getCities (http:Request req, http:Response res) {
        json reqPayload = req.getJsonPayload();
        string country = reqPayload["Country"].toString();
        soapReqBody, _ = <xml>("<GetCitiesByCountry xmlns=\"http://www.webserviceX.NET\"><CountryName>" +
                               country + "</CountryName></GetCitiesByCountry>");
        json resPayload = util:soapToJson(soapHost, soapReqPath, soapReqBody, soapReqAction);

        res.setJsonPayload(resPayload);
        _ = res.send();
    }
}



