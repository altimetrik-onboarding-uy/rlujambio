public with sharing class TabsController {

    @AuraEnabled
    public static List<Project__c> getProjects(){
        return [SELECT Id, Name, Status__c, OwnerId FROM Project__c ORDER BY Name LIMIT 10000];
    }

		@AuraEnabled
    public static List<Project__c> getOngoingProjects(){
        return [SELECT Id, Name, Status__c, OwnerId FROM Project__c WHERE Status__c = 'Ongoing' ORDER BY Name LIMIT 10000];
    }

    @AuraEnabled
    public static List<Test_Case__c> getTestCases(){
        return [SELECT Id, Title__c, Name, Description__c, Project__c, Preconditions__c, User_Story__c FROM Test_Case__c ORDER BY Name LIMIT 10000];
    }

    @AuraEnabled
    public static List<Test_Case__c> getRelatedTC(Project__c project){
        return [SELECT Id, Title__c, Name, Description__c, Project__c, Preconditions__c, User_Story__c, LastModifiedDate FROM Test_Case__c  WHERE Project__c = : project.Id ORDER BY LastModifiedDate DESC LIMIT 10000];
    }

    @AuraEnabled
    public static void removeTC(Test_Case__c tc) {

      Database.DeleteResult dr = Database.delete(tc);
    }

    @AuraEnabled
    public static Test_Case__c updateTestCase(Test_Case__c selectedTC){

        Database.SaveResult sr = Database.update(selectedTC);
        return selectedTC;
  }
}
