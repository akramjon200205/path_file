import 'dart:isolate';

void main(List<String> args) {
    callerCreateIsolate();
}

SendPort? newIsolateSendPort;

Isolate? newIsolate;

void callerCreateIsolate() async {  
  
  ReceivePort receivePort = ReceivePort();
  
  newIsolate = await Isolate.spawn(
    callbackFunction,
    receivePort.sendPort,
  );

  
  newIsolateSendPort = await receivePort.first;
  sendReceive('salom').then((value) {
    print(value);
  });
}

void callbackFunction(SendPort callerSendPort) {
  
  ReceivePort newIsolateReceivePort = ReceivePort();  
  callerSendPort.send(newIsolateReceivePort.sendPort);

  newIsolateReceivePort.listen((dynamic message) {
    CrossIsolatesMessage incomingMessage = message as CrossIsolatesMessage;
    String newMessage = "complemented string " + incomingMessage.message;
    incomingMessage.sender.send(newMessage);
  });
}

Future<String> sendReceive(String messageToBeSent) async {
  
  ReceivePort port = ReceivePort(); 
  newIsolateSendPort?.send(CrossIsolatesMessage<String>(
    sender: port.sendPort,
    message: messageToBeSent,
  ));  
  return await port.first;
}

class CrossIsolatesMessage<T> {
  final SendPort sender;
  final T message;

  CrossIsolatesMessage({
    required this.sender,
    required this.message,
  });
}
