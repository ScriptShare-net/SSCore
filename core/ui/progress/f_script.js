$(function () {
	$('body').fadeOut();

	var circle = document.querySelector('.progress-ring__circle');
	var radius = circle.r.baseVal.value;
	var circumference = radius * 2 * Math.PI;
	circle.style.strokeDasharray = `${circumference} ${circumference}`;
	circle.style.strokeDasharray = circumference;

	function setProgress(percent) {
		$(".progress-ring__circle").css("stroke-dashoffset", circumference - percent / 100 * circumference);
	}

	function start(length) {
		var progress = 0;
		setProgress(progress);
		$('body').fadeIn();
		var interval = setInterval(function(){
			if (progress >= 99) {
				$('body').fadeOut();
				$.post("http://SSCore/post", JSON.stringify({identifier: "Progress", name: "finished"}));
				clearInterval(interval);
			};
			progress = progress + 1;
			setProgress(progress);
		}, (length * 1000) / 100);
	}

	window.addEventListener('message', function (event) {
		if (event.data.start) {
			start(event.data.length);
		}
	});
});