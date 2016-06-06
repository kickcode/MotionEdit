class Document < NSDocument
  def readFromData(data, ofType: typeName, error: error)
    @contents = NSString.alloc.initWithData(data, encoding: NSUTF8StringEncoding)
    true
  end

  def dataOfType(typeName, error: error)
    @window_controller.text.dataUsingEncoding(NSUTF8StringEncoding)
  end

  def isDocumentEdited
    @window_controller && @window_controller.text != @contents
  end

  def makeWindowControllers
    @window_controller = WindowController.alloc.init
    @window_controller.text = @contents if @contents
    self.addWindowController(@window_controller)
  end
end
