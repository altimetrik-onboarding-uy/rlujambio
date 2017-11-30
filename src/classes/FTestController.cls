public with sharing class FTestController {

		@AuraEnabled
    public static List<Project__c> getProjects(){
        return [SELECT Id, Name, Status__c, OwnerId FROM Project__c ORDER BY Name LIMIT 10000];
    }

		@AuraEnabled
		public static List<Project__c> getOPProjects(){
			return [SELECT Id, Name, Status__c, OwnerId FROM Project__c WHERE ((Status__c = 'Ongoing') OR (Status__c = 'Proposed')) ORDER BY Name];
		}

    @AuraEnabled
    public static Test_Case__c addTestCase(Test_Case__c newTestCase){

        Database.SaveResult sr = Database.insert(newTestCase);

				if(sr.isSuccess()){
          System.debug('Insert was successful');
          System.debug(newTestCase);
        }
        else{
          for(Database.Error err : sr.getErrors()){
            System.debug('The following error occurred:');
            System.debug(err.getStatusCode() + err.getMessage());
            System.debug('Affected fields: ' + err.getFields());
          }
        }				
        return newTestCase;
  }
}