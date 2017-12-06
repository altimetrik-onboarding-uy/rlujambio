({
	editRecord : function(component, event, helper) {
		var editRecordEvent = $A.get("e.force:editRecord");
    editRecordEvent.setParams({
         "recordId": component.get("v.step.Id")
   });
    editRecordEvent.fire();
	},

	onDragStart : function(component, event, helper){
		event.dataTransfer.dropEffect = "move";
		var step = component.get("v.step");
		var steps = component.get("v.steps");
		var index = steps.indexOf(step);
		event.dataTransfer.setData('text', JSON.stringify(step));

		var evt = component.getEvent("stepChange");
		evt.setParams({"step": step, "isDrag": true, "index": index});
		evt.fire();
	}

})