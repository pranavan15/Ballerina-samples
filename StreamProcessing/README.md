# Song Lyrics Web-Service
This is a usecase example written in Ballerina language (https://ballerinalang.org) that explains How to write a service 
that consumes and processes a data stream.

# About This Service 
This is a sample web service, which is written using Ballerina language. This service will demonstrate the usage of 
ballerina language to consume and process streams. File I/O stream has been used here in this example. 
With the data streaming functionality, the result is streamed as a response to a request rather than building the full result and returning it. 

This service allows a user to query and get lyrics for few children songs. Files are stored in the local directory and read as streams of bytes.
These bytes are then processed and converted into json strings and sent as response to the clients.

# How to deploy
1) Go to http://www.ballerinalang.org and click Download.
2) Download the Ballerina Tools distribution and unzip it on your computer. Ballerina Tools includes the Ballerina runtime plus
the visual editor (Composer) and other tools.
3) Add the <ballerina_home>/bin directory to your $PATH environment variable so that you can run the Ballerina commands from anywhere.
4) After setting up <ballerina_home>, navigate to the folder containing `songLyricsService.bal` file and run: `$ ballerina run songLyricsService.bal` 

5) How to interact with this web service, 
* To view all the available songs     - GET `localhost:9090/lyricsService/getAvailableSongs`
* To retrieve the lyrics of a song    - GET `localhost:9090/lyricsService/getSongLyrics/{songName}`

6) Responses for above requst will be in application/json format
