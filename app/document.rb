class Document < NSDocument
  def readFromData(data, ofType: typeName, error: error)
    @contents = NSString.alloc.initWithData(data, encoding: NSUTF8StringEncoding)
    true
  end

  def makeWindowControllers
    @window_controller = WindowController.alloc.init
    @window_controller.text = @contents if @contents
    self.addWindowController(@window_controller)
  end
end
