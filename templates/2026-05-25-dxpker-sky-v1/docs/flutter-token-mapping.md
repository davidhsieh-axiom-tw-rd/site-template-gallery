# Flutter Token Mapping — N/A

本版型原站為 **Flutter Web (canvaskit)**，本身就是 Flutter 應用，**不需要** HTML→Flutter widget token 對應流程。

joy 系列因原站為傳統 SPA（React/Vue），復刻成 HTML 後若要回填到 Flutter App，需建立 token mapping；本版型來源已是 Flutter，HTML 復刻只是「視覺結構靜態版」用於 Gallery，業務端要在 Flutter App 還原時可直接參考原站的 widget tree（不在本 repo 範圍）。

## 對應建議

| HTML 元素 | Flutter widget 對應（參考） |
|----------|-------------------------|
| `.app-bar` | `Container` + `Row` |
| `.hero` | `Stack` + `Image.network` |
| `.marquee` | `Marquee` widget（package:marquee） |
| `.login-card` | `Card` + `Row` |
| `.hall-grid` | `GridView.count(crossAxisCount: 2)` |
| `.tab-bar` | `BottomNavigationBar` |
