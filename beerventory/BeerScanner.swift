//
//  BeerScanner.swift
//  beerventory
//
//  Created by Mia Henriksson on 2015-03-31.
//  Copyright (c) 2015 Önders et Gonas. All rights reserved.
//

import Foundation
import AVFoundation

class BeerScanner: NSObject, AVCaptureMetadataOutputObjectsDelegate {

  var captureSession: AVCaptureSession?
  var videoPreviewLayer: AVCaptureVideoPreviewLayer?

  var isReading = false
  let scanView: UIView
  let callback: (String)->(Void)

  init(scanView: UIView, callback: (String)->(Void)) {
    self.scanView = scanView
    self.callback = callback
  }

  func startStopReading() {
    if (!isReading) {
      startReading()
    } else {
      stopReading()
    }
    isReading = !isReading;
  }

  func startReading() {
    var error: NSError?

    let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let input = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error) as? AVCaptureDeviceInput

    if (input == nil) {
      println(error?.localizedDescription)
      return
    }
    captureSession = AVCaptureSession()
    captureSession?.addInput(input)

    let captureMetadataOutput = AVCaptureMetadataOutput()
    captureSession?.addOutput(captureMetadataOutput)

    let dispatchQueue = dispatch_queue_create("myQueue", nil)
    captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatchQueue)
    captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code]

    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
    videoPreviewLayer?.frame = scanView.layer.bounds
    scanView.layer.addSublayer(videoPreviewLayer)

    captureSession?.startRunning()
  }

  func stopReading() {
    captureSession?.stopRunning()
    captureSession = nil
    videoPreviewLayer?.removeFromSuperlayer()
  }

  func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
    if (metadataObjects != nil && metadataObjects.count > 0) {
      let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
      if (metadataObj.type == AVMetadataObjectTypeEAN13Code || metadataObj.type == AVMetadataObjectTypeEAN8Code) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          self.stopReading()
          self.callback(metadataObj.stringValue)
        })

        isReading = false
      }
    }
  }
}
