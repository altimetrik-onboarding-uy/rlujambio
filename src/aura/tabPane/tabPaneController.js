({
	doInit : function(component, event, helper) {

        helper.loadProjects(component);
        helper.loadTestCases(component);
	},

    displayForm : function(component, event, helper){
        component.set("v.selectedProject", null);
        component.set("v.showForm", true);
        component.set("v.showDetails", false);
    },

    refresh: function(component, event, helper){
        component.set("v.showForm", false);
	},

    showDetails: function(component, event, helper){
        var project = event.getParam("project");
        var show = event.getParam("show");
        component.set("v.selectedProject", project);
        component.set("v.showDetails", show);

        helper.getRelatedTC(component, project);
    },

    addTest: function(component, event, helper){
        var test = event.getParam("test");
        var tests = component.get("v.tests");
        tests.push(test);
        component.set("v.tests", tests);
    }

})
