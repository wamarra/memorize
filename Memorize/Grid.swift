//
//  Grid.swift
//  Memorize
//
//  Created by Wesley Marra on 06/08/21.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    
    typealias GridItemViewFactory = (Item) -> ItemView
    
    private var items: [Item]
    private var viewForItem: GridItemViewFactory
    
    init(_ items: [Item], viewForItem: @escaping GridItemViewFactory) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geomatry in
            body(for: GridLayout(itemCount: items.count, in: geomatry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { body(for: $0, with: layout)}
    }
    
    private func body(for item: Item, with layout: GridLayout) -> some View {
        Group {
            if let index = items.firstIndex(matching: item) {
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index))
            }
        }
    }
}
