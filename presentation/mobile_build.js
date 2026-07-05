const pptxgen = require("pptxgenjs");

let pres = new pptxgen();
pres.layout = "LAYOUT_WIDE"; // 13.3 x 7.5
pres.author = "HireConnect Team";
pres.title = "HireConnect — Mobile App";

const W = 13.3, H = 7.5;

// ---- Palette (identical to build.js) ----
const TEAL_DARK = "0B3B37";
const TEAL      = "0F6B65";
const TEAL_LIGHT = "E4F0EE";
const AMBER     = "E8A33D";
const CHARCOAL  = "1F2A2E";
const MUTED     = "5C6B68";
const WHITE     = "FFFFFF";
const CARD_BG   = "F3F7F6";
const RED       = "C0463C";

const FONT      = "Calibri";
const HEAD_FONT = "Cambria";

// ---- Helpers (identical to build.js) ----
function shadow() {
  return { type: "outer", color: "000000", blur: 8, offset: 3, angle: 45, opacity: 0.12 };
}

function addFooter(slide, section, num) {
  slide.addText(section, { x: 0.5, y: H - 0.45, w: 6, h: 0.3, fontSize: 9, color: MUTED, fontFace: FONT });
  slide.addText(String(num), { x: W - 1, y: H - 0.45, w: 0.5, h: 0.3, fontSize: 9, color: MUTED, fontFace: FONT, align: "right" });
}

function titleBar(slide, title, opts = {}) {
  const color = opts.dark ? WHITE : CHARCOAL;
  slide.addText(title, {
    x: 0.6, y: 0.45, w: W - 1.2, h: 0.9,
    fontSize: 32, bold: true, color, fontFace: HEAD_FONT,
  });
}

function kicker(slide, text, opts = {}) {
  const color = opts.dark ? AMBER : TEAL;
  slide.addText(text.toUpperCase(), {
    x: 0.6, y: 0.18, w: W - 1.2, h: 0.3,
    fontSize: 12, bold: true, color, fontFace: FONT, charSpacing: 2,
  });
}

// Figure placeholder — replaced by real images after export
function figPlaceholder(slide, x, y, w, h, label) {
  slide.addShape(pres.shapes.RECTANGLE, {
    x, y, w, h,
    fill: { color: CARD_BG },
    line: { color: "AECCC8", width: 1, dashType: "dash" },
  });
  slide.addText(`[ FIGURE: ${label} ]`, {
    x, y, w, h,
    fontSize: 11, italic: true, color: MUTED, fontFace: FONT,
    align: "center", valign: "middle",
  });
}

let n = 23; // continues from build.js (which ends at n = 23)

// ============ SLIDE M01 — WHAT THE MOBILE APP OFFERS ============
{
  let s = pres.addSlide();
  s.background = { color: TEAL_DARK };
  kicker(s, "Mobile App", { dark: true });
  titleBar(s, "What the Mobile App Offers", { dark: true });

  // Journey strip — 3 phases
  const phases = [
    { t: "DISCOVER", sub: "Find the right job" },
    { t: "APPLY",    sub: "Submit instantly"   },
    { t: "TRACK",    sub: "Stay informed"       },
  ];
  const phW = 3.7, phGap = 0.55;
  const phStartX = (W - (phW * 3 + phGap * 2)) / 2;
  phases.forEach((p, i) => {
    const x = phStartX + i * (phW + phGap);
    s.addShape(pres.shapes.RECTANGLE, {
      x, y: 1.55, w: phW, h: 0.72,
      fill: { color: AMBER, transparency: 20 }, line: { type: "none" },
    });
    s.addText(p.t, {
      x, y: 1.57, w: phW, h: 0.37,
      fontSize: 13, bold: true, color: TEAL_DARK, fontFace: FONT, align: "center", charSpacing: 2,
    });
    s.addText(p.sub, {
      x, y: 1.94, w: phW, h: 0.28,
      fontSize: 10, color: TEAL_DARK, fontFace: FONT, align: "center",
    });
  });

  // Three feature columns
  const cols = [
    {
      header: "Profile & Resume",
      pts: [
        "Onboarding — personal details",
        "Resume builder — education, experience, skills, certifications, languages",
      ],
    },
    {
      header: "Job Discovery",
      pts: [
        "Personalized feed — ranked by matching engine",
        "Search & filter by type, salary, location, arrangement",
        "Favorite jobs to review later",
      ],
    },
    {
      header: "Applications & Notifications",
      pts: [
        "One-tap apply with optional cover letter",
        "Application tracker — real-time status updates",
        "Push notifications (Firebase FCM) + email opt-in",
      ],
    },
  ];
  const cW = 3.7, cGap = 0.55;
  const cStartX = (W - (cW * 3 + cGap * 2)) / 2;
  cols.forEach((col, i) => {
    const x = cStartX + i * (cW + cGap);
    s.addShape(pres.shapes.RECTANGLE, {
      x, y: 2.45, w: cW, h: 4.3,
      fill: { color: TEAL, transparency: 55 }, line: { color: AMBER, width: 1 }, shadow: shadow(),
    });
    s.addText(col.header.toUpperCase(), {
      x: x + 0.2, y: 2.6, w: cW - 0.4, h: 0.35,
      fontSize: 11, bold: true, color: AMBER, fontFace: FONT, charSpacing: 1, align: "center",
    });
    s.addText(
      col.pts.map((p, j) => ({
        text: p,
        options: { bullet: { code: "2022" }, breakLine: j < col.pts.length - 1, color: WHITE },
      })),
      { x: x + 0.2, y: 3.1, w: cW - 0.4, h: 3.4, fontSize: 12.5, fontFace: FONT, lineSpacingMultiple: 1.45, valign: "top" }
    );
  });

  addFooter(s, "Mobile App", ++n);
}

// ============ SLIDE M02 — NAVIGATION ARCHITECTURE ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Mobile App");
  titleBar(s, "Application Architecture & Navigation Flow");

  // Left: figure placeholder
  figPlaceholder(s, 0.6, 1.75, 7.0, 4.9, "fig_navigation_flow.png — Screen Flow & Navigation Diagram");

  // Right: bottom-nav tabs
  s.addShape(pres.shapes.RECTANGLE, {
    x: 7.85, y: 1.75, w: 4.85, h: 0.5,
    fill: { color: TEAL_DARK }, line: { type: "none" },
  });
  s.addText("BOTTOM NAVIGATION — 4 TABS", {
    x: 7.85, y: 1.75, w: 4.85, h: 0.5,
    fontSize: 11, bold: true, color: AMBER, fontFace: FONT, align: "center", valign: "middle", charSpacing: 1,
  });

  const tabs = [
    { tab: "Tab 1 — Home",         sub: "Recommended jobs & Saved jobs (Favorites)" },
    { tab: "Tab 2 — Jobs",         sub: "All jobs list, search, filters & work arrangements" },
    { tab: "Tab 3 — Applied",      sub: "Applications status tracker" },
    { tab: "Tab 4 — Profile",      sub: "Edit profile, resume builder, app settings & info" },
  ];
  tabs.forEach((tab, i) => {
    const y = 2.35 + i * 1.1;
    s.addShape(pres.shapes.RECTANGLE, {
      x: 7.85, y, w: 4.85, h: 0.9,
      fill: { color: i % 2 === 0 ? CARD_BG : TEAL_LIGHT }, line: { type: "none" },
    });
    s.addText(tab.tab, {
      x: 8.05, y: y + 0.08, w: 4.45, h: 0.3,
      fontSize: 12, bold: true, color: TEAL, fontFace: FONT,
    });
    s.addText(tab.sub, {
      x: 8.05, y: y + 0.42, w: 4.45, h: 0.4,
      fontSize: 11, color: CHARCOAL, fontFace: FONT,
    });
  });

  // OTA gate note
  s.addShape(pres.shapes.RECTANGLE, {
    x: 7.85, y: 6.87, w: 4.85, h: 0.35,
    fill: { color: AMBER, transparency: 30 }, line: { type: "none" },
  });
  s.addText("Startup: OTA version check runs before any screen loads", {
    x: 7.85, y: 6.87, w: 4.85, h: 0.35,
    fontSize: 10, italic: true, color: TEAL_DARK, fontFace: FONT, align: "center", valign: "middle",
  });

  addFooter(s, "Mobile App", ++n);
}

// ============ SLIDE M03 — SECURE TOKEN STORAGE ============
{
  let s = pres.addSlide();
  s.background = { color: TEAL_DARK };
  kicker(s, "Security", { dark: true });
  titleBar(s, "Why We Don't Store JWT in SharedPreferences", { dark: true });

  // Left card — SharedPreferences (❌)
  s.addShape(pres.shapes.RECTANGLE, {
    x: 0.6, y: 1.75, w: 5.85, h: 3.5,
    fill: { color: TEAL, transparency: 55 }, line: { color: RED, width: 1.5 }, shadow: shadow(),
  });
  s.addText("SharedPreferences", {
    x: 0.85, y: 1.88, w: 5.35, h: 0.4,
    fontSize: 17, bold: true, color: RED, fontFace: HEAD_FONT,
  });
  const spProblems = [
    "Stored as plain XML on disk: /data/data/<package>/",
    "Readable by any process with root access",
    "Not encrypted at the OS level",
    "Cloud backup by default — token survives app uninstall on some devices",
    "No iOS Keychain equivalent",
  ];
  s.addText(
    spProblems.map((p, i) => ({
      text: p,
      options: { bullet: { code: "2022" }, breakLine: i < spProblems.length - 1, color: WHITE },
    })),
    { x: 0.85, y: 2.4, w: 5.35, h: 2.65, fontSize: 12, fontFace: FONT, lineSpacingMultiple: 1.35, valign: "top" }
  );

  // Right card — flutter_secure_storage (✅)
  s.addShape(pres.shapes.RECTANGLE, {
    x: 6.85, y: 1.75, w: 5.85, h: 3.5,
    fill: { color: TEAL, transparency: 55 }, line: { color: AMBER, width: 1.5 }, shadow: shadow(),
  });
  s.addText("flutter_secure_storage", {
    x: 7.1, y: 1.88, w: 5.35, h: 0.4,
    fontSize: 17, bold: true, color: AMBER, fontFace: HEAD_FONT,
  });
  const fssPoints = [
    "Android: Android Keystore + EncryptedSharedPreferences",
    "iOS: native Keychain Services API",
    "Keys are hardware-bound on supported devices",
    "Cleared on app uninstall (unlike cloud-backed prefs)",
    "Trade-off: ~1–3 ms read vs ~0.1 ms — negligible in a login flow",
    "Trade-off: wiped on factory reset → user simply re-authenticates",
  ];
  s.addText(
    fssPoints.map((p, i) => ({
      text: p,
      options: { bullet: { code: "2022" }, breakLine: i < fssPoints.length - 1, color: WHITE },
    })),
    { x: 7.1, y: 2.4, w: 5.35, h: 2.65, fontSize: 12, fontFace: FONT, lineSpacingMultiple: 1.35, valign: "top" }
  );

  // Bottom left: article screenshot placeholder
  figPlaceholder(s, 0.6, 5.45, 5.85, 1.3, "fig_shared_prefs_article.png — Medium Article Screenshot");

  // Bottom right: quote banner
  s.addShape(pres.shapes.RECTANGLE, {
    x: 6.85, y: 5.45, w: 5.85, h: 1.3,
    fill: { color: AMBER, transparency: 20 }, line: { type: "none" },
  });
  s.addText("\"The performance penalty is negligible.\nThe security boundary is not optional.\"", {
    x: 7.05, y: 5.45, w: 5.45, h: 1.3,
    fontSize: 16, bold: true, italic: true, color: TEAL_DARK, fontFace: HEAD_FONT, align: "center", valign: "middle",
  });

  addFooter(s, "Security", ++n);
}

// ============ SLIDE M04 — AUTH FLOW & DIO INTERCEPTOR ============
{
  let s = pres.addSlide();
  s.background = { color: TEAL_DARK };
  kicker(s, "Security", { dark: true });
  titleBar(s, "Authentication Flow & Dio Interceptor", { dark: true });

  // Left: sequence diagram placeholder
  figPlaceholder(s, 0.6, 1.75, 7.2, 4.9, "fig_auth_sequence.png — Authentication & Interceptor Sequence Diagram");

  // Right — Card 1: AuthInterceptor
  s.addShape(pres.shapes.RECTANGLE, {
    x: 8.1, y: 1.75, w: 4.6, h: 2.3,
    fill: { color: TEAL, transparency: 50 }, line: { color: AMBER, width: 1 }, shadow: shadow(),
  });
  s.addText("AuthInterceptor", {
    x: 8.3, y: 1.88, w: 4.2, h: 0.35,
    fontSize: 15, bold: true, color: AMBER, fontFace: HEAD_FONT,
  });
  const interceptorPts = [
    "Global Dio wrapper",
    "Reads JWT from flutter_secure_storage",
    "Appends Authorization: Bearer <token> to every request",
    "Intercepts 401 / 403 → delegates to AuthDialogManager",
    "Token logic never reaches the UI layer",
  ];
  s.addText(
    interceptorPts.map((p, i) => ({
      text: p,
      options: { bullet: { code: "2022" }, breakLine: i < interceptorPts.length - 1, color: WHITE },
    })),
    { x: 8.3, y: 2.3, w: 4.2, h: 1.6, fontSize: 11, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" }
  );

  // Right — Card 2: AuthDialogManager
  s.addShape(pres.shapes.RECTANGLE, {
    x: 8.1, y: 4.2, w: 4.6, h: 2.45,
    fill: { color: TEAL, transparency: 50 }, line: { color: AMBER, width: 1 }, shadow: shadow(),
  });
  s.addText("AuthDialogManager — Semaphore", {
    x: 8.3, y: 4.32, w: 4.2, h: 0.4,
    fontSize: 14, bold: true, color: AMBER, fontFace: HEAD_FONT,
  });
  s.addText([
    { text: "Problem: ", options: { bold: true, color: WHITE } },
    { text: "Profile page fires 4 parallel calls. All 4 return 401 simultaneously → 4 dialogs stack.", options: { color: WHITE, breakLine: true } },
    { text: "\nSolution — boolean semaphore:\n", options: { bold: true, color: AMBER, breakLine: true } },
    { text: "First 401 → raise flag → show dialog\nSubsequent 401s → flag is true → silently swallowed", options: { color: WHITE } },
  ], { x: 8.3, y: 4.78, w: 4.2, h: 1.75, fontSize: 11, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" });

  addFooter(s, "Security", ++n);
}

// ============ SLIDE M05 — LOGOUT & CACHE ISOLATION ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Security");
  titleBar(s, "Logout & Multi-Account Cache Isolation");

  // Left: logout flow placeholder
  figPlaceholder(s, 0.6, 1.75, 7.0, 4.9, "fig_logout_flow.png — Logout Sequence Flowchart");

  // Right: provider card
  s.addShape(pres.shapes.RECTANGLE, {
    x: 7.85, y: 1.75, w: 4.85, h: 3.85,
    fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow(),
  });
  s.addText("What gets cached — 12 providers:", {
    x: 8.05, y: 1.9, w: 4.45, h: 0.35,
    fontSize: 13, bold: true, color: TEAL, fontFace: FONT,
  });
  const providers = [
    "Profile data — name, photo, role",
    "Resume data — skills, education, experience",
    "Applied jobs list — status per job",
    "Favorite jobs list — bookmarked IDs",
    "Interest tags — field-of-interest chips",
    "Job feed pages — paginated results",
    "Search results — last query + filters",
    "Notifications — unread count + list",
    "Currency setting — selected code",
    "Language setting — AR / EN",
    "Personal info — contact details",
    "Auth state — current principal",
  ];
  s.addText(
    providers.map((p, i) => ({
      text: p,
      options: { bullet: { code: "2022" }, breakLine: i < providers.length - 1, color: CHARCOAL },
    })),
    { x: 8.05, y: 2.35, w: 4.45, h: 3.1, fontSize: 10.5, fontFace: FONT, lineSpacingMultiple: 1.2, valign: "top" }
  );

  // Bottom banner
  s.addShape(pres.shapes.RECTANGLE, {
    x: 7.85, y: 5.75, w: 4.85, h: 1.0,
    fill: { color: TEAL_DARK }, line: { type: "none" },
  });
  s.addText("\"On a shared device, skipping any one of these leaks the previous user's data to the next. Seasonal workers share devices — this is a real scenario.\"", {
    x: 8.0, y: 5.8, w: 4.55, h: 0.9,
    fontSize: 10.5, italic: true, color: WHITE, fontFace: FONT, valign: "middle", lineSpacingMultiple: 1.25,
  });

  addFooter(s, "Security", ++n);
}

// ============ SLIDE M06 — OTA: THE PLAY STORE PROBLEM ============
{
  let s = pres.addSlide();
  s.background = { color: TEAL_DARK };
  kicker(s, "OTA Updates", { dark: true });
  titleBar(s, "The Play Store Problem — Why We Built Our Own Update System", { dark: true });

  // Standard flow — 4 boxes
  const flowSteps = [
    "Developer signs APK",
    "Uploads to Play Store ($25 one-time fee)",
    "Store notifies all installed users",
    "User downloads with one tap",
  ];
  const bw = 2.85, bg = 0.2;
  const totalFlowW = bw * 4 + bg * 3;
  const flowStartX = (W - totalFlowW) / 2;
  flowSteps.forEach((step, i) => {
    const x = flowStartX + i * (bw + bg);
    s.addShape(pres.shapes.RECTANGLE, {
      x, y: 1.7, w: bw, h: 0.8,
      fill: { color: TEAL, transparency: 40 }, line: { color: MUTED, width: 1 },
    });
    s.addText(String(i + 1), {
      x: x + 0.15, y: 1.7, w: 0.4, h: 0.8,
      fontSize: 16, bold: true, color: AMBER, fontFace: HEAD_FONT, valign: "middle",
    });
    s.addText(step, {
      x: x + 0.6, y: 1.7, w: bw - 0.75, h: 0.8,
      fontSize: 11, color: WHITE, fontFace: FONT, valign: "middle",
    });
    if (i < 3) {
      s.addShape(pres.shapes.LINE, {
        x: x + bw, y: 2.1, w: bg, h: 0,
        line: { color: MUTED, width: 1.5, endArrowType: "triangle" },
      });
    }
  });

  // Constraint card
  s.addShape(pres.shapes.RECTANGLE, {
    x: 0.6, y: 2.7, w: 12.1, h: 1.6,
    fill: { color: TEAL, transparency: 60 }, line: { color: AMBER, width: 1.5 },
  });
  s.addText([
    { text: "Our Constraint\n", options: { bold: true, color: AMBER, fontSize: 14, breakLine: true } },
    { text: "As a graduation project, the Play Store fee is a cost we chose not to commit to before validating the product. We still required: automated APK builds on every push, user update notifications, and frictionless download.", options: { color: WHITE, fontSize: 12 } },
  ], { x: 0.85, y: 2.82, w: 11.6, h: 1.35, fontFace: FONT, valign: "top", lineSpacingMultiple: 1.3 });

  // Decomposition — 2 boxes
  const decomp = [
    { prob: "Problem 1 — Build automation", sol: "GitHub Actions CI/CD — builds and publishes a new APK release on every push" },
    { prob: "Problem 2 — Update notification", sol: "Mobile client queries GitHub Releases API directly — no backend relay needed" },
  ];
  decomp.forEach((d, i) => {
    const x = 0.6 + i * 6.2;
    s.addShape(pres.shapes.RECTANGLE, {
      x, y: 4.5, w: 5.9, h: 1.55,
      fill: { color: TEAL, transparency: 50 }, line: { color: AMBER, width: 1 }, shadow: shadow(),
    });
    s.addText(d.prob, {
      x: x + 0.25, y: 4.62, w: 5.4, h: 0.32,
      fontSize: 12, bold: true, color: AMBER, fontFace: FONT,
    });
    s.addText("→  " + d.sol, {
      x: x + 0.25, y: 4.98, w: 5.4, h: 0.9,
      fontSize: 11.5, color: WHITE, fontFace: FONT, lineSpacingMultiple: 1.2, valign: "top",
    });
  });

  s.addText("No intermediary — one fewer network hop — no extra backend code required.", {
    x: 0.6, y: 6.25, w: 12.1, h: 0.4,
    fontSize: 11, italic: true, color: MUTED, fontFace: FONT, align: "center",
  });

  addFooter(s, "OTA Updates", ++n);
}

// ============ SLIDE M07 — OTA: IMPLEMENTATION & SNOOZE ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "OTA Updates");
  titleBar(s, "OTA Implementation — Mandatory vs Optional & Snooze Flow");

  // Left — state machine flowchart placeholder
  figPlaceholder(s, 0.6, 1.75, 7.2, 4.9, "fig_ota_state_machine.png — Snooze State Machine Flowchart");

  // Right — screenshot placeholders stacked vertically
  figPlaceholder(s, 8.2, 1.75, 4.5, 2.35, "fig_optional_update_screen.png");
  figPlaceholder(s, 8.2, 4.3,  4.5, 2.35, "fig_mandatory_update_screen.png");

  addFooter(s, "OTA Updates", ++n);
}

// ============ SLIDE M08 — LOCALISATION & RTL ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Localisation");
  titleBar(s, "Arabic / English Localisation & RTL Support");

  // Top Center — RTL comparison placeholder
  figPlaceholder(s, 0.6, 1.75, 12.1, 3.5, "fig_rtl_comparison.png — English (LTR) vs Arabic (RTL) Screenshot");

  // Bottom — content card
  s.addShape(pres.shapes.RECTANGLE, {
    x: 0.6, y: 5.45, w: 12.1, h: 1.2,
    fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow(),
  });
  s.addText([
    { text: "Why it was required: ", options: { bold: true, color: TEAL, fontSize: 13 } },
    { text: "Our primary target market is Egypt — Arabic is the dominant language for seasonal workers. Without full RTL layout, text aligns incorrectly, list items render backwards, and navigation gestures mirror incorrectly, causing severe usability issues.", options: { color: CHARCOAL, fontSize: 12 } }
  ], { x: 0.85, y: 5.55, w: 11.6, h: 1.0, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "middle" });

  addFooter(s, "Localisation", ++n);
}

// ============ SLIDE M09 — PARALLEL AGGREGATION ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Performance");
  titleBar(s, "Parallel Aggregation — Eliminating Sequential Round-Trips");

  // Left — timeline comparison placeholder
  figPlaceholder(s, 0.6, 1.75, 6.0, 4.0, "fig_parallel_aggregation.png — Sequential vs Parallel Timeline Diagram");

  // Right — explanation
  s.addShape(pres.shapes.RECTANGLE, {
    x: 6.9, y: 1.75, w: 5.8, h: 2.05,
    fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow(),
  });
  s.addText("The Problem", {
    x: 7.1, y: 1.88, w: 5.4, h: 0.32,
    fontSize: 14, bold: true, color: TEAL, fontFace: FONT,
  });
  s.addText(
    "Profile page requires 4 API calls:\n  GET /api/users/{uid}\n  GET /api/applications/user\n  GET /api/jobs/favorites\n  GET /api/users/FOI/{uid}\n\nSequential → TTI ≈ ~800ms",
    { x: 7.1, y: 2.26, w: 5.4, h: 1.4, fontSize: 11.5, color: CHARCOAL, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" }
  );

  s.addShape(pres.shapes.RECTANGLE, {
    x: 6.9, y: 3.95, w: 5.8, h: 1.8,
    fill: { color: TEAL_DARK }, line: { type: "none" }, shadow: shadow(),
  });
  s.addText("Solution — Future.wait", {
    x: 7.1, y: 4.06, w: 5.4, h: 0.32,
    fontSize: 14, bold: true, color: AMBER, fontFace: FONT,
  });
  s.addText("await Future.wait([\n  getProfile, getApplications,\n  getFavorites, getInterests\n]);", {
    x: 7.1, y: 4.44, w: 5.4, h: 0.8,
    fontSize: 10.5, color: AMBER, fontFace: "Courier New",
  });
  s.addText("TTI = max(t1, t2, t3, t4) ≈ 200ms  →  ~75% reduction", {
    x: 7.1, y: 5.28, w: 5.4, h: 0.38,
    fontSize: 12, bold: true, color: WHITE, fontFace: FONT,
  });

  // Trade-off note
  s.addShape(pres.shapes.RECTANGLE, {
    x: 0.6, y: 5.9, w: 12.1, h: 0.75,
    fill: { color: TEAL_LIGHT }, line: { type: "none" },
  });
  s.addText("Trade-off: Future.wait throws immediately if any call fails. Mitigation: error boundary wraps the profile notifier — sections show skeleton loaders on partial failure.", {
    x: 0.85, y: 5.95, w: 11.6, h: 0.6,
    fontSize: 11.5, italic: true, color: CHARCOAL, fontFace: FONT, valign: "middle",
  });

  addFooter(s, "Performance", ++n);
}

// ============ SLIDE M10 — OPTIMISTIC UI & ROLLBACK ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Performance");
  titleBar(s, "Optimistic UI Updates & Automatic Rollback");

  // Left — sequence diagram placeholder
  figPlaceholder(s, 0.6, 1.75, 6.5, 4.9, "fig_optimistic_update.png — Favorites Optimistic Update & Rollback Sequence");

  // Right — pattern card
  s.addShape(pres.shapes.RECTANGLE, {
    x: 7.35, y: 1.75, w: 5.35, h: 3.9,
    fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow(),
  });
  s.addText("FavoritesController Pattern", {
    x: 7.55, y: 1.88, w: 4.95, h: 0.38,
    fontSize: 16, bold: true, color: TEAL, fontFace: HEAD_FONT,
  });
  const steps = [
    { label: "1. Cache current state",              code: "final previousState = state.value;",         err: false },
    { label: "2. Update UI immediately",             code: "state = AsyncData(updatedList);",             err: false },
    { label: "3. Fire async HTTP request",           code: "",                                             err: false },
    { label: "4a. On success",                       code: "ref.invalidate(favoriteJobsProvider);",       err: false },
    { label: "4b. On failure → rollback",            code: "state = AsyncData(previousState);",           err: true  },
  ];
  let stepY = 2.35;
  steps.forEach(({ label, code, err }) => {
    s.addText(label, {
      x: 7.55, y: stepY, w: 4.95, h: 0.28,
      fontSize: 12, bold: true, color: err ? RED : TEAL, fontFace: FONT,
    });
    stepY += 0.3;
    if (code) {
      s.addText(code, {
        x: 7.7, y: stepY, w: 4.8, h: 0.38,
        fontSize: 10, color: CHARCOAL, fontFace: "Courier New",
      });
      stepY += 0.45;
    }
  });

  // Trade-off banner
  s.addShape(pres.shapes.RECTANGLE, {
    x: 7.35, y: 5.8, w: 5.35, h: 0.85,
    fill: { color: TEAL_DARK }, line: { type: "none" },
  });
  s.addText("Trade-off: brief inconsistency on server rejection → mitigated by immediate rollback + visible error toast.", {
    x: 7.55, y: 5.85, w: 4.95, h: 0.75,
    fontSize: 11, italic: true, color: WHITE, fontFace: FONT, valign: "middle", lineSpacingMultiple: 1.2,
  });

  addFooter(s, "Performance", ++n);
}

// ============ SLIDE M11 — MULTI-CURRENCY REACTIVE STATE ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "State Management");
  titleBar(s, "Multi-Currency — Reactive State Propagation");

  // Left — reactive graph placeholder
  figPlaceholder(s, 0.6, 1.75, 6.0, 4.5, "fig_currency_reactive.png — Reactive State Propagation Diagram");

  // Right — explanation card
  s.addShape(pres.shapes.RECTANGLE, {
    x: 6.9, y: 1.75, w: 5.8, h: 4.5,
    fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow(),
  });
  s.addText("Supported Currencies", {
    x: 7.1, y: 1.88, w: 5.4, h: 0.32,
    fontSize: 14, bold: true, color: TEAL, fontFace: FONT,
  });
  s.addText("EGP (default)  •  USD  •  SAR  •  extensible to any ISO 4217 code", {
    x: 7.1, y: 2.26, w: 5.4, h: 0.4,
    fontSize: 12, color: CHARCOAL, fontFace: FONT,
  });

  s.addText("How it works", {
    x: 7.1, y: 2.78, w: 5.4, h: 0.32,
    fontSize: 14, bold: true, color: TEAL, fontFace: FONT,
  });
  s.addText("1. User selects currency in Settings\n2. PATCH /api/users/{uid} — backend sync\n3. personalInformationProvider updated\n4. Job feed and Favorites providers watch:", {
    x: 7.1, y: 3.15, w: 5.4, h: 1.05,
    fontSize: 11.5, color: CHARCOAL, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top",
  });

  s.addShape(pres.shapes.RECTANGLE, {
    x: 7.1, y: 4.28, w: 5.4, h: 0.6,
    fill: { color: TEAL_DARK }, line: { type: "none" },
  });
  s.addText("ref.watch(personalInformationProvider\n  .select((u) => u.value?.currency));", {
    x: 7.2, y: 4.3, w: 5.2, h: 0.56,
    fontSize: 10.5, color: AMBER, fontFace: "Courier New", valign: "middle",
  });

  s.addText("5. Currency change → auto-invalidates → feed & favorites reload\n6. intl.simpleCurrency() formats: $1,200 / EGP 15,000\n\nNo event bus. No refresh button. No imperative callbacks.", {
    x: 7.1, y: 4.98, w: 5.4, h: 1.1,
    fontSize: 11.5, color: CHARCOAL, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top",
  });

  addFooter(s, "State Management", ++n);
}

// ============ SLIDE M12 — IN-APP FEEDBACK ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "UX & Quality");
  titleBar(s, "In-App Feedback & Anonymous Submission");

  // Left — screenshot placeholder
  figPlaceholder(s, 0.6, 1.75, 5.2, 4.9, "fig_feedback_form.png — In-App Feedback Form Screenshot");

  // Right — content card
  s.addShape(pres.shapes.RECTANGLE, {
    x: 6.4, y: 1.75, w: 6.3, h: 4.9,
    fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow(),
  });
  s.addText([
    { text: "Why it exists\n", options: { bold: true, color: TEAL, fontSize: 15, breakLine: true } },
    { text: "Every shipped app has bugs that survive testing. Users need a low-friction channel to report issues directly from the device.\n\n", options: { color: CHARCOAL, breakLine: true } },
    { text: "Anonymous Toggle\n", options: { bold: true, color: TEAL, fontSize: 15, breakLine: true } },
    { text: "OFF  →  payload includes user's authenticated email\nON   →  email is excluded from the JSON payload entirely\n\n", options: { color: CHARCOAL, breakLine: true } },
    { text: "Benefit:\n", options: { bold: true, color: CHARCOAL, breakLine: true } },
    { text: "Enables workers to report employer misconduct, payment issues, or safety hazards safely without disclosing their identity, preventing retaliation.", options: { color: MUTED } }
  ], { x: 6.65, y: 1.95, w: 5.8, h: 4.5, fontSize: 12.5, fontFace: FONT, lineSpacingMultiple: 1.35, valign: "top" });

  addFooter(s, "UX & Quality", ++n);
}

// ============ SLIDE M13 — PERFORMANCE BENCHMARKS ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Performance");
  titleBar(s, "Benchmarks — State Engine vs UI Rendering");

  // Table 1 — CPU latency (Riverpod state engine)
  const rows1 = [
    [
      { text: "Data Scale",            options: { bold: true, color: WHITE, fill: { color: TEAL } } },
      { text: "CPU Execution Latency", options: { bold: true, color: WHITE, fill: { color: TEAL } } },
      { text: "Status",                options: { bold: true, color: WHITE, fill: { color: TEAL } } },
    ],
    ["100 Jobs",       "~0.15 ms",  "Excellent"],
    ["1,000 Jobs",     "~1.25 ms",  "Excellent"],
    ["10,000 Jobs",    "~8.10 ms",  "Good"],
    ["100,000 Jobs",   "~14.50 ms", "Safe (< 16.6 ms)"],
  ];
  s.addTable(rows1, {
    x: 0.6, y: 1.75, w: 5.85, h: 2.9,
    fontFace: FONT, fontSize: 11, color: CHARCOAL,
    border: { pt: 0.5, color: "D8E4E2" }, autoPage: false,
    colW: [1.85, 2.1, 1.9], valign: "middle",
  });

  // Table 2 — Memory projections
  const rows2 = [
    [
      { text: "Jobs in Heap",      options: { bold: true, color: WHITE, fill: { color: TEAL_DARK } } },
      { text: "Est. Memory Usage", options: { bold: true, color: WHITE, fill: { color: TEAL_DARK } } },
      { text: "Status",            options: { bold: true, color: WHITE, fill: { color: TEAL_DARK } } },
    ],
    ["100 Jobs",     "~150 KB",   "Negligible"],
    ["1,000 Jobs",   "~1.5 MB",   "Safe"],
    ["30,000+ Jobs", "~45.0 MB+", "OOM Risk"],
  ];
  s.addTable(rows2, {
    x: 6.85, y: 1.75, w: 5.85, h: 2.3,
    fontFace: FONT, fontSize: 11, color: CHARCOAL,
    border: { pt: 0.5, color: "D8E4E2" }, autoPage: false,
    colW: [1.85, 2.1, 1.9], valign: "middle",
  });

  // Justification box
  s.addShape(pres.shapes.RECTANGLE, {
    x: 0.6, y: 4.95, w: 12.1, h: 2.2,
    fill: { color: CARD_BG }, line: { type: "none" },
  });
  s.addText([
    { text: "Engineering Justification\n", options: { bold: true, color: TEAL, fontSize: 14, breakLine: true } },
    { text: "The Riverpod state engine is computationally efficient at any scale. The bottleneck is Flutter's widget inflation — rendering 1,000+ job cards consumes significant RAM and causes frame jank on low-end Android hardware (the dominant device class in our target market).\n\n", options: { color: CHARCOAL } },
    { text: "Hybrid Pagination: ", options: { bold: true, color: TEAL } },
    { text: "auto-scroll pauses at 200 items in the widget tree → user taps \"Load More\" to continue. The 14.5ms benchmark proves the limit is device rendering — not state management.", options: { color: CHARCOAL } },
  ], { x: 0.85, y: 5.05, w: 11.6, h: 2.0, fontSize: 12, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" });

  addFooter(s, "Performance", ++n);
}

// ============ SLIDE M14 — TESTING HIERARCHY ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Testing");
  titleBar(s, "Testing Hierarchy & Key Validation Scenarios");

  // Center — pyramid placeholder
  figPlaceholder(s, 2.15, 1.75, 9.0, 4.9, "fig_testing_hierarchy.png — Multi-Layer Testing Pyramid Diagram");

  addFooter(s, "Testing", ++n);
}

// ============ SLIDE M15 — COMPLETED & ROADMAP ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Summary");
  titleBar(s, "What Was Built — What Comes Next");

  // Left — Completed
  s.addShape(pres.shapes.RECTANGLE, {
    x: 0.6, y: 1.75, w: 5.85, h: 4.9,
    fill: { color: TEAL_LIGHT }, line: { type: "none" }, shadow: shadow(),
  });
  s.addText("COMPLETED", {
    x: 0.85, y: 1.9, w: 5.2, h: 0.35,
    fontSize: 13, bold: true, color: TEAL, fontFace: FONT, charSpacing: 1,
  });
  const done = [
    "Full onboarding — personal details",
    "Resume builder — education, experience, skills, certifications, languages",
    "Personalized job feed (matching engine integration)",
    "Search & filter by type, location, salary, arrangement",
    "One-tap apply with optional cover letter",
    "Application status tracker (real-time)",
    "Push notifications (Firebase FCM) + email opt-in",
    "Favorite jobs — optimistic UI + rollback",
    "Secure JWT storage (flutter_secure_storage)",
    "Dio AuthInterceptor + AuthDialogManager semaphore",
    "Multi-account cache isolation (12 providers on logout)",
    "OTA update system — mandatory + optional + 24-hr snooze",
    "Arabic / English localisation + full RTL support",
    "Multi-currency display (EGP, USD, SAR) — reactive state",
    "Parallel aggregation on profile page (Future.wait)",
    "In-app feedback with anonymous submission",
    "Performance benchmarks + hybrid pagination (200-item limit)",
  ];
  s.addText(
    done.map((d, i) => ({
      text: d,
      options: { bullet: { code: "2022" }, breakLine: i < done.length - 1, color: CHARCOAL },
    })),
    { x: 0.85, y: 2.35, w: 5.2, h: 4.15, fontSize: 10.5, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" }
  );

  // Right — Roadmap
  s.addShape(pres.shapes.RECTANGLE, {
    x: 6.85, y: 1.75, w: 5.85, h: 4.9,
    fill: { color: TEAL_DARK }, line: { type: "none" }, shadow: shadow(),
  });
  s.addText("ROADMAP", {
    x: 7.1, y: 1.9, w: 5.2, h: 0.35,
    fontSize: 13, bold: true, color: AMBER, fontFace: FONT, charSpacing: 1,
  });
  const next = [
    "In-app messaging (employer ↔ job seeker) — requires WebSocket server",
    "Employer rating & review system",
    "Interview scheduling in-app (calendar integration)",
    "Offline mode — cached feed for low-connectivity areas",
    "Semantic job search (NLP / vector similarity)",
    "Play Store publication (post-pilot validation)",
    "iOS build + App Store submission",
  ];
  s.addText(
    next.map((d, i) => ({
      text: d,
      options: { bullet: { code: "2022" }, breakLine: i < next.length - 1, color: WHITE },
    })),
    { x: 7.1, y: 2.35, w: 5.2, h: 4.15, fontSize: 12, fontFace: FONT, lineSpacingMultiple: 1.4, valign: "top" }
  );

  addFooter(s, "Summary", ++n);
}

pres.writeFile({ fileName: "HireConnect_Mobile_Presentation.pptx" })
  .then(() => console.log("done — " + n + " total slides (mobile: " + (n - 23) + ")"));
