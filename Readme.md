# Super Subtitler - Windows Edition

## Getting Started
First, download the repo.
Make sure you have:
1. Google Chrome
2. Processing with the following Libraries:
	1. WebSocketsP5
3. Resolume Arena (or Millumin/MadMapper for OSX)
4. Drop in the `sender.html` file to any server of your choice.

## Functionality
This project works with WebSockets and Syphon/Spout to pass data between applications.
The chain is as follows:
1. Google Chrome fires its diction events
2. The transcript is passed in through WebSockets to Processing as a string
3. Processing will read the string, and draw text based on the string that is recieved, then send its frame to Spout
4. Resolume/Millumin will read the frame data from Spout and display it along with its projection-mapping data.

## Documentation
For any issues, please see the docs for each respective application:
1. [Processing](https://processing.org/reference/)
2. [Spout](http://spout.zeal.co/)
	..* [Syphon](http://syphon.v002.info/)
3. [Resolume Arena/Avenue](https://resolume.com/)
	..* [Millumin](https://millumin2.com)
