({
	getStepsTC : function (component, tc){
		var action = component.get("c.getSteps");
		action.setParams({"tc": tc});

		action.setCallback(this, function(response){
			var state = response.getState();
			if(state == "SUCCESS"){
				var steps = response.getReturnValue();
				component.set("v.steps", steps);
			}
		});

		$A.enqueueAction(action);
	}
})
