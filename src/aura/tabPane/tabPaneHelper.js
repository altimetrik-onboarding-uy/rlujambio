({
	loadProjects: function(component) {

      var action = component.get("c.getProjects");

      action.setCallback(this, function(response){
        var state = response.getState();
        if (state == "SUCCESS"){
          component.set("v.projects", response.getReturnValue());
        }
        else{
          console.log("Failed with state: " + state);
        }
      })

      $A.enqueueAction(action);

    },

    loadTestCases: function(component) {

      var action = component.get("c.getTestCases");

      action.setCallback(this, function(response){
        var state = response.getState();
        if (state == "SUCCESS"){
          component.set("v.tests", response.getReturnValue());
        }
        else{
          console.log("Failed with state: " + state);
        }
      })

      $A.enqueueAction(action);

    },

     getRelatedTC: function(component, project){
        var action = component.get("c.getRelatedTC");
        action.setParams({"project": project});

        action.setCallback(this, function(response){
            var state = response.getState();
            if (state == "SUCCESS"){
                component.set("v.selectedProjectTC", response.getReturnValue());
            }
        });

        $A.enqueueAction(action);
    }

})
