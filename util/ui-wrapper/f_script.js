$(function () {
	var uiList = [];
	window.addEventListener("message", event => {
		var data = event.data
		var skip = false
		if (data.addon == "ui") {
			if (data.table.identifier != null) {
				uiList.forEach(function(item, index) {
					if (data.table.identifier == item) {
						skip = true;
					}
				})
				if (skip) return false;
				$("<iframe>")
				.attr("src", "nui://"+data.table.addonname+"/"+data.table.htmladd)
				.attr("name", data.table.addonname+"/"+data.table.identifier)
				.attr("id", data.table.identifier)
				.attr("allow", "microphone *; camera *;")
				.attr("tabindex", "-1")
				.attr("style", "visibility: visible; z-index: 0;")
				.appendTo(".ui-body");
				uiList.push(data.table.identifier);
			}
		} else if (data.addon == "ui-post") {
			$.post("http://SSCore/" + data.table.identifier + ":" + data.table.name, JSON.stringify(data.table.args));
		} else if (data.addon == "ui-focus") {
			console.log(data.table.focus);
			if (data.table.focus) {
				console.log($("#" + data.table.identifier).attr("style"));
				$("#" + data.table.identifier).attr("style", "z-index: 999;");
			} else {
				$("#" + data.table.identifier).attr("style", "z-index: 0;");
			}
		} else if (data.addon == "controls") {
			if (data.table.control == "hide") {
				$("#" + data.table.identifier).hide();
			} else if (data.table.control == "show") {
				$("#" + data.table.identifier).show();
			} else if (data.table.control == "showAll") {
				uiList.forEach(function(item, index) {
					$("#" + item).show();
				})
			} else if (data.table.control == "hideAll") {
				uiList.forEach(function(item, index) {
					$("#" + item).hide();
				})
			}
		} else if (data.addon != null) {
			try {
				$("#" + data.addon)[0].contentWindow.postMessage(data.table, "*");
			} catch(err) {
				console.log(err);
			}
		}
	});
});
