# Flutter 轉換指南 — N/A

來源已為 Flutter Web，無需「HTML → Flutter」轉換。

若業務端要在 Flutter App 中還原本版型結構，建議參照 `flutter-token-mapping.md` 的 widget 對應表，並注意：

- Placeholder 區（見 `README.md`）需在 Flutter 端塞自有 widget（`Image.asset` / `CachedNetworkImage` 等）
- Marquee 動畫用 `package:marquee` 或 `AnimationController` 自行實作
- Tab Bar 用 `BottomNavigationBar`，未登入 Tab 點擊導 `/login` 由 route guard 處理
