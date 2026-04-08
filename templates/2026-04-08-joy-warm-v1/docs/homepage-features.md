# Joy 首頁功能說明 — 暖橘棕色主題

> 來源：https://joy.star-link-rel.cc/（暖色主題 theme=11-1-2）
> 擷取日期：2026-04-08
> 頁面標題：JOY - Warm Theme

---

## 1. 頂部導航列 (Header, 60px)

| 元素 | 說明 |
|------|------|
| 背景圖 | `img_topnav_bg.avif`（山脈森林背景） |
| 漢堡選單 | 左側 `icon_dt_1cd.avif`（37×38px），點擊開啟側邊欄 |
| Logo | `img_dt_logo_mr1.avif`（139×42px） |
| 登录按鈕 | 背景圖 `btn_topnav_dl.avif` |
| 注册按鈕 | 背景圖 `btn_topnav_zc.avif` |

---

## 2. 公告跑馬燈 (Marquee)

- **位置**：Header 下方，39px 高
- **背景**：`rgba(0,0,0,0.3)` 半透明
- **左側 icon**：`icon_dt_pmd.webp`（34×29px）
- **內容**：橫向滾動文字公告
- **右側**：通知 icon `icon_dt_1xx_wd.avif` + 紅色 badge (10)
- **動畫**：20 秒線性無限循環

---

## 3. 中獎輪播 (Winner Cards)

- **位置**：Marquee 下方
- **背景**：`db_dt_zbcd.avif`（710×84 → 顯示 426×50）
- **內容**：水平滾動的中獎記錄卡片
- **每張卡片**：152×68px，bg: `rgba(0,0,0,0.4)`，圓角 20px
  - 左側遊戲圖（37×49px）
  - 遊戲名 + 恭喜 玩家名 + 中獎/贏得 金額
- **動畫**：25 秒線性無限循環

---

## 4. 遊戲分類標籤 (Category Tabs)

- **佈局**：水平可滾動標籤列
- **項目**：热门(active), PG, WG, LG, MG, CQ9, JDB, BBIN, Playtech, PA, PP
- **熱門**前有 fire icon：`icon_dtfl_rm_1.avif`
- **Active 狀態**：color `#FF6F00`（橘色），背景 `btn_dt_zbcd2.avif`
- **非 Active**：背景 `btn_dt_zbcd1.avif`
- **分隔線**：`img_dt_zbcd_line.avif`

---

## 5. 熱門遊戲 Grid (3列)

- **標題**：🔥 热门游戏（16.8px，白色）
- **佈局**：3 欄 grid，每張 126×168px（3:4 比例）
- **圓角**：15.75px
- **間距**：18px gap，左右 padding 18px
- **每張卡片**：
  - 遊戲封面（background-image, cover）
  - 邊框裝飾 `img_yxbk.avif`
  - 右上角收藏 star `btn_sc_off_2.avif`
  - 底部遊戲名（14.4px，白色）
- **遊戲數量**：12 個

---

## 6. 側邊欄選單 (Sidebar / Drawer)

- **觸發**：點擊漢堡選單 icon
- **方向**：從左側滑入
- **寬度**：288px
- **背景**：深棕色漸層 `linear-gradient(180deg, #6B3218, #5A2810)`
- **項目**（每項背景 `btn_sy_zc_pt.avif`）：
  1. 搜索框（border: 1px solid #9C5432）
  2. 电子游戏
  3. 娱乐城
  4. 优惠中心
  5. 简体中文
  6. 支持中心
- **關閉**：點擊 overlay 或關閉按鈕
- **E2E class**：`.more-drawer`

---

## 7. 底部 Tab Bar (89px，固定底部)

| Tab | 圖標 | 功能 |
|-----|------|------|
| 首页 | `icon_btm_sy.avif` | 首頁（選中：橘色高亮） |
| 娱乐城 | `icon_btm_gd.avif` | 娛樂城入口 |
| 登录 | `icon_btm_dl.avif` | 登入 |
| 注册 | `icon_btm_zc.avif` | 註冊 |
| 我的 | `icon_btm_wd.avif` | 個人中心 |

- **背景圖**：`img_db_dt_btm.avif`
- **Active indicator**：`img_btm_xz.avif`
- **Tab 分隔線**：`img_btm_line.avif`

---

## 8. Cookie Banner

- **位置**：底部固定（Tab Bar 上方）
- **內容**：Cookie 使用聲明 + 確認按鈕
- **凍結模式**：隱藏

---

## 9. 客服浮動按鈕

- **位置**：右下角，Tab Bar 上方 16px
- **尺寸**：60×60px
- **圖片**：`2041775917450227713.avif`（自定義客服頭像）
- **凍結模式**：隱藏

---

## 10. 全頁背景

- **圖片**：`img_db_dt_bg.avif`（1080×2340）
- **顯示**：background-size: cover，cover 整個頁面
- **桌面版**：body `#e8e8e8` 灰色背景，H5 容器居中

---

## 11. 視覺風格總結

| 屬性 | 值 |
|------|-----|
| 主色調 | 暖棕色（#783D21）+ 橘色（#FF6F00） |
| 背景 | 山脈森林漸層背景圖 + 棕色底 |
| 佈局 | 移動端優先（max-width 450px） |
| 圓角 | 遊戲卡片 15.75px、中獎卡片 20px |
| 字體 | 系統字體（中文簡體） |
| 圖片格式 | AVIF（主要）+ WebP（部分），均使用原站 CDN |

---

## 12. 互動功能清單

- [x] 公告跑馬燈滾動
- [x] 中獎輪播滾動
- [x] 分類標籤切換
- [x] 底部 Tab Bar 切換
- [x] 側邊欄選單（開/關）
- [x] Cookie Banner 確認關閉
- [x] 凍結模式（?freeze=true 停止動畫 + 隱藏 banner/客服）
- [ ] 遊戲搜索（原站有，此版未實作）
- [ ] 登入/註冊彈窗（原站有，此版未實作）
