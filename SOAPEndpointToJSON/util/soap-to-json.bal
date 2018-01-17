package SOAPEndpointToJSON.util;

import ballerina.net.soap;

public function soapToJson (string soapHost, string soapReqPath, xml soapReqBody, string soapReqAction) (json) {
    endpoint<soap:SoapClient> soapClient {
        create soap:SoapClient(soapHost, {});
    }

    soap:SoapVersion version11 = soap:SoapVersion.SOAP11;

    soap:Request soapRequest = {
                                   soapAction:soapReqAction,
                                   soapVersion:version11,
                                   payload:soapReqBody
                               };

    soap:Response soapResponse;
    soap:SoapError soapError;
    soapResponse, soapError = soapClient.sendReceive(soapReqPath, soapRequest);

    xml payload = soapResponse.payload;
    payload, _ = <xml>payload.getTextValue();
    xmlOptions options = {preserveNamespaces:false};
    json jsonPayload = payload.toJSON(options);
    return jsonPayload;
}