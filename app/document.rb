class Document < NSDocument
  def readFromData(data, ofType: typeName, error: error)
    NSApplication.sharedApplication.delegate.text = NSString.alloc.initWithData(data, encoding: NSUTF8StringEncoding)
    true
  end
end
