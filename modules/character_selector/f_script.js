$(function () {
	var left = $(".left");
	var middle = $(".middle");
	var right = $(".right");
	var leftmap = $(".leftmap");
	var middlemap = $(".middlemap");
	var rightmap = $(".rightmap");
	var leftcreator = $(".leftcreator");
	var middlecreator = $(".middlecreator");
	var rightcreator = $(".rightcreator");

	var spawnLocation = "";

	function toggleDisplay(input) {
		if (input) {
			left.show();
			middle.show();
			right.show();
			leftmap.hide();
			middlemap.hide();
			rightmap.hide();
			leftcreator.hide();
			middlecreator.hide();
			rightcreator.hide();
		} else {
			left.hide();
			middle.hide();
			right.hide();
			leftmap.hide();
			middlemap.hide();
			rightmap.hide();
			leftcreator.hide();
			middlecreator.hide();
			rightcreator.hide();
		}
	}

	function toggleMap(input) {
		if (input) {
			left.hide();
			middle.hide();
			right.hide();
			leftmap.show();
			middlemap.show();
			rightmap.show();
			leftcreator.hide();
			middlecreator.hide();
			rightcreator.hide();
		} else {
			left.hide();
			middle.hide();
			right.hide();
			leftmap.hide();
			middlemap.hide();
			rightmap.hide();
			leftcreator.hide();
			middlecreator.hide();
			rightcreator.hide();
		}
	}

	function toggleCreator(input) {
		if (input) {
			left.hide();
			middle.hide();
			right.hide();
			leftmap.hide();
			middlemap.hide();
			rightmap.hide();
			leftcreator.show();
			middlecreator.show();
			rightcreator.show();
		} else {
			left.hide();
			middle.hide();
			right.hide();
			leftmap.hide();
			middlemap.hide();
			rightmap.hide();
			leftcreator.hide();
			middlecreator.hide();
			rightcreator.hide();
		}
	}

	toggleDisplay(false);

	$("#left").click(function () {
		$.post("https://ui-wrapper/post", JSON.stringify({identifier: "CharacterSelector", name: "prevchar"}));
	});

	$("#right").click(function () {
		$.post("https://ui-wrapper/post", JSON.stringify({identifier: "CharacterSelector", name: "nextchar"}));
	});

	$("#middle").click(function () {
		$.post("https://ui-wrapper/post", JSON.stringify({identifier: "CharacterSelector", name: "spawnsel"}));
	})

	$("#middle").hover(function () {
		$(this).css("background-color", "rgba(155, 155, 155, 0.211)");
	}, function () {
		$(this).css("background-color", "rgba(155, 155, 155, 0.0)");
	})

	$("#pin").click(function () {
		$.post("https://ui-wrapper/post", JSON.stringify({identifier: "CharacterSelector", name: "confirmspawn", args: {
			spawn: spawnLocation
		}}));
	})

	$("#leftmap").click(function () {
		$.post("https://ui-wrapper/post", JSON.stringify({identifier: "CharacterSelector", name: "prevspawn"}));
	});

	$("#rightmap").click(function () {
		$.post("https://ui-wrapper/post", JSON.stringify({identifier: "CharacterSelector", name: "nextspawn"}));
	});

	$(".nbutton").click(function (e) {
		e.preventDefault();
		if ($("#fname").val() == "" || $("#lname").val() == "" || $("#day").val() == "" || $("#month").val() == "" || $("#year").val() == "" || $("#gender").val() == "" || $("#fname").val() == "Create" || $("#lname").val() == "Character") {
			return
		}
		if (!$("#fname").val().charAt(0).match(/[a-zA-Z]/) || !$("#lname").val().charAt(0).match(/[a-zA-Z]/)) {
			return
		}
		if ($("#gender").val() != 0 && $("#gender").val() != 1) {
			return
		}
		if (!$("#day").val().charAt(0).match(/[0-9]/) || !$("#month").val().charAt(0).match(/[0-9]/) || !$("#year").val().charAt(0).match(/[0-9]/)) {
			return
		}
		if ($("#day").val() <= 0 || $("#day").val() >= 32 || $("#month").val() <= 0 || $("#month").val() >= 13 || $("#year").val() <= 1900 || $("#year").val() >= 2005) {
			return
		}
		
		$.post("https://ui-wrapper/post", JSON.stringify({identifier: "CharacterSelector", name: "identity", args: {
			FirstName: $("#fname").val(),
			LastName: $("#lname").val(),
			dob: {
				d: $("#day").val(),
				m: $("#month").val(),
				y: $("#year").val(),
			},
			sex: $("#gender").val(),
		}}));
	});

	window.addEventListener("message", function (event) {
		var item = event.data;
		if (item.show) {
			toggleDisplay(true);
			$('.character').html('<h3>' + item.name + '</h3><p><b>Work:</b> ' + item.job + '</h3><p><b>Gang:</b> ' + item.gang + '</p><p><b>Date of brith:</b> ' + item.dob + '</p><p><b>Gender:</b> ' + item.sex + '</p>');
			$(".spawn").html(item.spawn);
		} else if (item.show == false) {
			toggleDisplay(false);
		}

		if (item.map) {
			toggleMap(true);
			spawnLocation = item.spawnname;
			$(".infospawns").html("<h3 class='spawns'>" + item.spawnname + "</h3><p><b>Coords:</b> " + item.x + ", " + item.y + ", " + item.z + "</p><p>When ready click the pin</p>")
		} else if (item.map == false) {
			toggleMap(false);
		}

		if (item.create) {
			toggleCreator(true);
		} else if (item.create == false) {
			toggleCreator(false);
		}

	});
});