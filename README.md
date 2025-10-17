# 5xRuby Marp Theme

基於 5xRuby 企業網站設計風格的 Marp 簡報主題。

## 設計特色

- **品牌色彩**：使用 5xRuby 標誌性的紅色 (#D32C25)
- **專業字體**：Barlow Semi Condensed
- **灰階調色盤**：從深灰到淺灰的完整色階
- **現代設計**：簡潔、專業、易讀

## 安裝與使用

### 1. 安裝 Marp CLI

```bash
npm install -g @marp-team/marp-cli
```

### 2. 使用主題

在你的 Markdown 檔案開頭加入：

```yaml
---
marp: true
theme: 5xruby
paginate: true
header: 'Your Header Text'
---
```

### 3. 產生簡報

```bash
# 產生 HTML
marp --theme themes/5xruby.css your-slides.md

# 產生 PDF
marp --theme themes/5xruby.css --pdf your-slides.md

# 產生 PPTX
marp --theme themes/5xruby.css --pptx your-slides.md
```

## 版面類別

### `lead` - 首頁/封面頁

置中顯示，適合標題頁。

```markdown
<!-- _class: lead -->

# 簡報標題
副標題或說明文字
```

### `invert` - 深色版面

深色背景，淺色文字。

```markdown
<!-- _class: invert -->

## 深色版面
內容...
```

### `highlight` - 強調版面

紅色漸層背景，適合重點訊息。

```markdown
<!-- _class: highlight -->

## 重要訊息
內容...
```

### `center` - 垂直置中

內容垂直置中對齊。

```markdown
<!-- _class: center -->

## 置中內容
```

### `columns` - 兩欄版面

左右兩欄排版。

```markdown
<!-- _class: columns -->

## 兩欄標題

### 左欄
內容...

### 右欄
內容...
```

## 顏色變數

主題使用以下 CSS 變數：

```css
--color-primary: #d32c25      /* 5xRuby 紅色 */
--color-gray-850: #272727     /* 深灰 */
--color-gray-500: #8b8b8b     /* 中灰 */
--color-gray-250: #dedede     /* 淺灰 */
--color-gray-150: #efefef     /* 極淺灰 */
```

## 文字格式

- **粗體文字** → 紅色強調
- *斜體文字* → 灰色
- [連結](url) → 紅色底線
- `程式碼` → 灰色背景

## 語法高亮

主題內建完整的語法高亮支援，支援多種程式語言：

````markdown
```ruby
class Developer
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello from #{@name}!"
  end
end
```

```javascript
const greeting = (name) => {
  console.log(`Hello from ${name}!`);
};
```

```python
def greet(name):
    print(f"Hello from {name}!")
```
````

### 語法高亮色彩

- **關鍵字** (def, class, function) → 紅色 (#d32c25)
- **字串** → 綠色 (#50a14f)
- **數字** → 橘色 (#c18401)
- **函式** → 藍色 (#4078f2)
- **類別/型別** → 紫色 (#a626a4)
- **註解** → 灰色斜體 (#8b8b8b)

### 注意事項

Marp 使用 **Shiki/Highlight.js** 進行語法高亮（不是 PrismJS），但本主題已針對常見語法元素設計完整的顏色配置，確保程式碼清晰易讀。

## 範例

查看 `5xruby-demo.md` 以了解完整功能展示。

## 授權

MIT License

## 關於 5xRuby

5xRuby 是台灣專業的 Ruby on Rails 開發團隊。

- 網站：https://5xruby.com
- GitHub：https://github.com/5xRuby
