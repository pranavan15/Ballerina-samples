package TwitterSummaryService.util;
import ballerina.net.http;
import TwitterSummaryService.connectors as conn;

// Consumer key and consumer secret for the twitter summary application
const string consumerKey = "2EJlE36flriywdeb9GdSIJTtr";
const string consumerSecret = "iuMABjGWEf96aytD1uXfVoF5EYNdiOMs4oYWdjd3N9uVgXImjq";

// Function to get the access token and the access secret to a user account from the user's request payload
public function getAccessTokens (json reqPayload) (string accessToken, string accessTokenSecret) {
    accessToken, _ = (string)reqPayload.accessToken;
    accessTokenSecret, _ = (string)reqPayload.accessTokenSecret;
    return;
}

// Function to get the Twitter client connector
public function getClientConnector (string accessToken, string accessTokenSecret,
                                    string consumerKey, string consumerSecret) (conn:ClientConnector clientConnector) {
    clientConnector = create conn:ClientConnector(consumerKey, consumerSecret, accessToken,
                                                  accessTokenSecret);
    return;
}

// Connect to twitter and get the user's timeline statuses
public function getUserTimelineStatuses (json reqPayload) (json responsePayload, http:HttpConnectorError e) {
    endpoint<conn:ClientConnector> twitterConnectorEP {
    }
    // Get the access token and secret
    var accessToken, accessTokenSecret = getAccessTokens(reqPayload);
    conn:ClientConnector clientConnector = getClientConnector(accessToken, accessTokenSecret, consumerKey, consumerSecret);
    // Bind the client connector with endpoint
    bind clientConnector with twitterConnectorEP;

    var searchResponse, e = twitterConnectorEP.getUserTimelineStatuses();
    responsePayload = searchResponse.getJsonPayload();
    return;
}

// Connect to twitter and get the user's follower details
public function getFollowers (json reqPayload) (json responsePayload, http:HttpConnectorError e) {
    endpoint<conn:ClientConnector> twitterConnectorEP {
    }
    // Get the access token and secret
    var accessToken, accessTokenSecret = getAccessTokens(reqPayload);
    conn:ClientConnector clientConnector = getClientConnector(accessToken, accessTokenSecret, consumerKey, consumerSecret);
    // Bind the client connector with endpoint
    bind clientConnector with twitterConnectorEP;

    var searchResponse, e = twitterConnectorEP.getUserFollowers();
    responsePayload = searchResponse.getJsonPayload();
    return;
}

// Connect to twitter and get the list of people who the user follows
public function getFollowingFriends (json reqPayload) (json responsePayload, http:HttpConnectorError e) {
    endpoint<conn:ClientConnector> twitterConnectorEP {
    }
    // Get the access token and secret
    var accessToken, accessTokenSecret = getAccessTokens(reqPayload);
    conn:ClientConnector clientConnector = getClientConnector(accessToken, accessTokenSecret, consumerKey, consumerSecret);
    // Bind the client connector with endpoint
    bind clientConnector with twitterConnectorEP;

    var searchResponse, e = twitterConnectorEP.getUserFollowingFriends();
    responsePayload = searchResponse.getJsonPayload();
    return;
}
