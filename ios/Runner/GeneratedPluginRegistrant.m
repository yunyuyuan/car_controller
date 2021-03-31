//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_bluetooth_serial/FlutterBluetoothSerialPlugin.h>)
#import <flutter_bluetooth_serial/FlutterBluetoothSerialPlugin.h>
#else
@import flutter_bluetooth_serial;
#endif

#if __has_include(<system_setting/SystemSettingPlugin.h>)
#import <system_setting/SystemSettingPlugin.h>
#else
@import system_setting;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterBluetoothSerialPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterBluetoothSerialPlugin"]];
  [SystemSettingPlugin registerWithRegistrar:[registry registrarForPlugin:@"SystemSettingPlugin"]];
}

@end
