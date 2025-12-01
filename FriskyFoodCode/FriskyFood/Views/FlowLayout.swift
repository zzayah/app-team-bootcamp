//
//  FlowLayout.swift
//  FriskyFood
//
//  (Hardly) Created by Zayah Cortright on 11/30/25.
//  Reference: https://talk.objc.io/episodes/S01E350-flow-layout-alignment <-- This file is written almost entirely from code here
//

// Please note the reference!

import SwiftUI

struct FlowLayout: Layout {
    var alignment: VerticalAlignment

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {

        let containerWidth = proposal.replacingUnspecifiedDimensions().width
        let dimensions = subviews.map { $0.dimensions(in: .unspecified) }

        return layout(
            dimensions: dimensions,
            spacing: 10,
            containerWidth: containerWidth,
            alignment: alignment
        ).size
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let dimensions = subviews.map { $0.dimensions(in: .unspecified) }

        let offsets = layout(
            dimensions: dimensions,
            spacing: 10,
            containerWidth: bounds.width,
            alignment: alignment
        ).offsets

        for (offset, subview) in zip(offsets, subviews) {
            subview.place(
                at: CGPoint(
                    x: offset.x + bounds.minX,
                    y: offset.y + bounds.minY
                ),
                proposal: .unspecified
            )
        }
    }
}

func layout(
    dimensions: [ViewDimensions],
    spacing: CGFloat = 10,
    containerWidth: CGFloat,
    alignment: VerticalAlignment
) -> (offsets: [CGPoint], size: CGSize) {

    var result: [CGRect] = []
    var currentPosition: CGPoint = .zero
    var currentLine: [CGRect] = []

    func flushLine() {
        currentPosition.x = 0

        let union = currentLine.union

        result.append(contentsOf: currentLine.map { rect in
            var copy = rect
            copy.origin.y += currentPosition.y - union.minY
            return copy
        })

        currentPosition.y += union.height + spacing
        currentLine.removeAll()
    }

    for dim in dimensions {

        // Flow to next line if necessary
        if currentPosition.x + dim.width > containerWidth {
            flushLine()
        }

        currentLine.append(
            CGRect(
                x: currentPosition.x,
                y: -dim[alignment],
                width: dim.width,
                height: dim.height
            )
        )

        currentPosition.x += dim.width
        currentPosition.x += spacing
    }

    flushLine()

    return (
        result.map { $0.origin },
        result.union.size
    )
}

extension Sequence where Element == CGRect {
    var union: CGRect {
        reduce(.null) { $0.union($1) }
    }
}
