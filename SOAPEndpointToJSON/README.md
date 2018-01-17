 # Converting an XML or SOAP endpoint to JSON

This is a technical use-case example written in Ballerina language (https://ballerinalang.org) that demonstrates
about Converting an XML or SOAP endpoint to JSON. 
# About This Use-case 
This is a sample use-case, which is written using Ballerina language. This example contains a service that consumes a SOAP/XML based endpoint, convert responses to JSON and send them to user (User sees only the Json service exposed). Ballerina SOAP connector is used to communicate with a SOAP/XML endpoint.

# How to Deploy
1) Go to http://www.ballerinalang.org and click Download.
2) Download the Ballerina Tools distribution and unzip it on your computer. Ballerina Tools includes the Ballerina runtime plus
the visual editor (Composer) and other tools.
3) Add the <ballerina_home>/bin directory to your $PATH environment variable so that you can run the Ballerina commands from anywhere.
4) Extract `ballerina-soap-connector-<version>.zip` and copy containing jars into `<BRE_HOME>/bre/lib/`
5) After setting up <ballerina_home>, navigate to the folder containing `{name}.bal` files and run: `$ ballerina run {fileName}.bal` 
