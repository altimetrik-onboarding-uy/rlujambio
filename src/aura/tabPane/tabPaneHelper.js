({
	loadOngoingProjects: function(component) {

      var action = component.get("c.getOngoingProjects");

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

		loadFormProjects: function(component) {

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
    },

		deleteTC: function(component, test_case){
			var tests = component.get("v.tests");
			var selectedProjectTC = component.get("v.selectedProjectTC");

			var index_tests = tests.indexOf(test_case);
			var index_selectedProjectTC = selectedProjectTC.indexOf(test_case);

			if (index_tests > -1){
				tests.splice(index_tests, 1);
			}

			if (index_selectedProjectTC > -1){
				selectedProjectTC.splice(index_selectedProjectTC, 1);
			}

			var action = component.get("c.removeTC");
			action.setParams({"tc": test_case});

			action.setCallback(this, function(response){
				var state = response.getState();
				if(state == "SUCCESS"){
					component.set("v.tests", tests);
					component.set("v.selectedProjectTC", selectedProjectTC);
				}

			});

			$A.enqueueAction(action);

		},

		editTestCase: function(component, selectedTC){
        var action = component.get("c.updateTestCase");
        action.setParams({"selectedTC" : selectedTC});

        action.setCallback(this, function(response){
            var state = response.getState();
            if (state == "SUCCESS") {
                component.set("v.showUForm", false);
								var tc = response.getReturnValue();
								var project = component.get("v.selectedProject");
								this.getRelatedTC(component, project);

            }
            else{
                console.log(response);
            }
        });

        $A.enqueueAction(action);
    },

		getAllRelatedTC : function(component, projects){
			var relatedTCs = [];
			for(var i = 0; i < projects.length; i++){
				var project = projects[i];
				var action = component.get("c.getRelatedTC");
				action.setParams({"project": project});

				action.setCallback(this, function(response){
						var state = response.getState();
						if (state == "SUCCESS"){

								relatedTCs = relatedTCs.concat(response.getReturnValue());
								component.set("v.tests", relatedTCs);
						}
				});

				$A.enqueueAction(action);
			}
		}
})