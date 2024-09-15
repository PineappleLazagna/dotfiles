(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      frame-title-format '("%b")
      ring-bell-function 'ignore
      use-dialog-box t ; only for mouse events, which I seldom use
      use-file-dialog nil
      enable-package-at-startup nil
      use-short-answers t
      inhibit-splash-screen t
      make-backup-file nil
      straight-use-package-by-default t
      inhibit-startup-screen t
      inhibit-x-resources t
      inhibit-startup-echo-area-message user-login-name
      inhibit-startup-buffer-menu t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
