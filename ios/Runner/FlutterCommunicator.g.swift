// Autogenerated from Pigeon (v18.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func createConnectionError(withChannelName channelName: String) -> FlutterError {
  return FlutterError(code: "channel-error", message: "Unable to establish connection on channel: '\(channelName)'.", details: "")
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol WatchCounterHostAPI {
  func increment() throws
  func decrement() throws
  func setCounter(counter: Int64) throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class WatchCounterHostAPISetup {
  /// The codec used by WatchCounterHostAPI.
  /// Sets up an instance of `WatchCounterHostAPI` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: WatchCounterHostAPI?, messageChannelSuffix: String = "") {
    let channelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
    let incrementChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.watch.WatchCounterHostAPI.increment\(channelSuffix)", binaryMessenger: binaryMessenger)
    if let api = api {
      incrementChannel.setMessageHandler { _, reply in
        do {
          try api.increment()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      incrementChannel.setMessageHandler(nil)
    }
    let decrementChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.watch.WatchCounterHostAPI.decrement\(channelSuffix)", binaryMessenger: binaryMessenger)
    if let api = api {
      decrementChannel.setMessageHandler { _, reply in
        do {
          try api.decrement()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      decrementChannel.setMessageHandler(nil)
    }
    let setCounterChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.watch.WatchCounterHostAPI.setCounter\(channelSuffix)", binaryMessenger: binaryMessenger)
    if let api = api {
      setCounterChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let counterArg = args[0] is Int64 ? args[0] as! Int64 : Int64(args[0] as! Int32)
        do {
          try api.setCounter(counter: counterArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setCounterChannel.setMessageHandler(nil)
    }
  }
}
/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol WatchCounterFlutterAPIProtocol {
  func increment(completion: @escaping (Result<Void, FlutterError>) -> Void)
  func decrement(completion: @escaping (Result<Void, FlutterError>) -> Void)
}
class WatchCounterFlutterAPI: WatchCounterFlutterAPIProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  private let messageChannelSuffix: String
  init(binaryMessenger: FlutterBinaryMessenger, messageChannelSuffix: String = "") {
    self.binaryMessenger = binaryMessenger
    self.messageChannelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
  }
  func increment(completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.watch.WatchCounterFlutterAPI.increment\(messageChannelSuffix)"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
  func decrement(completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.watch.WatchCounterFlutterAPI.decrement\(messageChannelSuffix)"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
}
