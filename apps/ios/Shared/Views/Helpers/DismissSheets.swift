//
//  DismissSheets.swift
//  PrivatelineX (iOS)
//
//  Created by Evgeny on 04/08/2022.
//  Copyright © 2026 Privateline X-Chat. All rights reserved.
//

import Foundation
import UIKit

// https://github.com/fatbobman/SheetKit/blob/main/Sources/SheetKit/SheetKit.swift
private func keyWindow() -> UIWindow? {
    UIApplication.shared.connectedScenes
    .filter { $0.activationState == .foregroundActive }
    .map { $0 as? UIWindowScene }
    .compactMap { $0 }
    .first?.windows
    .filter { $0.isKeyWindow }.first
}

func dismissAllSheets(animated flag: Bool = true, completion: (() -> Void)? = nil) {
    if let c = keyWindow()?.rootViewController {
        c.dismiss(animated: flag, completion: completion)
    } else {
        completion?()
    }
}
