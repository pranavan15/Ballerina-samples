package util;

import ballerina.net.http;
import ballerina.math;

map endpoints = {
                    ep1:"https://be053e7c-4d6a-4314-928e-55223350cee3.mock.pstmn.io",
                    ep2:"https://80860706-e456-4ed2-8347-1ac9cf265174.mock.pstmn.io",
                    ep3:"https://40a1d005-a8db-4456-9524-593f8285cd36.mock.pstmn.io",
                    ep4:"https://ecc74171-b022-4b09-9e83-f6acad148f54.mock.pstmn.io",
                    ep5:"https://743295d5-7081-4884-8de6-65ed4afb80a7.mock.pstmn.io"
                };

public function getEndpoint () (http:HttpClient) {
    int rand = math:randomInRange(1, 6);
    string key = "ep" + rand;
    var ep, _ = (string)endpoints[key];
    //println(ep);
    http:HttpClient conn = create http:HttpClient(ep, {});
    return conn;
}
