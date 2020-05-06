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
    _broker  = '192.168.1.101';
    _port = 1883;
    _username = 'moi';
    _password = 'moi';
    _clientId = 'App flutter';
    _topicsub = 'topic/sub';
    _topicpub = 'topic/pub';
    _subStatus = false;    
  }
  
  // Getter y setter 
  String _broker;
  int _port;
  String _username;
  String _password;
  String _clientId;
  String _topicsub;
  String _topicpub;
  bool _subStatus;
  
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

  // topic subscribe 
  get topicsub {
    return _topicsub;
  }
  set topicsub (String input) {
    this._topicsub = input;
    print('TopicSub: $_topicsub');        
  }

// topic publish 
  get topicpub {
    return _topicpub;
  }
  set topicpub (String input) {
    this._topicpub = input;
    print('TopicPub: $_topicpub');        
  }

// subsribe estatus 
  get subStatus {
    return _subStatus;
  }
  set subStatus (bool val) {
    this._subStatus = val;
    print('subStatus: $_subStatus');        
  }



}