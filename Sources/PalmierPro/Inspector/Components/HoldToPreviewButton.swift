import SwiftUI

struct HoldToPreviewButton: View {
    let onPress: () -> Void
    let onRelease: () -> Void
    @State private var held = false

    var body: some View {
        Image(systemName: held ? "eye.slash" : "eye")
            .font(.system(size: AppTheme.FontSize.xs))
            .foregroundStyle(held ? AppTheme.Text.primaryColor : AppTheme.Text.tertiaryColor)
            .frame(width: AppTheme.IconSize.sm, height: AppTheme.IconSize.sm)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in if !held { held = true; onPress() } }
                    .onEnded { _ in if held { held = false; onRelease() } }
            )
            .help("Hold to preview without this adjustment")
    }
}
