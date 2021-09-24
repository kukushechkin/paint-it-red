(function() {
    browser.runtime.sendMessage({ greeting: "hello" }).then((response) => {
        console.log("Received response: ", response);
    });

    browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
        console.log("Received request: ", request);
    });

    themeColor = document.createElement('meta');
    themeColor.name = "theme-color";
    themeColor.content = "#00ee00"
    document.getElementsByTagName('head')[0].appendChild(themeColor);

})()
