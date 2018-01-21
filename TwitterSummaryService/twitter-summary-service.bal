import ballerina.net.http;
import TwitterSummaryService.connectors as conn;
import TwitterSummaryService.util;

// Twitter Summary Service
service<http> twitterSummary {
    endpoint<conn:ClientConnector> twitterConnectorEP {
    }

    // Resource to get user tweets with tweeting times
    resource getTweetsWithTime (http:Request req, http:Response resp) {
        json reqPayload = req.getJsonPayload();
        // Get the user's timeline statuses
        var responsePayload, e = util:getUserTimelineStatuses(reqPayload);

        // Check whether the timeline statuses obtained without any problem
        if(e == null) {
            // Construct the results payload
            json[] resultsPayload = [];
            int i;
            while (i < lengthof responsePayload) {
                json payloadElement = {};
                payloadElement["Tweet"] = responsePayload[i]["text"];
                payloadElement["Date"] = responsePayload[i]["created_at"];
                resultsPayload[i] = payloadElement;
                i = i + 1;
            }
            // Send the response to the user
            resp.setJsonPayload((json)resultsPayload);
            _ = resp.send();
        }
        else {
            resp.setJsonPayload("Something Wrong");
            _ = resp.send();
        }
    }

    // Resource to get the followers of a user with following date
    resource getFollowers (http:Request req, http:Response resp) {
        json reqPayload = req.getJsonPayload();
        // Get the user followers
        var responsePayload, e = util:getFollowers(reqPayload);

        // Check whether the user followers obtained without any problem
        if (e == null) {
            // Construct the results payload
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
            // Send the response to the user
            resp.setJsonPayload((json)resultsPayload);
            _ = resp.send();
        }
        else {
            resp.setJsonPayload("Something Wrong");
            _ = resp.send();
        }
    }

    // Function to get the list of people who the user follows
    resource getFollowingFriends (http:Request req, http:Response resp) {
        json reqPayload = req.getJsonPayload();
        var responsePayload, e = util:getFollowingFriends(reqPayload);

        // Check whether the user following friends obtained without any problem
        if (e == null) {
            // Construct the results payload
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
            // Send the response to the user
            resp.setJsonPayload((json)resultsPayload);
            _ = resp.send();
        }
        else {
            resp.setJsonPayload("Something Wrong");
        _ = resp.send();
        }
    }
}
