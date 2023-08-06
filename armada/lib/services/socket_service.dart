import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'dart:async';

class SocketService {
  late IO.Socket socket;
  bool connected = false;
  String? userid;
  // late Timer heartbeatTimer;

  void initSocket(String? userId) {
    if (connected) {
      closeConnection();
    }

    userid = userId;

    print("userid");
    print(userid);
    print(userId);
    // socket = null;

    // Initialize a new socket instance with the user ID as a query parameter
    socket = IO.io('https://armada-server.glitch.me', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      // 'query': {'userId': userid},
    });

    print("IO");
    print(socket.query);
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
      socket.emit('auth', {'userId': userid});
      print("user id1");
      print(userid);

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
    // Check if the socket is connected
    if (socket != null && socket.connected) {
      // Disconnect the socket
      // socket?.clearData();
      // socket.
      socket.disconnect();
      socket.dispose();
      // socket.
      socket.close();

      // socket = null;
      print(socket.query);

      //Set the connected flag to false
      connected = false;
      // socket = null;
      // Perform any additional cleanup or tasks here
      // ...
    }
  }
}
