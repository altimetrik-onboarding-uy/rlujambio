public with sharing class FTestController {

//IN ORDER TO COMMIT...
		@AuraEnabled
    public static List<Project__c> getProjects(){
        return [SELECT Id, Name, Status__c, OwnerId FROM Project__c ORDER BY Name LIMIT 10000];
    }

		@AuraEnabled
		public static List<Project__c> getOPProjects(){
			return [SELECT Id, Name, Status__c, OwnerId FROM Project__c WHERE ((Status__c = 'Ongoing') OR (Status__c = 'Proposed')) ORDER BY Name LIMIT 10000];
		}

    @AuraEnabled
    public static Test_Case__c addTestCase(Test_Case__c newTestCase){

        Database.SaveResult sr = Database.insert(newTestCase);				
					if(sr.isSuccess()){
						System.debug('Insert was ok' + sr);
					}
					else{
						for(Database.Error err : sr.getErrors()) {
		            System.debug('The following error has occurred.');
		            System.debug(err.getStatusCode() + ': ' + err.getMessage());
		            System.debug('Contact fields that affected this error: ' + err.getFields());
							 }
					}
        return newTestCase;
  }
}
