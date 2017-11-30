({
	handleDetailsClick : function(component, event, helper) {

        var project = component.get("v.project");
        var showEvent = component.getEvent("showDetails");
        showEvent.setParams({"project": project, "show": true});
        showEvent.fire();
	}
})
