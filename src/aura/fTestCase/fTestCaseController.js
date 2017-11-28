({
    doInit : function(component, event, helper) {

        helper.loadProjects(component);
	},

    handleNewTestCaseClick : function(component, event, helper) {

            var newTestCase = component.get("v.newTestCase");
            helper.createTestCase(component, newTestCase);

    }
})
