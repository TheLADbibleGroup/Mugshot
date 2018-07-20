//
//  UserTester.swift
//  UserTestingSuite
//
//  Created by Kyle Thomas on 20/07/2018.
//  Copyright © 2018 Kyle Thomas. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit
import ReplayKit

public class UserTester: NSObject, AVCaptureFileOutputRecordingDelegate {
    
    public func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("FILE URL: ", outputFileURL)
    }
    //Screen
    let recorder = RPScreenRecorder.shared()
    private var isRecording = false
    //Camera
    var sessionOutput = AVCapturePhotoOutput()
    var movieOutput = AVCaptureMovieFileOutput()
    public var captureSession: AVCaptureSession?
    let captureDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: .front)

    var assetWriter: AVAssetWriter?

    
    func startRecording() {
        do {
            if let device = self.captureDevice {
                let input = try AVCaptureDeviceInput(device: device)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                if let canAdd = captureSession?.canAddOutput(sessionOutput), canAdd {
                    captureSession?.addOutput(sessionOutput)
                }
                captureSession?.addOutput(movieOutput)
                captureSession?.startRunning()
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let fileUrl = paths[0].appendingPathComponent("output.mov")
                try? FileManager.default.removeItem(at: fileUrl)
                movieOutput.startRecording(to: fileUrl, recordingDelegate: self)
                
            }
        } catch {
            print(error)
        }
        
        startRecordingScreen()
    }
    
    func stopRecording() {
        print("stopping")
        self.movieOutput.stopRecording()
        self.stopRecordingScreen()
    }
    
    private func startRecordingScreen() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileUrl = paths[0].appendingPathComponent("screen.mov")
        try? FileManager.default.removeItem(at: fileUrl)
        if #available(iOS 11.0, *) {
            let videoOutputSettings: Dictionary<String, Any> = [
                AVVideoCodecKey : AVVideoCodecType.h264,
                AVVideoWidthKey : UIScreen.main.bounds.size.width,
                AVVideoHeightKey : UIScreen.main.bounds.size.height
            ]
            assetWriter = try? AVAssetWriter(outputURL: fileUrl, fileType: AVFileType.mov)
            let assetWriterInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoOutputSettings)
            assetWriterInput.expectsMediaDataInRealTime = true
            assetWriter?.add(assetWriterInput)
            
            self.recorder.startCapture(handler: { (sample, bufferType, error) in
                if CMSampleBufferDataIsReady(sample)
                {
                    if self.assetWriter?.status == AVAssetWriterStatus.unknown
                    {
                        self.assetWriter?.startWriting()
                        self.assetWriter?.startSession(atSourceTime: CMSampleBufferGetPresentationTimeStamp(sample))
                    }
                    
                    if self.assetWriter?.status == AVAssetWriterStatus.failed {
                        print("Error occured, status = \(String(describing: self.assetWriter?.status.rawValue)), \(String(describing: self.assetWriter?.error!.localizedDescription)) \(String(describing: self.assetWriter?.error))")
                        return
                    }
                    
                    if (bufferType == .video)
                    {
                        if assetWriterInput.isReadyForMoreMediaData
                        {
                            assetWriterInput.append(sample)
                        }
                    }
                }
            }, completionHandler: { error in
                
            })
        } else {
            // Fallback on earlier versions
        };
    }
    
    private func stopRecordingScreen() {
        if #available(iOS 11.0, *)
        {
            self.recorder.stopCapture
                {    (error) in
                    
                    self.assetWriter?.finishWriting
                        {
                            
                            
                    }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
