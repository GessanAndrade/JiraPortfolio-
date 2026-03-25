@isTest
public class SprintControllerTest {
    @isTest
    static void testCreateAndGetActiveSprint() {
        Date startDate = Date.today();
        Date endDate = Date.today().addDays(7);

        Test.startTest();
        SprintController.createSprint('Sprint Test', startDate, endDate);
        Sprint__c activeSprint = SprintController.getActiveSprint();
        Test.stopTest();

        System.assertNotEquals(null, activeSprint, 'Expected an active sprint to be returned.');
        System.assertEquals(startDate, activeSprint.Date_Begin__c);
        System.assertEquals(endDate, activeSprint.Date_End__c);
    }

    @isTest
    static void testCreateSprintWithoutStartDateThrowsError() {
        Date endDate = Date.today().addDays(7);
        Boolean hasError = false;

        try {
            Test.startTest();
            SprintController.createSprint('Sprint Test', null, endDate);
            Test.stopTest();
        } catch (AuraHandledException e) {
            hasError = true;
        }
        System.assertEquals(true, hasError, 'Expected AuraHandledException to be thrown.');
    }
}