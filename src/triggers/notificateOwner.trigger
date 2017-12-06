trigger notificateOwner on Project__c (after update) {

  Boolean applies = false;

  for(Project__c p : Trigger.New){
    if((p.Status__c == 'Canceled') || (p.Status__c == 'Finished')){
      applies = true;
    }
  }

  if(applies){

    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    List<Project__c> projects = TabsController.getOngoingProjects();
    List<String> owners = new List<String>();
    for(Project__c p : projects){
      owners.add(p.OwnerId);
    }
    List<String> addresses = new List<String>();

    List<User> users = [SELECT Id, Name, Email FROM User WHERE Id IN : owners];

    for(User u : users){
      addresses.add(u.Email);
    }

    Integer index = 0;
    String message = '';
    List<String> projectIds = new List<String>();
    for(Project__c p : projects){
      projectIds.add(p.Id);
    }
    List<AggregateResult> queryResult = [SELECT COUNT_DISTINCT(Id) total FROM Test_Case__c WHERE Project__c IN : projectIds GROUP BY Project__c];
    Map<String, Integer> mapResult = new Map<String, Integer>();

    for(Integer i = 0; i < queryResult.size(); i++){
      mapResult.put(projectIds.get(i), (Integer) queryResult[i].get('total'));
    }
    for(String a : addresses){
      String name = users[index].Name;
      String id = users[index].Id;
      List<String> sendTo = new List<String>();
      sendTo.add(a);
      message = 'Hi, ' + name + '\n' + 'This is a list of your ongoing projects' + '\n';

      for(Project__c p : projects){
        if(p.OwnerId == id){
          message = message + 'Name: ' + p.Name + '- Status: ' + p.Status__c + ' ';
          Integer countOfTC = mapResult.get(p.Id);
          message = message + '- Number of associated Test Cases: ' + countOfTC + '\n';
        }
      }
      email.setSubject('List of Ongoing Projects');
      email.setPlainTextBody(message);
      email.setToAddresses(sendTo);
      Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
      index++;

      }

    }
  }