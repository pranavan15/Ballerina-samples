package FileStreamProcessing;

import ballerina.test;
import ballerina.net.http;

// Unit test for song-lyrics-service

function testGetAvailableSongs () {
    endpoint<http:HttpClient> httpEndpoint {
        create http:HttpClient("http://localhost:9090", {});
    }

    http:Request request = {};
    http:Response response = {};
    // Start lyricsService
    _ = test:startService("lyricsService");
    // Send a GET request to lyricsService to get all the available songs
    response, _ = httpEndpoint.get("/lyricsService/getAvailableSongs", request);
    string stringResponse = response.getJsonPayload().toString();
    // Assert Response
    test:assertTrue((stringResponse != null) && stringResponse.contains("Teapot"),
                    "Response is null / not appropriate");
}

function testGetSongLyrics () {
    endpoint<http:HttpClient> httpEndpoint {
        create http:HttpClient("http://localhost:9090", {});
    }
    http:Request request = {};
    http:Response response = {};
    // Start lyricsService
    _ = test:startService("lyricsService");
    // Send a GET request to lyricsService to get the lyrics of 'Teapot' song
    response, _ = httpEndpoint.get("/lyricsService/getSongLyrics/Teapot", request);
    string stringResponse = response.getJsonPayload().toString();
    // Assert Response
    test:assertTrue((stringResponse != null) && stringResponse.contains("I’M A LITTLE TEAPOT"),
                    "Response is null / not appropriate");
}

function testGetFileNames () {
    json[] files = getFileNames();
    test:assertTrue(((lengthof files) != 0) && !files[0].toString().contains(".txt"), "Cannot obtain file names
    correctly!");
}

function testGetLyrics () {
    blob lyricsBlob = getLyrics("Teapot");
    string lyrics = lyricsBlob.toString("UTF-8");
    test:assertTrue(lyrics.contains("I’M A LITTLE TEAPOT"), "Cannot read lyrics from the file correctly!");
}

//function testGetFileChannel
