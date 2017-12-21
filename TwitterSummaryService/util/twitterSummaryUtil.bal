
package util;

public function getAccessTokens(json reqPayload) (string accessToken, string accessTokenSecret) {
    accessToken, _ = (string)reqPayload.accessToken;
    accessTokenSecret, _ = (string)reqPayload.accessTokenSecret;
    return;
}