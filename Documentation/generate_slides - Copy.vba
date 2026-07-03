' =========================================================================
' GRADUATION PROJECT DEFENSE PRESENTATION GENERATOR (POWERPOINT VBA MACRO)
' =========================================================================
' This macro automatically builds, styles, and layouts the 12-slide
' graduation defense presentation for the Seasonal Job mobile application.
'
' Compatible with Microsoft 365 (Version 2606) PowerPoint Object Model.
'
' How to run this script:
' 1. Open Microsoft PowerPoint.
' 2. Press Alt + F11 to open the VBA Editor.
' 3. Click Insert -> Module, then copy and paste this entire code.
' 4. Press F5 (or click the Run button) to generate the presentation.
' =========================================================================

Sub GenerateDefenseSlides()
    ' Slide & Core Variables
    Dim pptPres As Presentation
    Dim sld As Slide
    Dim titleShape As Shape
    Dim bodyShape As Shape
    
    ' Layout Shapes
    Dim gBox As Shape
    Dim sBox As Shape
    Dim gPanel As Shape
    Dim sClient As Shape
    Dim sBackend As Shape
    Dim sArrow As Shape
    Dim shp As Shape
    Dim bSplash As Shape
    Dim bVerCheck As Shape
    Dim bBlocker As Shape
    Dim bShell As Shape
    Dim codePanel As Shape
    Dim col1 As Shape
    Dim col2 As Shape
    Dim updatePanel As Shape
    Dim node1 As Shape
    Dim node2 As Shape
    Dim node3 As Shape
    Dim pBox As Shape
    Dim t1 As Shape
    Dim t2 As Shape
    Dim tMatrix As Shape
    Dim timelineBox As Shape
    Dim tVal1 As Shape
    Dim tVal2 As Shape
    Dim tVal3 As Shape
    
    ' Helper Iterators
    Dim colIdx As Integer
    
    ' Theme Color Palette Tokens
    Dim cPrimary As Long
    Dim cSecondary As Long
    Dim cAccent As Long
    Dim cText As Long
    Dim cLightBg As Long
    Dim cWhite As Long
    
    cPrimary = RGB(20, 50, 110)      ' Deep Blue (#14326E)
    cSecondary = RGB(80, 95, 115)    ' Slate Grey (#505F73)
    cAccent = RGB(190, 40, 40)       ' Accent Red (#BE2828)
    cText = RGB(30, 30, 30)          ' Charcoal Text
    cLightBg = RGB(245, 247, 250)    ' Soft Off-White
    cWhite = RGB(255, 255, 255)
    
    Set pptPres = ActivePresentation
    
    ' Set Presentation Aspect Ratio to Widescreen (16:9)
    pptPres.PageSetup.SlideWidth = 960
    pptPres.PageSetup.SlideHeight = 540
    
    ' Clear existing slides to start fresh
    Do While pptPres.Slides.Count > 0
        pptPres.Slides(1).Delete
    Loop
    
    ' =========================================================================
    ' SLIDE 1: Title Slide (Dark Background)
    ' =========================================================================
    Set sld = pptPres.Slides.Add(1, ppLayoutBlank)
    sld.FollowMasterBackground = msoFalse
    sld.Background.Fill.Solid
    sld.Background.Fill.ForeColor.RGB = cPrimary
    
    ' Main Title
    Set titleShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 140, 860, 100)
    With titleShape.TextFrame.TextRange
        .Text = "SEASONAL JOB MATCHING PLATFORM" & vbCrLf & "Mobile Client Application (job_seeker)"
        .Font.Name = "Arial"
        .Font.Size = 36
        .Font.Bold = msoTrue
        .Font.Color.RGB = cWhite
        .ParagraphFormat.Alignment = ppAlignCenter
    End With
    
    ' Subtitle
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 260, 860, 50)
    With bodyShape.TextFrame.TextRange
        .Text = "Graduation Project Defense"
        .Font.Name = "Arial"
        .Font.Size = 22
        .Font.Color.RGB = cSecondary
        .ParagraphFormat.Alignment = ppAlignCenter
    End With
    
    ' Credentials
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 380, 860, 80)
    With bodyShape.TextFrame.TextRange
        .Text = "Candidate: [Your Name]         Supervisor: [Supervisor Name]" & vbCrLf & _
                          "Department of Computer Engineering   |   July 2026"
        .Font.Name = "Arial"
        .Font.Size = 14
        .Font.Color.RGB = cWhite
        .ParagraphFormat.Alignment = ppAlignCenter
    End With
    
    ' =========================================================================
    ' SLIDE 2: The Mobile Seasonal Job Challenge
    ' =========================================================================
    Set sld = pptPres.Slides.Add(2, ppLayoutBlank)
    sld.FollowMasterBackground = msoFalse
    sld.Background.Fill.Solid
    sld.Background.Fill.ForeColor.RGB = cLightBg
    
    ' Title
    Set titleShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 30, 860, 50)
    With titleShape.TextFrame.TextRange
        .Text = "The Mobile Seasonal Job Challenge"
        .Font.Name = "Arial"
        .Font.Size = 28
        .Font.Bold = msoTrue
        .Font.Color.RGB = cPrimary
    End With
    
    ' Left Box (Generic Portal Gaps)
    Set gBox = sld.Shapes.AddShape(msoShapeRoundedRectangle, 50, 110, 410, 360)
    gBox.Fill.Solid
    gBox.Fill.ForeColor.RGB = cWhite
    gBox.Line.ForeColor.RGB = cSecondary
    gBox.Line.Weight = 1
    
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 60, 120, 390, 340)
    With bodyShape.TextFrame.TextRange
        .Text = "Generic Job Portal Gaps:" & vbCrLf & vbCrLf & _
                          "• Heavy JSON Payload Structures: Drastically drains device battery." & vbCrLf & _
                          "• Session Cached Leakages: Exposure risks when logging in on shared mobile devices." & vbCrLf & _
                          "• Standard App Store Approvals: Delays critical updates by 1 to 7 days." & vbCrLf & _
                          "• Unoptimized Rendering: High list sizing causing frames jank."
        .Font.Name = "Arial"
        .Font.Size = 16
        .Font.Color.RGB = cText
        .Paragraphs(1).Font.Bold = msoTrue
        .Paragraphs(1).Font.Color.RGB = cPrimary
        .Paragraphs(1).Font.Size = 18
    End With
    
    ' Right Box (Seasonal Job Constraints)
    Set sBox = sld.Shapes.AddShape(msoShapeRoundedRectangle, 500, 110, 410, 360)
    sBox.Fill.Solid
    sBox.Fill.ForeColor.RGB = cWhite
    sBox.Line.ForeColor.RGB = cAccent
    sBox.Line.Weight = 2
    
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 510, 120, 390, 340)
    With bodyShape.TextFrame.TextRange
        .Text = "Seasonal Job Mobile Constraints:" & vbCrLf & vbCrLf & _
                          "• Erratic Mobile Networks: Demands minimal data transfer sizes." & vbCrLf & _
                          "• Device Sharing Habits: Requires absolute user profile cache isolation." & vbCrLf & _
                          "• Critical Security Updates: Bypasses standard Play Store delivery channels." & vbCrLf & _
                          "• Low-End Device Hardware: Restricts frame rendering tree sizing."
        .Font.Name = "Arial"
        .Font.Size = 16
        .Font.Color.RGB = cText
        .Paragraphs(1).Font.Bold = msoTrue
        .Paragraphs(1).Font.Color.RGB = cAccent
        .Paragraphs(1).Font.Size = 18
    End With
    
    ' =========================================================================
    ' SLIDE 3: Project Scope & Overview
    ' =========================================================================
    Set sld = pptPres.Slides.Add(3, ppLayoutBlank)
    sld.FollowMasterBackground = msoFalse
    sld.Background.Fill.Solid
    sld.Background.Fill.ForeColor.RGB = cLightBg
    
    ' Title
    Set titleShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 30, 860, 50)
    With titleShape.TextFrame.TextRange
        .Text = "Project Scope & System Overview"
        .Font.Name = "Arial"
        .Font.Size = 28
        .Font.Bold = msoTrue
        .Font.Color.RGB = cPrimary
    End With
    
    ' Left Details (Scope Boundaries)
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 110, 410, 360)
    With bodyShape.TextFrame.TextRange
        .Text = "System Boundaries Check:" & vbCrLf & vbCrLf & _
                          "• In-Scope Mobile Features:" & vbCrLf & _
                          "  - Custom session interceptor loops" & vbCrLf & _
                          "  - Dynamic OTA update checks & blockers" & vbCrLf & _
                          "  - Local secure storage state synchronization" & vbCrLf & _
                          "  - In-app feedback anonymization" & vbCrLf & vbCrLf & _
                          "• Out-of-Scope Configurations:" & vbCrLf & _
                          "  - Recruiter panel and opening dashboard management" & vbCrLf & _
                          "  - PostgreSQL backend database schemas"
        .Font.Name = "Arial"
        .Font.Size = 16
        .Font.Color.RGB = cText
        .Paragraphs(1).Font.Bold = msoTrue
        .Paragraphs(1).Font.Color.RGB = cPrimary
        .Paragraphs(1).Font.Size = 18
    End With
    
    ' Right Graphics Panel (System Components Block Diagram)
    Set gPanel = sld.Shapes.AddShape(msoShapeRectangle, 500, 110, 410, 360)
    gPanel.Fill.Solid
    gPanel.Fill.ForeColor.RGB = cWhite
    gPanel.Line.ForeColor.RGB = cSecondary
    gPanel.Line.Weight = 1
    
    ' Mobile Block Shape
    Set sClient = sld.Shapes.AddShape(msoShapeRoundedRectangle, 520, 240, 150, 80)
    sClient.Fill.Solid
    sClient.Fill.ForeColor.RGB = cPrimary
    sClient.TextFrame.TextRange.Text = "Flutter Mobile Client"
    sClient.TextFrame.TextRange.Font.Color.RGB = cWhite
    sClient.TextFrame.TextRange.Font.Size = 14
    sClient.TextFrame.TextRange.Font.Bold = msoTrue
    
    ' Backend Block Shape
    Set sBackend = sld.Shapes.AddShape(msoShapeRoundedRectangle, 730, 240, 150, 80)
    sBackend.Fill.Solid
    sBackend.Fill.ForeColor.RGB = cSecondary
    sBackend.TextFrame.TextRange.Text = "Spring Boot REST API"
    sBackend.TextFrame.TextRange.Font.Color.RGB = cWhite
    sBackend.TextFrame.TextRange.Font.Size = 14
    sBackend.TextFrame.TextRange.Font.Bold = msoTrue
    
    ' Draw Arrow between them
    Set sArrow = sld.Shapes.AddShape(msoShapeLeftRightArrow, 675, 270, 50, 20)
    sArrow.Fill.Solid
    sArrow.Fill.ForeColor.RGB = cText
    sArrow.Line.Visible = msoFalse
    
    ' Add Label
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 520, 130, 360, 40)
    With bodyShape.TextFrame.TextRange
        .Text = "System Topology and Connectors"
        .Font.Name = "Arial"
        .Font.Size = 16
        .Font.Bold = msoTrue
        .Font.Color.RGB = cPrimary
        .ParagraphFormat.Alignment = ppAlignCenter
    End With
    
    ' =========================================================================
    ' SLIDE 4: Architecture Blueprint
    ' =========================================================================
    Set sld = pptPres.Slides.Add(4, ppLayoutBlank)
    sld.FollowMasterBackground = msoFalse
    sld.Background.Fill.Solid
    sld.Background.Fill.ForeColor.RGB = cLightBg
    
    ' Title
    Set titleShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 30, 860, 50)
    With titleShape.TextFrame.TextRange
        .Text = "Internal Architectural Blueprint"
        .Font.Name = "Arial"
        .Font.Size = 28
        .Font.Bold = msoTrue
        .Font.Color.RGB = cPrimary
    End With
    
    ' Draw Stacked Layers
    ' Pres Layer
    Set shp = sld.Shapes.AddShape(msoShapeRoundedRectangle, 100, 110, 760, 80)
    shp.Fill.Solid
    shp.Fill.ForeColor.RGB = RGB(30, 70, 140)
    shp.TextFrame.TextRange.Text = "Presentation Layer (Widgets / View Shells / Riverpod Providers)"
    shp.TextFrame.TextRange.Font.Color.RGB = cWhite
    shp.TextFrame.TextRange.Font.Size = 18
    shp.TextFrame.TextRange.Font.Bold = msoTrue
    
    ' Domain Layer
    Set shp = sld.Shapes.AddShape(msoShapeRoundedRectangle, 100, 210, 760, 80)
    shp.Fill.Solid
    shp.Fill.ForeColor.RGB = RGB(60, 100, 170)
    shp.TextFrame.TextRange.Text = "Domain Layer (Pure UseCases / Business Validations)"
    shp.TextFrame.TextRange.Font.Color.RGB = cWhite
    shp.TextFrame.TextRange.Font.Size = 18
    shp.TextFrame.TextRange.Font.Bold = msoTrue
    
    ' Data Layer
    Set shp = sld.Shapes.AddShape(msoShapeRoundedRectangle, 100, 310, 760, 80)
    shp.Fill.Solid
    shp.Fill.ForeColor.RGB = RGB(90, 130, 200)
    shp.TextFrame.TextRange.Text = "Data Layer (Repositories / Local Secure Storage / API Dio wrappers)"
    shp.TextFrame.TextRange.Font.Color.RGB = cWhite
    shp.TextFrame.TextRange.Font.Size = 18
    shp.TextFrame.TextRange.Font.Bold = msoTrue
    
    ' Details Below Stack
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 100, 410, 760, 80)
    With bodyShape.TextFrame.TextRange
        .Text = "Design Principles Applied: Clean architecture boundaries decouple code concerns. UI components depend purely on abstract use cases, not network API configs."
        .Font.Name = "Arial"
        .Font.Size = 14
        .Font.Italic = msoTrue
        .Font.Color.RGB = cText
        .ParagraphFormat.Alignment = ppAlignCenter
    End With
    
    ' =========================================================================
    ' SLIDE 5: Screen Navigation & Branching Flow
    ' =========================================================================
    Set sld = pptPres.Slides.Add(5, ppLayoutBlank)
    sld.FollowMasterBackground = msoFalse
    sld.Background.Fill.Solid
    sld.Background.Fill.ForeColor.RGB = cLightBg
    
    ' Title
    Set titleShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 30, 860, 50)
    With titleShape.TextFrame.TextRange
        .Text = "Startup Branching Navigation Flow"
        .Font.Name = "Arial"
        .Font.Size = 28
        .Font.Bold = msoTrue
        .Font.Color.RGB = cPrimary
    End With
    
    ' Box 1 (Splash)
    Set bSplash = sld.Shapes.AddShape(msoShapeRoundedRectangle, 380, 110, 200, 60)
    bSplash.Fill.Solid
    bSplash.Fill.ForeColor.RGB = cSecondary
    bSplash.TextFrame.TextRange.Text = "SplashWrapper"
    bSplash.TextFrame.TextRange.Font.Color.RGB = cWhite
    bSplash.TextFrame.TextRange.Font.Bold = msoTrue
    
    ' Box 2 (Version Check)
    Set bVerCheck = sld.Shapes.AddShape(msoShapeDiamond, 380, 200, 200, 100)
    bVerCheck.Fill.Solid
    bVerCheck.Fill.ForeColor.RGB = cPrimary
    bVerCheck.TextFrame.TextRange.Text = "Update check?"
    bVerCheck.TextFrame.TextRange.Font.Color.RGB = cWhite
    bVerCheck.TextFrame.TextRange.Font.Bold = msoTrue
    
    ' Box 3 (Blocker)
    Set bBlocker = sld.Shapes.AddShape(msoShapeRoundedRectangle, 80, 220, 200, 60)
    bBlocker.Fill.Solid
    bBlocker.Fill.ForeColor.RGB = cAccent
    bBlocker.TextFrame.TextRange.Text = "UpdateBlockerScreen"
    bBlocker.TextFrame.TextRange.Font.Color.RGB = cWhite
    bBlocker.TextFrame.TextRange.Font.Bold = msoTrue
    
    ' Box 4 (Normal shell)
    Set bShell = sld.Shapes.AddShape(msoShapeRoundedRectangle, 380, 340, 200, 60)
    bShell.Fill.Solid
    bShell.Fill.ForeColor.RGB = RGB(46, 125, 50) ' Success Green
    bShell.TextFrame.TextRange.Text = "LayoutScreen (Tab Bar)"
    bShell.TextFrame.TextRange.Font.Color.RGB = cWhite
    bShell.TextFrame.TextRange.Font.Bold = msoTrue
    
    ' Draw Connections
    sld.Shapes.AddShape msoShapeDownArrow, 470, 175, 20, 20
    sld.Shapes.AddShape msoShapeLeftArrow, 290, 240, 80, 20
    sld.Shapes.AddShape msoShapeDownArrow, 470, 305, 20, 30
    
    ' Annotations
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 300, 210, 80, 30)
    bodyShape.TextFrame.TextRange.Text = "Mandatory"
    bodyShape.TextFrame.TextRange.Font.Size = 10
    
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 490, 310, 100, 30)
    bodyShape.TextFrame.TextRange.Text = "Optional / None"
    bodyShape.TextFrame.TextRange.Font.Size = 10
    
    ' Details Below Diagram
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 100, 420, 760, 80)
    With bodyShape.TextFrame.TextRange
        .Text = "Design Impact: Checking app integrity prior to loading profile credentials intercepts outdated client instances, locking databases from invalid transaction writes."
        .Font.Name = "Arial"
        .Font.Size = 14
        .Font.Italic = msoTrue
        .Font.Color.RGB = cText
        .ParagraphFormat.Alignment = ppAlignCenter
    End With
    
    ' =========================================================================
    ' SLIDE 6: Session Security
    ' =========================================================================
    Set sld = pptPres.Slides.Add(6, ppLayoutBlank)
    sld.FollowMasterBackground = msoFalse
    sld.Background.Fill.Solid
    sld.Background.Fill.ForeColor.RGB = cLightBg
    
    ' Title
    Set titleShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 30, 860, 50)
    With titleShape.TextFrame.TextRange
        .Text = "Session Security & Interceptor Logic"
        .Font.Name = "Arial"
        .Font.Size = 28
        .Font.Bold = msoTrue
        .Font.Color.RGB = cPrimary
    End With
    
    ' Code panel
    Set codePanel = sld.Shapes.AddShape(msoShapeRectangle, 50, 110, 450, 360)
    codePanel.Fill.Solid
    codePanel.Fill.ForeColor.RGB = RGB(40, 44, 52) ' Dark theme background
    codePanel.Line.ForeColor.RGB = cSecondary
    
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 60, 120, 430, 340)
    With bodyShape.TextFrame.TextRange
        .Text = "onError: (error, handler) async {" & vbCrLf & _
                          "  if (error.statusCode == 401) {" & vbCrLf & _
                          "    if (DialogManager.isHandled) {" & vbCrLf & _
                          "      handler.next(error); return;" & vbCrLf & _
                          "    }" & vbCrLf & _
                          "    DialogManager.markHandled();" & vbCrLf & _
                          "    await storage.clearToken();" & vbCrLf & _
                          "    ref.read(authProvider.notifier)" & vbCrLf & _
                          "       .logout(sessionExpired: true);" & vbCrLf & _
                          "  }" & vbCrLf & _
                          "  handler.next(error);" & vbCrLf & _
                          "}"
        .Font.Name = "Courier New"
        .Font.Size = 12
        .Font.Color.RGB = RGB(171, 178, 191) ' Syntax light grey
    End With
    
    ' Bullet details Right
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 520, 110, 390, 360)
    With bodyShape.TextFrame.TextRange
        .Text = "Token Lifecycle & Data Protection:" & vbCrLf & vbCrLf & _
                          "• Secure Storage Engine: JWT tokens are cached using device-level hardware encryption (Secure Storage)." & vbCrLf & vbCrLf & _
                          "• Duplicate Dialog Prevention: Dialog manager semaphore handles parallel connection errors, preventing multiple popup overlays." & vbCrLf & vbCrLf & _
                          "• Provider Reset on Logout: Invalidates 13 separate Riverpod data modules to prevent cached session leaks between different applicants."
        .Font.Name = "Arial"
        .Font.Size = 16
        .Font.Color.RGB = cText
        .Paragraphs(1).Font.Bold = msoTrue
        .Paragraphs(1).Font.Color.RGB = cPrimary
        .Paragraphs(1).Font.Size = 18
    End With
    
    ' =========================================================================
    ' SLIDE 7: Performance Optimizations
    ' =========================================================================
    Set sld = pptPres.Slides.Add(7, ppLayoutBlank)
    sld.FollowMasterBackground = msoFalse
    sld.Background.Fill.Solid
    sld.Background.Fill.ForeColor.RGB = cLightBg
    
    ' Title
    Set titleShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 30, 860, 50)
    With titleShape.TextFrame.TextRange
        .Text = "Dual Performance Optimization Strategies"
        .Font.Name = "Arial"
        .Font.Size = 28
        .Font.Bold = msoTrue
        .Font.Color.RGB = cPrimary
    End With
    
    ' Column 1: Pagination
    Set col1 = sld.Shapes.AddShape(msoShapeRoundedRectangle, 50, 110, 410, 360)
    col1.Fill.Solid
    col1.Fill.ForeColor.RGB = cWhite
    col1.Line.ForeColor.RGB = cSecondary
    
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 60, 120, 390, 340)
    With bodyShape.TextFrame.TextRange
        .Text = "Hybrid Scroll Pagination:" & vbCrLf & vbCrLf & _
                          "• Auto-Scroll Limit (Pages 1-4): Automatically loads the next page up to 200 total items." & vbCrLf & vbCrLf & _
                          "• Manual Page Pause: Infinite scrolling halts at 200 items, rendering a manual 'Load More' button." & vbCrLf & vbCrLf & _
                          "• Resource Justification: Prevents low-end device CPU frame dropouts by containing layout widget tree sizes."
        .Font.Name = "Arial"
        .Font.Size = 16
        .Font.Color.RGB = cText
        .Paragraphs(1).Font.Bold = msoTrue
        .Paragraphs(1).Font.Color.RGB = cPrimary
        .Paragraphs(1).Font.Size = 18
    End With
    
    ' Column 2: Parallel Fetching
    Set col2 = sld.Shapes.AddShape(msoShapeRoundedRectangle, 500, 110, 410, 360)
    col2.Fill.Solid
    col2.Fill.ForeColor.RGB = cWhite
    col2.Line.ForeColor.RGB = cSecondary
    
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 510, 120, 390, 340)
    With bodyShape.TextFrame.TextRange
        .Text = "Parallel Request Aggregation:" & vbCrLf & vbCrLf & _
                          "• Synchronous Bottleneck: Traditional pages make 4 sequential requests, multiplying network latencies." & vbCrLf & vbCrLf & _
                          "• Concurrent Aggregator: The notifier initiates asynchronous tasks concurrently using Future.wait." & vbCrLf & vbCrLf & _
                          "• Latency Improvement: Consolidates profile loading time to match only the speed of the single slowest service endpoint."
        .Font.Name = "Arial"
        .Font.Size = 16
        .Font.Color.RGB = cText
        .Paragraphs(1).Font.Bold = msoTrue
        .Paragraphs(1).Font.Color.RGB = cPrimary
        .Paragraphs(1).Font.Size = 18
    End With
    
    ' =========================================================================
    ' SLIDE 8: GitHub Releases OTA Update System
    ' =========================================================================
    Set sld = pptPres.Slides.Add(8, ppLayoutBlank)
    sld.FollowMasterBackground = msoFalse
    sld.Background.Fill.Solid
    sld.Background.Fill.ForeColor.RGB = cLightBg
    
    ' Title
    Set titleShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 30, 860, 50)
    With titleShape.TextFrame.TextRange
        .Text = "GitHub Releases OTA Update System"
        .Font.Name = "Arial"
        .Font.Size = 28
        .Font.Bold = msoTrue
        .Font.Color.RGB = cPrimary
    End With
    
    ' Left box: Update Classifications
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 110, 410, 360)
    With bodyShape.TextFrame.TextRange
        .Text = "Update Flow & Classifications:" & vbCrLf & vbCrLf & _
                          "• Mandatory Updates:" & vbCrLf & _
                          "  - Triggered by major version increments or [MANDATORY] tags in commits." & vbCrLf & _
                          "  - Disables system back navigation using PopScope wrappers." & vbCrLf & vbCrLf & _
                          "• Optional Updates:" & vbCrLf & _
                          "  - Prompted via Modal Bottom Sheet." & vbCrLf & _
                          "  - Dismissal caches timestamp in Secure Storage." & vbCrLf & _
                          "  - Snoozes alert prompts for exactly 24 hours."
        .Font.Name = "Arial"
        .Font.Size = 16
        .Font.Color.RGB = cText
        .Paragraphs(1).Font.Bold = msoTrue
        .Paragraphs(1).Font.Color.RGB = cPrimary
        .Paragraphs(1).Font.Size = 18
    End With
    
    ' Right graphics panel: Snooze logic
    Set updatePanel = sld.Shapes.AddShape(msoShapeRectangle, 500, 110, 410, 360)
    updatePanel.Fill.Solid
    updatePanel.Fill.ForeColor.RGB = cWhite
    updatePanel.Line.ForeColor.RGB = cSecondary
    
    Set node1 = sld.Shapes.AddShape(msoShapeRoundedRectangle, 605, 140, 200, 50)
    node1.Fill.Solid
    node1.Fill.ForeColor.RGB = cSecondary
    node1.TextFrame.TextRange.Text = "Optional Update Found"
    node1.TextFrame.TextRange.Font.Size = 12
    node1.TextFrame.TextRange.Font.Color.RGB = cWhite
    
    Set node2 = sld.Shapes.AddShape(msoShapeDiamond, 605, 230, 200, 80)
    node2.Fill.Solid
    node2.Fill.ForeColor.RGB = cPrimary
    node2.TextFrame.TextRange.Text = "Active Snooze < 24h?"
    node2.TextFrame.TextRange.Font.Size = 10
    node2.TextFrame.TextRange.Font.Color.RGB = cWhite
    
    Set node3 = sld.Shapes.AddShape(msoShapeRoundedRectangle, 605, 360, 200, 50)
    node3.Fill.Solid
    node3.Fill.ForeColor.RGB = cAccent
    node3.TextFrame.TextRange.Text = "Show Modal sheet"
    node3.TextFrame.TextRange.Font.Size = 12
    node3.TextFrame.TextRange.Font.Color.RGB = cWhite
    
    ' Draw Connections
    sld.Shapes.AddShape msoShapeDownArrow, 695, 195, 20, 30
    sld.Shapes.AddShape msoShapeDownArrow, 695, 315, 20, 40
    
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 715, 320, 80, 30)
    bodyShape.TextFrame.TextRange.Text = "No / Expired"
    bodyShape.TextFrame.TextRange.Font.Size = 9
    
    ' =========================================================================
    ' SLIDE 9: Bug Reporting & Anonymous Feedback
    ' =========================================================================
    Set sld = pptPres.Slides.Add(9, ppLayoutBlank)
    sld.FollowMasterBackground = msoFalse
    sld.Background.Fill.Solid
    sld.Background.Fill.ForeColor.RGB = cLightBg
    
    ' Title
    Set titleShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 30, 860, 50)
    With titleShape.TextFrame.TextRange
        .Text = "In-App Bug Reporting & Feedback"
        .Font.Name = "Arial"
        .Font.Size = 28
        .Font.Bold = msoTrue
        .Font.Color.RGB = cPrimary
    End With
    
    ' Left box: Anonymity Logic
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 110, 410, 360)
    With bodyShape.TextFrame.TextRange
        .Text = "Anonymous Payload Sanitization:" & vbCrLf & vbCrLf & _
                          "• Send Anonymously Switch (Checked):" & vbCrLf & _
                          "  - Filters user properties before network transport." & vbCrLf & _
                          "  - Excludes applicantEmail parameter from POST request." & vbCrLf & vbCrLf & _
                          "• Send Anonymously Switch (Unchecked):" & vbCrLf & _
                          "  - Extracts profile details automatically." & vbCrLf & _
                          "  - Appends user's logged-in email to the payload." & vbCrLf & vbCrLf & _
                          "• State Controller: Riverpod AsyncNotifier tracks execution spinner overlays."
        .Font.Name = "Arial"
        .Font.Size = 16
        .Font.Color.RGB = cText
        .Paragraphs(1).Font.Bold = msoTrue
        .Paragraphs(1).Font.Color.RGB = cPrimary
        .Paragraphs(1).Font.Size = 18
    End With
    
    ' Right Code block: Payload Comparison
    Set pBox = sld.Shapes.AddShape(msoShapeRectangle, 500, 110, 410, 360)
    pBox.Fill.Solid
    pBox.Fill.ForeColor.RGB = RGB(40, 44, 52)
    pBox.Line.ForeColor.RGB = cSecondary
    
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 510, 120, 390, 340)
    With bodyShape.TextFrame.TextRange
        .Text = "// Identified Request Payload" & vbCrLf & _
                          "{" & vbCrLf & _
                          "  ""title"": ""Job filtering error""," & vbCrLf & _
                          "  ""body"": ""Part-Time search returns zero result""," & vbCrLf & _
                          "  ""userEmail"": ""seeker@domain.com""" & vbCrLf & _
                          "}" & vbCrLf & vbCrLf & _
                          "// Anonymous Request Payload" & vbCrLf & _
                          "{" & vbCrLf & _
                          "  ""title"": ""Job filtering error""," & vbCrLf & _
                          "  ""body"": ""Part-Time search returns zero result""" & vbCrLf & _
                          "}"
        .Font.Name = "Courier New"
        .Font.Size = 11
        .Font.Color.RGB = RGB(171, 178, 191)
    End With
    
    ' =========================================================================
    ' SLIDE 10: State Engine Benchmarks
    ' =========================================================================
    Set sld = pptPres.Slides.Add(10, ppLayoutBlank)
    sld.FollowMasterBackground = msoFalse
    sld.Background.Fill.Solid
    sld.Background.Fill.ForeColor.RGB = cLightBg
    
    ' Title
    Set titleShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 30, 860, 50)
    With titleShape.TextFrame.TextRange
        .Text = "Computational Latency & Memory Limits"
        .Font.Name = "Arial"
        .Font.Size = 28
        .Font.Bold = msoTrue
        .Font.Color.RGB = cPrimary
    End With
    
    ' Table 1: CPU Latency
    Set t1 = sld.Shapes.AddTable(5, 3, 50, 110, 410, 300)
    With t1.Table
        .Cell(1, 1).Shape.TextFrame.TextRange.Text = "Data Scale"
        .Cell(1, 2).Shape.TextFrame.TextRange.Text = "CPU Latency"
        .Cell(1, 3).Shape.TextFrame.TextRange.Text = "Safety Rating"
        
        .Cell(2, 1).Shape.TextFrame.TextRange.Text = "100 Jobs"
        .Cell(2, 2).Shape.TextFrame.TextRange.Text = "~0.15 ms"
        .Cell(2, 3).Shape.TextFrame.TextRange.Text = "Excellent"
        
        .Cell(3, 1).Shape.TextFrame.TextRange.Text = "1,000 Jobs"
        .Cell(3, 2).Shape.TextFrame.TextRange.Text = "~1.25 ms"
        .Cell(3, 3).Shape.TextFrame.TextRange.Text = "Excellent"
        
        .Cell(4, 1).Shape.TextFrame.TextRange.Text = "10,000 Jobs"
        .Cell(4, 2).Shape.TextFrame.TextRange.Text = "~8.10 ms"
        .Cell(4, 3).Shape.TextFrame.TextRange.Text = "Good"
        
        .Cell(5, 1).Shape.TextFrame.TextRange.Text = "100,000 Jobs"
        .Cell(5, 2).Shape.TextFrame.TextRange.Text = "~14.50 ms"
        .Cell(5, 3).Shape.TextFrame.TextRange.Text = "Safe (<16.6 ms)"
        
        ' Style header
        For colIdx = 1 To 3
            .Cell(1, colIdx).Shape.Fill.Solid
            .Cell(1, colIdx).Shape.Fill.ForeColor.RGB = cPrimary
            .Cell(1, colIdx).Shape.TextFrame.TextRange.Font.Color.RGB = cWhite
            .Cell(1, colIdx).Shape.TextFrame.TextRange.Font.Bold = msoTrue
        Next colIdx
    End With
    
    ' Table 2: Memory Footprint
    Set t2 = sld.Shapes.AddTable(4, 3, 500, 110, 410, 240)
    With t2.Table
        .Cell(1, 1).Shape.TextFrame.TextRange.Text = "Jobs in Heap"
        .Cell(1, 2).Shape.TextFrame.TextRange.Text = "Est. Memory"
        .Cell(1, 3).Shape.TextFrame.TextRange.Text = "Status"
        
        .Cell(2, 1).Shape.TextFrame.TextRange.Text = "100 Jobs"
        .Cell(2, 2).Shape.TextFrame.TextRange.Text = "~150 KB"
        .Cell(2, 3).Shape.TextFrame.TextRange.Text = "Negligible"
        
        .Cell(3, 1).Shape.TextFrame.TextRange.Text = "1,000 Jobs"
        .Cell(3, 2).Shape.TextFrame.TextRange.Text = "~1.5 MB"
        .Cell(3, 3).Shape.TextFrame.TextRange.Text = "Safe"
        
        .Cell(4, 1).Shape.TextFrame.TextRange.Text = "30,000+ Jobs"
        .Cell(4, 2).Shape.TextFrame.TextRange.Text = "~45.0 MB+"
        .Cell(4, 3).Shape.TextFrame.TextRange.Text = "OOM Risk"
        
        For colIdx = 1 To 3
            .Cell(1, colIdx).Shape.Fill.Solid
            .Cell(1, colIdx).Shape.Fill.ForeColor.RGB = cSecondary
            .Cell(1, colIdx).Shape.TextFrame.TextRange.Font.Color.RGB = cWhite
            .Cell(1, colIdx).Shape.TextFrame.TextRange.Font.Bold = msoTrue
        Next colIdx
    End With
    
    ' Note Below Tables
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 430, 860, 40)
    With bodyShape.TextFrame.TextRange
        .Text = "Benchmark Verification: While our state engine scales efficiently, heap memory constraints prove that filters and pagination are essential to prevent OOM issues on low-end devices."
        .Font.Name = "Arial"
        .Font.Size = 12
        .Font.Italic = msoTrue
        .Font.Color.RGB = cText
        .ParagraphFormat.Alignment = ppAlignCenter
    End With
    
    ' =========================================================================
    ' SLIDE 11: Testing Resilience & Objectives Matrix
    ' =========================================================================
    Set sld = pptPres.Slides.Add(11, ppLayoutBlank)
    sld.FollowMasterBackground = msoFalse
    sld.Background.Fill.Solid
    sld.Background.Fill.ForeColor.RGB = cLightBg
    
    ' Title
    Set titleShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 30, 860, 50)
    With titleShape.TextFrame.TextRange
        .Text = "Testing Strategies & Objectives Matrix"
        .Font.Name = "Arial"
        .Font.Size = 28
        .Font.Bold = msoTrue
        .Font.Color.RGB = cPrimary
    End With
    
    ' Left box: Testing
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 110, 410, 360)
    With bodyShape.TextFrame.TextRange
        .Text = "Multi-Layered Verification:" & vbCrLf & vbCrLf & _
                          "• Programmatic Unit Tests (13 passed):" & vbCrLf & _
                          "  - Asserts version code boundaries." & vbCrLf & _
                          "  - Verifies email parsing during anonymous toggles." & vbCrLf & vbCrLf & _
                          "• Edge-Case Resilience:" & vbCrLf & _
                          "  - Connection timeouts and API rate limit dropouts are verified to bypass update checkers silently." & vbCrLf & _
                          "  - Snooze storage keys trigger modal sheets post-expiration."
        .Font.Name = "Arial"
        .Font.Size = 16
        .Font.Color.RGB = cText
        .Paragraphs(1).Font.Bold = msoTrue
        .Paragraphs(1).Font.Color.RGB = cPrimary
        .Paragraphs(1).Font.Size = 18
    End With
    
    ' Right Table: Objectives Matrix
    Set tMatrix = sld.Shapes.AddTable(6, 3, 500, 110, 410, 300)
    With tMatrix.Table
        .Cell(1, 1).Shape.TextFrame.TextRange.Text = "Objective"
        .Cell(1, 2).Shape.TextFrame.TextRange.Text = "Criteria Met"
        .Cell(1, 3).Shape.TextFrame.TextRange.Text = "Status"
        
        .Cell(2, 1).Shape.TextFrame.TextRange.Text = "OBJ-SEC-1"
        .Cell(2, 2).Shape.TextFrame.TextRange.Text = "Secure Session Isolation"
        .Cell(2, 3).Shape.TextFrame.TextRange.Text = "PASS"
        
        .Cell(3, 1).Shape.TextFrame.TextRange.Text = "OBJ-PERF-1"
        .Cell(3, 2).Shape.TextFrame.TextRange.Text = "TTI <= 150ms on 4G network"
        .Cell(3, 3).Shape.TextFrame.TextRange.Text = "PASS"
        
        .Cell(4, 1).Shape.TextFrame.TextRange.Text = "OBJ-UPD-1"
        .Cell(4, 2).Shape.TextFrame.TextRange.Text = "Self-contained update blocker"
        .Cell(4, 3).Shape.TextFrame.TextRange.Text = "PASS"
        
        .Cell(5, 1).Shape.TextFrame.TextRange.Text = "OBJ-CURR-1"
        .Cell(5, 2).Shape.TextFrame.TextRange.Text = "Reactive localized currencies"
        .Cell(5, 3).Shape.TextFrame.TextRange.Text = "PASS"
        
        .Cell(6, 1).Shape.TextFrame.TextRange.Text = "OBJ-FDBK-1"
        .Cell(6, 2).Shape.TextFrame.TextRange.Text = "Masked email payload POST"
        .Cell(6, 3).Shape.TextFrame.TextRange.Text = "PASS"
        
        For colIdx = 1 To 3
            .Cell(1, colIdx).Shape.Fill.Solid
            .Cell(1, colIdx).Shape.Fill.ForeColor.RGB = cPrimary
            .Cell(1, colIdx).Shape.TextFrame.TextRange.Font.Color.RGB = cWhite
            .Cell(1, colIdx).Shape.TextFrame.TextRange.Font.Bold = msoTrue
        Next colIdx
    End With
    
    ' =========================================================================
    ' SLIDE 12: Future Roadmap & Conclusion
    ' =========================================================================
    Set sld = pptPres.Slides.Add(12, ppLayoutBlank)
    sld.FollowMasterBackground = msoFalse
    sld.Background.Fill.Solid
    sld.Background.Fill.ForeColor.RGB = cLightBg
    
    ' Title
    Set titleShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 30, 860, 50)
    With titleShape.TextFrame.TextRange
        .Text = "Future Roadmap & Conclusion"
        .Font.Name = "Arial"
        .Font.Size = 28
        .Font.Bold = msoTrue
        .Font.Color.RGB = cPrimary
    End With
    
    ' Left box: Summary
    Set bodyShape = sld.Shapes.AddTextbox(msoOrientationHorizontal, 50, 110, 410, 360)
    With bodyShape.TextFrame.TextRange
        .Text = "Key Capstone Contributions:" & vbCrLf & vbCrLf & _
                          "• Decoupled Clean + MVVM Flutter application layer boundaries." & vbCrLf & vbCrLf & _
                          "• Centralized session interceptor loops preventing memory leaks." & vbCrLf & vbCrLf & _
                          "• Resource-optimized pagination and aggregation configurations." & vbCrLf & vbCrLf & _
                          "• Self-contained update check and anonymous feedback systems."
        .Font.Name = "Arial"
        .Font.Size = 16
        .Font.Color.RGB = cText
        .Paragraphs(1).Font.Bold = msoTrue
        .Paragraphs(1).Font.Color.RGB = cPrimary
        .Paragraphs(1).Font.Size = 18
    End With
    
    ' Right box: Roadmap timeline
    Set timelineBox = sld.Shapes.AddShape(msoShapeRectangle, 500, 110, 410, 360)
    timelineBox.Fill.Solid
    timelineBox.Fill.ForeColor.RGB = cWhite
    timelineBox.Line.ForeColor.RGB = cSecondary
    
    Set tVal1 = sld.Shapes.AddShape(msoShapeRoundedRectangle, 520, 140, 370, 60)
    tVal1.Fill.Solid
    tVal1.Fill.ForeColor.RGB = cSecondary
    tVal1.TextFrame.TextRange.Text = "Q3 2026: SQLite/Isar Caching database & offline upload queues."
    tVal1.TextFrame.TextRange.Font.Size = 11
    tVal1.TextFrame.TextRange.Font.Color.RGB = cWhite
    
    Set tVal2 = sld.Shapes.AddShape(msoShapeRoundedRectangle, 520, 240, 370, 60)
    tVal2.Fill.Solid
    tVal2.Fill.ForeColor.RGB = cPrimary
    tVal2.TextFrame.TextRange.Text = "Q4 2026: Mobile recruiter opening screens & job creations."
    tVal2.TextFrame.TextRange.Font.Size = 11
    tVal2.TextFrame.TextRange.Font.Color.RGB = cWhite
    
    Set tVal3 = sld.Shapes.AddShape(msoShapeRoundedRectangle, 520, 340, 370, 60)
    tVal3.Fill.Solid
    tVal3.Fill.ForeColor.RGB = RGB(46, 125, 50)
    tVal3.TextFrame.TextRange.Text = "Q1 2027: ML recommendations matching tags with NLP embeddings."
    tVal3.TextFrame.TextRange.Font.Size = 11
    tVal3.TextFrame.TextRange.Font.Color.RGB = cWhite
    
    ' Draw simple lines
    sld.Shapes.AddShape msoShapeDownArrow, 695, 205, 20, 30
    sld.Shapes.AddShape msoShapeDownArrow, 695, 305, 20, 30
    
    ' Closing
    MsgBox "Presentation Slides Created Successfully!", vbInformation, "VBA Generator"
End Sub


