/*import 'package:googleapis/gmail/v1.dart' as gMail;
import "package:googleapis_auth/auth_io.dart";
import 'package:flutter/services.dart' show rootBundle;

class Example {
  ServiceAccountCredentials credentials;

  Future<gMail.GmailApi> getGMailApi() async {
    return gMail.GmailApi(await getGoogleClient());
  }

  Future<AuthClient> getGoogleClient() async {
    return await clientViaServiceAccount(await getCredentials(), [
      'https://www.googleapis.com/auth/drive',
      'https://mail.google.com/',
    ]);
  }

  Future<ServiceAccountCredentials> getCredentials() async {
    if (credentials == null) {
      credentials = ServiceAccountCredentials.fromJson(
          json.decode(await rootBundle.loadString('GSuiteServiceAccountInfo.json')));
    }

    return credentials;
  }

  String getBase64Email({String source}) {
    List<int> bytes = utf8.encode(source);
    String base64String = base64UrlEncode(bytes);

    return base64StringFormatted;
  }

  sendEmail({
      String from: 'me',
      String to: 'someemail@gmail.com',
      String subject: 'Some subject',
      String contentType: 'text/html',
      String charset: 'utf-8',
      String contentTransferEncoding: 'base64',
      String emailContent: '<table></table>',
  }) async {
    (await getGMailApi()).users.messages.send(
       gMail.Message.fromJson({
         'raw': getBase64Email(
            source: 'From: $from\r\n'
                    'To: $to\r\n'
                    'Subject: $subject\r\n'
                    'Content-Type: $contentType; charset=$charset\r\n'
                    'Content-Transfer-Encoding: $contentTransferEncoding\r\n\r\n'
                    '$emailContent'), // emailContent is HTML table.
       }),
       from);
  }
}*/