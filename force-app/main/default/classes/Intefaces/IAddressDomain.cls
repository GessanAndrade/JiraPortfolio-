public interface IAddressDomain {
  void validateAddressFields(Address__c address);

  void validateAddressAccessibility();

  void validateAddressCreateability();

  void validateAddressUpdateability();

  void validateAddressDeletability();
}
