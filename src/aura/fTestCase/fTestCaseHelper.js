({
	loadProjects: function(component) {

      var action = component.get("c.getProjects");

      action.setCallback(this, function(response){
        var state = response.getState();
        if (state == "SUCCESS"){
            var projects = response.getReturnValue();
            var options = [];
            for(var i = 0; i < projects.length; i++){
                if((projects[i].Status__c == 'Ongoing') || (projects[i].Status__c == 'Proposed')){
                    options.push({ value: projects[i].Id, label: projects[i].Name});
                }
            }
            component.set("v.comboOptions", options);
        }
        else{
          console.log("Failed with state: " + state);
        }
      })

      $A.enqueueAction(action);

    },

    createTestCase: function(component, newTestCase){
        var action = component.get("c.addTestCase");
        action.setParams({"newTestCase" : newTestCase});

        action.setCallback(this, function(response){
            var state = response.getState();
            if (state == "SUCCESS") {
                var event = component.getEvent("newTC");
                event.setParams({"test" : response.getReturnValue()});
                event.fire();
            }
            else{
                console.log(response);
            }
        });

        $A.enqueueAction(action);
    }
})
