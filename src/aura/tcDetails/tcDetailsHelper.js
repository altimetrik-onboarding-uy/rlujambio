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
	},

	reOrder : function (component,steps,step,oldIndex,index){
		var stepsToUpdate = [];
		var tcId = steps[0].Test_Case__c;

		if(oldIndex > index){
			var i = index;
			for(i; i < oldIndex; i++){
				steps[i].Order__c = steps[i].Order__c + 1;
				stepsToUpdate.push(steps[i]);
			}
			steps[oldIndex].Order__c = index;
			stepsToUpdate.push(steps[oldIndex]);
		}
		else{
			if(oldIndex < index){
				var i = oldIndex + 1;
				for(i; i <= index; i++){
					steps[i].Order__c = steps[i].Order__c - 1;
					stepsToUpdate.push(steps[i]);
				}
				steps[oldIndex].Order__c = index;
				stepsToUpdate.push(steps[oldIndex]);
			}
		}

		var action = component.get("c.updateSteps");
		action.setParams({"steps": stepsToUpdate, "tcId": tcId});

		action.setCallback(this, function(response){
			var state = response.getState();
			if(state == "SUCCESS"){
				var newsteps = response.getReturnValue();
				component.set("v.steps", newsteps);
			}
		})

		$A.enqueueAction(action);
	},
})