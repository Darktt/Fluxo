//
//  EdgeInsetsExtension.swift
//
//  Created by Darktt on 25/8/20.
//  Copyright © 2025 Darktt. All rights reserved.
//

import SwiftUI

public
extension EdgeInsets
{
    static
    func allEdge(_ value: CGFloat) -> EdgeInsets
    {
        EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
    }
}
