//
//  LDXExportComponent.swift
//  LDXAVFoundation
//
//  Created by 刘东旭 on 2017/8/14.
//  Copyright © 2017年 刘东旭. All rights reserved.
//

import Foundation
import AVFoundation

public class LDXExportComposition {
    
    var videoPath:String
    let exportSession:AVAssetExportSession
    
    
    init(compositionVideo:LDXCompositionVideo,videoPath:String) {
        self.videoPath = videoPath
        exportSession = AVAssetExportSession(asset: compositionVideo.mutableComposition, presetName: AVAssetExportPresetHighestQuality)!
        exportSession.outputFileType = AVFileTypeMPEG4
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.outputURL = URL(fileURLWithPath: self.videoPath)
    }
    
    public func exportAsynchronously(completionHandler handler: @escaping (_ path:String) -> Swift.Void) {
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: videoPath) {
            try! fileManager.removeItem(atPath: videoPath)
        }
        exportSession.exportAsynchronously { 
            if self.exportSession.status == AVAssetExportSessionStatus.completed {
                handler(self.videoPath)
            } else {
                print(self.exportSession.status)
                print(self.exportSession.error!)
            }
        }
        
    }
    
    
}