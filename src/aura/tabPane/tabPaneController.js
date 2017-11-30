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
				component.set("v.tests", component.get("v.tests"));
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
    },

		deleteTestCase: function(component, event, helper){
			if(window.confirm("Are you sure you want to delete this Test Case?")){
				var test_case = event.getSource().get("v.value");
				helper.deleteTC(component, test_case);
				component.set("v.showCForm", false);
				component.set("v.showUForm", false);
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
    }
})