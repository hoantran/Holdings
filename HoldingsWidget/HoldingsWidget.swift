//
//  HoldingsWidget.swift
//  HoldingsWidget
//
//  Created by Hoan Tran on 12/31/20.
//

import WidgetKit
import SwiftUI

enum UIContstants {
    static let factor: CGFloat = 1.3
    static let minimumScaleFactor: CGFloat = 0.2
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct HoldingsWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    
    @ViewBuilder
    var body: some View {
        switch family {
            case .systemSmall: SmallHoldingsWidgetEntryView(entry: entry)
            default: MediumHoldingsWidgetEntryView(entry: entry)
        }
    }
}

struct MediumHoldingsWidgetEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text("hello")
                .foregroundColor(.brandColor)
        }
        .background(Color.black)
    }
}

struct SmallHoldingsWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            
            VStack {
                
                HStack {
                    Text("You Index®")
                        .foregroundColor(.brandColor)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(UIContstants.minimumScaleFactor)
                        .font(.system(size: 13*UIContstants.factor))
                    Spacer()
                }
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 10))
                
                HStack {
                    Text("1-Day")
                        .foregroundColor(.captionColor)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(UIContstants.minimumScaleFactor)
                        .font(.system(size: 13*UIContstants.factor))
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 10))
                
                Spacer()
                    .frame(height:6)
                
                HStack {
                    Image("down-arrow")
//                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 5))
                        .frame(width: 16*UIContstants.factor, height: 20*UIContstants.factor, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("0.12")
                        .foregroundColor(.numberColor)
                        .fontWeight(.regular)
                        .minimumScaleFactor(UIContstants.minimumScaleFactor)
                        .font(.system(size: 38*UIContstants.factor))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -5))
                    Text("%")
                        .foregroundColor(.percentageColor)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(UIContstants.minimumScaleFactor)
                        .font(.system(size: 13*UIContstants.factor))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            }
            
            Spacer()
        }
        .background(Color.black)
    }
}

@main
struct HoldingsWidget: Widget {
    let kind: String = "HoldingsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HoldingsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct HoldingsWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            HoldingsWidgetEntryView(entry: SimpleEntry(date: Date()))
//                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
//                .previewDisplayName("iPhone SE")
//                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
//            HoldingsWidgetEntryView(entry: SimpleEntry(date: Date()))
//                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
//                .previewDisplayName("iPhone SE")
//                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            HoldingsWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
                .previewDisplayName("iPhone 12 Pro Max")
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
        
    }
}
