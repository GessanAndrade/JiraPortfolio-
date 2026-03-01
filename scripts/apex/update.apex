List<Sprint__c> sprints = [SELECT Id, Name FROM Sprint__c LIMIT 100];

Integer maiorNumero = -1;
Id maiorId;

for (Sprint__c s : sprints) {
    Integer numero = Integer.valueOf(s.Name);

    if (numero > maiorNumero) {
        maiorNumero = numero;
        maiorId = s.Id;
    }
}

for (Sprint__c s : sprints) {
    if (s.Id == maiorId) {
        s.Status__c = 'Active';
    } else {
        s.Status__c = 'Inactive';
    }
}

update sprints;
