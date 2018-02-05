package SOAPEndpointToJSON.util;

import ballerina.net.soap;

// Function that communicates with a SOAP endpoint and returns a SOAP/XML response payload
public function callSoapEndpoint (string soapHost, string soapReqPath, string soapReqAction, xml soapReqBody) (xml) {
    // Create a soap client
    endpoint<soap:SoapClient> soapClient {
        create soap:SoapClient(soapHost, {});
    }

    // SOAP version of the request
    soap:SoapVersion soapReqVersion = soap:SoapVersion.SOAP11;
    // Construct the SOAP request
    soap:Request soapRequest = {
                                   soapAction:soapReqAction,
                                   soapVersion:soapReqVersion,
                                   payload:soapReqBody
                               };

    soap:Response soapResponse;
    soap:SoapError soapError;

    // Send the SOAP request and wait for the response
    soapResponse, soapError = soapClient.sendReceive(soapReqPath, soapRequest);
    // Get the XML response payload
    xml responsePayload = soapResponse.payload;
    return responsePayload;
}

public function xmlToJson (xml payload) (json) {
    // To handle CDATA in XML
    payload, _ = <xml>payload.getTextValue();
    // Xml options when converting xml to json
    xmlOptions options = {preserveNamespaces:false};
    // Convert the XML payload to JSON payload
    json jsonResPayload = payload.toJSON(options);
    return jsonResPayload;
}