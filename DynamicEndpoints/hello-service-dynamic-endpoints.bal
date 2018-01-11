import ballerina.net.http;
import util;

service<http> helloService {
    endpoint<http:HttpClient> httpEndpoint {
    }

    resource hello (http:Request req, http:Response res) {
        http:HttpClient conn = util:getEndpoint();
        bind conn with httpEndpoint;
        http:Request reqEP = {};
        http:Response resEP = {};
        resEP, _ = httpEndpoint.get("/say-hello", reqEP);
        var e = res.forward(resEP);
    }
}