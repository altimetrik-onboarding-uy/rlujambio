({
	handleDetailsTC : function(component, event, helper) {
		var tc = event.getParam("tc");
		var status = event.getParam("status");
		var selectedTC = component.get("v.selectedTC");
		event.stopPropagation();

		if((selectedTC != null) && (tc.Id == selectedTC.Id)){
			component.set("v.selectedTC", tc);
		}
		else{

			if(!((tc.Title__c == 'No Test Case Selected') && (tc.Id != selectedTC.Id))){
				component.set("v.selectedTC", tc);
				if(status){
					var steps = event.getParam("steps");
					component.set("v.steps", steps);
				}
				else{
					helper.getStepsTC(component, tc);
				}

				var button = component.find("newStepButton");
				button.set("v.disabled", status);
			}
		}
	},

	newStep : function(component, event, helper){

		var evt2 = component.getEvent("showStepForm");
		evt2.setParams({"show": true});
		evt2.fire();

		var evt = $A.get("e.c:sendFormTCEvent");
		var tc = component.get("v.selectedTC");
		evt.setParams({"tc": tc});
		evt.fire();
	},

	refresh : function(component, event, helper){
		event.stopPropagation();
		var tc = component.get("v.selectedTC");
		helper.getStepsTC(component, tc);
	},

	onStepChanged : function(component, event, helper){
		var step = event.getParam("step");
		var isDrag = event.getParam("isDrag");
		var index = event.getParam("index");
		var steps = component.get("v.steps");

		if(isDrag){
			component.set("v.oldIndex", index);
		}
		else{
		var oldIndex = component.get("v.oldIndex");
			if(oldIndex > -1){
				//steps.splice(oldIndex, 1);
				if(index > -1){
					//steps.splice(index,0,step);
					//component.set("v.steps", steps);
					helper.reOrder(component,steps,step,oldIndex,index);
				}
			}
		}
	}
})