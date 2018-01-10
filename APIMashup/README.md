# Merging Mutiple APIs Into a Single API
This is a usecase example that explains How to merge multiple APIs into a single API using Ballerina language (https://ballerinalang.org).

# About This Service 
This is a sample API, which is written using Ballerina language. This will demonstrate the usage of 
ballerina language to merge mutiple APIs into a single API to deal with multiple backends. This API allows the user to provide a location/IP adress/
Geo coordinates of a place and get several different details about that place. User will be able to get the weather, Air quality, twitter trends nearby 
restuarants and direction to any other place from the current location by consuming the appropriate resourses in the provided API. This API will communicate with
multiple backends to get all these details and act as an API Mashup. It needs to communicate with weather API, Twitter API, Zomato API and Google directions API.

# How to Deploy
1) Go to http://www.ballerinalang.org and click Download.
2) Download the Ballerina Tools distribution and unzip it on your computer. Ballerina Tools includes the Ballerina runtime plus
the visual editor (Composer) and other tools.
3) Add the <ballerina_home>/bin directory to your $PATH environment variable so that you can run the Ballerina commands from anywhere.
4) After setting up <ballerina_home>, navigate to the correct folder containing the .bal file and run: `$ ballerina run {filename}.bal` 
