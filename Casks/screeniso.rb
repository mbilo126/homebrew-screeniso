cask "screeniso" do
  version "0.1.3"
  sha256 "38162c8866b38af8420e109809941b2dea827259412fcf8adb3ccdc325c01799"

  url "https://github.com/mbilo126/screen-iso/releases/download/v#{version}/ScreenISO-#{version}.zip"
  name "ScreenISO"
  desc "Keeps the computer awake and locks the screen with the native lock"
  homepage "https://github.com/mbilo126/screen-iso"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "ScreenISO.app"

  # ScreenISO is signed ad hoc and not notarized: without this step Gatekeeper blocks the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/ScreenISO.app"]
  end

  uninstall quit: "it.yellowtech.screeniso"

  zap trash: [
    "~/Library/Application Support/ScreenISO",
    "~/Library/Logs/ScreenISO",
    "~/Library/Preferences/it.yellowtech.screeniso.plist",
    "~/Library/Screen Savers/ScreenISOSaver.saver",
  ]

  caveats <<~EOS
    The SleepDisabled switch installs a sudoers rule in /etc/sudoers.d/screeniso.
    Remove it from the panel ("Rimuovi regola sudoers") before uninstalling, or run:
      sudo rm /etc/sudoers.d/screeniso
  EOS
end
