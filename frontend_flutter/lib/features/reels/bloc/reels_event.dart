import 'package:equatable/equatable.dart';

abstract class ReelsEvent extends Equatable {
  const ReelsEvent();

  @override
  List<Object> get props => [];
}

class LoadReelsEvent extends ReelsEvent {}
