$(function () {
	$(".top-container-container").hide();
	$(".bottom-container-container").hide();
	
	var itemnumber = 0;
	var iteminspect = 0;
	var hotbarid = "";
	var pickupitem = "";
	var hoveritem = 0;
	var draggingelement;
	var splitnumber = 0;
	var divlist = [
		"wallet",
		"helmet",
		"armor",
		"holster",
		"hat",
		"mask",
		"glasses",
		"ear",
		"jacket",
		"shirt",
		"pants",
		"shoes",
		"watch",
		"chain",
		"primary",
		"secondary",
		"pistol",
		"knife",
		"vest",
		"backpack"
	]
	var hotbarlist = [
		"hotbar-1",
		"hotbar-2",
		"hotbar-3",
		"hotbar-4",
		"hotbar-5",
		"hotbar-6",
		"hotbar-7",
		"hotbar-8",
		"hotbar-9",
		"hotbar-0"
	]
	
	for (var k in hotbarlist) {
		$("#"+hotbarlist[k]).droppable({
			hoverClass: "item-cell-hover",
			drop: function(event, ui) {
				if (event.originalEvent.target.id == "inspect-bar")
                    return;
				$(this).empty();
				//$(this).append($("#" + pickupitem).clone().show()[0]);
				var container = $("#"+pickupitem).parent().attr("id");
				var x = $("#"+pickupitem).attr("data-x");
				var y = $("#"+pickupitem).attr("data-y");
				var slot = $(this).attr("id");
				$.post("http://SSCore/post", JSON.stringify({identifier: "Inventory", name: "hotbarItem", args: {
					slot: slot,
					container: container,
					y: y,
					x: x
				}}));
				return;
			}
		})
	}
	
	for (var k in divlist) {
		$("#"+divlist[k]).addClass("empty");
		$("#"+divlist[k]).droppable({
			hoverClass: "item-cell-hover",
			drop: function(event, ui) {
				if (event.originalEvent.target.id == "inspect-bar")
                    return;
				if ($("#"+pickupitem).attr("data-type") != $("#"+event.target.id).attr("data-type"))
					return;
				for (i = 0; i <= itemnumber; i++) {
					if (event.target.id == $("#"+i).parent().attr('id'))
						return;
				}
				var positionx = ui.helper.position().left - $("#"+event.target.id).offset().left;
				var positiony = ui.helper.position().top - $("#"+event.target.id).offset().top;
				var pos = GetSlot(positionx, positiony);
				var row = Number($("#" + pickupitem).attr("data-y"));
				var column = Number($("#" + pickupitem).attr("data-x"));
				var name = $("#" + pickupitem).attr("data-name");
				var newcontainer = event.target.id;
				var container = $("#" + pickupitem).parent().attr("id");
				var x = pos[0];
				var y = pos[1];
				var rotated = $("#"+pickupitem).attr("data-rotated");
				if (x <= 0 || y <= 0) {
					return;
				}
				if (row == y && column == x && container == newcontainer) {
					return;
				}
				if (rotated == "true") {
					rotated = false;
					var w = $("#" + pickupitem).attr("data-w");
					var h = $("#" + pickupitem).attr("data-h");
					$("#" + pickupitem).attr("data-w", h);
					$("#" + pickupitem).attr("data-h", w);
					$("#"+pickupitem).find(".itembackground").css({"background-image": "url("+ $("#"+pickupitem).attr("data-img") +")"});
				} else if (rotated == "false") {
					rotated = false;
				}
				$.post("http://SSCore/post", JSON.stringify({identifier: "Inventory", name: "moveItem", args: {name, container, row, column, newcontainer, y, x, rotated}}));
				$("#" + pickupitem).detach().appendTo("#" + event.target.id);
				$("#"+event.target.id).removeClass("empty");
			}
		})
	}

	function GetSlot(x, y) {
		return [Math.round(x / 60) + 1, Math.round(y / 60) + 1];
	}

	function CreateInv(classname, columns, rows) {
		$("."+classname).css("grid-template-columns", "repeat( " + columns + ", 60px)");
		$("."+classname).css("grid-template-rows", "repeat( " + rows + ", 60px)");
		$("."+classname).css("width", (columns * 60) + ((columns - 1) * $("."+classname).css("column-gap")) + "px")
		$("."+classname).attr("data-width", columns);
		$("."+classname).attr("data-height", rows);
		$("."+classname).droppable({
			drop: function(event, ui) {
				if (event.originalEvent.target.id == "inspect-bar")
                    return;
				if ($(this)[0].id == "backpack-inside" && $("#" + pickupitem).attr("data-type") == "backpack")
					return;
				var positionx = ui.helper.position().left - $("#"+event.target.id).offset().left;
				var positiony = ui.helper.position().top - $("#"+event.target.id).offset().top;
				var pos = GetSlot(positionx, positiony);
				var width = Number($("#" + event.target.id).attr("data-width"));
				var height = Number($("#" + event.target.id).attr("data-height"));
				var itemwidth = Number($("#" + pickupitem).attr("data-w"));
				var itemheight = Number($("#" + pickupitem).attr("data-h"));
				if (pos[0] > width || pos[1] > height)
					return;
				if (itemwidth > width || itemheight > height)
					return;
				if (pos[0] + itemwidth > width + 1 || pos[1] + itemheight > height + 1)
					return;
				for (i = 0; i <= itemnumber; i++) {
					var x = Number($("#" + i).attr("data-x"));
					var y = Number($("#" + i).attr("data-y"));
					var w1 = Number($("#" + i).attr("data-w"));
					var h1 = Number($("#" + i).attr("data-h"));
					for (w = 0; w < itemwidth; w++) {
						for (h = 0; h < itemheight; h++) {
							if (event.target.id == $("#"+i).parent().attr('id')) {
								if (i != pickupitem) {
									if (w + pos[0] >= x && w + pos[0] < x + w1 && h + pos[1] >= y && h + pos[1] < y + h1) {
										return;
									}
								}
							}
						}
					}
				}
				
				var x = pos[0];
				var y = pos[1];
				var width = Number($("#" + pickupitem).attr("data-w"));
				var height = Number($("#" + pickupitem).attr("data-h"));
				var row = Number($("#" + pickupitem).attr("data-y"));
				var column = Number($("#" + pickupitem).attr("data-x"));
				var name = $("#" + pickupitem).attr("data-name");
				var newcontainer = event.target.id;
				var container = $("#" + pickupitem).parent().attr("id");
				var rotated = $("#"+pickupitem).attr("data-rotated");
				if (x <= 0 || y <= 0) {
					return;
				}
				if (row == y && column == x && container == newcontainer && rotated == $(draggingelement).attr("data-rotated")) {
					return;
				}
				if (rotated == "true") {
					rotated = true;
				} else if (rotated == "false") {
					rotated = false;
				}
				if (rotated == true) {
					$("#"+pickupitem).find(".itembackground").css({"background-image": "url("+ $("#"+pickupitem).attr("data-rotatedimg") +")"});
				} else if (rotated == false) {
					$("#"+pickupitem).find(".itembackground").css({"background-image": "url("+ $("#"+pickupitem).attr("data-img") +")"});
				}
				var split = splitnumber;
				$.post("http://SSCore/post", JSON.stringify({identifier: "Inventory", name: "moveItem", args: {name, container, row, column, newcontainer, y, x, rotated, split}}));
				splitnumber = 0;
				$("#" + pickupitem).css({ "grid-row": y + " / span " + height, "grid-column": x + " / span " + width });
				$("#" + pickupitem).attr("data-x", x);
				$("#" + pickupitem).attr("data-y", y);
				$("#" + pickupitem).detach().appendTo("#" + event.target.id);
			}
		});
	}

	function AddItem(x, y, width, height, name, amount, classname, background, type, data, rotated, rotatedimage) {
		var data = data || {};
		var idnumber = 0;
		itemnumber++;
		idnumber = itemnumber;
		if (classname == "backpack" && type == "backpack")
			CreateInv("backpack-inside", data["width"], data["height"]);
		if (amount == 1) {
			amountnumber = "";
		} else {
			amountnumber = amount;
		}
		if (rotated) {
			$("."+classname).append("<div id=\"" + idnumber + "\" class=\"item\" data-w=\"" + width + "\" data-h=\"" + height + "\"><div class=\"itemname\" id=\""+ idnumber + "-name\">" + name + "</div><div class=\"itembackground\" id=\""+ idnumber + "-background\" style=\"background-image\: url("+ rotatedimage + ")\"></div><div class=\"itemamount\" id=\"" + idnumber + "-amount\">" + amountnumber + "</div></div>");
		} else {
			$("."+classname).append("<div id=\"" + idnumber + "\" class=\"item\" data-w=\"" + width + "\" data-h=\"" + height + "\"><div class=\"itemname\" id=\""+ idnumber + "-name\">" + name + "</div><div class=\"itembackground\" id=\""+ idnumber + "-background\" style=\"background-image\: url("+ background + ")\"></div><div class=\"itemamount\" id=\"" + idnumber + "-amount\">" + amountnumber + "</div></div>");
		}
		$("#"+idnumber).css({"grid-row": y + " / span " + height, "grid-column": x + " / span " + width});
		$("#"+idnumber).attr("data-id", idnumber);
		$("#"+idnumber).attr("data-name", name);
		$("#"+idnumber).attr("data-img", background);
		$("#"+idnumber).attr("data-x", x);
		$("#"+idnumber).attr("data-y", y);
		$("#"+idnumber).attr("data-amount", amount);
		$("#"+idnumber).attr("data-type", type);
		$("#"+idnumber).attr("data-rotated", rotated);
		$("#"+idnumber).attr("data-rotatedimg", rotatedimage);
		$("."+classname).removeClass("empty");
		$("#"+idnumber).attr("data", JSON.stringify(data));
		$("#"+idnumber).mouseover(function() {
			hoveritem = idnumber;
		});
		$("#"+idnumber).mouseleave(function() {
			hoveritem = 0;
		});
		$("#"+idnumber).draggable({	
			revert: 'invalid',
			scroll: false,
			helper: function() {
				return $(this).clone();
			},
			stack: "document",
			appendTo: "body",
			start: function(event, ui) {
				$(".context-menu").hide();
				$(".hotbar-menu").hide();
				$(this).parent().addClass("empty");
				$(this).hide();
				pickupitem = $(this)[0].id;
				$(ui.helper).width(60 * Number($(this).attr("data-w")));
				$(ui.helper).height(60 * Number($(this).attr("data-h")));
				$(ui.helper).css("position", "absolute");
				draggingelement = ui.helper;
				$(draggingelement).attr("data-y", $(this).attr("data-y"));
				$(draggingelement).attr("data-x", $(this).attr("data-x"));
				$(draggingelement).attr("data-parent", $(this).parent().attr("id"));
				$(ui.helper).css({"z-index": "99999"});
			},
			stop: function(event, ui) {
				$(this).show();
				$(this).parent().removeClass("empty");
				$(draggingelement).width(60 * Number($(this).attr("data-w")));
				$(draggingelement).height(60 * Number($(this).attr("data-h")));
				pickupitem = 0;
				draggingelement = "";
				if ($(this).parent()[0] == undefined) { 
					return; 
				}
			}
		});
		$("#"+idnumber).droppable({
			drop: function(event, ui) {
				var row = Number($("#" + pickupitem).attr("data-y"));
				var column = Number($("#" + pickupitem).attr("data-x"));
				var name = $("#" + pickupitem).attr("data-name");
				var newcontainer = $("#" + idnumber).parent().attr("id");
				var container = $("#" + pickupitem).parent().attr("id");
				var x = Number($("#" + idnumber).attr("data-x"));
				var y = Number($("#" + idnumber).attr("data-y"));
				var rotated = $("#"+idnumber).attr("data-rotated");
				var stack = true;
				var split = splitnumber;
				if (name == $("#"+idnumber).attr("data-name")) {
					$.post("http://SSCore/post", JSON.stringify({identifier: "Inventory", name: "moveItem", args: {name, container, row, column, newcontainer, y, x, rotated, stack, split}}));
					splitnumber = 0;
				}
			}
		});
	}

	//AddItem(1, 1, 1, 1, "Hat", 1, "hat", "", "hat");
	//CreateInv("stash", 10, 20);
	//AddItem(1, 1, 3, 2, "Pistol", 1, "stash", "https://cdn.discordapp.com/attachments/634645008364077057/818040369689657344/ap-pistol-item.png", "pistol");
	//AddItem(1, 3, 3, 2, "Pistol", 1, "stash", "https://cdn.discordapp.com/attachments/634645008364077057/818040369689657344/ap-pistol-item.png", "pistol");
/*
	AddItem(1, 1, 2, 2, "Pistol", "stash", "https://cdn.discordapp.com/attachments/634645008364077057/818040369689657344/ap-pistol-item.png", "pistol");
	//AddItem(1, 1, 1, 1, "Money $1,000", "backpack-inside", "", "cash");
	AddItem(3, 3, 2, 2, "Knife", "stash", "", "melee");
	AddItem(1, 1, 1, 1, "Hat", "hat", "", "hat");
	AddItem(1, 1, 6, 2, "Rifle", "primary", "", "primary");
	AddItem(1, 1, 6, 2, "Rifle", "hotbar-1", "", "primary");
	AddItem(1, 1, 4, 6, "Backpack", 1, "backpack", "", "backpack", {name: "backpack", width: 7, height: 10, items : {}});
	//AddItem(5, 1, 4, 6, "Backpack2", 1, "backpack", "", "backpack", {name: "backpack2", width: 5, height: 10, items: [{x: 1, y: 1, w: 2, h: 2, count: 1, name: "Knife", img: "", type: "melee"}, {x: 3, y: 1, w: 2, h: 2, count: 1, name: "Knife2", img: "", type: "melee"}]});
	//AddItem(4, 4, 4, 4, "test", "stash");*/

	// Start Fivem Script

	CreateInv("flpocket", 1, 2);
	CreateInv("frpocket", 1, 2);
	CreateInv("blpocket", 1, 2);
	CreateInv("brpocket", 1, 2);

	function rotateItem(id) {
		var width = Number($("#"+id).attr("data-w"));
		var height = Number($("#"+id).attr("data-h"));
		var x = Number($("#"+id).attr("data-x"));
		var y = Number($("#"+id).attr("data-y"));
		/* console.log("Rotate:", id)
		for (var s in $("#"+id)) {
			console.log(s, $("#"+id)[s])
		} */
		if ($("#"+id).parent().attr('id') == "stash" || $("#"+id).parent().attr('id') == "backpack-inside") {
			for (var k in $("#"+id)[0].parentNode.children) {
				var id2 = $("#"+id)[0].parentNode.children[k].id;
				var width2 = Number($("#"+id2).attr("data-w"));
				var height2 = Number($("#"+id2).attr("data-h"));
				var x2 = Number($("#"+id2).attr("data-x"));
				var y2 = Number($("#"+id2).attr("data-y"));
				if (id != id2) {
					for (var w = 0; w < height; w++) {
						for (var h = 0; h < width; h++) {
							for (var w2 = 0; w2 < width2; w2++) {
								for (var h2 = 0; h2 < height2; h2++) {
									if (x + w == x2 + w2 && y + h == y2 + h2) {
										return;
									}
								}
							}
						}
					}
				}
			}
			var name = $("#"+id).attr("data-name");
			var container = $("#"+id)[0].parentNode.id;
			var newcontainer = container;
			var rotated = $("#"+id).attr("data-rotated");
			var row = y;
			var column = x;
			if (rotated == "true") {
				rotated = false;
			} else if (rotated == "false") {
				rotated = true;
			}
			$.post("http://SSCore/post", JSON.stringify({identifier: "Inventory", name: "moveItem", args: {name, container, row, column, newcontainer, y, x, rotated}}));
			$("#"+id).attr("data-rotated", rotated);
		}
	}

	//rotateItem(1)

	//Inspect Menu
	function inspectItem(id) {
		var name = $("#"+id).attr("data-name");
		var image = $("#"+id).attr("data-img");
		var amount = $("#"+id).attr("data-amount");
		var type = $("#"+id).attr("data-type");
		var data = $("#"+id).attr("data");
		$(".inspect-container").css({top: 450, left: 729.6,});
		$(".inspect-container").show();
		$(".name").html(name);
		$(".inspect-content").hide();
		$(".inspect-attachments").hide();
		$(".inspect-backpack").hide();
		$(".inspect-list").html("");
		if (type != "backpack") {
			$(".inspect-container").css({"padding-bottom": "10px"});
			var count = 0;
			for (var k in data) {
				count++;
				$(".inspect-list").append("<li>" + k + ": " + data[k] + "</li>");
			}
			if (count != 0) $(".inspect-container").css({"padding-bottom": "20px"});
			$(".inspect-content").show();
			$(".item-amount").html(amount);
			$(".item-image").attr("src", image)
			if (type == "primary" || type == "pistol") {
				$(".inspect-attachments").show();
				CreateInv("inspect-a1", 1, 1);
				CreateInv("inspect-a2", 1, 1);
				CreateInv("inspect-a3", 1, 1);
				CreateInv("inspect-a4", 1, 1);
				CreateInv("inspect-a5", 1, 1);
			}
		} else {
			$(".inspect-backpack").show();
			CreateInv("inspect-backpack", 5, 5);
			$(".inspect-container").css({"padding-bottom": "30px"});
			//need to do containers
		}
	}

	//inspectItem("BackPack", "https://cdn.discordapp.com/attachments/634638004408811520/823083573728378880/assault-rifle.png", 1, "backpack", {})

	$(".inspect-container").draggable({handle: $(".inspect-bar"), start: function() {$(".context-menu").hide(); $(".hotbar-menu").hide();}});

	$(".inspect-close").click(function() {
		$(".inspect-container").hide();
	});


	$(".input-submit").click(function() {
		if ($("#number-amount").val() == "") return;
		splitnumber = $("#number-amount").val();
		$("#number-amount").val(null);
		$(".input-container").hide();
	});
	$(".input-cancel").click(function() {
		$("#number-amount").val(null);
		$(".input-container").hide();
	});

	for (var i = 1; i <= 5; i++) {
		$(".inspect-a"+i).droppable({
			drop: function(event, ui) {
				if (event.originalEvent.target.id == "inspect-bar")
                    return;
				console.log(event, ui);
			}
		});
	}

	$(".input-container").hide();
	$(".context-menu").hide();
	$(".hotbar-menu").hide();

	/* $(document).bind('contextmenu click',function(){
		$(".context-menu").hide();
	}); */

	
	$(".context-split").click(function() {
		$(".input-container").show();
		$("#number-amount").focus();
		$(".context-menu").hide();
	});

	$(".context-inspect").click(function() {
		inspectItem(iteminspect);
		$(".context-menu").hide();
	});

	$(".context-reload").click(function() {
		console.log("cancel");
		$(".context-menu").hide();
	});

	$(".context-unload").click(function() {
		console.log("cancel");
		$(".context-menu").hide();
	});

	$(".context-rotate").click(function() {
		rotateItem(iteminspect);
		console.log(iteminspect);
		$(".context-menu").hide();
	});

	$(".hotbar-remove").click(function() {
		console.log("clear "+hotbarid)
		$(".hotbar-menu").hide();
	});

	$(".hotbar-emotes").click(function() {
		console.log("emotes "+hotbarid)
		$(".hotbar-menu").hide();
	});


	window.addEventListener('message', function (event) {
		if (event.data.show) {
			//$("body").show();
			$(".top-container-container").show();
			$("#backpack-inside").hide();
			$("#backpack-inside").empty();
			$("body").css("background-color", "rgba(0, 0, 0, 0.562);");
			
			for (var k in divlist) {
				$("."+divlist[k]).empty();
				$("#"+divlist[k]).addClass("empty");
			}

			$(".flpocket").empty();
			$(".frpocket").empty();
			$(".blpocket").empty();
			$(".brpocket").empty();

			if (event.data.stash.length != 0) {
				$(".right-container").show();
				$(".title").html(event.data.name);
				$(".stash").empty();
				CreateInv("stash", event.data.stash.width, event.data.stash.height);
				for (var k in event.data.stashcontent) {
					var item = event.data.stashcontent[k];
					AddItem(item.column, item.row, item.width, item.height, item.name, item.count, item.container, item.image, item.type, item.data, item.rotated, item.rotatedimage);
				}
			} else {
				$(".right-container").hide();
			}
			for (var k in event.data.contents) {
				var item = event.data.contents[k];
				AddItem(item.column, item.row, item.width, item.height, item.name, item.count, item.container, item.image, item.type, item.data, item.rotated, item.rotatedimage);
				if (item.container == "backpack") {
					$("#backpack-inside").show();
					CreateInv("backpack-inside", item.data[0]["width"], item.data[0]["height"]);
					for (var k2 in item.data[0].items) {
						var subitem = item.data[0].items[k2];
						AddItem(subitem.column, subitem.row, subitem.width, subitem.height, subitem.name, subitem.count, subitem.container, subitem.image, subitem.type, subitem.data, subitem.rotated, subitem.rotatedimage);
					}
				}
			}
		}
		
		if (event.data.hide) {
			//$("body").hide();
			$(".top-container-container").hide();
			$("body").css("background-color", "rgba(0, 0, 0, 0.0);");
		}
		
		if (event.data.hotbar) {
			//$("body").hide();
			$(".bottom-container-container").show();
			if (event.data.hotbardata != null) {
				for (var k in event.data.hotbardata) {
					$("#"+event.data.hotbardata[k].container).children().each(function( index ) {
						if ($(this).attr("data-x") == event.data.hotbardata[k].column && $(this).attr("data-y") == event.data.hotbardata[k].row) {
							$("#hotbar-"+event.data.hotbardata[k].key).css({"background": "url("+$(this).attr("data-img")+"), linear-gradient(0deg, rgba(50, 50, 48, 0.5) 0%, rgba(6, 6, 6, 0.5) 50%)", "background-size": "contain", "background-repeat": "no-repeat", "background-position": "center"});
						}
					});
				}
			}
		} else if (event.data.hotbar == false) {
			$(".bottom-container-container").hide();
		}
	});

	window.addEventListener('keydown', function (event) {
		$(".context-menu").hide();
		$(".hotbar-menu").hide();
		if (event.key == "Escape" || event.key == "Tab") {
			$(".top-container-container").hide();
			$("body").css("background-color", "rgba(0, 0, 0, 0.0);");
			$.post("http://SSCore/post", JSON.stringify({identifier: "Inventory", name: "closeInventory", args: {}}));
		}
		if (event.key == "i") {
			if (hoveritem > 0) {
				var name = $("#"+hoveritem).attr("data-name");
				var image = $("#"+hoveritem).attr("data-img");
				var amount = $("#"+hoveritem).attr("data-amount");
				var type = $("#"+hoveritem).attr("data-type");
				var data = $("#"+hoveritem).attr("data");
				inspectItem(name, image, amount, type, data);
			}
		}
		if (event.key == "r") {
			if (hoveritem > 0) {
				rotateItem(hoveritem);
			} else if (pickupitem > 0) {
				var rotated = $("#"+pickupitem).attr("data-rotated");
				if (rotated == "true") {
					rotated = true;
				} else if (rotated == "false") {
					rotated = false;
				}
				$("#"+pickupitem).attr("data-rotated", !rotated);
				var h = $("#"+pickupitem).attr("data-h");
				var w = $("#"+pickupitem).attr("data-w");
				$(draggingelement).width(60 * Number(h));
				$(draggingelement).height(60 * Number(w));
				$("#"+pickupitem).attr("data-h", w);
				$("#"+pickupitem).attr("data-w", h);
				if ($("#"+pickupitem).attr("data-rotated") == "true") {
					$(draggingelement).find(".itembackground").css({"background-image": "url("+ $("#"+pickupitem).attr("data-rotatedimg") +")"});
					//$("#"+pickupitem).find(".itembackground").css({"background-image": "url("+ $("#"+pickupitem).attr("data-rotatedimg") +")"});
				} else if ($("#"+pickupitem).attr("data-rotated") == "false") {
					$(draggingelement).find(".itembackground").css({"background-image": "url("+ $("#"+pickupitem).attr("data-img") +")"});
					//$("#"+pickupitem).find(".itembackground").css({"background-image": "url("+ $("#"+pickupitem).attr("data-img") +")"});
				}
			}
		}
		/* for (var k in event["target"]) {
			console.log(k, event["target"][k]);
		} */
	}, true);

	window.addEventListener('mousedown', function(event) {
		if (event.button == 2) {
			var item = document.elementFromPoint(event.pageX, event.pageY);
			var classlist = item.classList;
			if (classlist == "itemamount" || classlist == "itembackground" || classlist == "itemname") {
				$(".context-menu").show();
				$(".context-menu").css({left: event.pageX, top: event.pageY});
				iteminspect = item.parentElement.id;
			} else {
				$(".context-menu").hide();
			}
			if ($("#"+item.id).attr("id").includes("hotbar")) {
				$(".hotbar-menu").show();
				$(".hotbar-menu").css({left: event.pageX, top: event.pageY});
				hotbarid = $("#"+item.id).attr("id");
			} else {
				$(".hotbar-menu").hide();
			}
		} else if (event.button == 0) {
			var classlist = document.elementFromPoint(event.pageX, event.pageY).classList;
			if (classlist == "context-split" || classlist == "context-inspect" || classlist == "context-reload" || classlist == "context-unload" || classlist == "context-rotate") {

			} else {
				$(".context-menu").hide();
			}
			if (classlist == "hotbar-remove" || classlist == "hotbar-emotes") {

			} else {
				$(".hotbar-menu").hide();
			}
		} else if (event.button == 1) {
			$(".context-menu").hide();
			$(".hotbar-menu").hide();
		}
	});
})