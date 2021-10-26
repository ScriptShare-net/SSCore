$(function () {

	// Whole bunch of math to calculate the circle progress

	// Engine circle has been commented out since it was not asked to be
	// implemented in the v.1

	// Circle stuff - (!) Don't touch if you don't know what you're doing (!) ------------------------------------------------
	var circle = document.querySelector('.progress-ring__circle');
	var fuel = document.querySelector('.fuel-ring__circle');
	/* var engine = document.querySelector('.engine-ring__circle'); */
	var lock = document.querySelector('.lock-ring__circle');
	var belt = document.querySelector('.belt-ring__circle');
    var hungerring = document.querySelector('.hunger-ring__circle');
    var thirstring = document.querySelector('.thirst-ring__circle');
	var radius = circle.r.baseVal.value;
	var fuelradius = fuel.r.baseVal.value;
	var hungerradius = hungerring.r.baseVal.value;
    var thirstradius = thirstring.r.baseVal.value;
	// var engineradius = engine.r.baseVal.value;
	//var lockradius = lock.r.baseVal.value;
	//var beltradius = belt.r.baseVal.value;
	var circumference = radius * 2 * Math.PI;
	var fuelcircumference = fuelradius * 2 * Math.PI;
	var hungerringcircumference = hungerradius * 2 * Math.PI;
    var thirstringcircumference = thirstradius * 2 * Math.PI;
	// var enginecircumference = engineradius * 2 * Math.PI;
	//var lockcircumference = lockradius * 2 * Math.PI;
	//var beltcircumference = beltradius * 2 * Math.PI;

	// HTML vars ------------------------------------------------
	// Used Variables
	var speed = $("#speed");
	var km = $("#kmh");
	var circles = $("#circles");
	var container = $("#container");
	var direction = $("#direction");
	var road = $("#road");
	var suburb = $("#suburb");
	var speedometer = $("#speedometer");
	var speedcircle = $("#speedcircle");
	var fuelcircle = $("#fuelcircle");
	var beltcircle = $("#beltcircle");
	var lockcircle = $("#lockcircle");
	var whisper = $("#whisper");
	var normal = $("#normal");
	var shout = $("#shout");
	var tbelt = document.getElementById('togglebelt');
	var tlock = document.getElementById('togglelock');
	var hna = $(".show_bar_2");
	var armour = $("#armour");
	var health = $("#health");
	var hidec = $("#hide-circle");
	var hunger = $(".hunger-container")
	var thirst = $(".thirst-container")
	//var bon = new Audio("f_belton.mp3");
	//var boff = new Audio("f_beltoff.mp3");
	//var carl = new Audio("f_carl.mp3");
	//var caru = new Audio("f_caru.mp3");

	// Engine circle - Enable this along with html/css if wanting to show cars engine health.
	// var enginecircle = $("#enginecircle");
	// Temporary disabled variables
	// var fuelicon = $("#ficon");
	// var fuel = $("#fuel");
	// var belt = $("#belt");


	// Offset math for circles ------------------------------------------------------------------------
	circle.style.strokeDasharray = `${circumference} ${circumference}`;
	circle.style.strokeDashoffset = `${circumference}`;
	fuel.style.strokeDasharray = `${fuelcircumference} ${fuelcircumference}`;
	fuel.style.strokeDashoffset = `${fuelcircumference}`;
	hungerring.style.strokeDasharray = `${hungerringcircumference} ${hungerringcircumference}`;
	hungerring.style.strokeDashoffset = `${hungerringcircumference}`;
	thirstring.style.strokeDasharray = `${thirstringcircumference} ${thirstringcircumference}`;
	thirstring.style.strokeDashoffset = `${thirstringcircumference}`;
	// lock.style.strokeDasharray = `${lockcircumference} ${lockcircumference}`;
	// lock.style.strokeDashoffset = `${lockcircumference}`;
	// belt.style.strokeDasharray = `${beltcircumference} ${beltcircumference}`;
	// belt.style.strokeDashoffset = `${beltcircumference}`;
	// engine.style.strokeDasharray = `${enginecircumference} ${enginecircumference}`;
	// engine.style.strokeDashoffset = `${enginecircumference}`;

	// Functions ------------------------------------------------------------------------------------------------
	function setProgress(percent) {
		$(".progress-ring__circle").css("stroke-dashoffset", circumference - percent / 100 * circumference);
		$("#speednumber").text(Math.floor(percent));
	}

	function setFuel(percent) {
		$(".fuel-ring__circle").css("stroke-dashoffset", fuelcircumference - percent / 100 * fuelcircumference);
	}

	function setHunger(percent) {
		$(".hunger-ring__circle").css("stroke-dashoffset", hungerringcircumference - percent / 100 * hungerringcircumference);
	}

	function setThirst(percent) {
		$(".thirst-ring__circle").css("stroke-dashoffset", thirstringcircumference - percent / 100 * thirstringcircumference);
	}

	// function setEngine(percent) {
	// 	const offset = enginecircumference - percent / 100 * enginecircumference;
	// 	engine.style.strokeDashoffset = offset;
	// }

	// function setLock(percent) {
	// 	const offset = lockcircumference - percent / 100 * lockcircumference;
	// 	lock.style.strokeDashoffset = offset;
	// }

	// function setBelt(percent) {
	// 	const offset = beltcircumference - percent / 100 * beltcircumference;
	// 	belt.style.strokeDashoffset = offset;
	// }

	function toggleBelt(value) {
		if (value) {
			tbelt.style.color = "green";
		} else if (value == false) {
			tbelt.style.color = "white";
		}
	}

	function toggleLock(value) {
		if (value) {
			tlock.style.color = "green";
		} else if (value == false) {
			tlock.style.color = "white";
		}
	}

	function hideHud() {
		var itemDivs = document.getElementById("container").children;
		for (var i = 0; i < itemDivs.length; i++) {
			if (i > 2) {
				itemDivs[i].hide();
			}
		}
	}

	function showHud() {
		var itemDivs = document.getElementById("container").children;
		for (var i = 0; i < itemDivs.length; i++) {
			if (i > 2) {
				itemDivs[i].show();
			}
		}
	}

	function listHud() {
		container.show();
		circles.show();
		km.show();
		hidec.show();
		speed.show();
		speedcircle.show();
		fuelcircle.show();
		lockcircle.show();
		beltcircle.show();
		hna.show();
		armour.show();
		health.show();
		$(".speedometer").show();
		$(".fuel").show();
		$(".lock").show();
		$(".belt").show();
		$(".hunger-container").css({"left": "130px", "top": "10px"});
		$(".thirst-container").css({"left": "180px", "top": "10px"});
	}

	function unlistHud() {
		//container.hide();
		circles.hide();
		km.hide();
		hidec.hide();
		speed.hide();
		speedcircle.hide();
		fuelcircle.hide();
		lockcircle.hide();
		beltcircle.hide();
		$(".speedometer").hide();
		$(".fuel").hide();
		$(".lock").hide();
		$(".belt").hide();
		$(".hunger-container").css({"left": "32px", "top": "50px"});
		$(".thirst-container").css({"left": "80px", "top": "50px"});
	}

	function hnaShow() {
		hna.show();
		armour.show();
		health.show();
	}

	function hnaHide() {
		hna.show();
	}

	/*
		function playBeltOn() {
			bon.play();
		}
		
		function playLockOn() {
			carl.play();
		}
		
		function playBeltOff() {
			boff.play();
		}
		
		function playLockOff() {
			caru.play();
		}
		*/

	window.addEventListener("message", function (event) {

		// Showing and Hiding the HUD ------------------------
		if (event.data.hidehud) {
			unlistHud();
			//hideHud();
		} else if (event.data.hidehud == false) {
			showHud();
		}

		if (event.data.showhud) {
			listHud();
		} else if (event.data.showhud == false) {
			unlistHud();
		}


		//Circle Calculations (Top speed == Circles length) ------------------------
		// Speed KM Circle
		if (event.data.speed < 351 && event.data.speed > 0) {
			setProgress(event.data.speed / 4.2);
		} else if (event.data.speed == 0) {
			setProgress(0);
		}
		// Fuel Circle
		if (event.data.fuel < 101 && event.data.fuel > -1) {
			setFuel(event.data.fuel * 0.82);
		}
		// Hunger Circle
		if (event.data.hunger < 100 && event.data.hunger > -1) {
			setHunger(event.data.hunger);
			$(".hunger-container").show();
		} else if (event.data.hunger == 100) {
			$(".hunger-container").hide();
		}
		// Thirst Circle
		if (event.data.thirst < 100 && event.data.thirst > -1) {
			setThirst(event.data.thirst);
			$(".thirst-container").show();
		} else if (event.data.thirst == 100) {
			$(".thirst-container").hide();
		}
		//		if (event.data.lock < 2 && event.data.lock > -1) {
		//			setLock(event.data.lock * 0.82);
		//		}
		//		if (event.data.belt < 2 && event.data.belt > -1) {
		//			setBelt(event.data.belt * 0.82);
		//		}
		// if (event.data.engine < 1001 && event.data.engine > -1) {
		// 	setEngine(event.data.engine * 0.082);
		// }


		// Toggling Belt and lock on and off ------------------------
		if (event.data.belt) {
			toggleBelt(true);
			//playBeltOn();
		} else if (event.data.belt == false) {
			toggleBelt(false);
			//playBeltOff();
		}

		if (event.data.lock) {
			toggleLock(true);
			//playLockOn();
		} else if (event.data.lock == false) {
			toggleLock(false);
			//playLockOff();
		}

		// Address updating text  ------------------------
		if (event.data.locations) {
			road.text(event.data.road);
			suburb.text(event.data.suburb);
			direction.text(event.data.direction);
			// locationa.css('height', "20px");
		} else if (event.data.locations == false) {
			locationa.css('height', "0px");
		}

		// Health bar and armor toggling ------------------------
		if (event.data.healthshow) {
			hnaShow();
			hna.css('height', "11px");
			health.css('width', event.data.health + '%');
			armour.css('width', event.data.armour + '%');
		} else {
			return
		}
	});

	// Rescaling the extension depending on players resolution
	//var scalex = ($("#container").width() / $("body").width()) * ($("body").width() / 1920);
	//var scaley = ($("#container").height() / $("body").height()) * ($("body").height() / 1080);
	//$("#container").css("transform", "scale(" + scalex + ", " + scaley + ")");
	//$("#container").width($("#container")[0].scrollWidth / scalex + "px").height($("#container")[0].scrollHeight / scaley + "px");

});