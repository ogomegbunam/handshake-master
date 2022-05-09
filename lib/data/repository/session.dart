
import 'package:handshake/data/models/responses/access_token_model.dart';
import 'package:handshake/data/models/responses/user_model.dart';
import 'package:handshake/data/models/responses/user_model2.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  User? user;
  AccessToken? token;

  SessionManager._internal(){
    //print("Creating session object");
  }
  static SessionManager get instance => _instance;

  void destroySession(){
    user= null;
    token=null;
  }

  void updateUser(User2 updateUser){
    if(user!=null){
      user?.full_name = updateUser.full_name;
      user?.avatar = updateUser.avatar;
      user?.nok_alternate_phone_number = updateUser.nok_alternate_phone_number;
      user?.nok_phone_number = updateUser.nok_phone_number;
      user?.email = updateUser.email;
      user?.phone_number = updateUser.phone_number;
      user?.address = updateUser.address;
      user?.business_name = updateUser.business_name;
      user?.business_address = updateUser.business_address;
      user?.vehicle_plate_number = updateUser.vehicle_plate_number;
      user?.qr_code = updateUser.qr_code;
    }

  }

}