//
//  TaigiTTSService.swift
//  TaigiTTSService
//
//  Created by Li-Heng Hsu on 2021/3/4.
//

import Foundation
import AVFoundation
import Combine

@available(iOS 13.0, OSX 10.15, *)
public class TaigiTTSService {
    
    public static let shared = TaigiTTSService()
    var subscriptions = Set<AnyCancellable>()
    
    func speechRemoteURL(for text: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "xn--lhrz38b.xn--v0qr21b.xn--kpry57d"
        components.path = "/文本直接合成"
        components.queryItems = [
            .init(name: "查詢腔口", value: "台語"),
            .init(name: "查詢語句", value: text)
        ]
        return components.url!
    }
    
    
    public func preparePlayer(for text: String, completionHandler: @escaping (AVPlayer?) -> Void) {
        let url = speechRemoteURL(for: text)
        let asset = AVURLAsset(url: url, options: nil)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        playerItem.publisher(for: \.status)
            .sink {
                switch $0 {
                case .failed:
                    completionHandler(nil)
                case .readyToPlay:
                    completionHandler(player)
                default:
                    break
                }
            }
            .store(in: &subscriptions)
    }
}
