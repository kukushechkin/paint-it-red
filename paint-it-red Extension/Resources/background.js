(function() {
    browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
        console.log("Received request: ", request);
        // await
        browser.runtime.sendNativeMessage("application.id", { host: request["host"] }, function(response) {
            console.log("Received sendNativeMessage response: ", response);
            sendResponse({ "theme-color": response["theme-color"] });
        });
        return true;
    });
})();
