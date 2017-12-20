# Balleina Built-in resilience sample
This sample demonstrates how to use built-in resiliency options available in Ballerina. 
Ballerina runtime will provides some built-in utilities to handle the connector actions in a more resilient manner easier than any other languages.


# About this sample
This sample provides a service which can be consumed by users to get the stock exchange rates. It basically calls Foreign exchange rates and currency conversion API in the backend to get these information.
`ExchangeRatesWithRetry.bal` uses retry resilience option available in Ballerina while `ExchangeRatesWithTimeOut.bal`uses timeout option.
This sample has the following functionalities.

* Get latest exchange rates by providing the base 

    (`GET ../ExchangeRatesService/getLatestRates/{base}`)
* Get historical rates for any day since 1999 by providing the date 
  
    (`GET ../ExchangeRatesService/getHistoricalRates/{date}`)
* Get specific exchange rates by providing the target list 
  
    (`GET ../ExchangeRatesService/getSpecificExchange/{UnderscoreSeperatedTargets}`)

# To run the sample
`$ ballerina run ExchangeRatesWithRetry.bal`
`$ ballerina run ExchangeRatesWithTimeOut.bal`

# Invoke services using curl
eg: `$ curl -v "http://localhost:9090/ExchangeRatesService/getLatestRates/USD"`
