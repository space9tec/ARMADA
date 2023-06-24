import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';

class SocketService {
  late IO.Socket socket;
  bool connected = false;
  late String userid;
  // late Timer heartbeatTimer;

  void initSocket(String userId) {
    this.userid = userId;

    // Initialize a new socket instance with the user ID as a query parameter
    socket = IO.io('http://127.0.0.1:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'userId': userid},
    });

    // Set up the listeners for socket events
    _setupSocketListeners();

    // Connect to the server
    socket.connect();
  }

  void _setupSocketListeners() {
    // Listen for connection event
    socket.onConnect((_) {
      connected = true;
      print('Connected to server!');

      // Start the heartbeat timer once the socket is connected
      // _startHeartbeatTimer();
    });

    // Listen for messages from the server
    socket.on('message', (data) {
      print('Received message: $data');
    });

    // Listen for disconnection event
    socket.onDisconnect((_) {
      connected = false;
      print('Disconnected from server!');

      // Cancel the heartbeat timer on disconnection
      // _cancelHeartbeatTimer();
    });
  }

  // void _startHeartbeatTimer() {
  //   // heartbeatTimer = Timer.periodic(Duration(seconds: 10), (_) {
  //     if (connected) {
  //       socket.emit('heartbeat'); // Send a heartbeat event to the server
  //     } else {
  //       _cancelHeartbeatTimer(); // Cancel the heartbeat timer if the socket is not connected
  //     }
  //   // });
  // }

  // void _cancelHeartbeatTimer() {
  //   heartbeatTimer.cancel();
  // }

  void sendMessage(String message) {
    if (connected) {
      // Only send the message if the socket is connected
      socket.emit('message', message);
    }
  }

  void closeConnection() {
    // _cancelHeartbeatTimer(); // Cancel the heartbeat timer before closing the connection
    socket.disconnect();
  }
}
