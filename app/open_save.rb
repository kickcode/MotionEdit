module OpenSave
  def panel(sender, isValidFilename: filename)
    validate_filename(sender, filename)
  end

  def panel(sender, directoryDidChange: path)
    if is_in_home_dir(path)
      NSSound.soundNamed("Pop").play
    else
      NSSound.soundNamed("Basso").play
    end
  end

  def panelSelectionDidChange(sender)
    if sender.URL
      if validate_filename(sender, sender.URL.absoluteString)
        NSSound.soundNamed("Hero").play
      else
        NSSound.soundNamed("Basso").play
      end
    end
  end

  def validate_filename(panel, filename)
    *path, file = filename.gsub("file://", "").split("/")
    path = path.join("/")
    has_motion_in_name = file.downcase.index("motion")
    if is_in_home_dir(path)
      if has_motion_in_name
        panel.message = ""
      else
        panel.message = "File must have motion in name!"
      end
    else
      panel.message = "File must be within the users home directory!"
    end
    is_in_home_dir(path) && has_motion_in_name
  end

  def is_in_home_dir(path)
    home = NSHomeDirectory()
    (path[0...home.length] == home)
  end
end