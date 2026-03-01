List<AggregateResult> results = [
    SELECT Status__c, COUNT(Id) total
    FROM Task__c
    GROUP BY Status__c
];

for (AggregateResult ar : results) {
    String status = (String) ar.get('Status__c');
    Integer quantidade = (Integer) ar.get('total');

    System.debug('Status: ' + status + ' - Quantidade: ' + quantidade);
}
