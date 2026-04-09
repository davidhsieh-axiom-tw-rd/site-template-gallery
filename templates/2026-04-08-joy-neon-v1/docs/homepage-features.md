# 功能說明 — Joy Neon V1

> 首頁各功能區塊的詳細行為說明

## 功能清單

### 1. Header

| 項目 | 說明 |
|------|------|
| Logo | 左上角，139x42，連結到首頁 |
| 搜尋 | 右上角放大鏡 icon，點擊打開搜尋（此版型為展示用，無實際功能） |
| 背景 | 透明，疊在主背景圖上方 |

### 2. 跑馬燈 (Marquee)

| 項目 | 說明 |
|------|------|
| 背景 | 半透明深藍灰，圓角 |
| 喇叭 icon | 左側，橘金色 SVG |
| 文字 | 水平滾動，20 秒一輪 |
| 訊息 badge | 右側數字 "10"，紅色圓角背景 |
| 凍結模式 | 停止滾動，文字靜態顯示 |

### 3. 中獎輪播 (Winner Cards)

| 項目 | 說明 |
|------|------|
| 背景 | banner 圖片 |
| 卡片 | 水平自動滾動，25 秒一輪 |
| 卡片內容 | 遊戲縮圖 + "恭喜 X***XX 中奖 X倍" |
| 循環 | 資料複製 2 份實現無縫循環 |
| 凍結模式 | 停止滾動，只顯示前 3 張 |

### 4. 導航區 (Nav Section)

| 項目 | 說明 |
|------|------|
| 登入按鈕 | 透明背景 + 白色邊框，圓角 |
| 註冊按鈕 | 白色填充 + 深色文字 |
| VIP | 圖標 + 文字垂直排列 |
| 分享赚钱 | 圖標 + 文字垂直排列 |
| 更多 | 圖標 + 文字，點擊打開更多選單 |

### 5. JACKPOT 區

| 項目 | 說明 |
|------|------|
| 背景 | cjc1_style_2_bg.webp，cover 模式 |
| 標題 | JACKPOT 精靈圖（cjc1_style_1_font_sprite.avif） |
| 數字 | 橘金色，monospace 字體，每 3 秒遞增隨機 1-50 |
| 文字效果 | 3 層 text-shadow 發光效果 |
| 凍結模式 | 停止計數，固定顯示 10,702,017 |

### 6. 遊戲 Grid

| 項目 | 說明 |
|------|------|
| 佈局 | 2 列 CSS Grid，gap 12px |
| 热门 | 左側跨 2 行，大圖輪播 + 收藏星 + 圓點指示器 |
| 捕鱼 | 右上，2 張平台圖 |
| 电子 | 右，2 張平台圖 |
| 棋牌 | 左，2 張平台圖 |
| 真人 | 右，2 張平台圖 |
| 体育 | 左，2 張平台圖 |
| 更多 | 右，彩票 + 电竞圖標 |

### 7. Footer

| 項目 | 說明 |
|------|------|
| 三欄連結 | 娱乐城(10) + 游戏(11) + 支持(3) = 24 個連結 |
| 牌照合规 | 18+ 圖示 + 自我禁止連結 |
| 联系我们 | 2 個 Telegram 聯繫方式 |

### 8. 底部 Tab Bar

| Tab | 圖標 | 說明 |
|-----|------|------|
| 首页 | icon_btm_sy / sy1 | 預設 active（藍色） |
| 优惠 | icon_btm_yh / yh1 | — |
| 存款 | apng_icon_btm_cz | 突出 tab bar，52px 大圖，動畫 webp |
| 提现 | icon_btm_tx | — |
| 我的 | icon_btm_wd / wd1 | — |

### 9. 更多選單 (More Overlay)

| 項目 | 說明 |
|------|------|
| 觸發 | 點擊導航區「更多」按鈕 |
| 呈現 | 底部滑出式 overlay，半透明遮罩 |
| 佈局 | 5 列 grid，28 個圖標項目 |
| 關閉 | 點擊 X 按鈕或遮罩區域 |

#### 更多選單項目（共 28 個）

| # | 名稱 | 圖標檔案 |
|---|------|---------|
| 1 | 客服 | icon_dt_1kf.avif |
| 2 | 提现 | icon_dt_1tx.avif |
| 3 | 存款 | icon_dt_1cz.avif |
| 4 | 活动 | icon_dt_1yh.avif |
| 5 | 任务 | icon_dt_1rw.avif |
| 6 | 返水 | icon_dt_1fs.avif |
| 7 | 有奖反馈 | icon_dt_1yjfq.avif |
| 8 | 安全中心 | icon_dt_1aqzx.avif |
| 9 | APP下载 | icon_dt_1app.avif |
| 10 | 个人资料 | icon_dt_1sz.avif |
| 11 | 账户明细 | icon_dt_1zhmx.avif |
| 12 | 投注记录 | icon_dt_1tzjl.avif |
| 13 | 个人报表 | icon_dt_1grbb.avif |
| 14 | 待领取 | icon_dt_1jl.avif |
| 15 | 提现管理 | icon_dt_1txgl.avif |
| 16 | 语言 | icon_dt_1yuyuan.avif |
| 17 | 投注任务 | icon_dt_1jh.avif |
| 18 | 盲盒抽奖 | apng_icon_mhcj.webp |
| 19 | 立即分享 | icon_dt_1ljfx.avif |
| 20 | 最近游戏 | icon_dt_1zj.avif |
| 21 | 收藏游戏 | icon_dt_1sc.avif |
| 22 | 免费试玩 | icon_dt_1sw.avif |
| 23 | 朋友圈 | icon_dt_1fx.avif |
| 24 | 砍一刀 | apng_icon_kyd.webp |
| 25 | 自我禁止 | icon_dt_1zwjz.avif |
| 26 | 幸运转盘 | apng_icon_xyzp_alpha.webp |
| 27 | 领取记录 | icon_dt_1lqjl.avif |
| 28 | 客服代充 | icon_dt_1kfdc.avif |

### 10. 客服浮動按鈕

| 項目 | 說明 |
|------|------|
| 位置 | 右下角，Tab Bar 上方 16px |
| 大小 | 54x54 圓形 |
| 顏色 | 主色藍 #0A69FF |
| 效果 | hover 放大 1.08x，藍色發光陰影 |

## 凍結模式 (?freeze=true)

| 功能 | 正常模式 | 凍結模式 |
|------|---------|---------|
| 跑馬燈 | 水平滾動 | 靜態文字 |
| 中獎輪播 | 自動滾動 | 固定顯示 3 張 |
| Jackpot 計數 | 每 3 秒遞增 | 固定 10,702,017 |
| CSS 動畫 | 正常播放 | animation-play-state: paused |
| CSS 過渡 | 正常 | transition: none |
