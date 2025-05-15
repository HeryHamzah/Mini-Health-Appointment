import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/profile/data/datasources/profile_data_source.dart';
import 'package:mini_health_appointment/features/profile/domain/entities/profile_entity.dart';

import '../models/profile_model.dart';

class RemoteProfileDataSource extends ProfileDataSource {
  @override
  Future<Either<AppException, ProfileEntity>> getProfile(String id) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot snapshot = await users.doc(id).get();

      var data = snapshot.data()!;

      return Right(
          ProfileModel.fromJson(data as Map<String, dynamic>).toEntity());
    } catch (e) {
      return Left(GeneralException(message: e.toString()));
    }
  }
}
