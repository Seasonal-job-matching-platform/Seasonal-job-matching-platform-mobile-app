# Build Reference (PptxGenJS)

## Objective

Treat `build.js` as production software.

The presentation is generated programmatically using **PptxGenJS**.

The goal is not only to create slides, but to maintain a clean, maintainable presentation codebase.

---

# Before Modifying build.js

Always:

1. Read the existing file.
2. Understand the current architecture.
3. Identify reusable helper functions.
4. Understand the theme.
5. Understand the layout system.
6. Understand slide-generation patterns.

Never modify code blindly.

---

# Modification Rules

Prefer:

- extending existing helper functions
- reusing layouts
- reusing colors
- reusing typography
- reusing icons
- reusing spacing

Avoid:

- duplicated code
- duplicated layouts
- inconsistent fonts
- inconsistent colors
- magic numbers
- one-off helper functions

---

# Theme Consistency

Maintain consistency regarding:

- fonts
- colors
- margins
- title placement
- bullet spacing
- image sizing
- table styling
- footer style
- logo placement

Every new slide should appear as if it was originally part of the presentation.

---

# Code Quality

Follow clean software engineering practices.

Prefer:

- reusable functions
- descriptive names
- modular slide generation
- configuration objects
- constants

Avoid:

- repeated slide code
- unnecessary complexity

---

# Visual Consistency

Keep:

- identical spacing
- identical margins
- identical title styles
- consistent diagram sizing

---

# Speaker Notes

If build.js supports speaker notes,

generate them.

Otherwise,

prepare them separately.

---

# Images

Whenever possible:

Generate images automatically.

Otherwise:

Describe:

- filename
- resolution
- purpose
- placement
- required external assets

---

# Review

Before modifying build.js verify:

- theme consistency
- code quality
- reusable components
- visual consistency
- no duplicated layouts