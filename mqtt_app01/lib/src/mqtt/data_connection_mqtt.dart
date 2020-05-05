/*
class MySingleton {
  static final MySingleton _instance = MySingleton._internal();
  factory MySingleton() => _instance;
  
  MySingleton._internal() {
    // init things inside this
  }
  
  // Methods, variables ...
}
*/

class DataConnectionMQTT {

// singleton
  static final DataConnectionMQTT _singleton = DataConnectionMQTT._internal();
  factory DataConnectionMQTT() => _singleton;
  
  DataConnectionMQTT._internal(){
    // Valores iniciales aqui dentro     
    _broker  = 'xxx.xxx.x.xxx';
    _port = 1883;
    _username = '********';
    _password = '********';
    _clientId = 'App flutter';
  }
  
  // Getter y setter 
  String _broker;
  int _port;
  String _username;
  String _password;
  String _clientId;

  // Getter y setter 
  // broker
  get broker {
    return _broker;
  }
  set broker (String input) {
    this._broker = input;
    print('Broker: $_broker');
  }
  
  // port
  get port {
    return _port;
  }
  set port (int input) {
    this._port = input;
    print('Port: $_port');    
  }
  
  // clientId 
  get clientId {
    return _clientId;
  }
  set clientId (String input) {
    this._clientId = input;    
    print('ClientId: $_clientId');    
  }
  
  // username 
  get username {
    return _username;
  }
  set username (String input) {
    this._username = input;
    print('Username: $_username');        
  }
  
  // password 
  get password {
    return _password;
  }
  set password (String input) {
    this._password = input;
    print('Password: $_password');        
  }

  
}