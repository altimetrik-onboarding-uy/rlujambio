({
	handleNewTestStepClick : function(component, event, helper) {
		var step = component.get("v.newTestStep");
		var tc = component.get("v.selectedTC");

		step.Test_Case__c = tc.Id;

		helper.addTestStep(component, step);

		$A.get("e.c:refreshSteps").fire();

	},

	getSelectedTC : function(component, event, helper){
		var tc = event.getParam("tc");
		event.stopPropagation();
		component.set("v.selectedTC", tc);
	}
})
