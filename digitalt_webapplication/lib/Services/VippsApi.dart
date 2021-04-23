import 'package:http/http.dart' as http;

///
///this class is currently not used
class VippsApi {
  static const String _base_url = 'apitest.vipps.no';
  static const String _client_id = '67a9c4f8-0e21-4b89-bf94-daa6abb7b166';
  static const String _client_secret = '6-lnEIve7NKxxbzGiYjgfMN-3WA=';
  static const String _merchantSerialNumber = '218468';
  static const String _sub_key = '5c194972d7994fe284168479cd99bef1';

  String _bearerToken;

  Future<dynamic> getAccessToken() async {
    http.Response response =
        await http.post(Uri.http(_base_url, 'accesstoken/get'), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
      'client_id': _client_id,
      'client_secret': _client_secret,
      'Ocp-Apim-Subscription-Key': _sub_key,
    });
    print(response);
    switch (response.statusCode) {
      case 200:
        {
          print(response.body);
          _bearerToken = response.body.toString();
        }
        break;
    }
  }

  Future<dynamic> initiatePayment() async {
    http.Response response =
        await http.post(Uri.http(_base_url, 'ecomm/v2/payments'), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
      'Authorization': 'Bearer' + _bearerToken,
      'Ocp-Apim-Subscription-Key': _sub_key,
      'Vipps-System_Name': '',
      'Vipps-System-Version': '',
      'Merchant-Serial_Number': _merchantSerialNumber
    }, body: {
      "merchantInfo": {
        "merchantSerialNumber": _merchantSerialNumber,
        "callbackPrefix": "{{callbackPrefix}}",
        "fallBack": "{{fallBack}}",
        "authToken": "{{guid}}",
        "isApp": false
      },
      "customerInfo": {"mobileNumber": "{{mobileNumber}}"},
      "transaction": {
        "orderId": "{{orderId}}",
        "amount": {
          {200}
        },
        "transactionText": "{{transactionTextInitiate}}",
        "skipLandingPage": false
      }
    });
    print(response);
    switch (response.statusCode) {
      case 200:
        {
          print(response.body);
          _bearerToken = response.body.toString();
        }
        break;
    }
  }
}
