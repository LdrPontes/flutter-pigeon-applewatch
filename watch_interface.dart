import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/flutter_communicator.g.dart',
  dartOptions: DartOptions(),
  swiftOut: 'ios/Runner/FlutterCommunicator.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'watch',
))
@HostApi()
abstract class WatchCounterHostAPI {
  @SwiftFunction('increment()')
  void increment();
  @SwiftFunction('decrement()')
  void decrement();
  @SwiftFunction('setCounter(counter:)')
  void setCounter(int counter);
}

@FlutterApi()
abstract class WatchCounterFlutterAPI {
  void increment();
  void decrement();
}
