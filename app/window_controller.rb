class WindowController < NSWindowController
  def init
    @window = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @window.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @window.orderFrontRegardless

    @text = NSTextView.alloc.initWithFrame(@window.contentView.frame)
    @text.allowsUndo = true
    @window.contentView.addSubview(@text)

    self.initWithWindow(@window)
  end

  def text
    @text.string
  end
  
  def text=(str)
    @text.string = str
  end
end
