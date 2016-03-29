# Super Subtitler - Windows Edition

## Getting Started
First, download the repo.
Make sure you have:

1. Google Chrome
2. Processing with the following Libraries:
	1. WebSocketsP5. This is distributed with this repo. Move the websocketP5 folder to your `/libraries` folder
3. Resolume Arena (or Millumin/MadMapper for OSX)
4. Drop in the `sender.html` file to any server of your choice.

## The Setup
1. Start up Processing and ensure that Super_Subtitler.pde is open.
	a. Ensure that spout.pde and JSpout.java are open.
2. Run Processing. You should see the sketch screen open.
3. Open Google Chrome and verify that you are connected.
	a. If you are not connected to the websocket server, verify that you are connecting to your local machine's IP address in ```sender.html```
4. Open Resolume Arena and drag the Spout source to a layer.
5. Whenever you want to fire speech recognition, click the "Go!" button in Chrome after selecting a target language.

## Functionality
This project works with WebSockets and Syphon/Spout to pass data between applications.
The chain is as follows:

1. Google Chrome fires its diction events
2. The transcript or translation is passed in through WebSockets to Processing as a string
3. Processing will read the string, and draw text based on the string that is recieved, then send its frame to Spout
4. Resolume/Millumin will read the frame data from Spout and display it along with its projection-mapping data.

WARNING: The Google Translate API will only accept requests from ```http://www.virtualmo.com/*```
If you need change the API: please open an issue in this repo and I will get back to you ASAP. Otherwise, send me an email at ```scottdj92@gmail.com```

## Documentation
For any issues, please see the docs for each respective application:

1. [Processing](https://processing.org/reference/)
2. [Spout](http://spout.zeal.co/)
	1. [Syphon](http://syphon.v002.info/)
3. [Resolume Arena/Avenue](https://resolume.com/)
	1. [Millumin](https://millumin2.com)


## FAQ/Common Issues
```A library requires native code that is not imported```

Make sure you are running the correct ```.dll``` files for your OS. 

This issue is usually caused by a 32-bit .dll being imported for a 64-bit and vice versa. These files can be found in their respective folders in the Spout directory: ```Spout/PROCESSING/```

Make sure you are connecting to the websocket server either locally or through HTTP. HTTPS doesn't behave very well with the webbitserver library.

My web browser isn't connecting to the websocket server!

Make sure that you are edit the IP address in ```sender.html``` to match up with the IP address of your machine.