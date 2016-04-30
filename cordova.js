if(Meteor.isCordova){
	Meteor.startup(function(){
		document.addEventListener("backbutton", function(){
			if(history.state && history.state.initial === true) {
				navigator.app.exitApp();
			}
			else {
				history.go(-1);
			}
		});
	});
}