import 'package:equatable/equatable.dart';

abstract class homepageState extends Equatable {
  const homepageState();

  @override
  List<Object> get props => [];
}

class homepageInitial extends homepageState {}

class homepageLoading extends homepageState {}

class homepageFailure extends homepageState {
  final String errMessage;

  const homepageFailure(this.errMessage);
}

class homepageSuccess extends homepageState {
  // final List<GroupModel> groups;

  // const homepageSuccess(this.groups);
}

class ChangeBottomNavigationBarIndex extends homepageState {}
