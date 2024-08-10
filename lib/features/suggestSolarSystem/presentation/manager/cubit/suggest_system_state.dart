part of 'suggest_system_cubit.dart';

abstract class SuggestSystemState {}

class SuggestSystemInitial extends SuggestSystemState {}

class SuggestSystemUpdatedpage extends SuggestSystemState {
  final double page;

  SuggestSystemUpdatedpage(this.page);
}

class SuggestSystemUpdatedHoursRange extends SuggestSystemState {
  final RangeValues hoursRange;

  SuggestSystemUpdatedHoursRange(this.hoursRange);
}

class SuggestSystemUpdatedPowerRange extends SuggestSystemState {
  final RangeValues powerRange;

  SuggestSystemUpdatedPowerRange(this.powerRange);
}