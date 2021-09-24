(function() {
    browser.runtime.sendMessage({ host: window.location.host }).then((response) => {
        console.log("Received response: ", response);

        if(response == undefined) {
            console.log("no theme-color provided, bail out");
            return;
        }

        // remove whatever theme-color exists
        // TODO:

        // inject the new one
        themeColor = document.createElement('meta');
        themeColor.name = "theme-color";
        themeColor.content = response["theme-color"];
        document.getElementsByTagName("head")[0].appendChild(themeColor);
    });

//    browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
//        console.log("Received request: ", request);
//    });
})();
