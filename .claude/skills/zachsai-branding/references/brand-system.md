# Zachs AI Brand System — Complete Reference

## Brand Identity

- **Company:** Zachs AI — AI automation startup for business processes and workflows
- **Target audience:** Medium-sized companies looking to streamline internal processes (not technical)
- **Personality:** Turn technical AI concepts into PLAYFUL COMMUNICATION. Accessible, inclusive, no jargon.
- **Brand metaphor:** An expert colleague you delegate complex tasks to
- **Designer:** Adriana Vincenti

## Color Palette

### Primary Colors

| Token | Name | Hex | RGB | Use |
|-------|------|-----|-----|-----|
| `accent` | Accent Tone | `#7BFF00` | 123, 255, 0 | Interactive elements, buttons, highlights, CTAs, links |
| `light` | Light Tone | `#F1F1F1` | 241, 241, 241 | Light backgrounds, card surfaces, secondary text on dark |
| `dark` | Dark Tone | `#221A10` | 34, 26, 16 | Primary text on light backgrounds |
| `secondary` | Secondary Tone | `#06024C` | 6, 2, 76 | Primary dark backgrounds, navy surfaces |
| `variant` | Variant Tone | `#0C0472` | 12, 4, 114 | Gradient companion, secondary dark surfaces |

### Color Pairing Rules

- **Dark theme (primary):** Background `#06024C`, text white or `#F1F1F1`, accents `#7BFF00`
- **Light theme:** Background white or `#F1F1F1`, text `#221A10`, accents `#7BFF00`
- **Gradients:** `#7BFF00` → white (decorative backgrounds), `#06024C` → `#0C0472` (dark surfaces)
- **Never** use neon green `#7BFF00` for body text — only for accents and interactive elements

## Typography

### Font Stack

| Role | Font | Style | Use |
|------|------|-------|-----|
| Main | Funnel Display | Bold, geometric sans-serif | Headings, UI labels, bold text |
| Accent | Instrument Serif Italic | Elegant serif | Decorative text, pull quotes, contrast moments |
| Fallback | SF Pro (system) | Regular/Bold | All UI text when brand fonts unavailable |

### Hierarchy

- **H1:** Funnel Display Bold, large
- **H2-H3:** Funnel Display Medium
- **Body:** System font (SF Pro on macOS)
- **Accent/decorative:** Instrument Serif Italic

## Logo & Symbol

### Logo Construction

- Wordmark: "Zachs AI" in bold geometric sans-serif
- Symbol: Z mark — 2x2 grid of squares with quarter-circle cutouts forming a Z shape
- Combined: Wordmark + Symbol with specific spacing (X unit between "AI" and symbol, 2X between "Zachs" and "AI")

### Logo Versions

- **Positive:** Black on white background
- **Negative:** White on deep navy (`#06024C`) background
- **Logo only** (no symbol): Available for constrained spaces
- **Symbol only:** Z mark standalone for favicons, app icons

### Clear Space

- Minimum clear space around logo = height of the "Z" in "Zachs"

## Pictogram System

Brand icons built from the same quarter-circle geometric language as the Z symbol. Each icon is constructed from a 2x2 grid with arc cutouts.

Available pictograms: AI/SMB Focused, Speed, Learning, Fair/Transparent Pricing, Multi-Agent Mastery, Strategic Innovator

## SwiftUI Implementation

### Color Definitions

```swift
extension Color {
    static let zachsAccent = Color(red: 123/255, green: 255/255, blue: 0/255)       // #7BFF00
    static let zachsLight = Color(red: 241/255, green: 241/255, blue: 241/255)      // #F1F1F1
    static let zachsDark = Color(red: 34/255, green: 26/255, blue: 16/255)          // #221A10
    static let zachsNavy = Color(red: 6/255, green: 2/255, blue: 76/255)            // #06024C
    static let zachsVariant = Color(red: 12/255, green: 4/255, blue: 114/255)       // #0C0472
}
```

### Gradient

```swift
let zachsGreenGradient = LinearGradient(
    colors: [.zachsAccent, .white],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)

let zachsNavyGradient = LinearGradient(
    colors: [.zachsNavy, .zachsVariant],
    startPoint: .leading,
    endPoint: .trailing
)
```

### Button Style Example

```swift
struct ZachsButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.zachsAccent)
            .foregroundColor(.zachsDark)
            .font(.system(.body, design: .rounded, weight: .semibold))
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
```

### Dark Theme View Pattern

```swift
VStack {
    Text("Title")
        .font(.system(.title, design: .rounded, weight: .bold))
        .foregroundColor(.white)
    Text("Subtitle")
        .font(.system(.subheadline))
        .foregroundColor(.zachsLight)
}
.frame(maxWidth: .infinity)
.background(Color.zachsNavy)
```

## App Store Screenshot Guidelines

- **Resolution:** 2560x1600px (Mac)
- **Background:** Deep navy `#06024C` or neon green gradient
- **Text:** White headlines (Funnel Display style), green accents for key features
- **Show the app:** Center the app window/menu on the screenshot
- **Branding:** Include "Zachs AI" or Z symbol subtly in corner
- **Style:** Clean, minimal, high contrast — match the brand's playful-yet-professional tone
