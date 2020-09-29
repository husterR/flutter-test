// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
//TODO: flutter drive --target=test_driver/app.dart --profile
void main() {
  group('Scrollable App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });
    test("Test webView", () async {
      final websiteOpenTile = find.byValueKey("WebsiteOpenTile");
      final websiteTextFinish = find.byValueKey("WebsiteText");
      final timeline = await driver.traceAction(() async {
        driver.tap(find.byTooltip("Open navigation menu"));
        driver.tap(websiteOpenTile);
        expect(await driver.getText(websiteTextFinish), startsWith("It took "));
      });
      final summary = new TimelineSummary.summarize(timeline);

      await summary.writeSummaryToFile("webview_summary", pretty: true);

      await summary.writeTimelineToFile("webview_timeline", pretty: true);
    });
//
//    test("Test Video", () async {
//      final videoOpenTile = find.byValueKey("VideoOpenTile");
//      final videoTextFinish = find.byValueKey("VideoPlayerText");
//      final timeline = await driver.traceAction(() async {
//        driver.tap(find.byTooltip("Open navigation menu"));
//        driver.tap(videoOpenTile);
//        expect(await driver.getText(videoTextFinish), startsWith("It took "));
//      });
//      final summary = new TimelineSummary.summarize(timeline);
//
//      await summary.writeSummaryToFile("video_summary", pretty: true);
//
//      await summary.writeTimelineToFile("video_timeline", pretty: true);
//    });

//    test("Test Text", () async {
//      final videoOpenTile = find.byValueKey("TextOpenTile");
//      final videoTextFinish = find.byValueKey("Text");
//      final timeline = await driver.traceAction(() async {
//        driver.tap(find.byTooltip("Open navigation menu"));
//        driver.tap(videoOpenTile);
//        expect(await driver.getText(videoTextFinish), endsWith("the End"));
//      });
//      final summary = new TimelineSummary.summarize(timeline);
//
//      await summary.writeSummaryToFile("text_summary", pretty: true);
//
//      await summary.writeTimelineToFile("text_timeline", pretty: true);
//    });
//    test('verifies the list contains a specific item', () async {
//      // Create two SerializableFinders and use these to locate specific
//      // widgets displayed by the app. The names provided to the byValueKey
//      // method correspond to the Keys provided to the widgets in step 1.
//      final listFinder = find.byValueKey('long_list');
//      final itemFinder = find.byValueKey('item_999_text');
//      final timeline = await driver.traceAction(() async {
//        expect(await driver.getText(itemFinder), "Item 999");
//      });
//
//      // Verify that the item contains the correct text.
//      expect(
//        await driver.getText(itemFinder),
//        'Item 999',
//      );
//      final summary = new TimelineSummary.summarize(timeline);
//
//      await summary.writeSummaryToFile("srolling_summary", pretty: true);
//
//      await summary.writeTimelineToFile("scrolling_timeline", pretty: true);
//    });

  });

}
  void openDrawer(FlutterDriver driver) async {
    final app = find.byValueKey("App");
    await driver.scroll(app, 300, 0, const Duration(milliseconds: 100));
  }
