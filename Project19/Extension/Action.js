var Action = function() { }

Action.prototype = {
    
run: function(parameters) {
    parameters.completionFunction({"URL": document.URL, "title": document.title});
},
    
finalize: function(parameters) {
    var customJavaScript = parameters["customJavaScript"];
    alert(customJavaScript);
}
    
};

var ExtensionPreprocessingJS = new Action
