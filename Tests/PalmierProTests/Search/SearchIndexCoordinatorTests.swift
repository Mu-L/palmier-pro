import Testing
@testable import PalmierPro

@Suite("SearchIndexCoordinator — export pause")
struct ExportPauseCounterTests {
    typealias Counter = SearchIndexCoordinator.ExportPauseCounter

    @Test func nestedExportsKeepPausedUntilAllEnd() {
        var c = Counter()
        #expect(!c.isActive)
        c.begin()
        #expect(c.isActive)
        c.begin()              // a second window starts exporting
        c.end()
        #expect(c.isActive)    // still paused: one export remains
        c.end()
        #expect(!c.isActive)   // both done → resume
    }

    @Test func unbalancedEndClampsAtZero() {
        var c = Counter()
        c.end()                // end without a matching begin
        #expect(!c.isActive)   // can't go negative
        c.begin()
        #expect(c.isActive)
        c.end()
        #expect(!c.isActive)
    }
}
