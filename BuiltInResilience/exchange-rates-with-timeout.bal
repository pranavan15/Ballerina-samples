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
