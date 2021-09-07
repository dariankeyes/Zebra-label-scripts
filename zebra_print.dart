import 'dart:io';
import 'dart:core';
import 'dart:typed_data';

void main() async {
  // set printer_ip and printer_port variables
  // String? printer_ip = '12';
  // int? printer_port = 12;

  var printer = {'ip': printer_ip, 'port': printer_port};

  print("Name:");
  String? name = stdin.readLineSync();
  print("User ID:");
  String? userID = stdin.readLineSync();
  print("Ticket Number:");
  String? ticketNumber = stdin.readLineSync();
  print("Call (Y/N:");
  String? callUser = stdin.readLineSync();
  String? today = "08/20/2021";

  final label = "^XA"
      "^CFE,30^FO12,30^FD$name^FS"
  "^FO310,120^BQN,2,6,Q,7^FD$userID^FS"
  "^FO12,80^FD$userID^FS"
  "^FO12,130^FD$ticketNumber^FS"
  "^FO12,180^FDCall: $callUser^FS"
  "^FO12,230^FD$today^FS"
  "^XZ";


  // connect to the socket server
  final socket = await Socket.connect(12, 12);
  print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

  // listen for responses from the server
  socket.listen(

    // handle data from the server
        (Uint8List data) {
      final serverResponse = String.fromCharCodes(data);
      print('Server: $serverResponse');
    },

    // handle errors
    onError: (error) {
      print(error);
      socket.destroy();
    },

    // handle server ending connection
    onDone: () {
      print('Server left.');
      socket.destroy();
    },
  );

  await sendLabel(socket, label);

}


Future<void> sendLabel(Socket socket, String zebra_label) async {
  print('Label Sent');
  socket.write(zebra_label);
  await Future.delayed(Duration(seconds: 2));
}

