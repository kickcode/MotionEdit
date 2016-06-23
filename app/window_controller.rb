class WindowController < NSWindowController
  def init
    @window = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @window.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @window.orderFrontRegardless

    @undo_manager = NSUndoManager.alloc.init

    @text = NSTextView.alloc.initWithFrame(@window.contentView.frame)
    @text.delegate = self
    @text.allowsUndo = true
    @window.contentView.addSubview(@text)

    self.initWithWindow(@window)
  end

  def text
    @text.string
  end
  
  def text=(str)
    @text.string = str
    @current_text = str
  end

  def undoManagerForTextView(text_view)
    @undo_manager
  end

  def textDidChange(notification)
    self.set_text(@text.string.clone)
  end

  def set_text(text)
    if @current_text != text
      @undo_manager.registerUndoWithTarget(self, selector: 'set_text:', object: @current_text)
      @undo_manager.setActionName("text change")
      @current_text = text
    end
  end
end
