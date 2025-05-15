import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mini_health_appointment/core/utils/app_exception.dart';
import 'package:mini_health_appointment/features/therapist/data/datasources/therapist_data_source.dart';
import 'package:mini_health_appointment/features/therapist/data/models/remote_therapist_model.dart';
import 'package:mini_health_appointment/features/therapist/domain/entities/therapist_entity.dart';

class RemoteTherapistDataSource extends TherapistDataSource {
  @override
  Future<Either<AppException, List<TherapistEntity>>> getTherapists() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot =
          await users.where("user_type", isEqualTo: "therapist").get();

      final data = querySnapshot.docs;

      final therapistsModel = data
          .map(
            (e) =>
                RemoteTherapistModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();

      List<TherapistEntity> therapists = therapistsModel
          .map(
            (e) => e.toEntity(),
          )
          .toList();

      return Right(therapists);
    } catch (e) {
      return Left(GeneralException(message: e.toString()));
    }
  }
}
