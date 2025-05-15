import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_health_appointment/features/auth/domain/entities/user_type_enum.dart';

import '../../../../core/utils/app_exception.dart';
import '../../domain/entities/session_entity.dart';
import 'auth_data_source.dart';

class RemoteAuthDataSource extends AuthDataSource {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Future<Either<AppException, SessionEntity>> login(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      DocumentSnapshot snapshot = await users.doc(credential.user!.uid).get();

      var data = snapshot.data()! as Map<String, dynamic>;

      UserType userType = UserType.values.singleWhere(
        (element) => element.name == data["user_type"] as String,
      );

      return Right(
          SessionEntity(token: credential.user!.uid, userType: userType));
    } catch (e) {
      return Left(GeneralException(message: e.toString()));
    }
  }

  @override
  Future<Either<AppException, SessionEntity>> register({
    required String email,
    required String password,
    required String name,
    required UserType userType,
  }) async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await users.doc(credential.user!.uid).set({
        'id': credential.user!.uid,
        'name': name,
        'email': email,
        'user_type': userType.name,
      });

      return Right(SessionEntity(
          token: credential.user!.uid, userType: UserType.patient));
    } catch (e) {
      return Left(GeneralException(message: e.toString()));
    }
  }
}
