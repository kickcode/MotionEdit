class Document < NSDocument
  include OpenSave

  def readFromData(data, ofType: typeName, error: error)
    @contents = NSString.alloc.initWithData(data, encoding: NSUTF8StringEncoding)
    @window_controller.text = @contents if @window_controller
    true
  end

  def dataOfType(typeName, error: error)
    @window_controller.text.dataUsingEncoding(NSUTF8StringEncoding)
  end

  def isDocumentEdited
    @window_controller && @window_controller.text != (@contents || "")
  end

  def makeWindowControllers
    @window_controller = WindowController.alloc.init
    @window_controller.text = @contents if @contents
    self.addWindowController(@window_controller)
  end

  def prepareSavePanel(savePanel)
    @save_panel = savePanel
    @save_panel.delegate = self
    self.reset_panel(@save_panel)

    save_panel_button = NSButton.alloc.initWithFrame([[0, 0], [200, 50]])
    save_panel_button.title = "Suggest a valid filename"
    save_panel_button.target = self
    save_panel_button.action = 'save_panel_button_click:'

    @save_panel.accessoryView = save_panel_button

    !@window_controller.text.empty?
  end

  def save_panel_button_click(sender)
    self.reset_panel(@save_panel)
  end

  def reset_panel(panel)
    panel.setDirectoryURL(NSURL.URLWithString(NSHomeDirectory()))
    panel.nameFieldStringValue = "motion-edit-#{Time.now.to_i}"
  end
end
