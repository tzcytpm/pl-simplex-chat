//
//  MPVolumeView.swift
//  PrivatelineX (iOS)
//
//  Created by Avently on 24.04.2024.
//  Copyright © 2024 Privateline X-Chat. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import AVKit

struct AudioDevicePicker: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let v = AVRoutePickerView(frame: .zero)
        v.activeTintColor = .white
        v.tintColor = .white
        return v
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}
