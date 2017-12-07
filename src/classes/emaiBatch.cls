global class emaiBatch implements Database.Batchable<Email_Entry__c> {

	global List<Email_Entry__c> mailsToSend;


	global emaiBatch(){

	}

	global Iterable<Email_Entry__c> start(Database.BatchableContext BC) {
		return new iCustomIterator();
	}

   	global void execute(Database.BatchableContext BC, List<Email_Entry__c> scope) {

			mailsToSend = new List<Email_Entry__c>();
			for(Email_Entry__c entry : scope){
				mailsToSend.add(entry);
			}
	}

	global void finish(Database.BatchableContext BC) {
		for(Email_Entry__c entry : mailsToSend){
			List<String> sendTo = new List<String>();
			sendTo.add(entry.Recipient_Mail__c);

			Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
			email.setSubject('List of Ongoing Projects');
			email.setPlainTextBody(entry.Message__c);
			email.setToAddresses(sendTo);
			Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
			}
	}
}
