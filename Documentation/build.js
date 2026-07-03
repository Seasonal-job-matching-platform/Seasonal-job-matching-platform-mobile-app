const pptxgen = require("pptxgenjs");

let pres = new pptxgen();
pres.layout = "LAYOUT_WIDE"; // 13.3 x 7.5
pres.author = "HireConnect Team";
pres.title = "Seasonal Job Matching Platform — HireConnect";

const W = 13.3, H = 7.5;

// ---- Palette ----
const TEAL_DARK = "0B3B37";
const TEAL = "0F6B65";
const TEAL_LIGHT = "E4F0EE";
const AMBER = "E8A33D";
const CHARCOAL = "1F2A2E";
const MUTED = "5C6B68";
const WHITE = "FFFFFF";
const CARD_BG = "F3F7F6";
const RED = "C0463C";

const FONT = "Calibri";
const HEAD_FONT = "Cambria";

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

let n = 0;

// ============ SLIDE 1 — TITLE ============
{
  let s = pres.addSlide();
  s.background = { color: TEAL_DARK };
  s.addShape(pres.shapes.OVAL, { x: 9.6, y: -2.2, w: 6, h: 6, fill: { color: TEAL, transparency: 55 }, line: { type: "none" } });
  s.addShape(pres.shapes.OVAL, { x: -2.5, y: 4.5, w: 5, h: 5, fill: { color: AMBER, transparency: 82 }, line: { type: "none" } });

  s.addText("ALEXANDRIA UNIVERSITY  •  GRADUATION PROJECT", {
    x: 0.8, y: 1.0, w: 8, h: 0.4, fontSize: 13, color: AMBER, fontFace: FONT, bold: true, charSpacing: 2,
  });
  s.addText([
    { text: "HireConnect", options: { breakLine: true, color: WHITE, bold: true } },
    { text: "A Seasonal Job Matching Platform", options: { color: "BFE3DE", bold: false } },
  ], { x: 0.8, y: 1.5, w: 10.5, h: 2.2, fontSize: 46, fontFace: HEAD_FONT });

  s.addText("Connecting seasonal employers and job seekers in Egypt's agriculture, hospitality, retail, tourism, and construction sectors.", {
    x: 0.8, y: 3.7, w: 8.2, h: 0.8, fontSize: 15, color: "BFE3DE", fontFace: FONT,
  });

  s.addShape(pres.shapes.RECTANGLE, { x: 0.8, y: 4.9, w: 4.6, h: 1.35, fill: { color: TEAL, transparency: 60 }, line: { color: AMBER, width: 1 } });
  s.addText([
    { text: "Supervised by\n", options: { breakLine: true, fontSize: 11, color: "9FC9C3" } },
    { text: "Dr. Hicham Elmongui", options: { fontSize: 17, bold: true, color: WHITE } },
  ], { x: 1.0, y: 5.0, w: 4.2, h: 1.15, fontFace: FONT, valign: "middle" });

  addFooter(s, "Opening", ++n);
}

// ============ SLIDE 2 — AGENDA ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Agenda");
  titleBar(s, "What We'll Cover");

  const items = [
    ["01", "The Problem & Market"],
    ["02", "Competitive Reality"],
    ["03", "Product Overview"],
    ["04", "System Architecture"],
    ["05", "API, Security & Matching Engine"],
    ["06", "Web & Mobile Applications"],
    ["07", "Business Model"],
    ["08", "Risks & Roadmap"],
  ];
  const colW = 5.9, gx = 0.6, gy = 1.7, rowH = 1.15;
  items.forEach((it, i) => {
    const col = Math.floor(i / 4), row = i % 4;
    const x = gx + col * (colW + 0.3), y = gy + row * rowH;
    s.addShape(pres.shapes.RECTANGLE, { x, y, w: colW, h: rowH - 0.2, fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow() });
    s.addText(it[0], { x: x + 0.25, y, w: 1, h: rowH - 0.2, fontSize: 26, bold: true, color: AMBER, fontFace: HEAD_FONT, valign: "middle" });
    s.addText(it[1], { x: x + 1.2, y, w: colW - 1.4, h: rowH - 0.2, fontSize: 16, bold: true, color: CHARCOAL, fontFace: FONT, valign: "middle" });
  });
  addFooter(s, "Opening", ++n);
}

// ============ SLIDE 3 — THE PROBLEM ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "The Problem");
  titleBar(s, "Egypt's Youth Are Locked Out of Seasonal Work");

  const stats = [
    ["13.2%", "Youth unemployment (ages 15-29), vs. 6.3% nationally"],
    ["33.8%", "Unemployment among young women — vs. 8.1% for young men"],
    ["21M+", "People aged 18-29 in Egypt (~20% of the population)"],
  ];
  stats.forEach((st, i) => {
    const x = 0.6 + i * 4.15;
    s.addShape(pres.shapes.RECTANGLE, { x, y: 1.75, w: 3.85, h: 2.15, fill: { color: TEAL_LIGHT }, line: { type: "none" }, shadow: shadow() });
    s.addText(st[0], { x: x + 0.25, y: 1.9, w: 3.4, h: 0.9, fontSize: 44, bold: true, color: TEAL, fontFace: HEAD_FONT });
    s.addText(st[1], { x: x + 0.25, y: 2.75, w: 3.4, h: 1.0, fontSize: 12.5, color: CHARCOAL, fontFace: FONT });
  });

  s.addText("Source: CAPMAS, 2025 — Egypt's labor force reached 34.15M in 2025 (up from 32.04M in 2024); total employment 32.02M.", {
    x: 0.6, y: 4.1, w: 12.1, h: 0.4, fontSize: 10.5, italic: true, color: MUTED, fontFace: FONT,
  });

  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 4.7, w: 12.1, h: 2.0, fill: { color: CARD_BG }, line: { type: "none" } });
  s.addText([
    { text: "Sectoral employment in HireConnect's target industries (CAPMAS, 2025):", options: { bold: true, breakLine: true, color: CHARCOAL, fontSize: 13 } },
    { text: "Agriculture & fishing: 6.57M   •   Wholesale & retail trade: 5.24M   •   Manufacturing: 4.31M   •   Construction: 3.63M", options: { color: MUTED, fontSize: 13 } },
  ], { x: 0.9, y: 5.0, w: 11.5, h: 1.4, fontFace: FONT, valign: "top", lineSpacingMultiple: 1.4 });

  addFooter(s, "Problem & Market", ++n);
}

// ============ SLIDE 4 — MARKET SIZING ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Market Sizing — Egypt Pilot");
  titleBar(s, "TAM / SAM / SOM");

  const funnel = [
    { label: "TAM", desc: "All seasonal/temporary hiring events across the 5 target sectors", val: "1.0 - 2.0M events/yr", w: 10.5 },
    { label: "SAM", desc: "Digitally reachable subset — internet-connected employers & seekers", val: "650K - 1.4M events/yr", w: 7.8 },
    { label: "SOM", desc: "Realistic Year-1 pilot target, bounded by go-to-market capacity", val: "500-1,500 employer accounts", w: 5.1 },
  ];
  let y = 1.7;
  funnel.forEach((f, i) => {
    const x = 0.6 + (10.5 - f.w) / 2;
    const colors = [TEAL_LIGHT, "CDE7E3", TEAL];
    const txtColor = i === 2 ? WHITE : CHARCOAL;
    s.addShape(pres.shapes.RECTANGLE, { x, y, w: f.w, h: 1.3, fill: { color: colors[i] }, line: { type: "none" }, shadow: shadow() });
    s.addText(f.label, { x: x + 0.3, y: y + 0.1, w: 1.4, h: 1.1, fontSize: 22, bold: true, color: i === 2 ? AMBER : TEAL, fontFace: HEAD_FONT, valign: "middle" });
    s.addText(f.desc, { x: x + 1.8, y: y + 0.1, w: f.w - 4.2, h: 1.1, fontSize: 12, color: txtColor, fontFace: FONT, valign: "middle" });
    s.addText(f.val, { x: x + f.w - 2.5, y: y + 0.1, w: 2.3, h: 1.1, fontSize: 14, bold: true, color: txtColor, fontFace: FONT, valign: "middle", align: "right" });
    y += 1.55;
  });

  s.addText("Pilot cluster proposal: Red Sea/South Sinai tourism corridor + Nile Delta agricultural belt — the two clusters with the clearest seasonal calendars. All figures are bounded estimates pending pilot validation, not cited statistics (CAPMAS does not publish a seasonal-labor breakout).", {
    x: 0.6, y: 6.5, w: 12.1, h: 0.7, fontSize: 11, italic: true, color: MUTED, fontFace: FONT,
  });

  addFooter(s, "Problem & Market", ++n);
}

// ============ SLIDE 5 — DIGITAL REACH ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Digital Reach");
  titleBar(s, "The Same Reason This Works Online...");

  const stats = [
    ["96.3M", "Internet users in Egypt (81.9% penetration)"],
    ["116M", "Mobile connections (~99% of population)"],
    ["51.6M", "Facebook users — the dominant platform"],
  ];
  stats.forEach((st, i) => {
    const x = 0.6 + i * 4.15;
    s.addShape(pres.shapes.RECTANGLE, { x, y: 1.8, w: 3.85, h: 1.9, fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow() });
    s.addText(st[0], { x: x + 0.25, y: 1.95, w: 3.4, h: 0.8, fontSize: 38, bold: true, color: TEAL, fontFace: HEAD_FONT });
    s.addText(st[1], { x: x + 0.25, y: 2.7, w: 3.4, h: 0.9, fontSize: 12.5, color: CHARCOAL, fontFace: FONT });
  });

  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 4.0, w: 12.1, h: 1.9, fill: { color: TEAL_DARK }, line: { type: "none" } });
  s.addText([
    { text: "...is exactly why it's already a solved problem for free.", options: { bold: true, breakLine: true, color: AMBER, fontSize: 16 } },
    { text: "The penetration that makes a mobile app viable is the same penetration that makes Facebook groups and WhatsApp chains the default seasonal-hiring channel today — free, zero onboarding, already liquid on both sides.", options: { color: WHITE, fontSize: 13 } },
  ], { x: 0.95, y: 4.25, w: 11.4, h: 1.5, fontFace: FONT, valign: "top", lineSpacingMultiple: 1.3 });

  addFooter(s, "Problem & Market", ++n);
}

// ============ SLIDE 6 — COMPETITIVE LANDSCAPE ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Competitive Reality");
  titleBar(s, "Our Real Competitor Isn't LinkedIn");

  const rows = [
    [
      { text: "Competitor Type", options: { bold: true, color: WHITE, fill: { color: TEAL } } },
      { text: "Examples", options: { bold: true, color: WHITE, fill: { color: TEAL } } },
      { text: "Why It Currently Wins", options: { bold: true, color: WHITE, fill: { color: TEAL } } },
    ],
    ["Informal social channels", "Facebook groups, WhatsApp chains, foreman networks", "Free, zero onboarding, existing liquidity and social trust"],
    ["Formal job boards", "LinkedIn, Indeed, Wuzzuf", "Built for long-term placement — not what seasonal employers actually use"],
    ["Gig-economy apps", "Uber, Glovo", "Fast & trusted, but locked to one service type — not an open marketplace"],
  ];
  s.addTable(rows, {
    x: 0.6, y: 1.7, w: 12.1, h: 2.6,
    fontFace: FONT, fontSize: 12.5, color: CHARCOAL,
    border: { pt: 0.5, color: "D8E4E2" },
    autoPage: false,
    colW: [3.2, 4.0, 4.9],
    valign: "middle",
  });

  s.addText("The credible pain points HireConnect must solve — or lose to free channels:", {
    x: 0.6, y: 4.55, w: 12, h: 0.35, fontSize: 13, bold: true, color: CHARCOAL, fontFace: FONT,
  });
  const pains = [
    "Discovery cost: scrolling dozens of unstructured, unfiltered posts for current listings",
    "Trust & no-show risk: no verification an applicant is real or will show up",
    "No structured history: neither side can see application status or a searchable profile",
  ];
  pains.forEach((p, i) => {
    s.addShape(pres.shapes.OVAL, { x: 0.6, y: 5.0 + i * 0.55, w: 0.16, h: 0.16, fill: { color: AMBER }, line: { type: "none" } });
    s.addText(p, { x: 0.9, y: 4.88 + i * 0.55, w: 11.6, h: 0.45, fontSize: 12.5, color: CHARCOAL, fontFace: FONT });
  });

  addFooter(s, "Problem & Market", ++n);
}

// ============ SLIDE 7 — PRODUCT OVERVIEW ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Product");
  titleBar(s, "One Platform, Three Layers");

  const cols = [
    { t: "Mobile App", sub: "Job Seekers", pts: ["Personalized job feed", "One-tap apply with cover letter", "Application status tracking", "Push & email notifications", "Favorite jobs & resume builder"] },
    { t: "Web App", sub: "Employers", pts: ["Post & manage job listings", "Review and filter applicants", "Accept / reject with one click", "Interview scheduling", "Job credit balance & purchase"] },
    { t: "Backend Engine", sub: "The Brain", pts: ["RESTful API (Spring Boot)", "JWT-secured, stateless auth", "Matching & ranking logic", "Notifications & payments"] },
  ];
  cols.forEach((c, i) => {
    const x = 0.6 + i * 4.15;
    s.addShape(pres.shapes.RECTANGLE, { x, y: 1.75, w: 3.85, h: 4.9, fill: { color: i === 2 ? TEAL_DARK : CARD_BG }, line: { type: "none" }, shadow: shadow() });
    s.addText(c.t, { x: x + 0.3, y: 2.0, w: 3.3, h: 0.5, fontSize: 19, bold: true, color: i === 2 ? WHITE : TEAL, fontFace: HEAD_FONT });
    s.addText(c.sub.toUpperCase(), { x: x + 0.3, y: 2.5, w: 3.3, h: 0.3, fontSize: 11, bold: true, color: AMBER, fontFace: FONT, charSpacing: 1 });
    s.addText(c.pts.map((p, j) => ({ text: p, options: { bullet: { code: "2022" }, breakLine: j < c.pts.length - 1, color: i === 2 ? WHITE : CHARCOAL } })),
      { x: x + 0.3, y: 3.0, w: 3.35, h: 3.5, fontSize: 12.5, fontFace: FONT, valign: "top", lineSpacingMultiple: 1.35 });
  });

  addFooter(s, "Product", ++n);
}

// ============ SLIDE 8 — SYSTEM ARCHITECTURE ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Architecture");
  titleBar(s, "System Architecture — The Full Picture");

  // Client layer
  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 1.65, w: 12.1, h: 0.7, fill: { color: TEAL_LIGHT }, line: { type: "none" } });
  s.addText("CLIENT LAYER — Employer Web App   |   Jobseeker Mobile App", { x: 0.6, y: 1.65, w: 12.1, h: 0.7, fontSize: 13, bold: true, color: TEAL, fontFace: FONT, align: "center", valign: "middle" });

  s.addShape(pres.shapes.LINE, { x: 6.65, y: 2.35, w: 0, h: 0.4, line: { color: MUTED, width: 1.5, endArrowType: "triangle" } });
  s.addText("HTTPS + JWT", { x: 5.3, y: 2.35, w: 2.7, h: 0.3, fontSize: 9, italic: true, color: MUTED, fontFace: FONT, align: "center" });

  // API layer
  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 2.75, w: 12.1, h: 0.85, fill: { color: TEAL }, line: { type: "none" }, shadow: shadow() });
  s.addText("SPRING BOOT REST API — Controllers → Services → Repositories → JPA/Hibernate", { x: 0.6, y: 2.75, w: 12.1, h: 0.85, fontSize: 13, bold: true, color: WHITE, fontFace: FONT, align: "center", valign: "middle" });

  s.addShape(pres.shapes.LINE, { x: 6.65, y: 3.6, w: 0, h: 0.35, line: { color: MUTED, width: 1.5, endArrowType: "triangle" } });

  // Data / services row
  const boxes = [
    { t: "PostgreSQL", d: "Primary DB" },
    { t: "Redis", d: "Token / cache store" },
    { t: "Firebase FCM", d: "Push notifications" },
    { t: "Stripe API", d: "Payments" },
    { t: "SendGrid", d: "Transactional email" },
  ];
  const bw = 2.28, gap = 0.16;
  const totalW = bw * 5 + gap * 4;
  const startX = (W - totalW) / 2;
  boxes.forEach((b, i) => {
    const x = startX + i * (bw + gap);
    s.addShape(pres.shapes.RECTANGLE, { x, y: 4.0, w: bw, h: 1.05, fill: { color: CARD_BG }, line: { color: "D8E4E2", width: 1 } });
    s.addText(b.t, { x: x + 0.1, y: 4.08, w: bw - 0.2, h: 0.45, fontSize: 13, bold: true, color: CHARCOAL, fontFace: FONT, align: "center" });
    s.addText(b.d, { x: x + 0.1, y: 4.5, w: bw - 0.2, h: 0.45, fontSize: 10, color: MUTED, fontFace: FONT, align: "center" });
  });

  s.addShape(pres.shapes.LINE, { x: 6.65, y: 5.05, w: 0, h: 0.35, line: { color: MUTED, width: 1.5, endArrowType: "triangle" } });

  // CI/CD row
  s.addShape(pres.shapes.RECTANGLE, { x: 3.15, y: 5.4, w: 3.0, h: 0.65, fill: { color: CARD_BG }, line: { color: "D8E4E2", width: 1 } });
  s.addText("GitHub Actions CI/CD", { x: 3.15, y: 5.4, w: 3.0, h: 0.65, fontSize: 11.5, bold: true, color: CHARCOAL, fontFace: FONT, align: "center", valign: "middle" });
  s.addShape(pres.shapes.LINE, { x: 7.15, y: 5.72, w: 3.0, h: 0, line: { color: MUTED, width: 1.5, endArrowType: "triangle" } });
  s.addShape(pres.shapes.RECTANGLE, { x: 7.15, y: 5.4, w: 3.0, h: 0.65, fill: { color: TEAL_DARK }, line: { type: "none" } });
  s.addText("Docker + Heroku", { x: 7.15, y: 5.4, w: 3.0, h: 0.65, fontSize: 11.5, bold: true, color: WHITE, fontFace: FONT, align: "center", valign: "middle" });

  s.addText("Stateless API design — horizontally scalable by adding dynos with zero code changes.", {
    x: 0.6, y: 6.4, w: 12.1, h: 0.4, fontSize: 11, italic: true, color: MUTED, fontFace: FONT, align: "center",
  });

  addFooter(s, "Architecture", ++n);
}

// ============ SLIDE 9 — TECH STACK ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Architecture");
  titleBar(s, "Technology Stack");

  const rows = [
    [{ text: "Layer", options: { bold: true, color: WHITE, fill: { color: TEAL } } }, { text: "Technology", options: { bold: true, color: WHITE, fill: { color: TEAL } } }, { text: "Why We Chose It", options: { bold: true, color: WHITE, fill: { color: TEAL } } }],
    ["Backend Framework", "Spring Boot 3.1 (Java 17)", "Mature, production-grade, strong JPA ecosystem"],
    ["Database", "PostgreSQL", "ACID compliance, native array types for skills/tags"],
    ["Cache / Token Store", "Redis", "O(1) lookup, TTL-based token blacklisting"],
    ["Security", "Spring Security + JJWT 0.12", "Industry-standard stateless JWT auth"],
    ["Push Notifications", "Firebase Admin SDK 9.2", "Cross-platform FCM, reliable delivery"],
    ["Email", "Spring Mail (SendGrid SMTP)", "Transactional email with opt-in control"],
    ["Payments", "Stripe Java SDK 24.22", "PCI-compliant, session-based checkout"],
    ["ORM Mapping", "MapStruct + Lombok", "Zero-boilerplate DTO ↔ Entity mapping"],
    ["DevOps", "Docker + Heroku + GitHub Actions", "Container-first, automated deployment"],
  ];
  s.addTable(rows, {
    x: 0.6, y: 1.7, w: 12.1, h: 5.2,
    fontFace: FONT, fontSize: 12, color: CHARCOAL,
    border: { pt: 0.5, color: "D8E4E2" },
    autoPage: false,
    colW: [3.0, 3.8, 5.3],
    valign: "middle",
    fill: { color: CARD_BG },
  });

  addFooter(s, "Architecture", ++n);
}

// ============ SLIDE 10 — DATABASE DESIGN ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Architecture");
  titleBar(s, "Database Design — Key Decisions");

  const cards = [
    { t: "User ↔ Job (Favorites)", d: "ManyToMany. Neither side owns the other; JPA generates a clean junction table automatically." },
    { t: "User ↔ Job (Applications)", d: "Two ManyToOne relations via a rich Application entity — needed because an application carries its own data (cover letter, status, interview details)." },
    { t: "User ↔ Resume", d: "OneToOne, optional — employers may not need a resume." },
    { t: "Job ↔ JobComment", d: "OneToMany with a self-referencing parentComment field, enabling threaded replies." },
    { t: "Skills / Requirements / Benefits", d: "Native PostgreSQL text[] arrays (Hypersistence Utils) — avoids extra lookup tables, supports the @> contains operator." },
  ];
  let y = 1.75;
  cards.forEach((c, i) => {
    const cw = i < 3 ? 3.95 : 5.925;
    const x = i < 3 ? 0.6 + i * 4.05 : 0.6 + (i - 3) * 6.05;
    const yy = i < 3 ? 1.75 : 4.35;
    s.addShape(pres.shapes.RECTANGLE, { x, y: yy, w: cw, h: 2.4, fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow() });
    s.addText(c.t, { x: x + 0.25, y: yy + 0.2, w: cw - 0.5, h: 0.6, fontSize: 14, bold: true, color: TEAL, fontFace: FONT });
    s.addText(c.d, { x: x + 0.25, y: yy + 0.85, w: cw - 0.5, h: 1.4, fontSize: 11.5, color: CHARCOAL, fontFace: FONT, lineSpacingMultiple: 1.25 });
  });

  addFooter(s, "Architecture", ++n);
}

// ============ SLIDE 11 — API DESIGN ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Backend");
  titleBar(s, "RESTful API — 4 Core Domains");

  const domains = [
    { t: "Users", p: "/api/users", ops: "Register, Login, Edit profile, Get FOI tags" },
    { t: "Jobs", p: "/api/jobs", ops: "Create, Search, Edit, Delete listings" },
    { t: "Resumes", p: "/api/resumes", ops: "Create, Update skills, Delete" },
    { t: "Applications", p: "/api/applications", ops: "Apply, View, Accept/Reject, Withdraw" },
  ];
  domains.forEach((d, i) => {
    const x = 0.6 + i * 3.05;
    s.addShape(pres.shapes.RECTANGLE, { x, y: 1.75, w: 2.85, h: 2.2, fill: { color: TEAL }, line: { type: "none" }, shadow: shadow() });
    s.addText(d.t, { x: x + 0.2, y: 1.9, w: 2.45, h: 0.45, fontSize: 17, bold: true, color: WHITE, fontFace: HEAD_FONT });
    s.addText(d.p, { x: x + 0.2, y: 2.35, w: 2.45, h: 0.3, fontSize: 11, color: AMBER, fontFace: "Courier New" });
    s.addText(d.ops, { x: x + 0.2, y: 2.75, w: 2.45, h: 1.1, fontSize: 10.5, color: WHITE, fontFace: FONT, lineSpacingMultiple: 1.2 });
  });

  s.addText("Design Principles", { x: 0.6, y: 4.25, w: 5, h: 0.4, fontSize: 15, bold: true, color: CHARCOAL, fontFace: FONT });
  const princ = [
    ["DTO Layer", "API-facing objects decoupled from DB entities — prevents password/data leaks"],
    ["Partial Updates", "PATCH requests merge changes server-side, not full replace"],
    ["Array Actions", "Add/Remove patterns for lists prevent data overrides"],
    ["Consistent Errors", "Standardized JSON error shape across all 4xx responses"],
  ];
  princ.forEach((p, i) => {
    const x = 0.6 + (i % 2) * 6.05, y = 4.7 + Math.floor(i / 2) * 1.15;
    s.addShape(pres.shapes.RECTANGLE, { x, y, w: 5.85, h: 1.0, fill: { color: CARD_BG }, line: { type: "none" } });
    s.addText(p[0], { x: x + 0.2, y: y + 0.08, w: 5.45, h: 0.3, fontSize: 12.5, bold: true, color: TEAL, fontFace: FONT });
    s.addText(p[1], { x: x + 0.2, y: y + 0.4, w: 5.45, h: 0.55, fontSize: 10.5, color: CHARCOAL, fontFace: FONT });
  });

  addFooter(s, "Backend", ++n);
}

// ============ SLIDE 12 — SECURITY (JWT) ============
{
  let s = pres.addSlide();
  s.background = { color: TEAL_DARK };
  kicker(s, "Backend", { dark: true });
  titleBar(s, "Security — JWT Authentication Flow", { dark: true });

  const steps = [
    "Client sends credentials via POST /api/users/login",
    "CustomUserDetailsService retrieves matching user from DB",
    "Password verified using BCrypt hashing",
    "JWTService signs a token using the HS256 algorithm",
    "Signed JWT returned to the client",
    "Client attaches JWT to the Authorization header",
    "JwtAuthenticationFilter intercepts and extracts the token",
    "Server validates signature and expiry",
    "CurrentUserService injects the authenticated principal",
    "On logout, token fingerprint is blacklisted in Redis with TTL",
  ];
  const colH = 0.42;
  steps.forEach((st, i) => {
    const col = i < 5 ? 0 : 1;
    const row = i % 5;
    const x = 0.7 + col * 6.1, y = 1.75 + row * colH * 1.9;
    s.addShape(pres.shapes.OVAL, { x, y, w: 0.34, h: 0.34, fill: { color: AMBER }, line: { type: "none" } });
    s.addText(String(i + 1), { x, y, w: 0.34, h: 0.34, fontSize: 12, bold: true, color: TEAL_DARK, fontFace: FONT, align: "center", valign: "middle" });
    s.addText(st, { x: x + 0.5, y: y - 0.06, w: 5.5, h: 0.65, fontSize: 11.5, color: WHITE, fontFace: FONT, valign: "middle" });
  });

  s.addShape(pres.shapes.RECTANGLE, { x: 0.7, y: 6.1, w: 11.9, h: 0.95, fill: { color: TEAL, transparency: 40 }, line: { type: "none" } });
  s.addText("Stateless architecture: no server-side sessions — Redis holds only the logout blacklist. Tokens are signed, not encrypted; no sensitive data lives in the payload.", {
    x: 1.0, y: 6.1, w: 11.3, h: 0.95, fontSize: 11.5, color: WHITE, italic: true, fontFace: FONT, valign: "middle",
  });

  addFooter(s, "Backend", ++n);
}

// ============ SLIDE 13 — MATCHING ENGINE ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Backend");
  titleBar(s, "How the Job Feed Is Ranked");

  const pipe = [
    "Fetch all OPEN jobs from the database",
    "PostgreSQL full-text search scores jobs against resume text",
    "Category boost for jobs matching the user's Fields of Interest",
    "Skill-overlap score: resume skills ∩ job requirements",
    "Filter by job type, work arrangement, and location preferences",
    "Sort by composite score, descending",
  ];
  let y = 1.75;
  pipe.forEach((p, i) => {
    s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y, w: 8.1, h: 0.68, fill: { color: i % 2 === 0 ? CARD_BG : TEAL_LIGHT }, line: { type: "none" } });
    s.addShape(pres.shapes.OVAL, { x: 0.8, y: y + 0.14, w: 0.4, h: 0.4, fill: { color: TEAL }, line: { type: "none" } });
    s.addText(String(i + 1), { x: 0.8, y: y + 0.14, w: 0.4, h: 0.4, fontSize: 13, bold: true, color: WHITE, fontFace: FONT, align: "center", valign: "middle" });
    s.addText(p, { x: 1.4, y, w: 7.15, h: 0.68, fontSize: 12.5, color: CHARCOAL, fontFace: FONT, valign: "middle" });
    y += 0.78;
  });

  s.addShape(pres.shapes.RECTANGLE, { x: 9.0, y: 1.75, w: 3.7, h: 4.7, fill: { color: TEAL_DARK }, line: { type: "none" }, shadow: shadow() });
  s.addText("Signals used", { x: 9.25, y: 1.95, w: 3.2, h: 0.35, fontSize: 14, bold: true, color: AMBER, fontFace: FONT });
  const sig = ["Fields of Interest (category tags)", "Full-text relevance (tsvector/tsquery)", "Skill-overlap percentage", "Job type & work-arrangement fit", "Planned: semantic embeddings (roadmap)"];
  s.addText(sig.map((x, i) => ({ text: x, options: { bullet: { code: "2022" }, breakLine: i < sig.length - 1, color: WHITE } })),
    { x: 9.25, y: 2.4, w: 3.2, h: 3.9, fontSize: 12, fontFace: FONT, lineSpacingMultiple: 1.5, valign: "top" });

  addFooter(s, "Backend", ++n);
}

// ============ SLIDE 14 — WEB APP ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Applications");
  titleBar(s, "Employer Web App");

  const feats = [
    "JWT-secured login and registration",
    "Create rich job postings — type, salary model, work arrangement, benefits, requirements",
    "Edit listings with partial updates — add/remove requirements without a full rewrite",
    "View applicants per job with cover letter and resume",
    "Accept/reject with automatic candidate notification",
    "Interview scheduling — date, time, location",
    "\"My Jobs\" dashboard filtered by status",
    "Job credit indicator — remaining posts before purchase is needed",
  ];
  const colW = 5.85;
  feats.forEach((f, i) => {
    const col = i % 2, row = Math.floor(i / 2);
    const x = 0.6 + col * (colW + 0.4), y = 1.8 + row * 1.15;
    s.addShape(pres.shapes.OVAL, { x, y: y + 0.05, w: 0.14, h: 0.14, fill: { color: AMBER }, line: { type: "none" } });
    s.addText(f, { x: x + 0.3, y: y - 0.12, w: colW - 0.3, h: 0.95, fontSize: 12.5, color: CHARCOAL, fontFace: FONT, valign: "middle" });
  });

  // Placeholder for screenshot
  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 6.15, w: 12.1, h: 0.02, fill: { color: "D8E4E2" }, line: { type: "none" } });

  addFooter(s, "Applications", ++n);
}

// ============ SLIDE 15 — MOBILE APP ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Applications");
  titleBar(s, "Jobseeker Mobile App");

  const feats = [
    "Onboarding with profile photo and personal details",
    "Resume builder — education, experience, certificates, skills, languages",
    "Document upload — camera or photo library",
    "Personalized job feed powered by the matching engine",
    "Search & filter by type, location, salary, arrangement",
    "One-tap apply with optional cover letter",
    "\"My Applications\" tracker with real-time status",
    "Push notifications (Firebase) + email opt-in",
    "Favorite jobs to review later",
  ];
  const colW = 5.85;
  feats.forEach((f, i) => {
    const col = i % 2, row = Math.floor(i / 2);
    const x = 0.6 + col * (colW + 0.4), y = 1.75 + row * 1.02;
    s.addShape(pres.shapes.OVAL, { x, y: y + 0.05, w: 0.14, h: 0.14, fill: { color: TEAL }, line: { type: "none" } });
    s.addText(f, { x: x + 0.3, y: y - 0.12, w: colW - 0.3, h: 0.85, fontSize: 12.5, color: CHARCOAL, fontFace: FONT, valign: "middle" });
  });

  addFooter(s, "Applications", ++n);
}

// ============ SLIDE 16 — MOBILE CLIENT: OTA UPDATES ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Mobile Client");
  titleBar(s, "Self-Contained OTA Update System");

  // Left Column: Update Classifications
  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 1.75, w: 5.85, h: 4.9, fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow() });
  s.addText("Update Flow & Classifications", { x: 0.9, y: 1.95, w: 5.25, h: 0.35, fontSize: 17, bold: true, color: TEAL, fontFace: HEAD_FONT });
  s.addText([
    { text: "• Mandatory Updates: ", options: { bold: true, color: CHARCOAL } },
    { text: "Triggered by major version increments or [MANDATORY] tags in release titles. Disables system back navigation using PopScope wrappers to block outdated transactions.", options: { breakLine: true, color: MUTED } },
    { text: "\n• Optional Updates: ", options: { bold: true, color: CHARCOAL } },
    { text: "Prompted via Modal Bottom Sheet. Users can dismiss it, which caches a timestamp in Secure Storage, suppressing the prompt for exactly 24 hours.", options: { breakLine: true, color: MUTED } },
    { text: "\n• Settings Badge Indicator: ", options: { bold: true, color: CHARCOAL } },
    { text: "An active snooze places a subtle red badge on the settings tab, offering a non-intrusive way to trigger the update.", options: { color: MUTED } }
  ], { x: 0.9, y: 2.45, w: 5.25, h: 3.9, fontSize: 12.5, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" });

  // Right Column: Snooze State Flow Diagram
  s.addShape(pres.shapes.RECTANGLE, { x: 6.85, y: 1.75, w: 5.85, h: 4.9, fill: { color: TEAL_DARK }, line: { type: "none" }, shadow: shadow() });
  s.addText("SNOOZE FLOW STATE MACHINE", { x: 7.15, y: 1.95, w: 5.25, h: 0.35, fontSize: 14, bold: true, color: AMBER, fontFace: FONT, charSpacing: 1 });
  
  // Draw Flow Blocks
  const blocks = [
    "Query GitHub Releases API & Parse SemVer Tags",
    "Read 24-Hour Snooze Timestamp from Secure Storage",
    "Active Snooze? Bypass Sheets  |  Expired? Prompt Update"
  ];
  blocks.forEach((bl, i) => {
    const y = 2.45 + i * 1.5;
    s.addShape(pres.shapes.RECTANGLE, { x: 7.45, y, w: 4.65, h: 0.8, fill: { color: TEAL }, line: { color: AMBER, width: 1 } });
    s.addText(bl, { x: 7.55, y, w: 4.45, h: 0.8, fontSize: 11.5, bold: true, color: WHITE, fontFace: FONT, align: "center", valign: "middle" });
    if (i < 2) {
      s.addShape(pres.shapes.LINE, { x: 9.775, y: y + 0.8, w: 0, h: 0.7, line: { color: AMBER, width: 1.5, endArrowType: "triangle" } });
    }
  });

  addFooter(s, "Mobile Client", ++n);
}

// ============ SLIDE 17 — MOBILE CLIENT: SECURITY & FEEDBACK ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Mobile Client");
  titleBar(s, "Session Security & In-App Feedback");

  // Left Column: Session Security
  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 1.75, w: 5.85, h: 4.9, fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow() });
  s.addText("Session Integrity & Auth Interceptor", { x: 0.9, y: 1.95, w: 5.25, h: 0.35, fontSize: 17, bold: true, color: TEAL, fontFace: HEAD_FONT });
  s.addText([
    { text: "• AuthInterceptor: ", options: { bold: true, color: CHARCOAL } },
    { text: "A global Dio wrapper that automatically appends JWT Bearer headers to requests and catches 401/403 token expirations.", options: { breakLine: true, color: MUTED } },
    { text: "\n• AuthDialogManager: ", options: { bold: true, color: CHARCOAL } },
    { text: "Uses an in-memory semaphore structure to intercept parallel requests, preventing multiple concurrent 'Session Expired' popups.", options: { breakLine: true, color: MUTED } },
    { text: "\n• Cache Reset on Logout: ", options: { bold: true, color: CHARCOAL } },
    { text: "Resets all 13 Riverpod providers to avoid cached data leakage on shared devices (crucial for seasonal workers).", options: { color: MUTED } }
  ], { x: 0.9, y: 2.45, w: 5.25, h: 3.9, fontSize: 12.5, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" });

  // Right Column: Feedback Form
  s.addShape(pres.shapes.RECTANGLE, { x: 6.85, y: 1.75, w: 5.85, h: 4.9, fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow() });
  s.addText("In-App Feedback & Anonymous Submission", { x: 7.15, y: 1.95, w: 5.25, h: 0.35, fontSize: 17, bold: true, color: TEAL, fontFace: HEAD_FONT });
  s.addText([
    { text: "• Privacy Toggle: ", options: { bold: true, color: CHARCOAL } },
    { text: "Allows job seekers to report application/layout bugs anonymously, removing any personal identity markers.", options: { breakLine: true, color: MUTED } },
    { text: "\n• Data Payload Sanitization: ", options: { bold: true, color: CHARCOAL } },
    { text: "If the toggle is active, the notifier excludes userEmail parameters from the JSON request, mapping only body strings.", options: { breakLine: true, color: MUTED } },
    { text: "\n• Riverpod Notifier State: ", options: { bold: true, color: CHARCOAL } },
    { text: "Uses AsyncNotifier to wrap submit actions, managing loading states, error toast bars, and validation rules globally.", options: { color: MUTED } }
  ], { x: 7.15, y: 2.45, w: 5.25, h: 3.9, fontSize: 12.5, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" });

  addFooter(s, "Mobile Client", ++n);
}

// ============ SLIDE 18 — MOBILE CLIENT: PERFORMANCE ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Mobile Client");
  titleBar(s, "Performance Benchmarks & Memory Limits");

  // Left Side: Table 1 (CPU Latency)
  const rows1 = [
    [{ text: "Data Scale", options: { bold: true, color: WHITE, fill: { color: TEAL } } }, { text: "CPU Execution Latency", options: { bold: true, color: WHITE, fill: { color: TEAL } } }, { text: "Safety Status", options: { bold: true, color: WHITE, fill: { color: TEAL } } }],
    ["100 Jobs", "~0.15 ms", "Excellent"],
    ["1,000 Jobs", "~1.25 ms", "Excellent"],
    ["10,000 Jobs", "~8.10 ms", "Good"],
    ["100,000 Jobs", "~14.50 ms", "Safe (< 16.6 ms)"],
  ];
  s.addTable(rows1, {
    x: 0.6, y: 1.75, w: 5.85, h: 3.0,
    fontFace: FONT, fontSize: 11, color: CHARCOAL,
    border: { pt: 0.5, color: "D8E4E2" }, autoPage: false, colW: [1.85, 2.15, 1.85], valign: "middle",
  });

  // Right Side: Table 2 (Memory Heap Projections)
  const rows2 = [
    [{ text: "Jobs in Heap", options: { bold: true, color: WHITE, fill: { color: TEAL_DARK } } }, { text: "Est. Memory Usage", options: { bold: true, color: WHITE, fill: { color: TEAL_DARK } } }, { text: "Safety Status", options: { bold: true, color: WHITE, fill: { color: TEAL_DARK } } }],
    ["100 Jobs", "~150 KB", "Negligible"],
    ["1,000 Jobs", "~1.5 MB", "Safe"],
    ["30,000+ Jobs", "~45.0 MB+", "OOM Risk"],
  ];
  s.addTable(rows2, {
    x: 6.85, y: 1.75, w: 5.85, h: 2.3,
    fontFace: FONT, fontSize: 11, color: CHARCOAL,
    border: { pt: 0.5, color: "D8E4E2" }, autoPage: false, colW: [1.85, 2.15, 1.85], valign: "middle",
  });

  // Bottom Justification box
  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 5.15, w: 12.1, h: 1.5, fill: { color: CARD_BG }, line: { type: "none" } });
  s.addText("Engineering Justification: The benchmarks confirm that Riverpod's state updates are highly scalable (calculating 100,000 entries in 14.5ms, well within single-frame budgets). However, widget inflation in the Flutter layout tree creates high RAM footprints. This validates our Hybrid Pagination Strategy, which pauses auto-scrolling at 200 items to avoid out-of-memory errors on low-end hardware.", {
    x: 0.9, y: 5.25, w: 11.5, h: 1.3, fontSize: 12, italic: true, color: CHARCOAL, fontFace: FONT, valign: "middle", lineSpacingMultiple: 1.3
  });

  addFooter(s, "Mobile Client", ++n);
}

// ============ SLIDE 19 — MOBILE CLIENT: AGGREGATION & OPTIMISTIC STATE ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Mobile Client");
  titleBar(s, "Parallel Aggregation & Optimistic State");

  // Left Column: Parallel Aggregation
  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 1.75, w: 5.85, h: 4.9, fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow() });
  s.addText("Parallel Query Aggregation", { x: 0.9, y: 1.95, w: 5.25, h: 0.35, fontSize: 17, bold: true, color: TEAL, fontFace: HEAD_FONT });
  s.addText([
    { text: "• High Latency Mitigation: ", options: { bold: true, color: CHARCOAL } },
    { text: "To avoid multiple sequential round-trips when rendering the profile page, the app aggregates endpoints concurrently.", options: { breakLine: true, color: MUTED } },
    { text: "\n• Concurrent Fetching: ", options: { bold: true, color: CHARCOAL } },
    { text: "Uses Future.wait to combine user profile, applied job list, favorite job list, and interest chips into a single unified stream.", options: { breakLine: true, color: MUTED } },
    { text: "\n• Performance Bound: ", options: { bold: true, color: CHARCOAL } },
    { text: "Time-to-Interactive (TTI) is limited only by the slowest single endpoint, rather than the sum of all four.", options: { color: MUTED } }
  ], { x: 0.9, y: 2.45, w: 5.25, h: 3.9, fontSize: 12.5, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" });

  // Right Column: Optimistic Updates
  s.addShape(pres.shapes.RECTANGLE, { x: 6.85, y: 1.75, w: 5.85, h: 4.9, fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow() });
  s.addText("Optimistic UI Updates & Rollback", { x: 7.15, y: 1.95, w: 5.25, h: 0.35, fontSize: 17, bold: true, color: TEAL, fontFace: HEAD_FONT });
  s.addText([
    { text: "• Perceived Performance: ", options: { bold: true, color: CHARCOAL } },
    { text: "Action toggles (e.g., toggling a favorite heart icon) occur instantly in the UI state without waiting for network confirmations.", options: { breakLine: true, color: MUTED } },
    { text: "\n• State Rollback Loop: ", options: { bold: true, color: CHARCOAL } },
    { text: "The FavoritesController caches the previousState. If the asynchronous HTTP request fails, the controller catches the error, restores the old state, and alerts the user.", options: { breakLine: true, color: MUTED } },
    { text: "\n• Cache Invalidation: ", options: { bold: true, color: CHARCOAL } },
    { text: "On success, related provider lists are invalidated (favoriteJobsProvider) to pull updated card lists behind the scenes.", options: { color: MUTED } }
  ], { x: 7.15, y: 2.45, w: 5.25, h: 3.9, fontSize: 12.5, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" });

  addFooter(s, "Mobile Client", ++n);
}

// ============ SLIDE 20 — MOBILE CLIENT: MULTI-CURRENCY SUPPORT ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Mobile Client");
  titleBar(s, "User-Selected Multi-Currency Support");

  // Left Column: User-Selected Currency Flow
  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 1.75, w: 5.85, h: 4.9, fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow() });
  s.addText("Dropdown Selection & Backend Sync", { x: 0.9, y: 1.95, w: 5.25, h: 0.35, fontSize: 17, bold: true, color: TEAL, fontFace: HEAD_FONT });
  s.addText([
    { text: "• Currency Dropdown Selection: ", options: { bold: true, color: CHARCOAL } },
    { text: "Users can dynamically select their preferred currency (e.g., USD, EGP, SAR) in the application settings dropdown.", options: { breakLine: true, color: MUTED } },
    { text: "\n• Asynchronous Synchronization: ", options: { bold: true, color: CHARCOAL } },
    { text: "Tapping a currency sends a PATCH request updating the preferred currency key on the user profile endpoint (/api/users/{uid}).", options: { breakLine: true, color: MUTED } },
    { text: "\n• Local Cache Persistence: ", options: { bold: true, color: CHARCOAL } },
    { text: "The selected currency is instantly synchronized with the personalInformationProvider state in Riverpod.", options: { color: MUTED } }
  ], { x: 0.9, y: 2.45, w: 5.25, h: 3.9, fontSize: 12.5, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" });

  // Right Column: Reactive Invalidation & Formatting
  s.addShape(pres.shapes.RECTANGLE, { x: 6.85, y: 1.75, w: 5.85, h: 4.9, fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow() });
  s.addText("Reactive Invalidation & Local Formatting", { x: 7.15, y: 1.95, w: 5.25, h: 0.35, fontSize: 17, bold: true, color: TEAL, fontFace: HEAD_FONT });
  s.addText([
    { text: "• Reactive Feed Invalidation: ", options: { bold: true, color: CHARCOAL } },
    { text: "Instead of a manual screen refresh, PaginatedJobs and RecommendedJobsNotifier watch the currency state and auto-invalidate/reload listings immediately.", options: { breakLine: true, color: MUTED } },
    { text: "\n• Declarative Invalidation Snippet: ", options: { bold: true, color: CHARCOAL } },
    { text: "ref.watch(personalInformationProvider.select((u) => u.value?.currency));", options: { fontFace: "Courier New", fontSize: 10.5, color: RED, breakLine: true } },
    { text: "\n• UI Currency Formatting: ", options: { bold: true, color: CHARCOAL } },
    { text: "Active salary values are dynamically formatted utilizing Dart's intl simpleCurrency helper based on the active currency name code (e.g. $1,200 or EGP 15,000).", options: { color: MUTED } }
  ], { x: 7.15, y: 2.45, w: 5.25, h: 3.9, fontSize: 12.5, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" });

  addFooter(s, "Mobile Client", ++n);
}

// ============ SLIDE 21 — BUSINESS MODEL: WHAT'S ACTUALLY BUILT ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Business Model");
  titleBar(s, "Monetization — What's Actually Implemented");

  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 1.75, w: 12.1, h: 1.2, fill: { color: TEAL }, line: { type: "none" }, shadow: shadow() });
  s.addText([
    { text: "One live revenue stream: job-posting credit packages", options: { bold: true, breakLine: true, color: WHITE, fontSize: 17 } },
    { text: "Employers buy 5 job-posting credits per Stripe purchase. Everything else below is roadmap, not current revenue.", options: { color: "D8F0EC", fontSize: 12.5 } },
  ], { x: 0.9, y: 1.9, w: 11.5, h: 0.95, fontFace: FONT, valign: "top" });

  const flow = ["Employer buys credits", "API starts Stripe session", "Employer completes checkout", "Stripe webhook confirms", "Credits added to account"];
  const fw = 2.28, fg = 0.16;
  const totalW = fw * 5 + fg * 4;
  const sx = (W - totalW) / 2;
  flow.forEach((f, i) => {
    const x = sx + i * (fw + fg);
    s.addShape(pres.shapes.RECTANGLE, { x, y: 3.3, w: fw, h: 1.0, fill: { color: CARD_BG }, line: { type: "none" } });
    s.addText(String(i + 1), { x: x + 0.15, y: 3.4, w: 0.5, h: 0.4, fontSize: 16, bold: true, color: AMBER, fontFace: HEAD_FONT });
    s.addText(f, { x: x + 0.15, y: 3.75, w: fw - 0.3, h: 0.5, fontSize: 10.5, color: CHARCOAL, fontFace: FONT });
    if (i < 4) s.addShape(pres.shapes.LINE, { x: x + fw, y: 3.8, w: fg, h: 0, line: { color: MUTED, width: 1.5, endArrowType: "triangle" } });
  });

  s.addText("Job seekers remain free — deliberately. They're the harder side to acquire; charging them would suppress the liquidity employers are paying for.", {
    x: 0.6, y: 4.7, w: 12.1, h: 0.5, fontSize: 12.5, italic: true, color: CHARCOAL, fontFace: FONT,
  });

  s.addText("Roadmap only — not built, priced, or validated:", { x: 0.6, y: 5.35, w: 6, h: 0.35, fontSize: 13, bold: true, color: MUTED, fontFace: FONT });
  const roadmap = ["Employer subscription plans", "Paid AI applicant-ranking tier", "Premium employer analytics", "Corporate recruitment packages"];
  roadmap.forEach((r, i) => {
    const x = 0.6 + (i % 2) * 6.05, y = 5.75 + Math.floor(i / 2) * 0.5;
    s.addText("†  " + r, { x, y, w: 5.85, h: 0.4, fontSize: 12, color: MUTED, fontFace: FONT });
  });

  addFooter(s, "Business Model", ++n);
}

// ============ SLIDE 17 — VALUE PROPOSITION / BMC ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Business Model");
  titleBar(s, "Value Proposition");

  const cols = [
    { t: "Job Seekers", c: TEAL, pts: ["Faster job discovery than scrolling social feeds", "One-click application with status tracking", "AR/EN bilingual, RTL support", "Push & email status updates"] },
    { t: "Employers", c: AMBER, pts: ["Reduces applicant-screening time via ranking", "Structured, verifiable applicant history — mitigates no-show risk", "Draft/publish job posting workflow"] },
  ];
  cols.forEach((c, i) => {
    const x = 0.6 + i * 6.05;
    s.addShape(pres.shapes.RECTANGLE, { x, y: 1.75, w: 5.85, h: 3.0, fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow() });
    s.addShape(pres.shapes.RECTANGLE, { x, y: 1.75, w: 5.85, h: 0.65, fill: { color: c.c }, line: { type: "none" } });
    s.addText(c.t, { x: x + 0.3, y: 1.75, w: 5.25, h: 0.65, fontSize: 17, bold: true, color: WHITE, fontFace: HEAD_FONT, valign: "middle" });
    s.addText(c.pts.map((p, j) => ({ text: p, options: { bullet: { code: "2022" }, breakLine: j < c.pts.length - 1, color: CHARCOAL } })),
      { x: x + 0.3, y: 2.6, w: 5.25, h: 2.0, fontSize: 12.5, fontFace: FONT, lineSpacingMultiple: 1.4, valign: "top" });
  });

  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 5.0, w: 12.1, h: 1.4, fill: { color: TEAL_DARK }, line: { type: "none" } });
  s.addText([
    { text: "Key partners: ", options: { bold: true, color: AMBER, fontSize: 12.5 } },
    { text: "University career centers, seasonal employer associations, Stripe, Heroku, Firebase, SendGrid.", options: { color: WHITE, fontSize: 12.5, breakLine: true } },
    { text: "Channels: ", options: { bold: true, color: AMBER, fontSize: 12.5 } },
    { text: "Employer web portal, Android/iOS app, university career-center partnerships, direct employer field outreach.", options: { color: WHITE, fontSize: 12.5 } },
  ], { x: 0.9, y: 5.15, w: 11.5, h: 1.1, fontFace: FONT, valign: "top", lineSpacingMultiple: 1.3 });

  addFooter(s, "Business Model", ++n);
}

// ============ SLIDE 18 — UNIT ECONOMICS ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Business Model");
  titleBar(s, "Unit Economics — Pilot-Scale Estimates");

  s.addText("All figures below are estimates for planning purposes, built from published vendor pricing and reasonable assumptions — not actual usage data. None exists pre-launch.", {
    x: 0.6, y: 1.55, w: 12.1, h: 0.5, fontSize: 11.5, italic: true, color: MUTED, fontFace: FONT,
  });

  // Cost table
  const rows = [
    [{ text: "Infrastructure line item", options: { bold: true, color: WHITE, fill: { color: TEAL } } }, { text: "Est. monthly cost (USD)", options: { bold: true, color: WHITE, fill: { color: TEAL } } }],
    ["Heroku web dynos (standard)", "$50 - 100"],
    ["Heroku managed PostgreSQL", "$50 - 90"],
    ["Redis add-on", "$15 - 50"],
    ["Matching-engine compute", "$50 - 70"],
    ["SendGrid (paid tier)", "$20 - 30"],
    ["Firebase Cloud Messaging", "$0 (free tier at pilot scale)"],
    [{ text: "Estimated total", options: { bold: true, fill: { color: CARD_BG } } }, { text: "$185 - 345", options: { bold: true, fill: { color: CARD_BG } } }],
  ];
  s.addTable(rows, {
    x: 0.6, y: 2.2, w: 6.5, h: 4.0,
    fontFace: FONT, fontSize: 11, color: CHARCOAL,
    border: { pt: 0.5, color: "D8E4E2" }, autoPage: false, colW: [4.3, 2.2], valign: "middle",
  });

  s.addShape(pres.shapes.RECTANGLE, { x: 7.4, y: 2.2, w: 5.3, h: 4.0, fill: { color: TEAL_DARK }, line: { type: "none" } });
  s.addText("Break-even logic", { x: 7.65, y: 2.4, w: 4.8, h: 0.4, fontSize: 15, bold: true, color: AMBER, fontFace: FONT });
  s.addText([
    { text: "Proposed price: ", options: { bold: true, color: WHITE, breakLine: true } },
    { text: "EGP 500 / ~$10 per 5-credit package (illustrative — not yet validated against employer willingness-to-pay)", options: { color: "CFE9E5", breakLine: true, fontSize: 11.5 } },
    { text: "\nNet per package after Stripe fees: ", options: { bold: true, color: WHITE, breakLine: true } },
    { text: "~$9.60", options: { color: "CFE9E5", breakLine: true, fontSize: 11.5 } },
    { text: "\nPackages needed to cover the $265/mo midpoint infra estimate:", options: { bold: true, color: WHITE, breakLine: true } },
  ], { x: 7.65, y: 2.9, w: 4.8, h: 2.2, fontSize: 12.5, fontFace: FONT, lineSpacingMultiple: 1.3, valign: "top" });
  s.addText("≈ 28 packages / month", { x: 7.65, y: 5.3, w: 4.8, h: 0.6, fontSize: 24, bold: true, color: AMBER, fontFace: HEAD_FONT });
  s.addText("Achievable only if a meaningful share of the 500-1,500 Year-1 employer accounts convert to paid postings — a go-to-market execution question, not a market-size question.", {
    x: 7.65, y: 5.85, w: 4.8, h: 0.35, fontSize: 10, italic: true, color: "CFE9E5", fontFace: FONT,
  });

  addFooter(s, "Business Model", ++n);
}

// ============ SLIDE 19 — GO TO MARKET ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Business Model");
  titleBar(s, "Go-to-Market — Solving the Cold Start");

  const phases = [
    { t: "1. Employer-first seeding", d: "Field outreach to 50-100 anchor employers in one seasonal cluster before any seeker marketing begins — so the feed isn't empty on day one." },
    { t: "2. Seeker acquisition", d: "University career centers near the pilot cluster, timed 4-6 weeks ahead of the seasonal hiring window." },
    { t: "3. Discount trial pricing", d: "First-credit-package discount for anchor employers to generate the first cohort of applications for the matching engine to learn from." },
    { t: "4. Cluster-by-cluster expansion", d: "Each new cluster restarts employer-first seeding — slower than a broad launch but avoids diluting density." },
  ];
  phases.forEach((p, i) => {
    const x = 0.6 + i * 3.05;
    s.addShape(pres.shapes.RECTANGLE, { x, y: 1.8, w: 2.85, h: 4.0, fill: { color: i % 2 === 0 ? TEAL : TEAL_DARK }, line: { type: "none" }, shadow: shadow() });
    s.addText(p.t, { x: x + 0.2, y: 2.0, w: 2.45, h: 0.9, fontSize: 13.5, bold: true, color: AMBER, fontFace: FONT });
    s.addText(p.d, { x: x + 0.2, y: 2.9, w: 2.45, h: 2.7, fontSize: 10.5, color: WHITE, fontFace: FONT, lineSpacingMultiple: 1.3 });
  });

  s.addText("This sequencing is a proposal, not a validated plan — it needs pressure-testing against real employer-association or career-center relationships before it goes in a final report as tested fact.", {
    x: 0.6, y: 6.1, w: 12.1, h: 0.5, fontSize: 11, italic: true, color: MUTED, fontFace: FONT,
  });

  addFooter(s, "Business Model", ++n);
}

// ============ SLIDE 20 — RISKS ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Business Model");
  titleBar(s, "Risk Analysis");

  const risks = [
    ["Facebook/WhatsApp inertia", "The single largest adoption threat. If the pilot can't show measurably lower discovery cost or no-show risk, paid conversion stalls regardless of product quality."],
    ["Revenue seasonality", "Credit-package revenue clusters around harvest/tourist peaks — cash flow must be modeled as seasonal, not smoothed."],
    ["Two-sided cold start failure", "If either side fails to reach critical mass in the pilot cluster, the matching engine has nothing to learn from."],
    ["Informal/cash economy mismatch", "A portion of seasonal hiring is cash-and-verbal, outside any formal system — not every match converts to a trackable outcome."],
    ["Matching-engine dependency", "If the ranking service becomes unavailable, the platform degrades to an unranked job board — an acceptable but explicit fallback."],
  ];
  let y = 1.75;
  risks.forEach((r, i) => {
    s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y, w: 12.1, h: 0.92, fill: { color: i % 2 === 0 ? CARD_BG : WHITE }, line: { type: "none" } });
    s.addShape(pres.shapes.OVAL, { x: 0.8, y: y + 0.26, w: 0.4, h: 0.4, fill: { color: RED }, line: { type: "none" } });
    s.addText(String(i + 1), { x: 0.8, y: y + 0.26, w: 0.4, h: 0.4, fontSize: 13, bold: true, color: WHITE, fontFace: FONT, align: "center", valign: "middle" });
    s.addText(r[0], { x: 1.4, y: y + 0.08, w: 3.2, h: 0.76, fontSize: 12.5, bold: true, color: CHARCOAL, fontFace: FONT, valign: "middle" });
    s.addText(r[1], { x: 4.7, y: y + 0.08, w: 7.85, h: 0.76, fontSize: 11, color: MUTED, fontFace: FONT, valign: "middle" });
    y += 1.0;
  });

  addFooter(s, "Business Model", ++n);
}

// ============ SLIDE 21 — COMPLETED VS ROADMAP ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Roadmap");
  titleBar(s, "Where We Are & Where We're Going");

  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 1.75, w: 5.85, h: 4.9, fill: { color: TEAL_LIGHT }, line: { type: "none" }, shadow: shadow() });
  s.addText("COMPLETED", { x: 0.9, y: 1.95, w: 5.2, h: 0.35, fontSize: 13, bold: true, color: TEAL, fontFace: FONT, charSpacing: 1 });
  const done = ["Full RESTful backend (Users, Jobs, Resumes, Applications, Comments, Notifications)", "JWT auth with Redis token blacklisting", "Firebase FCM + SendGrid email notifications", "Stripe payment integration + job credit system", "Docker + Heroku deployment, GitHub Actions CI/CD", "Full-text-search + skill-overlap matching", "Employer web app & jobseeker mobile app"];
  s.addText(done.map((d, i) => ({ text: d, options: { bullet: { code: "2022" }, breakLine: i < done.length - 1, color: CHARCOAL } })),
    { x: 0.9, y: 2.35, w: 5.2, h: 4.2, fontSize: 11.5, fontFace: FONT, lineSpacingMultiple: 1.4, valign: "top" });

  s.addShape(pres.shapes.RECTANGLE, { x: 6.85, y: 1.75, w: 5.85, h: 4.9, fill: { color: TEAL_DARK }, line: { type: "none" }, shadow: shadow() });
  s.addText("ROADMAP", { x: 7.15, y: 1.95, w: 5.2, h: 0.35, fontSize: 13, bold: true, color: AMBER, fontFace: FONT, charSpacing: 1 });
  const next = ["Semantic embedding-based matching (NLP vector similarity)", "In-app messaging (employer ↔ jobseeker)", "Rating & review system for both sides", "Admin moderation panel", "Employer subscriptions, premium analytics, corporate packages", "Gulf market expansion + full Arabic localization (strategic vision — contingent on Egypt-pilot validation)"];
  s.addText(next.map((d, i) => ({ text: d, options: { bullet: { code: "2022" }, breakLine: i < next.length - 1, color: WHITE } })),
    { x: 7.15, y: 2.35, w: 5.2, h: 4.2, fontSize: 11.5, fontFace: FONT, lineSpacingMultiple: 1.4, valign: "top" });

  addFooter(s, "Roadmap", ++n);
}

// ============ SLIDE 22 — ACKNOWLEDGEMENTS & DEDICATION ============
{
  let s = pres.addSlide();
  s.background = { color: WHITE };
  kicker(s, "Acknowledgements");
  titleBar(s, "Acknowledgements & Dedication");

  const cols = [
    { t: "To My Parents & Family", c: TEAL, pts: ["For their endless patience and sacrifices", "For their constant encouragement during difficult phases", "For their unwavering support throughout my academic journey"] },
    { t: "To My Supervisor & Faculty", c: AMBER, pts: ["Dr. Hicham Elmongui for his continuous guidance", "For his insightful academic reviews and mentorship", "The Department of Computer Engineering for their core support"] },
  ];
  cols.forEach((c, i) => {
    const x = 0.6 + i * 6.05;
    s.addShape(pres.shapes.RECTANGLE, { x, y: 1.75, w: 5.85, h: 3.2, fill: { color: CARD_BG }, line: { type: "none" }, shadow: shadow() });
    s.addShape(pres.shapes.RECTANGLE, { x, y: 1.75, w: 5.85, h: 0.65, fill: { color: c.c }, line: { type: "none" } });
    s.addText(c.t, { x: x + 0.3, y: 1.75, w: 5.25, h: 0.65, fontSize: 17, bold: true, color: WHITE, fontFace: HEAD_FONT, valign: "middle" });
    s.addText(c.pts.map((p, j) => ({ text: p, options: { bullet: { code: "2022" }, breakLine: j < c.pts.length - 1, color: CHARCOAL } })),
      { x: x + 0.3, y: 2.6, w: 5.25, h: 2.2, fontSize: 12.5, fontFace: FONT, lineSpacingMultiple: 1.4, valign: "top" });
  });

  s.addShape(pres.shapes.RECTANGLE, { x: 0.6, y: 5.2, w: 12.1, h: 1.2, fill: { color: TEAL_DARK }, line: { type: "none" } });
  s.addText("Dedicated with respect and gratitude to those who inspired, guided, and supported this endeavor from inception to defense.", {
    x: 0.9, y: 5.2, w: 11.5, h: 1.2, fontSize: 13, color: WHITE, italic: true, fontFace: FONT, align: "center", valign: "middle"
  });

  addFooter(s, "Closing", ++n);
}

// ============ SLIDE 23 — CLOSING ============
{
  let s = pres.addSlide();
  s.background = { color: TEAL_DARK };
  s.addShape(pres.shapes.OVAL, { x: -2, y: -2.5, w: 6, h: 6, fill: { color: TEAL, transparency: 55 }, line: { type: "none" } });
  s.addShape(pres.shapes.OVAL, { x: 9.5, y: 4, w: 5, h: 5, fill: { color: AMBER, transparency: 82 }, line: { type: "none" } });

  s.addText("Thank You", { x: 0.8, y: 2.5, w: 11.7, h: 1.2, fontSize: 46, bold: true, color: WHITE, fontFace: HEAD_FONT, align: "center" });
  s.addText("A narrower, more credible business model — one implemented revenue stream, an Egypt-only pilot, and monetization headroom that's real but unbuilt.", {
    x: 1.8, y: 3.7, w: 9.7, h: 0.8, fontSize: 14, italic: true, color: "BFE3DE", fontFace: FONT, align: "center",
  });
  s.addText("We're ready for your questions.", { x: 0.8, y: 4.8, w: 11.7, h: 0.5, fontSize: 15, color: AMBER, fontFace: FONT, align: "center", bold: true });

  addFooter(s, "Closing", ++n);
}

pres.writeFile({ fileName: "HireConnect_Presentation.pptx" }).then(() => console.log("done"));
