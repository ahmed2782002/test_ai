import '../../mock_model/home_model.dart';

enum HomeStatus { loading, success, error }

class HomeState {
  final HomeStatus status;
  final HomeModel? home;

  const HomeState({this.status = HomeStatus.loading, this.home});

  HomeState copyWith({HomeStatus? status, HomeModel? home}) {
    return HomeState(status: status ?? this.status, home: home ?? this.home);
  }
}
