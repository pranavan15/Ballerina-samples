package SOAPEndpointToJSON.util;

import ballerina.net.soap;

// Function that communicates with a SOAP endpoint and converts its SOAP/XML response payload to JSON payload
public function soapToJson (string soapHost, string soapReqPath, string soapReqAction, xml soapReqBody) (json) {
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
    responsePayload, _ = <xml>responsePayload.getTextValue();
    xmlOptions options = {preserveNamespaces:false};
    // Convert the XML payload to JSON payload
    json jsonResPayload = responsePayload.toJSON(options);
    return jsonResPayload;
}
