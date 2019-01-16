import IOBluetooth
import Foundation
import RainbowSwift

// See https://developer.apple.com/reference/iobluetooth/iobluetoothdevice
// for API details.
class BluetoothDevices {
	
	var foundConnectedDevice = false
	func pairedDevices() {
		print("Getting connected bluetooth devices...".blue.bold)
		guard let devices = IOBluetoothDevice.pairedDevices() else {
			print("No devices.")
			return
		}
		if (devices.count == 0) {
			print("No devices.")

		} else {
			for (index, item) in devices.enumerated() {
				if let device = item as? IOBluetoothDevice {
					if (device.isConnected()) {
						self.foundConnectedDevice = true
						print("\(index+1)) \(device.name ?? "No name")")
					}
				}
			}
		}
		if (self.foundConnectedDevice == false) {
			print("No devices connected...".red)
			print("\nAvailable Devices:".green.bold)

			for (index , item) in devices.enumerated() {
				if let device = item as? IOBluetoothDevice {
					print("\(index+1)) \(device.name ?? "No name")")
				}
			}
			print("\nConnect to device?".yellow.bold)
			let inputNumber = Int(readLine()!)
			if let inputNumber = inputNumber {
				if let target = devices[inputNumber-1] as? IOBluetoothDevice {
					let status = target.openConnection()
					if(status == 0){
						print("\(target.name ?? "")".green.bold, terminator: "")
						print("connected.".green.bold.blink)
					} else {
						print("Connection to \(target.name ?? "")".red.bold, terminator: " ")
						print("failed.".red.bold.blink)
					}
				}
			}
		}
	}

}

var bt = BluetoothDevices()
bt.pairedDevices()
