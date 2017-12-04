({
	onDrop : function(component, event, helper){
		event.preventDefault();
		var evt = component.getEvent("stepChange");
		var step = JSON.parse(event.dataTransfer.getData('text'));
		var index = parseInt(component.get("v.index"));
		evt.setParams({"step": step, "isDrag": false, "index": index});
		evt.fire();
	},

	allowDrop : function(component, event, helper){
		event.preventDefault();
	}
})
