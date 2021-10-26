$(function () {
	$('body').fadeOut();

	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'open':
				$('body').fadeIn();
				break;

			case 'close':
				$('body').hide();
				break;

			case 'updatePlayerJobs':
				var ed = event.data.jobs;
				$('#player_count').html(ed.player_count);
				
				if (ed.house == "yes") {
					$("#house").show();
				} else {
					$("#house").hide();
				}
				if (ed.bank == "yes") {
					$("#bank").show();
				} else {
					$("#bank").hide();
				}
				if (ed.drugs == "yes") {
					$("#drugs").show();
				} else {
					$("#drugs").hide();
				}
				if (ed.jewellery == "yes") {
					$("#jewellery").show();
				} else {
					$("#jewellery").hide();
				}
				if (ed.convenience == "yes") {
					$("#convenience").show();
				} else {
					$("#convenience").hide();
				}
				if (ed.house == "yes" || ed.bank == "yes" || ed.drugs == "yes" || ed.jewellery == "yes" || ed.convenience == "yes") {
					$("#spacer").show();
				} else {
					$("#spacer").hide();
				}
				break;

			case 'updatePlayerList':
				$('.players').remove();
				$('#playerlist').append(event.data.players);
				break;

			case 'updateServerInfo':
				if (event.data.maxPlayers) {
					$('#max_players').html(event.data.maxPlayers);
				}

				if (event.data.uptime) {
					$('#server_uptime').html(event.data.uptime);
				}

				if (event.data.playTime) {
					$('#play_time').html(event.data.playTime);
				}
				break;

			default:
				console.log('doppler_scoreboard: unknown action!');
				break;
		}
	}, false);
});