import ballerina.net.http;
import ballerina.log;

public function main (string[] args) {
    http:HttpClient conn = create http:HttpClient("http://localhost:9090", {});
    while (true) {
        makeRequest(conn);
    }
}

public function makeRequest (http:HttpClient conn) {
    endpoint<http:HttpClient> httpEndpoint {
        conn;
    }
    http:Request reqEP = {};
    http:Response resEP = {};
    resEP, _ = httpEndpoint.get("/helloService/hello", reqEP);
    json jsonResEP = resEP.getJsonPayload();
    log:printInfo(jsonResEP.toString());
}
