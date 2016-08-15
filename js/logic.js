var debug = true;

if("WebSocket" in window) {
    //MAKE SURE YOU INPUT YOUR IP ADDRESS BEFORE STARTING THE SERVER
    var ws = new WebSocket('ws://10.221.204.37:8080/p5websocket');
    console.log('socket opened', ws);
    console.log('recognition insantiated');
    var recognition = new webkitSpeechRecognition();

} else {
    //not supported
    alert('WebSocket not supported');
}

// debugging keypress events
window.addEventListener('keydown', displayText, false);

function displayText(e) {
    console.log(e.keyCode);

    if(debug) {
        switch (e.keyCode) {
            case 65:
                ws.send("It's so nice to meet you");
                break;
            case 83:
                ws.send("Oh yeah, I know where that is");
                break;
            case 68:
                ws.send("Walk two streets in that direction");
                break;
            case 70:
                ws.send("Happy to help");
                break;
            case 71:
                ws.send("Welcome to Bahston!");
                break;
            case 32:
                ws.send("");
                break;
        }
    }
}

ws.onopen = function() {
    console.log("we're connected", ws);
    document.getElementById('socketURL').innerHTML = ws.url;
}

ws.onclose = function() {
    console.log("we're disconnected", ws);
}

recognition.onstart = function() {
    // permission = true;
    console.log('diction started');
}

recognition.onend = function() {
    // permission = false;
    console.log('diction ended');
    recognition.stop();
}

recognition.onresult = function(event) {
    console.log(event);
    var transcript = event.results[event.results.length-1][0].transcript;

    //add ajax call to translate API here:
    //source is the source language (get this from recognition.lang)
    //target is the target language to be translated TO (en is english)
    //q is query (var transcript)
    //GET https://www.googleapis.com/language/translate/v2?key=AIzaSyC67QxLvpQXXyCI9TWYd5giKl0QeMXHXnU&source=en&target=en&q=Hello%20world

    var request = new XMLHttpRequest();
    var query = 'https://www.googleapis.com/language/translate/v2?key=AIzaSyC67QxLvpQXXyCI9TWYd5giKl0QeMXHXnU&source=en&target=en&q=';
    //append source language
    query = query.replace('source=en', 'source=' + recognition.lang);
    //append transcript
    query += transcript;
    console.log(query);

    request.onreadystatechange = function() {
        if (request.readyState === 4 && request.status === 200) {
            console.log(request.responseText);
            returnedData = JSON.parse(request.responseText);
            //send to websocket
            ws.send(returnedData.data.translations[0].translatedText);
        }
    }


    if (recognition.lang != 'en') {
        //open and send request - unless it's english
        request.open('GET', query, true);
        request.send();
    } else {
        ws.send(transcript);
    }
}

start = document.getElementById('start_diction');

start.onclick = function() {
    recognition.lang = document.getElementById('selectLang').value;
    //only fire speech event when we are connected to the websocket server
    //start speech recognition
    //currently only Chrome supports this
    //add more language codes here:
    //https://sites.google.com/site/tomihasa/google-language-codes

    recognition.continuous = true;
    recognition.interimResults = true;

    recognition.start();
}
