// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString?);

import 'dart:convert';

class ConfigurationModel {
  ConfigurationModel({
    this.id,
    this.initialAssignedNumber = 1,
    this.initialInvoiceNumber = 1,
    this.initialControlNumber = 1,
    this.mainCurrency = 'USD',
    this.invoiceCurrency = 'VEF',
    this.changeFactor = 24.5,
    this.iva = 14,
    this.logo = "",
  });

  String? id;
  int? initialAssignedNumber;
  int? initialInvoiceNumber;
  int? initialControlNumber;
  String? mainCurrency;
  String? invoiceCurrency;
  double? changeFactor;
  double? iva;
  String? logo;

  factory ConfigurationModel.fromMap(Map<String?, dynamic> json) =>
      ConfigurationModel(
          id: json["id"],
          initialAssignedNumber: json["initial_assigned_number"],
          initialControlNumber: json["initial_control_number"],
          initialInvoiceNumber: json["initial_invoice_number"],
          mainCurrency: json["main_currency"],
          invoiceCurrency: json["invoice_currency"],
          changeFactor: json["change_factor"],
          iva: json["iva"],
          logo: json["logo"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "initial_assigned_number": initialAssignedNumber,
        "initial_control_number": initialControlNumber,
        "initial_invoice_number": initialInvoiceNumber,
        "main_currency": mainCurrency,
        "invoice_currency": invoiceCurrency,
        "change_factor": changeFactor,
        "iva": iva,
        "logo": logo
      };

  ConfigurationModel fromJson(String? str) =>
      ConfigurationModel.fromMap(json.decode(str!));

  String? toJson(ConfigurationModel data) => json.encode(data.toMap());
}
