# Ballerina Built-in Resilience
Following guide demonstrates how to use built-in resiliency options available in Ballerina. 
Ballerina runtime provides built-in utilities to handle the connector actions in a more resilient manner. Handling transient failures in Ballerina is easier than any other languages.

## What You'll Build
You'll build a service, which can be consumed by users to get the stock exchange rates. It basically calls the Foreign exchange rates and currency conversion API (http://fixer.io/) in the backend to get these information.
`ExchangeRatesWithRetry.bal` uses `retry` resilience option available in Ballerina while `ExchangeRatesWithTimeOut.bal`uses `timeout` option.

Service will have the following resources, which are consumable through HTTP GET requests.

* Get latest exchange rates by providing the base 
```
    GET http://localhost:9090/ExchangeRatesService/getLatestRates/{base}
```

* Get historical rates for any day since 1999 by providing the date 
```
    GET http://localhost:9090/ExchangeRatesService/getHistoricalRates/{date}
```
    
* Get specific exchange rates by providing the target list 
```  
    GET http://localhost:9090/ExchangeRatesService/getSpecificExchange/{UnderscoreSeperatedTargets}
```

Example:

Get latest exchange rates with base USD
```
    GET http://localhost:9090/ExchangeRatesService/getLatestRates/USD
```

You will get a response in JSON format
```
    {"base":"USD","date":"2017-12-20","rates":{"AUD":1.3024,"BGN":1.6512,"BRL":3.2886,"CAD":1.285,"CHF":0.98793,"CNY":6.5788,"CZK":21.675,"DKK":6.2848,"GBP":0.74563,"HKD":7.8241,"HRK":6.3715,"HUF":264.04,"IDR":13578.0,"ILS":3.495,"INR":64.118,"JPY":113.26,"KRW":1082.0,"MXN":19.246,"MYR":4.074,"NOK":8.3312,"NZD":1.4327,"PHP":50.234,"PLN":3.5493,"RON":3.9075,"RUB":58.686,"SEK":8.3688,"SGD":1.3457,"THB":32.75,"TRY":3.83,"ZAR":12.673,"EUR":0.84424}}
```
## Before You Begin:  What You'll Need
- About 30 minutes
- A favorite text editor or IDE
- JDK 1.8 or later
- Ballerina Distribution (Install Instructions:  https://ballerinalang.org/docs/quick-tour/quick-tour/#install-ballerina)
- You can import or write the code straight on your text editor/Ballerina Composer

## How to Complete This Guide
Download and unzip or clone the source repository for this guide in https://github.com/pranavan15/Ballerina-samples. Then navigate to the `Built-in-resilience` subfolder and continue with the next steps.

## Writing the Service
Create a new directory(Ex: Built-in-resilience). Create a new package if needed. Ballerina package is another directory in the project hierarchy.
Create a new file in your text editor and copy following contents. Save the files with .bal extension (ex: ExchangeRatesWithRetry.bal, ExchangeRatesWithTimeOut.bal) 
```
Built-in-resilience
   └── ExchangeRatesWithRetry.bal
   └── ExchangeRatesWithTimeOut.bal
```

##### ExchangeRatesWithRetry.bal

```ballerina

import ballerina.net.http;

@http:configuration {basePath:"/ExchangeRatesService"}
service<http> ExchangeRatesService {
    endpoint<http:HttpClient> exchangeRatesEP {
        create http:HttpClient("http://api.fixer.io", {
            retryConfig: {
                count: 4,
                interval:100
            }
        });
    }

    @http:resourceConfig {
        methods:["GET"],
        path:"/getLatestRates/{base}"
    }
    resource getLatestRates (http:Request request, http:Response response, string base) {
        // Resource to get latest exchange rates
        string reqPath = "/latest?base=" + base;
        http:Response latestRatesResponse = {};
        latestRatesResponse, _ = exchangeRatesEP.get(reqPath, request);
        var e = response.forward(latestRatesResponse);
    }

    @http:resourceConfig {
        methods:["GET"],
        path:"/getHistoricalRates/{date}"
    }
    resource getHistoricalRates (http:Request request, http:Response response, string date) {
        // Resource to get historical exchange rates
        string reqPath = "/" + date;
        http:Response latestRatesResponse = {};
        latestRatesResponse, _ = exchangeRatesEP.get(reqPath, request);
        var e = response.forward(latestRatesResponse);
    }

    @http:resourceConfig {
        methods:["GET"],
        path:"/getSpecificExchange/{UnderscoreSeperatedTargets}"
    }
    resource getSpecificExchange (http:Request request, http:Response response, string base, string UnderscoreSeperatedTargets) {
        // Resource to get specific exchange rates
        string reqPath = "/latest?symbols=" + base + "," + UnderscoreSeperatedTargets;
        http:Response latestRatesResponse = {};
        latestRatesResponse, _ = exchangeRatesEP.get(reqPath, request);
        var e = response.forward(latestRatesResponse);
    }
}

```

##### ExchangeRatesWithTimeOut.bal

```ballerina

import ballerina.net.http;

@http:configuration {basePath:"/ExchangeRatesService"}
service<http> ExchangeRatesService {
    endpoint<http:HttpClient> exchangeRatesEP {
        create http:HttpClient("http://api.fixer.io", {
            endpointTimeout: 30000
        });
    }

    @http:resourceConfig {
        methods:["GET"],
        path:"/getLatestRates/{base}"
    }
    resource getLatestRates (http:Request request, http:Response response, string base) {
        // Resource to get latest exchange rates
        string reqPath = "/latest?base=" + base;
        http:Response latestRatesResponse = {};
        latestRatesResponse, _ = exchangeRatesEP.get(reqPath, request);
        var e = response.forward(latestRatesResponse);
    }

    @http:resourceConfig {
        methods:["GET"],
        path:"/getHistoricalRates/{date}"
    }
    resource getHistoricalRates (http:Request request, http:Response response, string date) {
        // Resource to get historical exchange rates
        string reqPath = "/" + date;
        http:Response latestRatesResponse = {};
        latestRatesResponse, _ = exchangeRatesEP.get(reqPath, request);
        var e = response.forward(latestRatesResponse);
    }

    @http:resourceConfig {
        methods:["GET"],
        path:"/getSpecificExchange/{UnderscoreSeperatedTargets}"
    }
    resource getSpecificExchange (http:Request request, http:Response response, string base, string UnderscoreSeperatedTargets) {
        // Resource to get specific exchange rates
        string reqPath = "/latest?symbols=" + base + "," + UnderscoreSeperatedTargets;
        http:Response latestRatesResponse = {};
        latestRatesResponse, _ = exchangeRatesEP.get(reqPath, request);
        var e = response.forward(latestRatesResponse);
    }
}

```

## Handling Transient Failures

### Retry
`ExchangeRatesWithRetry.bal` file shows how to use the retry resilience option available in Ballerina.

```ballerina
@http:configuration {basePath:"/ExchangeRatesService"}
service<http> ExchangeRatesService {
    endpoint<http:HttpClient> exchangeRatesEP {
        create http:HttpClient("http://api.fixer.io", {
            retryConfig: {
                count: 4,
                interval: 100
            }
        });
    }
```

When creating an `http:HttpClient`, you can pass the retry configurations in the option struct available.

```ballerina
       retryConfig: {
            count: 4,
            interval: 100
       }
```

Above block determines the configurations we needed for the retry option. `count: 4` specifies the number of retry counts and 
`interval: 100` specifies the retry delay.

### Timeout
`ExchangeRatesWithTimeOut.bal` file shows how to use the timeout resilience option available in Ballerina.

```ballerina
@http:configuration {basePath:"/ExchangeRatesService"}
service<http> ExchangeRatesService {
    endpoint<http:HttpClient> exchangeRatesEP {
        create http:HttpClient("http://api.fixer.io", {
            endpointTimeout: 30000
        });
    }
```

Similar to retry, When creating an `http:HttpClient`, you can pass the timeout configurations in the option struct available.
`endpointTimeout: 30000` specifies the timeout duration we need.

## Running Service in Command-line
You can run the ballerina service/application from the command line. Execute following command to compile and execute the ballerina program.

```
$ ballerina run ExchangeRatesWithRetry.bal

$ ballerina run ExchangeRatesWithTimeOut.bal
```

Following commands will compile the ballerina program and run. Note that compiler will create a .balx file, which is the executable binary of the service/application upon execution of **build** command.

```
$ballerina build ExchangeRatesWithRetry.bal
$balleina run ExchangeRatesWithRetry.balx

$ballerina build ExchangeRatesWithTimeOut.bal
$balleina run ExchangeRatesWithTimeOut.balx
```

Console Output
```
ballerina: deploying service(s) in 'services'
ballerina: started HTTP/WS server connector 0.0.0.0:9090
```

## Running Service in Composer
Start Composer https://ballerinalang.org/docs/quick-tour/quick-tour/#run-the-composer
Navigate to File -> Open Program Directory, and pick the project folder (Ballerina-samples/Built-in-resilience).

Click on **Run**(Ctrl+Shift+R) button in the tool bar.

![alt text](https://github.com/pranavan15/Ballerina-samples/blob/master/Built-in-resilience/images/Resilience.png)


## Running in Intellij IDEA
Refer https://github.com/ballerinalang/plugin-intellij/tree/master/getting-started to setup your IntelliJ IDEA environment with Ballerina.
Open Built-in-resilience project in IntelliJ IDEA and run `ExchangeRatesWithRetry.bal` or `ExchangeRatesWithTimeOut.bal`

![alt text](https://github.com/pranavan15/Ballerina-samples/blob/master/Built-in-resilience/images/intelliJ%20sample.png)


## Running in VSCode
<TODO>


## Test the Service
Now that the service is up, visit http://localhost:9090/ExchangeRatesService/[resource]/[option] to access an available resource you need.

## Invoke Service Using Curl
```
eg: `$ curl -v "http://localhost:9090/ExchangeRatesService/getLatestRates/USD"`
```

## Writing Test Cases

## Creating Documentation

## Run Service on Docker

## Run Service on Cloud Foundry
