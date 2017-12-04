({
	doInit : function(component, event, helper) {

        helper.loadOngoingProjects(component);
        helper.loadTestCases(component);
	},

    displayForm : function(component, event, helper){
        component.set("v.selectedProject", null);
        component.set("v.showForm", true);
        component.set("v.showDetails", false);
				component.set("v.showCForm", false);
				component.set("v.showUForm", false);
				component.set("v.showStepForm", false);
				component.set("v.tests", component.get("v.tests"));

				var evt = $A.get("e.c:seeTCDetails");
				var tc = {'sobjectType': 'Test_Case__c','Title__c' : 'No Test Case selected', 'Project__c' : '','Name': ''};
				evt.setParams({"tc": tc, "status": true, "steps": []});
				evt.fire();

    },

    refresh: function(component, event, helper){
        component.set("v.showForm", false);
				component.set("v.showCForm", false);
				component.set("v.showUForm", false);
	},

    showDetails: function(component, event, helper){
        var project = event.getParam("project");
        var show = event.getParam("show");
        component.set("v.selectedProject", project);
        component.set("v.showDetails", show);
				component.set("v.showCForm", false);
				component.set("v.showUForm", false);

        helper.getRelatedTC(component, project);
    },

    addTest: function(component, event, helper){
        helper.loadTestCases(component);
				var selectedProject = component.get("v.selectedProject");
				helper.getRelatedTC(component, selectedProject);
    },

		deleteTestCase: function(component, event, helper){
			if(window.confirm("Are you sure you want to delete this Test Case?")){
				var test_case = event.getSource().get("v.value");
				helper.deleteTC(component, test_case);
				component.set("v.showCForm", false);
				component.set("v.showUForm", false);
				component.set("v.showStepForm", false);

				var evt = $A.get("e.c:seeTCDetails");
				var tc = {'sobjectType': 'Test_Case__c','Title__c' : 'No Test Case selected', 'Project__c' : '','Name': ''};
				evt.setParams({"tc": {'Title__c' : 'No Test Case Selected', 'Project__c' : '','Name': ''}, "status": true, "steps": []});
				evt.fire();

			}
		},

		editTestCase: function(component, event, helper){
			component.set("v.showCForm", false);
			component.set("v.showUForm", true);
			var test_case = event.getSource().get("v.value");
			component.set("v.selectedTC", test_case);
			helper.loadFormProjects(component);
		},

		cuForm: function(component, event, helper){
			component.set("v.showUForm", false);
			component.set("v.showCForm", true);
		},

		handleEditTestCaseClick : function(component, event, helper) {

            var selectedTC = component.get("v.selectedTC");
            helper.editTestCase(component, selectedTC);
						helper.loadTestCases(component);

						var evt = $A.get("e.c:seeTCDetails");
						evt.setParams({"tc": selectedTC, "status": true});
						evt.fire();
    },

		seeDetails : function (component, event, helper){
			var evt = $A.get("e.c:seeTCDetails");
			var tc = event.getSource().get("v.value");
			var selectedTC = component.get("v.selectedTC");
			evt.setParams({"tc": tc, "status": false});
			evt.fire();
			if(selectedTC == null ){
				component.set("v.selectedTC", tc);
			}
			if((selectedTC != null) && (tc.id != component.get("v.selectedTC").Id)){
				component.set("v.showStepForm", false);
			}
		},

		showStepF : function(component, event, helper){
			component.set("v.showStepForm", event.getParam("show"));
		}
})
