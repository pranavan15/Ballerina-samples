# Converting an XML or SOAP endpoint to JSON

This web service, which is written in Ballerina language demonstrates how to convert an SOAP/XML based endpoint to a 
JSON endpoint. This is a service that provides important cities of any given country. All the user interactions 
(requests, responses) to the service are in Application/JSON format. Whereas, the Ballerina service communicates with
a SOAP backend to get the necessary details. What happens internally is Ballerina service gets a JSON request from 
the user and converts it as an XML request, and sends a SOAP request to the actual backend. When it receives an XML 
request from the backend, it again converts it as JSON response and sends back to user. Therefore, a user only sees 
a JSON endpoint.

Below diagram explains this process.

 
`http://webservicex.net` is used as the SOAP host. The following is a sample SOAP 1.1 request and response to/from the 
SOAP host.

```
POST /globalweather.asmx HTTP/1.1
Host: www.webservicex.net
Content-Type: text/xml; charset=utf-8
Content-Length: length
SOAPAction: "http://www.webserviceX.NET/GetCitiesByCountry"

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetCitiesByCountry xmlns="http://www.webserviceX.NET">
      <CountryName>string</CountryName>
    </GetCitiesByCountry>
  </soap:Body>
</soap:Envelope>
```

```
HTTP/1.1 200 OK
Content-Type: text/xml; charset=utf-8
Content-Length: length

<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GetCitiesByCountryResponse xmlns="http://www.webserviceX.NET">
      <GetCitiesByCountryResult>string</GetCitiesByCountryResult>
    </GetCitiesByCountryResponse>
  </soap:Body>
</soap:Envelope>
```
 
Ballerina Soap Connector has been used in this example, which allows us to send an ordinary xml request to a soap 
backend by specifying the necessary details to construct a soap envelope. It abstracts out the details of the 
creation of a soap envelope, headers and the body in a soap message.

As ballerina has built-in support to JSON to XML and XML to JSON conversions, this task can easily be done than many 
other languages. 
 
## How to Run
1) Go to https://ballerinalang.org and click Download.
2) Download the Ballerina Tools distribution and unzip it on your computer. Ballerina Tools includes the Ballerina 
runtime plus the visual editor (Composer) and other tools.
3) Add the `<BALLERINA_HOME>/bin` directory to your $PATH environment variable so that you can run the Ballerina 
commands from anywhere.
4) Go to https://ballerinalang.org/connectors and download Ballerina soap Connector.
5) Extract `ballerina-soap-connector-<version>.zip` and copy containing jars into `<BALLERINA_HOME>/bre/lib/`
6) After that, navigate to the `SOAPEndpointToJSON` folder and run:
 `$ ballerina run cities-by-country-service.bal` to run the service.
5) To run the client, run: `$ ballerina run cities-by-country-json-client.bal`

#### How to interact with this web service
* POST `localhost:9090/getCitiesByCountry/getCities` with appropriate json payload

Example payload: `{Country:"Sri Lanka"}`

Response for the above request will be in Application/Json format.

To check the above service, either you can send the above mentioned POST request or simply run the 
cities by country json client, which will initiate the POST request to the service and log the response from the 
server.

#### Sample Response 

```
{
    "NewDataSet": {
        "Table": [
            {
                "Country": "Sri Lanka",
                "City": "Katunayake"
            },
            {
                "Country": "Sri Lanka",
                "City": "Anuradhapura"
            },
            {
                "Country": "Sri Lanka",
                "City": "Batticaloa"
            },
            {
                "Country": "Sri Lanka",
                "City": "Ratmalana"
            },
            {
                "Country": "Sri Lanka",
                "City": "Trincomalee"
            }
        ]
    }
}
```