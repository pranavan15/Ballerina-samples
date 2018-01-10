
package util;
import ballerina.net.http;
import connectors as conn;

const string consumerKey = "2EJlE36flriywdeb9GdSIJTtr";
const string consumerSecret = "iuMABjGWEf96aytD1uXfVoF5EYNdiOMs4oYWdjd3N9uVgXImjq";

public function getAccessTokens (json reqPayload) (string accessToken, string accessTokenSecret) {
    accessToken, _ = (string)reqPayload.accessToken;
    accessTokenSecret, _ = (string)reqPayload.accessTokenSecret;
    return;
}

public function getClientConnector (string accessToken, string accessTokenSecret,
                                    string consumerKey, string consumerSecret) (conn:ClientConnector clientConnector) {
    clientConnector = create conn:ClientConnector(consumerKey, consumerSecret, accessToken,
                                                  accessTokenSecret);
    return;
}

public function getUserTimelineStatuses (json reqPayload) (json responsePayload, http:HttpConnectorError e) {
    endpoint<conn:ClientConnector> twitterConnectorEP {
    }
    var accessToken, accessTokenSecret = getAccessTokens(reqPayload);
    conn:ClientConnector clientConnector = getClientConnector(accessToken, accessTokenSecret, consumerKey, consumerSecret);
    bind clientConnector with twitterConnectorEP;

    var searchResponse, e = twitterConnectorEP.getUserTimelineStatuses();
    responsePayload = searchResponse.getJsonPayload();
    return;
}

public function getFollowers (json reqPayload) (json responsePayload, http:HttpConnectorError e) {
    endpoint<conn:ClientConnector> twitterConnectorEP {
    }
    var accessToken, accessTokenSecret = getAccessTokens(reqPayload);
    conn:ClientConnector clientConnector = getClientConnector(accessToken, accessTokenSecret, consumerKey, consumerSecret);
    bind clientConnector with twitterConnectorEP;

    var searchResponse, e = twitterConnectorEP.getUserFollowers();
    responsePayload = searchResponse.getJsonPayload();
    return;
}

public function getFollowingFriends (json reqPayload) (json responsePayload, http:HttpConnectorError e) {
    endpoint<conn:ClientConnector> twitterConnectorEP {
    }
    var accessToken, accessTokenSecret = getAccessTokens(reqPayload);
    conn:ClientConnector clientConnector = getClientConnector(accessToken, accessTokenSecret, consumerKey, consumerSecret);
    bind clientConnector with twitterConnectorEP;

    var searchResponse, e = twitterConnectorEP.getUserFollowingFriends();
    responsePayload = searchResponse.getJsonPayload();
    return;
}
