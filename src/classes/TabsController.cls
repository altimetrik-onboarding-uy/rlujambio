public with sharing class TabsController {

    @AuraEnabled
    public static List<Project__c> getProjects(){
        return [SELECT Id, Name, Status__c, OwnerId FROM Project__c ORDER BY Name];
    }

		@AuraEnabled
    public static List<Project__c> getOngoingProjects(){
        return [SELECT Id, Name, Status__c, OwnerId FROM Project__c WHERE Status__c = 'Ongoing' ORDER BY Name];
    }

    @AuraEnabled
    public static List<Test_Case__c> getTestCases(){
        return [SELECT Id, Title__c, Name, Description__c, Project__c, Preconditions__c, User_Story__c FROM Test_Case__c ORDER BY Name];
    }

    @AuraEnabled
    public static List<Test_Case__c> getRelatedTC(Project__c project){
        return [SELECT Id, (SELECT Id, Title__c, Name, Description__c, Project__c, Preconditions__c, User_Story__c, LastModifiedDate FROM Test_Cases__r ORDER BY LastModifiedDate DESC) FROM Project__c WHERE Id = : project.Id].Test_Cases__r;
    }

    @AuraEnabled
    public static void removeTC(Test_Case__c tc) {

      Database.DeleteResult dr = Database.delete(tc);

      if(dr.isSuccess()){
        System.debug('Delete was successful');
      }
      else{
        for(Database.Error err : dr.getErrors()){
          System.debug('The following error occurred:');
          System.debug(err.getStatusCode() + err.getMessage());
          System.debug('Affected fields: ' + err.getFields());
        }
      }
    }

    @AuraEnabled
    public static Test_Case__c updateTestCase(Test_Case__c selectedTC){

        Database.SaveResult sr = Database.update(selectedTC);

        if(sr.isSuccess()){
          System.debug('Update was successful');
          System.debug(selectedTC);
        }
        else{
          for(Database.Error err : sr.getErrors()){
            System.debug('The following error occurred:');
            System.debug(err.getStatusCode() + err.getMessage());
            System.debug('Affected fields: ' + err.getFields());
          }
        }

        return selectedTC;
  }
}
