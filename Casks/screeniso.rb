cask "screeniso" do
  version "0.1.1"
  sha256 "9dc728eb912dcd4df85e03b172140665f4c8d207444183cb4f6ccf3ef8cc67cc"

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
