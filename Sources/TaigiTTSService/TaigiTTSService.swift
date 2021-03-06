//
//  TaigiTTSService.swift
//  TaigiTTSService
//
//  Created by Li-Heng Hsu on 2021/3/4.
//

import Foundation
import AVFoundation


public enum Error: String, Swift.Error {
    case loadingFailure
}


public class TaigiTTSService {
    
    static func speechRemoteURL(for text: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "hts.ithuan.tw"
        components.path = "/文本直接合成"
        components.queryItems = [
            .init(name: "查詢腔口", value: "台語"),
            .init(name: "查詢語句", value: text)
        ]
        return components.url!
    }
    
    public static func player(for text: String, completionHandler: @escaping (AVPlayer?) -> Void) {
        let url = speechRemoteURL(for: text)
        let asset = AVURLAsset(url: url, options: nil)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        var observation: Any?
        observation = playerItem.observe(\.status) { playerItem, _ in
            switch playerItem.status {
            case .failed:
                completionHandler(nil)
                observation = nil
            case .readyToPlay:
                completionHandler(player)
                observation = nil
            default:
                _ = observation
            }
        }
    }
}
