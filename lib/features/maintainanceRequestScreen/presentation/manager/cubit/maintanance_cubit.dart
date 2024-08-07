import 'package:alternative_energy_user_app/features/maintainanceRequestScreen/data/repos/maintanance_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'maintanance_state.dart';

class MaintananceCubit extends Cubit<MaintananceState> {
  MaintananceCubit(this.Repo) : super(MaintananceInitial());

  XFile? imageFile;
  String maintenance_order = "";
  String location = "";
  final MaintananceRepo Repo;

  void pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageFile = pickedFile;
        emit(MaintenanceImagePicked(pickedFile));
      }
    } catch (e) {
      emit(MaintenanceFailure(errMessage: e.toString()));
    }
  }

  void submitMaintenanceRequest() async {
    if (maintenance_order.isEmpty || imageFile == null) {
      emit(MaintenanceFailure(errMessage: 'يرجى إدخال وصف ورفع صورة'));
      return;
    }
    emit(MaintenanceLoading());
    try {
      FormData formData = FormData.fromMap({
        'desc': maintenance_order,
        'image': await MultipartFile.fromFile(imageFile!.path,
            filename: imageFile!.name),
        'type_id': 1,
        'location': location,
      });

      final result = await Repo.submitMaintenanceRequest(formData);
      result.fold(
        (failure) => emit(MaintenanceFailure(errMessage: failure.errorMessege)),
        (success) => emit(MaintenanceSuccess(message: success.msg)),
      );
    } catch (e) {
      emit(MaintenanceFailure(errMessage: e.toString()));
    }
  }
}
