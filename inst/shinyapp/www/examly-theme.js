(() => {
  "use strict";

  const themes = new Set(["classic", "academic", "dark"]);
  const cookieKey = "examly-theme=";
  const root = document.documentElement;
  // Desktop launches use different ports on the same host.
  const cookiePath = new URL(".", location.href).pathname;
  const stored = document.cookie
    .split(";")
    .map(cookie => cookie.trim())
    .find(cookie => cookie.startsWith(cookieKey))
    ?.slice(cookieKey.length);
  root.dataset.examlyTheme = themes.has(stored) ? stored : "classic";

  document.addEventListener("DOMContentLoaded", () => {
    const picker = document.getElementById("examly_theme");
    const label = document.getElementById("theme_label");
    picker.value = root.dataset.examlyTheme;

    picker.addEventListener("change", () => {
      if (!themes.has(picker.value)) return;
      root.dataset.examlyTheme = picker.value;
      const secure = location.protocol === "https:" ? "; Secure" : "";
      document.cookie = `${cookieKey}${picker.value}; Path=${cookiePath}; Max-Age=31536000; SameSite=Lax${secure}`;
    });

    Shiny.addCustomMessageHandler("examly-theme-labels", labels => {
      label.textContent = labels.label;
      for (const option of picker.options) {
        option.textContent = labels[option.value];
      }
    });
  });
})();
