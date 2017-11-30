public with sharing class FTestController {
	
		@AuraEnabled
    public static List<Project__c> getProjects(){
        return [SELECT Id, Name, Status__c, OwnerId FROM Project__c ORDER BY Name];
    }

    @AuraEnabled
    public static Test_Case__c addTestCase(Test_Case__c newTestCase){

        Database.SaveResult sr = Database.insert(newTestCase);
        return newTestCase;
  }
}
