({
	addTestStep : function(component, step) {

		var action = component.get("c.insertTestStep");
		action.setParams({"step": step});

		action.setCallback(this, function(response){
			var state = response.getState();
			if (state == "SUCCESS"){
				component.set("v.newTestStep", {'sobjectType': 'Step__c', 'Description__c': '', 'Expected_Result__c': ''});
			}
		});

		$A.enqueueAction(action);
	}
})
