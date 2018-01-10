
import ballerina.net.http;
import connectors as conn;
import util;

service<http> twitterSummary {
    endpoint<conn:ClientConnector> twitterConnectorEP {
    }
    
    string accessToken;
    string accessTokenSecret;

    resource getTweetsWithTime (http:Request req, http:Response resp) {
        json reqPayload = req.getJsonPayload();
        var responsePayload, e = util:getUserTimelineStatuses(reqPayload);

        if(e == null) {
            json[] resultsPayload = [];
            int i;
            while (i < lengthof responsePayload) {
                json payloadElement = {};
                payloadElement["Tweet"] = responsePayload[i]["text"];
                payloadElement["Date"] = responsePayload[i]["created_at"];
                resultsPayload[i] = payloadElement;
                i = i + 1;
            }
            resp.setJsonPayload((json)resultsPayload);
            _ = resp.send();
        }
        else {
            resp.setJsonPayload("Something Wrong");
        _ = resp.send();
        }
    }

    resource getFollowers (http:Request req, http:Response resp) {
        json reqPayload = req.getJsonPayload();
        var responsePayload, e = util:getFollowers(reqPayload);

        if (e == null) {
            responsePayload = responsePayload["users"];
            json[] resultsPayload = [];
            int i;
            while(i < lengthof responsePayload) {
                json payloadElement = {};
                payloadElement["name"] = responsePayload[i]["name"];
                payloadElement["screen_name"] = responsePayload[i]["screen_name"];
                payloadElement["Following_from"] = responsePayload[i]["created_at"];
                resultsPayload[i] = payloadElement;
                i = i + 1;
            }
            resp.setJsonPayload((json)resultsPayload);
        _ = resp.send();
        }
        else {
            resp.setJsonPayload("Something Wrong");
        _ = resp.send();
        }
    }

    resource getFollowingFriends (http:Request req, http:Response resp) {
        json reqPayload = req.getJsonPayload();
        var responsePayload, e = util:getFollowingFriends(reqPayload);

        if (e == null) {
            responsePayload = responsePayload["users"];
            json[] resultsPayload = [];
            int i;
            while(i < lengthof responsePayload) {
                json payloadElement = {};
                payloadElement["name"] = responsePayload[i]["name"];
                payloadElement["screen_name"] = responsePayload[i]["screen_name"];
                payloadElement["Following_from"] = responsePayload[i]["created_at"];
                resultsPayload[i] = payloadElement;
                i = i + 1;
            }
            resp.setJsonPayload((json)resultsPayload);
        _ = resp.send();
        }
        else {
            resp.setJsonPayload("Something Wrong");
        _ = resp.send();
        }
    }
}
