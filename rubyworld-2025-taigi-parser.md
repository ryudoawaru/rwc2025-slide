---
marp: true
theme: 5xruby
paginate: true
header: 'RubyWorld Conference 2025'
---

<!-- _class: lead scale-95 -->
<!-- _paginate: false -->

# コードのように台湾語を解析
## Rubyによる白話字ローマ字の3段階解析

**鄧慕凡 (Mu-Fan Teng)**

RubyWorld Conference 2025
Nov. 7, 2025
島根県立産業交流会館「くにびきメッセ」

<!--
Speaker Note:
みなさん、こんにちは。5xRubyのCEO、鄧慕凡と申します。
本日は「コードのように台湾語を解析：Rubyによる白話字ローマ字の3段階解析」というテーマで発表させていただきます。
これから15分間、台湾語の文字解析という一見難しそうな問題を、Rubyを使ってどのように解決したかをお話しします。
-->

---

<!-- _class: center scale-95 -->

# 自己紹介

**鄧慕凡 (Mu-Fan Teng) 
- 日本では竜堂 終と呼ばれています
- 5xRuby CO., LTD 創業者
- 台湾のRuby伝道師
- RubyConf Taiwan Chief Organizer

![bg right:40% fit](images/2024_AVATAR_RYUDOAWARU.jpg)

<!--
Speaker Note:
まず簡単に自己紹介させてください。
私は台湾の5xRubyという会社のCEOで、2011年からRubyコミュニティで活動しています。
毎年RubyConf Taiwanを主催しており、Ruby普及活動を続けています。

そして、今年2025年1月に、島根県松江市とMOUを締結しました！
松江市はRubyの生まれ故郷であり、このご縁に大変感謝しております。
今回のRubyWorld Conferenceでは、Rubyコミュニティのブースも出展しておりますので、
ぜひお立ち寄りください。
-->

---

<!-- _class: scale-75 -->

# RubyCity 縁結びの地との10年の物語

<div style="width: 90%; margin: 1.5em auto;">

<!-- 上半部：卡片與照片 -->
<div style="display: grid; grid-template-columns: 1fr 1fr 1fr 1fr; gap: 0.5em; margin-bottom: 1em;">

  <!-- 2015 事件卡片 -->
  <div style="display: flex; flex-direction: column; align-items: center; justify-content: flex-end;">
    <div style="background: linear-gradient(135deg, #fff 0%, #fafafa 100%); padding: 0.6em; border-radius: 8px; border: 2px solid #CC342D; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
      <div style="color: #CC342D; font-weight: bold; margin-bottom: 0.3em; font-size: 0.8em;">🌸 縁の始まり</div>
      <ul style="font-size: 0.65em; line-height: 1.2; margin: 0; padding-left: 2em; text-align: left;">
        <li>初めてRWCの講者として登壇</li>
        <li>RubyCity Matsueとの出会い</li>
      </ul>
    </div>
    <div style="margin: 1em 0; font-size: 1.1em; font-weight: bold; color: #CC342D;">2015</div>
    <div style="width: 3px; height: 1em; background: #CC342D;"></div>
  </div>

  <!-- 2023 照片 -->
  <div style="display: flex; flex-direction: column; align-items: center; justify-content: flex-end;">
    <img src="images/page3-2.jpg" style="width: 100%; margin-bottom: 1em;">
  </div>

  <!-- 2024 事件卡片 -->
  <div style="display: flex; flex-direction: column; align-items: center; justify-content: flex-end;">
    <div style="background: linear-gradient(135deg, #fff 0%, #fafafa 100%); padding: 0.6em; border-radius: 8px; border: 2px solid #CC342D; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
      <div style="color: #CC342D; font-weight: bold; margin-bottom: 0.3em; font-size: 0.8em;">🤝 縁の深化</div>
      <ul style="font-size: 0.65em; line-height: 1.2; margin: 0; padding-left: 2em; text-align: left;">
        <li>上定昭仁市長の5xRuby訪問</li>
        <li>RubyCityとの絆が深まる</li>
      </ul>
    </div>
    <div style="margin: 1em 0; font-size: 1.1em; font-weight: bold; color: #CC342D;">2024</div>
    <div style="width: 3px; height: 1em; background: #CC342D;"></div>
  </div>

  <!-- 2025 照片 -->
  <div style="display: flex; flex-direction: column; align-items: center; justify-content: flex-end;">
    <img src="images/page3-4.jpg" style="width: 100%; margin-bottom: 1em;">
  </div>

</div>

<!-- 時間軸線 -->
<div style="position: relative; height: 8px; background: #CC342D; border-radius: 4px; margin: 0;">

  <!-- 2015 標記點 -->
  <div style="position: absolute; left: 12.5%; top: 50%; transform: translate(-50%, -50%);">
    <div style="width: 20px; height: 20px; background: #CC342D; border: 4px solid white; border-radius: 50%; box-shadow: 0 0 0 2px #CC342D; position: relative; z-index: 10;"></div>
  </div>

  <!-- 2023 標記點 -->
  <div style="position: absolute; left: 37.5%; top: 50%; transform: translate(-50%, -50%);">
    <div style="width: 20px; height: 20px; background: #CC342D; border: 4px solid white; border-radius: 50%; box-shadow: 0 0 0 2px #CC342D; position: relative; z-index: 10;"></div>
  </div>

  <!-- 2024 標記點 -->
  <div style="position: absolute; left: 62.5%; top: 50%; transform: translate(-50%, -50%);">
    <div style="width: 20px; height: 20px; background: #CC342D; border: 4px solid white; border-radius: 50%; box-shadow: 0 0 0 2px #CC342D; position: relative; z-index: 10;"></div>
  </div>

  <!-- 2025 標記點 -->
  <div style="position: absolute; left: 87.5%; top: 50%; transform: translate(-50%, -50%);">
    <div style="width: 20px; height: 20px; background: #CC342D; border: 4px solid white; border-radius: 50%; box-shadow: 0 0 0 2px #CC342D; position: relative; z-index: 10;"></div>
  </div>

</div>

<!-- 下半部：照片與卡片 -->
<div style="display: grid; grid-template-columns: 1fr 1fr 1fr 1fr; gap: 0.5em; margin-top: 1em;">

  <!-- 2015 照片 -->
  <div style="display: flex; flex-direction: column; align-items: center; justify-content: flex-start;">
    <div style="width: 0px; height: 1em; background: #CC342D; margin-bottom: 1em;"></div>
    <img src="images/page3-1.jpg" style="width: 100%;">
  </div>

  <!-- 2023 事件卡片 -->
  <div style="display: flex; flex-direction: column; align-items: center; justify-content: flex-start;">
    <div style="width: 3px; height: 1em; background: #CC342D;"></div>
    <div style="margin: 1em 0; font-size: 1.1em; font-weight: bold; color: #CC342D;">2023</div>
    <div style="background: linear-gradient(135deg, #fff 0%, #fafafa 100%); padding: 0.6em; border-radius: 8px; border: 2px solid #CC342D; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
      <div style="color: #CC342D; font-weight: bold; margin-bottom: 0.3em; font-size: 0.8em;">💝 縁結びの実現</div>
      <ul style="font-size: 0.65em; line-height: 1.2; margin: 0; padding-left: 2em; text-align: left;">
        <li>RubyCityからの協携提案</li>
        <li>市長と市役所で会談</li>
        <li>再びRWCの壇上へ</li>
      </ul>
    </div>
  </div>

  <!-- 2024 照片 -->
  <div style="display: flex; flex-direction: column; align-items: center; justify-content: flex-start;">
    <div style="width: 0px; height: 1em; background: #CC342D; margin-bottom: 1em;"></div>
    <img src="images/page3-3.jpg" style="width: 100%;">
  </div>

  <!-- 2025 事件卡片 -->
  <div style="display: flex; flex-direction: column; align-items: center; justify-content: flex-start;">
    <div style="width: 3px; height: 1em; background: #CC342D;"></div>
    <div style="margin: 1em 0; font-size: 1.1em; font-weight: bold; color: #CC342D;">2025</div>
    <div style="background: linear-gradient(135deg, #fff 0%, #fafafa 100%); padding: 0.6em; border-radius: 8px; border: 2px solid #CC342D; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
      <div style="color: #CC342D; font-weight: bold; margin-bottom: 0.3em; font-size: 0.8em;">💍 縁結びの証</div>
      <ul style="font-size: 0.65em; line-height: 1.2; margin: 0; padding-left: 2em; text-align: left;">
        <li>RubyConf Taiwan × COSCUP 2025 <BR/>で覚書締結</li>
        <li>RubyCityとの正式な絆</li>
      </ul>
    </div>
  </div>

</div>

</div>

<!--
Speaker Note:
私と松江市の縁についてお話しさせてください。

2015年、私は初めてRubyWorld Conferenceの講者として、この松江市を訪れました。
Ruby誕生の地で講演できたことは、大変光栄でした。
それから8年の時を経て...

2023年、私は再びRWCに登壇する機会をいただきました。
その際、松江市から台湾のRubyコミュニティとの正式な協力関係を提案されました。
上定昭仁市長と直接お話しする機会もあり、具体的な協力の方向性を議論しました。

2024年2月2日、市長が一行を率いて台北の5xRubyを訪問してくださいました。
技術と文化を超えた、深い交流となりました。

そして今年、2025年1月8日、RubyConf TaiwanとCOSCUPの会場で、
正式にMOUを締結しました。
市長もTwitterで、この歴史的な瞬間をシェアしてくださいました。

これは単なるビジネスの提携ではありません。
Rubyを愛する者同士が、10年という時間をかけて築いた、
深い絆の結晶なのです。

だからこそ、今回のRubyWorld Conference 2025で、
この場所で、皆さんの前で発表できることを、
心から光栄に思っています。
-->

---

<!-- _class: center -->

# 5xRubyについて

**「愛する技術で愛される製品を創る」**

- **創業**: 2014年（台北）
- **専門**: Ruby/Railsを中心としたソフトウェア開発
- **実績**: 政府機関・企業向けシステム開発多数

<!--
Speaker Note:
5xRubyは2014年に台北で創業したソフトウェア開発会社です。
私たちのビジョンは「愛する技術で愛される製品を創る」こと。
Rubyを中心とした技術スタックで、政府機関や企業向けの
システム開発を数多く手がけています。
-->

---

<!-- _class: scale-85 -->

# 5xRubyの事業

<div class="two-columns">

<div>

## 1. 委託開発サービス
- ソフトウェア開発・コンサルティング
- プロダクト検証・技術支援
- 柔軟なチーム編成で最適なソリューション提供

</div>

<div>

## 2. SOSI製品
- リモートアクセス管理システム
- セキュアな外部接続環境を提供
- 中小企業向けVDIソリューション

</div>

</div>

<!--
Speaker Note:
私たちは2つの柱で事業を展開しています。

1つ目は委託開発サービスです。クライアントのビジネスゴールを深く理解し、
実践的なソリューションを提供します。柔軟なチーム編成により、
プロジェクトの規模や要件に応じた最適な開発体制を構築します。

2つ目は自社製品のSOSIです。これはセキュアなリモートアクセス管理システムで、
企業の機密情報を守りながら、リモートワークを実現するVDIソリューションです。
ブラウザベースで利用でき、複雑な設定が不要なのが特徴です。
-->

---

<!-- _class: lead -->

# 第一幕：無人入札の物語

**なぜ誰も手を出さなかったのか？**

<!--
Speaker Note:
それでは本題に入ります。まずは、このプロジェクトがどのように始まったのか、
少し面白いエピソードからお話しします。
-->

---

<!-- _class: scale-95 -->

# 台湾政府案件の特殊性

<div class="three-columns">

<div>

<div style="text-align: center;">

![w:200](images/page6-1.jpg)

</div>

### 技術の制約
- Microsoft製品への依存
- .NET/MS-SQL/Windows Server
- Ruby/Railsは落選しがち

</div>

<div>

<div style="text-align: center;">

![w:200](images/page6-2.jpg)

</div>

### プロセスの問題
- RFP（要求仕様書）の不備
- 担当者の専門知識不足
- 実務との乖離

</div>

<div>

<div style="text-align: center;">

![w:200](images/page6-3.jpg)

</div>

### 関係構築コスト
- 技術以上に「関係」が重要
- 本来の開発時間を圧迫

</div>

</div>

<!--
Speaker Note:
まず、台湾政府のIT案件には特殊な構造的課題があります。

1つ目は技術的制約です。政府機関はMicrosoft製品に強く依存しており、
RubyやRailsを使う私たちのような会社は、技術スタックの理由だけで落選することがよくあります。

2つ目は、プロセスの問題です。要求仕様書が不十分だったり、
担当者や評価委員が技術の専門知識を持っていないため、適切な評価が難しい状況があります。

3つ目は、関係構築のコストです。落札には技術力以上に「関係」が重要で、
本来ソフトウェア開発に使うべき時間を、営業活動に費やさなければなりません。

このような環境で、私たちは何度も挑戦を続けてきました。
-->

---

<!-- _class: scale-90 -->

# 8連敗からの学び

<div class="two-columns">

<div>

<div style="text-align: center;">

![w:200](images/page7-1.jpg)

</div>

## 落選の理由（技術以外）
- Microsoft製品前提の仕様
- 既存システムとの「互換性要求」
- 評価基準の不透明さ
- 価格競争ではなく、技術スタックの制約

</div>

<div>

<div style="text-align: center;">

![w:200](images/page7-2.jpg)

</div>

## 9回目：驚きの展開
- **競合：ゼロ**
- 「なぜ誰も入札しないのか？」
- 担当者も困惑：「本当に大丈夫ですか？」
- **一体何が起こったのか？**

</div>

</div>

<!--
Speaker Note:
私たちは8回連続で落札に失敗しました。その理由は価格ではありませんでした。

多くの場合、仕様がMicrosoft製品を前提としていたり、
既存システムとの「互換性」という名目で、実質的に特定の技術スタックに縛られていました。

しかし、9回目の入札で驚くべきことが起こりました。
競合がゼロ。つまり、私たち以外誰も入札しなかったのです。

政府の担当者も困惑して、「本当に大丈夫ですか？受託できますか？」と何度も確認されました。

一体何が起こったのでしょうか？その理由は、落札後に明らかになります。
-->

---

<!-- _class: center highlight -->

# 落札後の真相

**「分詞（文字分割）が煩雑すぎて**
**誰も手を出さない」**

<!--
落札してから、その理由が分かりました。
この案件の核心は「台湾語の分詞処理」。
つまり、台湾語の文章を単語ごとに分割する作業です。

業界の人たちは、これがどれだけ複雑で面倒な作業か知っていたのです。
だから誰も入札しなかった。

でも、私たちはその複雑さを理解していませんでした。
ある意味、無知が勇気だったのかもしれません。

そして、実際に取り組んでみて分かったのは、
これは確かに難しい問題だが、Rubyを使えば解決できる、ということでした。
-->

---

<!-- _class: lead -->

# 第二幕：台羅拼音（POJ）とは？

**日本語との類似性から理解する**

<!--
Speaker Note:
では、何がそんなに難しいのか？
まず台湾語の文字システムについて説明します。
日本語と比較すると理解しやすいと思います。
-->

---

<!-- _class: scale-80 -->

# 日本語と台湾語の文字システム

<div class="columns">

## 日本語
- **漢字** ↔ **ひらがな/カタカナ**
- **一対多の関係**
- 例：
  - 「生」→ せい/しょう/なま/い...
  - 文脈によって読み方が変わる
  - 複数の読み方が許容される

## 台湾語
- **漢字** ↔ **POJ（白話字）**
- **一対一対応が必須**
- 例：
  - 「紲落」→ suà-lo̍h（のみ）
  - 各漢字に対して必ず1つのPOJ
  - 完全な対応が要求される

</div>

<!--
Speaker Note:
日本語では、漢字とひらがな・カタカナは一対多の関係です。
「生」という漢字は、「せい」「しょう」「なま」「いきる」など、
文脈によって様々な読み方があります。

一方、台湾語では、漢字とPOJ（白話字）は一対一対応でなければなりません。
「紲落」という2文字には「suà-lo̍h」という1つの読み方しかありません。

この「完全な一対一対応」を維持することが、今回の課題の本質です。
-->

---

<!-- _class: scale-80 -->

# 実際の分詞アライメント処理例

<div style="background: #f5f5f5; padding: 1.5em; border-radius: 8px; margin: 1em 0;">

**入力データ（拆字前）:**
- 漢字：`紲落來看新竹市明仔載二十六號的天氣`
- 白話字：`suà-lo̍h lâi-khuànn Sin-tik-tshī bîn-á-tsài gī-tsap-lak hō ê thinn-khì`

**期待される出力（分詞アライメント処理後）:**

| 漢字 | 白話字 |
|------|--------|
| 紲落 | suà-lo̍h |
| 來看 | lâi-khuànn |
| 新竹市 | Sin-tik-tshī |
| 明仔載 | bîn-á-tsài |
| 二十六 | gī-tsap-lak |
| 號 | hō |
| 的 | ê |
| 天氣 | thinn-khì |

</div>

<!--
Speaker Note:
実際の例を見てみましょう。

上段は拆字前のデータです。漢字の文章と、それに対応するPOJ（台羅拼音）が
スペース区切りで並んでいます。

下段が期待される出力です。漢字とPOJを単語ごとに分割し、
それぞれが完全に対応するように配列化する必要があります。

「紲落」と「suà-lo̍h」、「來看」と「lâi-khuànn」、
このように各単語が正確に対応しなければなりません。

一見簡単そうですが、これには多くの技術的課題があります。
-->

---

<!-- _class: scale-80 -->

# 課題1: 連字符（ハイフン）の複雑性

<div class="two-columns">

<div>

## 1. 単語内連字符（保持）

**音節を繋ぐハイフンは保持**

<div style="font-size: 1.3em; line-height: 2.2; margin: 1em 0;">

<ruby>紲落<rt>suà-lo̍h</rt></ruby>
<span style="color: #808080; font-size: 0.75em;">（スア・ロッ）</span>

<ruby>來看<rt>lâi-khuànn</rt></ruby>
<span style="color: #808080; font-size: 0.75em;">（ライ・クアン）</span>

<ruby>斷斷仔<rt>tuān-tuān-á</rt></ruby>
<span style="color: #808080; font-size: 0.75em;">（トゥアン・トゥアン・ア）</span>

</div>

**処理:**
```ruby
split(/\s/)  # ハイフンは保持
```

</div>

<div>

## 2. 二重ハイフン（語間停頓）

**日本語の「っ」に類似**

<div style="font-size: 1.3em; line-height: 2.2; margin: 1em 0;">

<ruby>日時斷斷仔<rt>ji̍t--sî tuān-tuān-á</rt></ruby>
<span style="color: #808080; font-size: 0.75em;">（ジッ（っ）スィー トゥアントゥアナー）</span>

</div>

**処理:**
```ruby
# 漢字側で分離
/(\w+)(--)(\w+)/ => '\1 \2\3'
'日時' → '日 時'

# 前置連字符
if rword.match?(/^-/)
  [rword]  # 1トークンとして保持
end
```

</div>

</div>

<!--
Speaker Note:
技術的課題の1つ目は、ハイフンの処理です。
詳しく分析すると、実は2つの大きなカテゴリーに分けられます。

【1. 単語内連字符】
1つ目は、単語内の音節を繋ぐハイフンです。

例えば「紲落」、日本語で「スアロ」と読みます。
POJでは「suà-lo̍h」、スア・ロッという2音節です。

「來看」は「ライクアン」、POJでは「lâi-khuànn」、ライ・クアンです。

「斷斷仔」は「トゥアントゥアナー」、POJでは「tuān-tuān-á」、
トゥアン・トゥアン・アという3音節です。

これらの単語内ハイフンは、基本的に保持します。
なぜなら、最終的な分割は「スペースで行う」からです。
ハイフン自体では分割しません。

【2. 二重ハイフン（語間停頓）】
2つ目は、二重ハイフンの処理です。
これは台湾語特有の韻律マーカーで、日本語の促音「っ」に似ています。

実際の例を見てみましょう。
「日時斷斷仔」という文章があります。
日本語では「ジッスィー トゥアントゥアナー」と読みます。
「ジッ」の後に小さな「っ」が入るイメージです。

POJでは「ji̍t--sî tuān-tuān-á」と書きます。

この「--」が語間停頓のマーカーです。

処理方法を見てみましょう。
まず、KANJI_GSUB_PATTERNSの68行目で、
漢字側の「日時」を「日 時」と分離します。

次に、roman_kanji_arrayメソッドの154-157行目で、
前置連字符を特殊処理します。

もし単語が「-」で始まり、後ろにハイフンがない場合は、
1つのトークンとして保持します。

それ以外の場合は、先頭の「--」を削除し、
内部の「--」を「-」に置き換えてから分割します。

これにより、「ji̍t--sî」が「日」と「時」に正しく対応します。

最も重要なポイントは、
「ハイフンでは分割せず、スペースで分割する」ということです。

前処理でパターンをスペースに変換し、
最後にスペースで分割する。
これがシンプルで効果的なアプローチでした。
-->

---

<!-- _class: scale-70 -->

# 課題2: 60+の特殊記号パターン

<div class="four-columns">

<div>

## 引用符類（8種類）

```ruby
# スマート引用符正規化
/''/ => "'"
例: "it''s" → "it's"

# 引用符前後分離
/(.)('')(.)/ => '\1 \2 \3'
例: "he''said" → "he '' said"

# 行頭・行末処理
/^"/ => '" '
/"$/ => ' "'
```

</div>

<div>

## 括弧類（6種類）

```ruby
# 英数字括弧最適化
/\(\s([a-zA-Z0-9]+)\s\)/ => '(\1)'
例: "( ABC )" → "(ABC)"

# 全角括弧分離
/（([^（]+)/ => ' （ \1'
例: "前（後" → "前 （ 後"

/([^）]+)）/ => '\1 ） '
例: "前）後" → "前 ） 後"
```

</div>

<div>

## 省略記号（6種類）

```ruby
# 3点リーダー正規化
/\s\.\s\.\s\.$/ => ' ...'
例: ". . ." → "..."

# 前後分離
/([^\.])(\.\.\.)/ => '\1 \2'
例: "end..." → "end ..."

# 台湾式省略記号
/(‧‧‧)([^‧])/ => '\1 \2'
例: "‧‧‧後" → "‧‧‧ 後"
```

</div>

<div>

## 長音符・句読点（10種類）

```ruby
# 長音符分離
'─' => ' ─ '
例: "前─後" → "前 ─ 後"

# カンマ・コロン分離
/(.)(,)(.)/ => '\1 \2 \3'
例: "a,b" → "a , b"

/(.)(:)(.)/ => '\1 \2 \3'
例: "時:分" → "時 : 分"
```

</div>

</div>

<!--
Speaker Note:
2つ目の課題は、60以上の特殊記号パターンの処理です。

まず引用符類です。
シングルクォート、ダブルクォート、スマート引用符など、
8種類の引用符パターンを正規化する必要がありました。

次に括弧類です。
半角括弧、全角括弧、それぞれの前後で分離処理が必要です。
特に英数字を含む括弧は、最適化処理を行います。

3つ目は省略記号です。
ピリオド3つの省略記号と、台湾特有の中黒（‧）を使った省略記号、
両方に対応する必要がありました。

最後に長音符や句読点です。
全角・半角の長音符、カンマ、コロンなど、
10種類以上のパターンを処理します。

実際のコードでは、これらのパターンを順番に適用することで、
様々な記号が混在したテキストを正しく処理できるようになりました。
-->

---

<!-- _class: scale-75 -->

# 課題3: 多言語混在処理

<div class="four-columns">

<div>

## 1. 日本語

```ruby
RXP_SPK = /[\p{Han}
  \p{Katakana}
  \p{Hiragana}
  \p{Hangul}]/
```

**例:**
```
"咱台灣的せんぱい"
```

**結果:**
```ruby
kanji: ["咱台灣的",
        "せんぱい"]
roman: ["lán Tâi-uân ê",
        "senpai"]
```

</div>

<div>

## 2. 英語固有名詞

```ruby
SP_MIRRORS = {
  'Siong-ne-oo'
    => 'Chanel'
}
```

**マッピング:**
- ブランド名の特殊処理
- 固有名詞の対応関係

</div>

<div>

## 3. 大文字処理

```ruby
"Sin-tik-tshī"
  # 新竹市
"Tâi-uân"
  # 台灣
"Tâi-pak"
  # 台北
```

**規則:**
- 固有名詞は大文字開始
- 音節は小文字

</div>

<div>

## 4. Unicode結合

```ruby
/([aeiou])([̀́̂̌̄̍])/
  => '\1\2'
```

**6種類の声調:**
- `à` (2声) 低平調
- `á` (3声) 低上声
- `â` (5声) 高下声
- `ǎ` (7声) 中入声
- `ā` (1声) 高平調
- `a̍` (8声) 高促声

</div>

</div>

<!--
Speaker Note:
最後の課題は、多言語混在の処理です。

1つ目は、日本語の片仮名・平仮名です。
台湾語のテキストには、日本語が混在することがよくあります。
例えば「せんぱい」という言葉が台湾語の文章に含まれる場合、
これを正しく識別して処理する必要があります。

正規表現で漢字、片仮名、平仮名、ハングルを識別し、
それぞれを適切に分割します。

2つ目は、英語の固有名詞です。
特にブランド名などは、POJと英語の対応関係を
特殊なマッピングテーブルで管理します。

「Siong-ne-oo」が「Chanel」に対応する、といった具合です。

3つ目は、大文字処理です。
台湾語の地名や固有名詞は、大文字で始まります。
「Sin-tik-tshī」（新竹市）、「Tâi-uân」（台灣）など、
これらを正しく認識する必要があります。

4つ目は、Unicode結合文字の処理です。
台湾語の声調記号は、Unicodeの結合文字で表現されます。
母音の上に、6種類の声調記号が付きます。

これらの結合文字を正規表現でマッチングするのは複雑で、
特に正規化処理が重要でした。

このように、4つの大きな技術的課題を解決することで、
台湾語の複雑な文字処理を実現できました。
-->

---

<!-- _class: lead -->

# 第三幕：初版から定稿版への進化

**40+のパターンルールの発見**

<!--
Speaker Note:
それでは、これらの課題にどのように取り組んだのか、
開発の進化過程をお見せします。
-->

---

<!-- _class: scale-95 -->

# Phase 1: 初版の苦労（PR #30）

```ruby
# ナイーブな実装
def simple_split(text)
  text.split(/[\s-]/)  # 問題：連字符も分割してしまう
end

# 結果
"suà-lo̍h lâi-khuànn"
# => ["suà", "lo̍h", "lâi", "khuànn"]
# ❌ 期待: ["suà-lo̍h", "lâi-khuànn"]
```

**問題点:**
- 単語内のハイフンも削除される
- 声調記号の扱いが不安定
- 数字の連音処理ができない

<!--
Speaker Note:
最初の実装は非常にシンプルでした。
スペースとハイフンで分割するだけの正規表現です。

しかし、これでは単語内のハイフンまで削除されてしまいます。
"suà-lo̍h"という1つの単語が、"suà"と"lo̍h"に分割されてしまうのです。

これは明らかに間違いです。
私たちは、もっと賢い方法が必要だと気づきました。
-->

---

<!-- _class: scale-70 -->

# Phase 2: 規則の発見と整理（PR #68）

<div class="four-columns">

<div>

## 引用符（8件）

```ruby
# スマート引用符
/''/ => "'"

# 前後分離
/(.)('')(.)/ => '\1 \2 \3'
/(.)(")(.)/ => '\1 \2 \3'

# 行頭・行末
/^"/ => '" '
/"$/ => ' "'
```

</div>

<div>

## 括弧（6件）

```ruby
# 全角括弧
/（([^（]+)/ => ' （ \1'
/([^）]+)）/ => '\1 ） '

# 英数字最適化
/\(\s([a-z0-9]+)\s\)/
  => '(\1)'
```

</div>

<div>

## 省略記号（7件）

```ruby
# 3点リーダー
/\s\.\s\.\s\.$/
  => ' ...'
'. ..' => '...'

# 台湾式省略
/(‧‧‧)([^‧])/
  => '\1 \2'
```

</div>

<div>

## 句読点（10+件）

```ruby
# カンマ・ピリオド
/(.)(,)(.)/ => '\1 \2 \3'
/([^\.])(\.)/ => '\1 \2'

# 長音符
'─' => ' ─ '

# コロン
/(.)(:)(.)/ => '\1 \2 \3'
```

</div>

</div>

**合計: 65+ パターン規則を体系化**

<!--
Speaker Note:
次の段階では、実際のデータを分析して、パターンを発見し整理しました。

最終的に65以上の変換パターンを定義したハッシュを作りました。
これらは大きく4つのカテゴリーに分けられます。

1つ目は引用符の処理です。8種類のパターン。
スマート引用符の正規化、引用符前後の分離、行頭行末の処理など。

2つ目は括弧の処理です。6種類のパターン。
全角括弧と半角括弧の前後分離処理。
特に英数字を含む括弧は最適化処理を行います。

3つ目は省略記号です。7種類のパターン。
ピリオド3つの省略記号と、台湾特有の中黒を使った省略記号、
両方に対応する必要がありました。

4つ目は句読点の処理です。10種類以上のパターン。
カンマ、ピリオド、コロン、長音符など、
様々な句読点を前後のテキストから分離します。

これらのパターンを順番に適用することで、
複雑な記号が混在したテキストを正しく処理できるようになりました。
-->

---

# Phase 3: 実装の洗練（PR #73）

```ruby
class Corpus < ApplicationRecord
  def roman_kanji_array
    # Step 1: Apply 40+ GSUB patterns
    processed_roman = apply_patterns(roman)

    # Step 2: Split by delimiters
    self.roman_array = processed_roman.split(/[\s]+/)

    # Step 3: Align with kanji
    self.kanji_array = align_kanji_with_roman

    # Step 4: Balance check
    self.arrays_balanced = validate_alignment
  end

  private

  def apply_patterns(text)
    ROMAN_GSUB_PATTERNS.reduce(text) do |result, (pattern, replacement)|
      result.gsub(pattern, replacement)
    end
  end
end
```

<!--
Speaker Note:
最終的な実装では、処理を4つのステップに分けました。

Step 1: 40以上のGSUBパターンを順番に適用
Step 2: 処理後のテキストをスペースで分割
Step 3: 漢字との対応付け
Step 4: バランスチェック（配列の長さが一致するか）

特に注目してほしいのは、apply_patternsメソッドです。
reduceを使って、すべてのパターンを順番に適用しています。

これは非常にRubyらしい書き方で、読みやすく保守しやすいコードです。
-->

---

<!-- _class: scale-80 -->

# 実装の全体フロー：Step 1 - 漢字拆分処理

**処理の流れ:** 漢字文本 → 記号正規化 → CJK文字スキャン → 特殊組合処理 → kanji_array

<div class="three-columns">

<div>

## Step 1-2: 正規化とスキャン

```ruby
# Step 1: 記号正規化
kanji = "紲落來看新竹市明仔載。"
normalized = apply_kanji_patterns(kanji)
# => "紲落來看新竹市明仔載 。"

# Step 2: CJK文字をスキャン
RXP_SPK = /[\p{Han}\p{Katakana}
  \p{Hiragana}\p{Hangul}
  \u3000-\u303F\uFF00-\uFFEF]|
  [^\p{Han}\p{Katakana}
  \p{Hiragana}\p{Hangul}
  \u3000-\u303F\uFF00-\uFFEF]+/x

tokens = normalized.scan(RXP_SPK)
```

</div>

<div>

## RXP_SPK が識別する文字

**Unicode文字プロパティ:**

- **\p{Han}**
  漢字（中日韓）

- **\p{Katakana}**
  日本語カタカナ

- **\p{Hiragana}**
  日本語ひらがな

- **\p{Hangul}**
  韓国語ハングル

- **\u3000-\u303F**
  CJK記号・句読点

- **\uFF00-\uFFEF**
  全角ASCII・半角カタカナ

</div>

<div>

## Step 3: 特殊組合せと結果

```ruby
# Step 3: 特殊組合せを処理
combined = combine_special_pairs(tokens)

# 例: 一緒に扱うべき記号
# "……" + "。" => "……。"
# "』" + "。" => "』。"
# "——" + 文字 => "——" + 文字

# 最終結果
kanji_array = combined.split
# => ["紲落", "來看", "新竹市",
#     "明仔載", "。"]
```

**ポイント:**
- 多言語混在に対応
- Unicode標準に基づく
- 記号の前後処理で分割準備

</div>

</div>

<!--
Speaker Note:
それでは、実際の実装フローを4つのステップに分けて詳しく見ていきましょう。

【Step 1: 漢字拆分処理】

まず、漢字側の処理を見てみましょう。
処理の流れは非常にシンプルです。

入力は、漢字の文章です。
例えば「紲落來看新竹市明仔載。」という文章があります。

ステップ1は、記号正規化です。
KANJI_GSUB_PATTERNS を適用して、
記号の前後にスペースを挿入します。

例えば、句点「。」の前にスペースが挿入されて、
「紲落來看新竹市明仔載 。」となります。

これにより、後の処理で句点を独立したトークンとして扱えるようになります。

ステップ2は、CJK文字のスキャンです。
ここで重要なのが、RXP_SPK という正規表現です。

画面に表示されているように、この正規表現は6種類の文字を識別します。

1つ目は、\p{Han}、つまり漢字です。
中国語、日本語、韓国語の漢字をすべてカバーします。

2つ目と3つ目は、日本語のカタカナとひらがなです。
台湾語のテキストには、日本語が混在することがよくあるからです。

4つ目は、韓国語のハングルです。

5つ目と6つ目は、CJK記号・句読点と、全角ASCII・半角カタカナです。

このように、Unicode文字プロパティを使うことで、
多言語が混在したテキストを正確に識別できます。

ステップ3は、特殊組合せの処理です。
省略記号「……」と句点「。」のように、
一緒に扱うべき記号の組み合わせを処理します。

最終結果として、kanji_array が得られます。
この例では、["紲落", "來看", "新竹市", "明仔載", "。"]
という配列になります。

各単語が正しく分割され、次のステップで
POJとの対応付けができる状態になりました。
-->

---

<!-- _class: scale-80 -->

# 実装の全体フロー：Step 2 - POJ拆分処理

**処理の流れ:** POJ文本 → 記号正規化 → スペース分割 → roman_array

<div class="three-columns">

<div>

## Step 1: 記号正規化

```ruby
# ROMAN_GSUB_PATTERNS の適用
roman = "suà-lo̍h lâi-khuànn,Sin-tik-tshī"
normalized = apply_roman_patterns(roman)
# => "suà-lo̍h lâi-khuànn , Sin-tik-tshī"

# 65+ パターンで正規化:
# - 引用符の前後にスペース
# - カンマ・ピリオドの分離
# - 括弧の前後処理
# - 声調記号の正規化
# - ハイフンの保持（重要！）
```

**ポイント:**
- ハイフンは**保持**
- 記号を分離してスペース挿入
- Unicode声調記号を正規化

</div>

<div>

## Step 2: スペース分割

```ruby
# Roman側は非常にシンプル
def splitted_roman
  washed_roman
    .split(/\s/)
    .compact_blank
end

# 例:
"suà-lo̍h lâi-khuànn , Sin-tik-tshī"
  .split(/\s/)
# => ["suà-lo̍h",
#     "lâi-khuànn",
#     ",",
#     "Sin-tik-tshī"]
```

**重要な設計:**
- **ハイフンでは分割しない**
- **スペースのみで分割**
- 単語内の音節構造を保持

</div>

<div>

## 最終結果と特徴

```ruby
# roman_array の生成
roman_array = splitted_roman
# => ["suà-lo̍h",
#     "lâi-khuànn",
#     ",",
#     "Sin-tik-tshī"]
```

**POJ側の特徴:**

- ✅ **シンプル**: 2ステップのみ
- ✅ **予測可能**: スペースで分割
- ✅ **音節保持**: ハイフンを保持
- ✅ **記号分離**: 独立トークン化

**Kanji側との違い:**
- CJK文字スキャン不要
- 特殊組合せ処理不要
- 分割ルールが明確

</div>

</div>

<!--
Speaker Note:
【Step 2: POJ拆分処理】

次は、POJ側の拆分処理を見ていきましょう。
実は、POJ側の処理は漢字側と比べて非常にシンプルです。

【Step 1: 記号正規化】

まず第一歩は、記号の正規化です。

入力例を見てみましょう。
「suà-lo̍h lâi-khuànn,Sin-tik-tshī」というPOJテキストがあります。

注目してほしいのは、カンマの後にスペースがないことです。
また、「lâi-khuànn」と「Sin-tik-tshī」の間にはハイフンがあります。

ROMAN_GSUB_PATTERNS を適用すると、
「suà-lo̍h lâi-khuànn , Sin-tik-tshī」となります。

カンマの前後にスペースが挿入されました。

このパターンハッシュには、65以上のパターンが定義されています：
- 引用符の前後にスペース挿入
- カンマ・ピリオドの分離
- 括弧の前後処理
- Unicode声調記号の正規化
- そして最も重要なのは、ハイフンの保持です！

単語内のハイフンは削除せず、そのまま保持します。
なぜなら、最終的な分割は「スペース」で行うからです。

【Step 2: スペース分割】

第二歩は、非常にシンプルです。

splitted_roman メソッドは、わずか3行です：

washed_romanで正規化されたテキストを、
スペース（\s）で分割し、
compact_blankで空要素を削除するだけです。

実行結果を見てみましょう：
「suà-lo̍h lâi-khuànn , Sin-tik-tshī」
を split(/\s/) で分割すると、

["suà-lo̍h", "lâi-khuànn", ",", "Sin-tik-tshī"]

という配列が得られます。

ここで重要なポイントは：
**ハイフンでは分割しない**
**スペースのみで分割する**

ということです。

単語内の音節構造を表すハイフンは保持されます。
「suà-lo̍h」は1つのトークンとして扱われます。

【POJ側の特徴】

POJ側の処理には4つの大きな特徴があります：

1つ目は、シンプルさです。
わずか2ステップで完了します。

2つ目は、予測可能性です。
スペースで分割するという単純なルールです。

3つ目は、音節構造の保持です。
ハイフンを保持することで、単語内の音節関係を維持します。

4つ目は、記号の分離です。
カンマやピリオドは独立したトークンになります。

【Kanji側との違い】

最後に、漢字側との違いを強調しておきます：

POJ側には、CJK文字のスキャンは不要です。
特殊な組み合わせ処理も不要です。
分割ルールが非常に明確で、シンプルです。

これは、POJがラテン文字ベースであり、
スペースという明確な区切り文字があるからです。

一方、漢字はスペースなしで連続するため、
より複雑な処理が必要になるのです。

この対比が、次のステップでの対応付け処理を理解する上で重要になります。
-->

---

<!-- _class: scale-80 -->

# 実装の全体フロー：Step 3 - 配對邏輯（アライメント）

**処理の流れ:** roman_array + kanji_array → ハイフン数で対応付け → 配対陣列

<div class="three-columns">

<div>

## 基本原理：音節数の一致

```ruby
# POJ側
"suà-lo̍h"
  .split('-')
  # => ["suà", "lo̍h"]
  # 2音節

# 漢字側
"紲落"
  .split('-')
  # => ["紲落"]
  # 1トークン（ハイフンなし）
```

**問題:**
- POJ: 2音節
- 漢字: 1トークン
- **一致しない!**

</div>

<div>

## 解決策：複数結合

```ruby
# Step 1: POJの音節数をカウント
roman_syllables = 2

# Step 2: 漢字側を累積
kanji_tokens = ["紲", "落"]
combined = "紲" # 1トークン
total = 1

# Step 3: 足りない分を追加
while total < roman_syllables
  combined += kanji_tokens.shift
  total += 1
end

# 結果
combined # => "紲落"
```

**対応関係:**
- `"suà-lo̍h"` ↔ `"紲落"`

</div>

<div>

## 実際の処理例

```ruby
# 入力配列
roman_array = [
  "suà-lo̍h",    # 2音節
  "lâi-khuànn",  # 2音節
  "Sin-tik-tshī" # 3音節
]

kanji_array = [
  "紲", "落", "來", "看",
  "新", "竹", "市"
]
```

**処理結果:**
```ruby
[
  ["suà-lo̍h", "紲落"],
  ["lâi-khuànn", "來看"],
  ["Sin-tik-tshī", "新竹市"]
]
```

</div>

</div>

<!--
Speaker Note:
【Step 3: 配對邏輯（アライメント）】

さて、いよいよ最も重要なステップ、対応付け処理です。
ここでは、一般的なケースのみに焦点を当てます。

【基本原理：音節数の一致】

左側のカラムを見てください。
基本的な問題を示しています。

POJ側では、「suà-lo̍h」という単語があります。
ハイフンで分割すると、「suà」と「lo̍h」の2音節です。

一方、漢字側では「紲落」という2文字があります。
しかし、これはハイフンがないので、1つのトークンとして扱われます。

ここに問題があります：
POJは2音節、漢字は1トークン。
数が一致しません！

【解決策：複数結合】

中央のカラムでは、この問題の解決策を示しています。

ステップ1：POJの音節数をカウントします。
この場合、2音節です。

ステップ2：漢字側のトークンを累積していきます。
最初に「紲」を取り出します。これで1トークンです。

ステップ3：音節数が足りないので、
whileループで次のトークン「落」を追加します。
これで2トークンになり、音節数と一致します。

結果として、「紲落」という結合されたトークンができます。

これで、「suà-lo̍h」と「紲落」が対応関係になりました。

【実際の処理例】

右側のカラムでは、実際の処理例を見てみましょう。

入力として、3つのPOJ単語があります：
1. 「suà-lo̍h」（2音節）
2. 「lâi-khuànn」（2音節）
3. 「Sin-tik-tshī」（3音節）

漢字側には、7つのトークンがあります：
紲、落、來、看、新、竹、市

対応付けプロセスを見てみましょう：

1つ目：「suà-lo̍h」は2音節なので、
「紲」と「落」を結合して「紲落」にします。

2つ目：「lâi-khuànn」も2音節なので、
「來」と「看」を結合して「來看」にします。

3つ目：「Sin-tik-tshī」は3音節なので、
「新」と「竹」と「市」を結合して「新竹市」にします。

最終結果として、3つのペアの配列ができます。

このように、音節数を基準に、
漢字トークンを動的に結合していくことで、
POJと漢字の完全な対応関係を構築できるのです。

この方法は非常にシンプルですが、効果的です。
音節という言語学的な単位を基準にすることで、
複雑な対応関係も自然に解決できます。
-->

---

<!-- _class: scale-80 -->

# 実装の全体フロー：Step 4 - 配列構築と検証

**処理の流れ:** 配対陣列 → Transpose → 2つの配列 → 平衡性検証

<div class="three-columns">

<div>

## Step 1: Transpose操作

```ruby
# 入力：配対陣列
pairs = [
  ["suà-lo̍h", "紲落"],
  ["lâi-khuànn", "來看"],
  ["Sin-tik-tshī", "新竹市"]
]

# Transposeで分離
transposed = pairs.transpose
# => [
#   ["suà-lo̍h", "lâi-khuànn", "Sin-tik-tshī"],
#   ["紲落", "來看", "新竹市"]
# ]

# 配列に設定
roman_array = transposed[0]
kanji_array = transposed[1]
```
</div>

<div>

## Step 2: 平衡性検証

```ruby
# 3つの条件をチェック
balanced = [
  # 条件1: 空でない = 処理が成功している
  roman_array.size > 0,

  # 条件2: サイズ一致 = 1:1対応が保たれている
  roman_array.size == kanji_array.size,

  # 条件3: 文字数一致 = 漢字が欠落していない = 重複もしていない
  kanji_array.join.size ==
    original_kanji.delete(' ').size
].all?
```

</div>

<div>

## 検証の具体例

```ruby
roman_array.size # => 3
kanji_array.size # => 3
# ✅ サイズ一致

kanji_array.join.size # => 7
original.size # => 7
# ✅ 文字数一致

arrays_balanced = true
```

</div>

</div>

<!--
Speaker Note:
【Step 4: 配列構築と検証】

最後のステップは、配列の構築と平衡性の検証です。

【Step 1: Transpose操作】

左側のカラムを見てください。

前のステップで得られた配対陣列があります：
[["suà-lo̍h", "紲落"], ["lâi-khuànn", "來看"], ["Sin-tik-tshī", "新竹市"]]

これは、[POJ, 漢字] のペアの配列です。

ここで、Rubyの transpose メソッドを使います。

transposeは、行列の転置操作を行います。
つまり、行と列を入れ替えるのです。

実行すると、
[["suà-lo̍h", "lâi-khuànn", "Sin-tik-tshī"],
 ["紲落", "來看", "新竹市"]]
という2つの配列に分離されます。

最初の配列が roman_array、
2つ目の配列が kanji_array になります。

このように、transposeメソッドを使うことで、
ペアの配列から、2つの独立した配列を簡単に取り出せます。

これは非常にRubyらしい、エレガントな方法です。

【Step 2: 平衡性検証】

中央のカラムでは、平衡性の検証について説明します。

平衡性とは、対応付けが正しく行われたかどうかを確認する指標です。

3つの条件をチェックします：

1つ目は、配列が空でないこと。
roman_array のサイズが 0 より大きいことを確認します。
もし空なら、処理が失敗しています。

2つ目は、サイズの一致です。
roman_array と kanji_array のサイズが同じでなければなりません。
一対一対応が保たれているはずなので、サイズは必ず一致します。

3つ目は、文字数の一致です。
kanji_array を結合した文字列のサイズが、
元の kanji テキストからスペースを削除したサイズと一致するか確認します。

これにより、漢字が欠落したり重複したりしていないことを保証できます。

これら3つの条件がすべて満たされた場合のみ、
arrays_balanced フラグを true に設定します。

【検証の具体例】

右側のカラムでは、具体的な検証例を見てみましょう。

入力データとして、「紲落來看新竹市」という7文字の漢字があります。

処理後、kanji_array は ["紲落", "來看", "新竹市"] の3要素、
roman_array も ["suà-lo̍h", "lâi-khuànn", "Sin-tik-tshī"] の3要素です。

検証を実行します：

まず、サイズをチェックします。
roman_array.size は 3、kanji_array.size も 3。
✅ サイズ一致！

次に、文字数をチェックします。
kanji_array を結合すると「紲落來看新竹市」、7文字です。
元の kanji からスペースを削除したサイズも7文字です。
✅ 文字数一致！

すべての条件を満たしているので、
arrays_balanced を true に設定します。

これで、完全な一対一対応が保証されました。
データの完全性が確認でき、次の処理へ進めます。

このように、transposeと平衡性検証を組み合わせることで、
正確で信頼性の高いデータ処理を実現できるのです。
-->

---

<!-- _class: lead -->

# 第四幕：Parserとの出会い

**2024年の実装から2025年の気づきへ**

<!--
Speaker Note:
2024年初頭、私たちは台羅拼音の拆字システムを完成させました。
40以上のGSUBパターン、音節数による対応付け、バランスチェック。
これらはすべて、実務の要求から生まれた実装でした。

そして2025年5月、物語は思わぬ展開を見せます。
-->

---

<!-- _class: center highlight -->

# 金子さんのProposal からの発想：2025年5月

**RubyConf x COSCUP Taiwan 2025 CFP**

<!--
Speaker Note:
2025年5月、私は RubyConf x COSCUP Taiwan 2025 の主催者として、
CFP（Call for Proposals）の審査を行っていました。

その中に、Yuichiro Kaneko さんからの投稿がありました。

Kaneko さんは、Ruby 3.3 から導入された Lrama Parser の主要開発者です。
彼の投稿したトークのタイトルを見た瞬間、私は凍りつきました：

「Understanding Ruby Grammar Through Conflicts」

Ruby の文法を、Parser の衝突（Conflict）を通じて理解する。

彼の投稿概要を読んでいるとき、稲妻に打たれたような感覚を覚えました。

「待てよ... これは...」
-->

---

<!-- _class: scale-90 -->

# CFPからの気づき

<div style="display: grid; grid-template-columns: 1.2fr 1fr; gap: 2em; align-items: center;">

<div>

<img src="images/rubyconftw2025-kaneko.jpg" style="width: 100%; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);">

</div>

<div>

## Kaneko さんのトーク

**"Understanding Ruby Grammar Through Conflicts"**

<div style="margin: 1.5em 0; padding: 1em; background: #f5f5f5; border-left: 4px solid #CC342D; border-radius: 4px;">

**Parser の3段階処理**

1. **Lexical Analysis** (字句解析)
2. **Syntax Analysis** (構文解析)
3. **Semantic Analysis** (意味解析)

</div>

<div style="margin-top: 2em; padding: 1em; background: linear-gradient(135deg, #fff3cd 0%, #fff 100%); border-radius: 8px;">

<div style="text-align: center; font-size: 1.1em; margin-bottom: 0.8em;">
💡 **「これは... 私の台羅拼音システムと同じ構造だ！」**
</div>

<div style="text-align: center; font-size: 1.05em; margin-top: 1em; padding-top: 1em; border-top: 2px dashed #CC342D;">
→ **「Parser の視点で、このテーマを語りたい」**
</div>

</div>

</div>

</div>

<!--
Speaker Note:
2025年5月、私は RubyConf x COSCUP Taiwan 2025 の CFP 審査をしていました。

その中に、Yuichiro Kaneko さんからの投稿がありました。
Kaneko さんは、Ruby 3.3 から導入された Lrama Parser の主要開発者です。

彼のトークタイトルは「Understanding Ruby Grammar Through Conflicts」。
Ruby の文法を、Parser の衝突（Conflict）を通じて理解する、という内容です。

投稿概要を読んでいるとき、私は衝撃を受けました。

Parser の 3 段階処理：
1. Lexical Analysis - テキストをトークンに分割
2. Syntax Analysis - トークン間の構造関係を構築
3. Semantic Analysis - 意味の検証とエラー検出

これは... 私が 2024 年に実装した台羅拼音の拆字システムと、
まったく同じ構造ではないか！

40 個以上の GSUB パターンで記号を正規化し（字句解析）、
漢字と POJ を音節数で対応付けて（構文解析）、
最後に配列のバランスをチェックする（意味解析）。

私が無意識に実装していたものは、
コンパイラの 3 段階分析そのものだったのです。

プログラミング言語の Parser と、自然言語の処理が、
本質的に同じ原理に基づいている。

この気づきから、私はこのテーマを Parser の視点で語りたいと思いました。

そして、RubyWorld Conference 2025 の CFP が始まったとき、
この発見を共有したいという強い思いで投稿を決めました。

投稿準備の中で、「本当に Parser と同じなのか？」を自分で確かめたくなり、
Parslet という PEG Parser ライブラリを使って、
真の Parser 理論に基づいた実験的実装を試みました。

これは production コードではなく、あくまで学習のための実験です。
しかし、この実験を通じて、コンパイラ理論の普遍性を実感できました。
-->

---

<!-- _class: scale-70 -->

# RomanParser: Parslet による真の Parser 実装

**RubyWorld Conference 2025 のために開発した新実装**

```ruby
class RomanParser < Parslet::Parser
  # Phase 1: Lexical Analysis (Tokenization)
  # Phase 2: Syntax Analysis (AST Construction)
  # Phase 3: Semantic Analysis (Transformation)
end
```

**目的:**
- Ruby の Parser と同じ 3-phase アプローチを実証
- コンパイラ理論を自然言語処理に応用
- Parslet gem を使った PEG Parser の構築

<!--
Speaker Note:
ここからが、今回の発表の最も重要な部分です。

実は、このプロジェクトを進めている中で、
私は Ruby の Parser 自体と非常に似た構造を持つ
新しい実装を開発しました。

それが RomanParser です。

これは、RubyWorld Conference 2025 での発表のために、
特別に開発した実装です。

Parslet という PEG Parser ライブラリを使って、
Ruby の Parser と同じ 3-phase アプローチを実現しています。

これから、この 3 つの Phase を詳しく見ていきましょう。
-->

---

<!-- _class: scale-70 -->

# Phase 1: Lexical Analysis（字句解析）

**Parslet Grammar Rules による Tokenization**

<div class="two-columns">

<div>

## 基本的な Token 定義

```ruby
# 空白文字
rule(:space) { str(' ') | str('\t') }
rule(:spaces) { space.repeat(1) }
rule(:spaces?) { space.repeat }

# ローマ字
rule(:letter) { match['a-zA-Z'] }

# ハイフン
rule(:hyphen) { str('-') }

# 句読点
rule(:punctuation) do
  str(',') | str('.') | str('!') |
  str('?') | str('「') | str('」')
end
```

</div>

<div>

## Roman Word の定義

```ruby
rule(:roman_word) do
  (
    letter.repeat(1) >>
    # Unicode 声調記号
    (hyphen.absent? >>
     match['\u0300-\u036F']).repeat >>
    # ハイフンで繋がる音節
    (hyphen >> letter.repeat(1) >>
     (hyphen.absent? >>
      match['\u0300-\u036F']).repeat
    ).repeat
  ).as(:word)
end
```

**マッチ例:**
- `suà-lo̍h` ✓
- `lâi-khuànn` ✓
- `Sin-tik-tshī` ✓

</div>

</div>

<!--
Speaker Note:
Phase 1 は、字句解析です。

Parslet の Grammar Rules を使って、
テキストを Token に分割します。

左側では、基本的な Token の定義を見ることができます。

space、spaces、spaces? という 3 種類の空白ルール。
なぜ 3 種類必要なのか？

space は単一の空白文字。
spaces は 1 つ以上の空白（必須）。
spaces? は 0 個以上の空白（オプション）。

これにより、「必須の空白」と「オプションの空白」を
明確に区別できます。

右側では、roman_word の定義を見てみましょう。

これは非常に複雑です。

まず、letter を 1 つ以上マッチします。
次に、Unicode の声調記号（U+0300-U+036F）を処理します。
そして、ハイフンで繋がる音節を繰り返しマッチします。

この定義により、
「suà-lo̍h」のような複雑な台湾語の単語を
1 つの Token として正しく認識できるのです。

重要なポイントは、
「ハイフンは Token の一部として保持される」
ということです。

最終的な分割は、スペースで行います。
-->

---

<!-- _class: scale-70 -->

# Phase 2: Syntax Analysis（構文解析）

**AST (Abstract Syntax Tree) の構築**

<div class="two-columns">

<div>

## Sentence Rule

```ruby
rule(:sentence) do
  (
    spaces? >>           # 句首の空白（任意）
    token >>             # 最初の Token
    (spaces >> token).repeat >>  # 後続 Token
    spaces?              # 句尾の空白（任意）
  ).as(:sentence)
end

root(:sentence)
```

**入力:**
```
"  suà-lo̍h lâi-khuànn  "
```

</div>

<div>

## 生成される AST

```ruby
{
  sentence: [
    { word: "suà-lo̍h" },
    { word: "lâi-khuànn" }
  ]
}
```

**重要な設計:**
- 空白は消費されるが AST に含まれない
- Token の構造関係のみを保持
- 音節内ハイフンは保持される

</div>

</div>

<!--
Speaker Note:
Phase 2 は、構文解析です。

ここでは、Token から AST（抽象構文木）を構築します。

左側の Sentence Rule を見てください。

まず、spaces? で句首の空白をマッチします。
これは任意です。あっても、なくてもいい。

次に、token で最初の Token をマッチします。

そして、(spaces >> token).repeat で、
後続の Token をマッチします。

ここでの spaces は必須です。
Token と Token の間には、必ずスペースが必要です。

最後に、spaces? で句尾の空白をマッチします。
これも任意です。

この設計により、
「  suà-lo̍h lâi-khuànn  」のような
前後に空白がある入力でも、正しく処理できます。

右側では、生成される AST を見てみましょう。

sentence というキーの下に、
word の配列が格納されています。

重要なのは、
「空白は消費されるが、AST には含まれない」
ということです。

空白は Token の区切りとしてのみ機能し、
AST の構造には影響しません。

そして、音節内のハイフンは保持されます。
「suà-lo̍h」は 1 つの word として扱われます。

これが、Ruby の Parser が AST を構築する方法と
非常に似ていることが分かりますね。
-->

---

<!-- _class: scale-65 -->

# Phase 3: Semantic Analysis（意味解析）

**AST から最終配列への変換**

<div class="two-columns">

<div>

## Transform Rules

```ruby
class RomanTransform < Parslet::Transform
  # 1. Word ノードの変換
  rule(word: simple(:w)) { w.to_s }

  # 2. 複数 Token の Sentence
  rule(sentence: sequence(:tokens)) do
    WASHING_PATTERNS
      .reduce(tokens.join(' ')) { |r, (p, rep)|
        r.gsub(p, rep)
      }
      .split(/\s/)
      .compact_blank
  end

  # 3. 単一 Token の Sentence
  rule(sentence: simple(:token)) do
    WASHING_PATTERNS
      .reduce(token.to_s) { |r, (p, rep)|
        r.gsub(p, rep)
      }
      .split(/\s/)
      .compact_blank
  end
end
```

</div>

<div>

## 変換の流れ

**Step 1: Word 変換**
```ruby
{ word: "suà-lo̍h" } → "suà-lo̍h"
{ word: "lâi-khuànn" } → "lâi-khuànn"
```

**Step 2: Join**
```ruby
["suà-lo̍h", "lâi-khuànn"]
  .join(' ')
# => "suà-lo̍h lâi-khuànn"
```

**Step 3: Apply WASHING_PATTERNS**
```ruby
WASHING_PATTERNS.reduce(...) { ... }
# => "suà-lo̍h lâi-khuànn"
```

**Step 4: Split & Compact**
```ruby
.split(/\s/).compact_blank
# => ["suà-lo̍h", "lâi-khuànn"]
```

</div>

</div>

<!--
Speaker Note:
Phase 3 は、意味解析です。

ここでは、AST を最終的な配列形式に変換します。

Parslet の Transform というメカニズムを使います。

左側の Transform Rules を見てください。

まず、rule(word: simple(:w)) で、
個々の word ノードを文字列に変換します。

次に、rule(sentence: sequence(:tokens)) で、
複数の Token を持つ Sentence を処理します。

ここで重要なのは、WASHING_PATTERNS の適用です。

これは、元の実装で使っていた
65 個以上のパターン置換ルールです。

reduce を使って、すべてのパターンを順番に適用し、
最後に split で配列に分割します。

そして、もう 1 つの rule で、
単一 Token の Sentence も処理します。

これは、バグ修正で追加したルールです。

右側では、変換の流れを見てみましょう。

Step 1: 個々の word ノードが文字列に変換されます。

Step 2: tokens.join(' ') で、スペースで結合します。

Step 3: WASHING_PATTERNS を適用します。
これにより、記号の正規化などが行われます。

Step 4: split で配列に分割し、compact_blank で空要素を削除します。

最終的に、["suà-lo̍h", "lâi-khuànn"] という
クリーンな配列が得られます。

この 3-phase アプローチは、
Ruby の Parser が行う処理と本質的に同じです。

Lexical Analysis で Token 化し、
Syntax Analysis で構造を構築し、
Semantic Analysis で最終形式に変換する。

コンパイラ理論を、自然言語処理に応用した例です。
-->

---

<!-- _class: scale-70 -->

# Ruby Parser との比較

<div class="two-columns">

<div>

## Ruby Parser (Prism)

```ruby
# 入力
"def foo(x); x + 1; end"
```

**Phase 1: Lexical**
```
[DEF][IDENTIFIER][LPAREN][IDENTIFIER]
[RPAREN][SEMICOLON][IDENTIFIER][PLUS]
[INTEGER][SEMICOLON][END]
```

**Phase 2: Syntax**
```ruby
DefNode(
  name: :foo,
  parameters: ParametersNode(...),
  body: StatementsNode(...)
)
```

**Phase 3: Semantic**
- Type checking
- Scope analysis
- Code generation

</div>

<div>

## 台羅 Parser (RomanParser)

```
# 入力
"suà-lo̍h lâi-khuànn"
```

**Phase 1: Lexical**
```
[suà-lo̍h][lâi-khuànn]
```

**Phase 2: Syntax**
```ruby
{
  sentence: [
    { word: "suà-lo̍h" },
    { word: "lâi-khuànn" }
  ]
}
```

**Phase 3: Semantic**
- Pattern washing
- Token validation
- Array generation
```ruby
["suà-lo̍h", "lâi-khuànn"]
```

</div>

</div>

<!--
Speaker Note:
それでは、Ruby の Parser と比較してみましょう。

左側は、Ruby の Prism Parser です。

Phase 1 で、コードを Token に分割します。
DEF、IDENTIFIER、LPAREN など、
様々な種類の Token が生成されます。

Phase 2 で、Token から AST を構築します。
DefNode という構造を持つ、抽象構文木です。

Phase 3 で、型チェックやスコープ解析を行い、
最終的にコードを生成します。

右側は、私たちの台羅 Parser、RomanParser です。

Phase 1 で、テキストを Token に分割します。
「suà-lo̍h」と「lâi-khuànn」という 2 つの Token です。

Phase 2 で、Token から AST を構築します。
sentence という構造を持つ、抽象構文木です。

Phase 3 で、パターンの適用と検証を行い、
最終的に配列を生成します。

構造が非常に似ていることが分かりますね。

プログラミング言語の Parser も、
自然言語の Parser も、
本質的に同じ原理に基づいているのです。

これが、コンパイラ理論の普遍性です。

Ruby で学んだ Parser の設計原則が、
台湾語の処理にも応用できる。

これは非常に興味深い発見でした。
-->

---

<!-- _class: scale-85 -->

# 3段階分析の詳細

<div class="two-columns">

<div>

## 1. Lexical Analysis（字句解析）
- トークン分割
- 特殊記号の識別
- デリミタの処理

## 2. Syntax Analysis（構文解析）
- 構造関係の構築
- 対応ルールの適用
- パターンマッチング

</div>

<div>

## 3. Semantic Analysis（意味解析）
- バランスチェック
- 一貫性検証
- エラー検出・修復

</div>

</div>

<!--
Speaker Note:
コンパイラの3段階分析を、台羅パーサーに当てはめてみましょう。

第1段階：字句解析
テキストをトークンに分割し、特殊記号を識別します。
これが、40+のパターンを適用する処理に相当します。

第2段階：構文解析
トークン間の構造関係を構築し、対応ルールを適用します。
これが、漢字とPOJの対応付け処理です。

第3段階：意味解析
配列のバランスをチェックし、一貫性を検証します。
エラーがあれば検出して修復します。

このように、コンパイラの設計原則を応用することで、
複雑な文字処理も体系的に整理できました。
-->

---

<!-- _class: center scale-95 -->

# コンパイラ理論の応用

**言語処理の共通性**

プログラミング言語のパーサー設計で培われた知識が、
自然言語（台湾語）の処理にも適用できる

↓

**プログラミングの思考法は万能**

<!--
Speaker Note:
ここで重要な洞察があります。

プログラミング言語のパーサー設計で培われた知識は、
自然言語の処理にも適用できる、ということです。

Rubyのコードを解析する技術と、台湾語を解析する技術は、
本質的に同じ原理に基づいています。

プログラミングの思考法、特にコンパイラ理論の考え方は、
様々な問題領域に応用できる普遍的なツールなのです。
-->

---

<!-- _class: lead -->

# 第五幕：Rubyの優位性

**なぜRubyが最適だったのか**

<!--
Speaker Note:
最後に、なぜRubyがこの問題に最適だったのか、
3つのポイントでお話しします。
-->

---

<!-- _class: scale-85 -->

# Rubyの3つの優位性

## 1. 正規表現の表現力
```ruby
ROMAN_GSUB_PATTERNS = {
  /([a-z])-([aeiou])/ => '\1 \2',
  /([aeiou])([̀́̂̌̄̍])/ => '\1\2',
  # 複雑なパターンも簡潔に記述
}
```

## 2. Method Chainingの可読性
```ruby
def apply_patterns(text)
  ROMAN_GSUB_PATTERNS.reduce(text) do |result, (pattern, replacement)|
    result.gsub(pattern, replacement)
  end
end
```

## 3. Railsエコシステム
- ActiveRecord による大量データ処理
- バッチ処理の効率化
- テストフレームワークの充実

<!--
Speaker Note:
1つ目は、正規表現の表現力です。
Rubyの正規表現は非常に強力で、複雑なパターンも簡潔に記述できます。
Unicode結合文字のような特殊なケースも、柔軟に処理できました。

2つ目は、メソッドチェーンの可読性です。
reduceとgsubを組み合わせて、40以上のパターンを順番に適用する処理が、
わずか数行で書けます。これは非常にRubyらしい、読みやすいコードです。

3つ目は、Railsエコシステムです。
ActiveRecordを使った大量データの処理、バッチ処理の効率化、
充実したテストフレームワーク。
これらすべてが、プロジェクトの成功に貢献しました。

実際、208時間分の音声データ、数万件のテキストデータを
安定して処理できたのは、Rubyとそのエコシステムのおかげです。
-->

---

<!-- _class: scale-85 -->

# プロジェクトの成果

<div class="two-columns">

<div>

## 処理規模
- **208時間**の音声データ
- **数万件**のテキストデータ処理
- **全台湾の国中小学校**で利用

## 技術的成果
- **40+ GSUBパターン**の体系化
- **3段階分析**フレームワークの確立
- **99%以上**の精度達成

</div>

<div>

## 社会的インパクト
- 台湾語教育の標準プラットフォーム
- 教育部・国家教育研究院の公式システム
- 次世代への言語継承に貢献

</div>

</div>

<!--
Speaker Note:
プロジェクトの成果をまとめます。

処理規模としては、208時間の音声データと、数万件のテキストデータを処理し、
全台湾の国中小学校で利用されるシステムになりました。

技術的には、40以上のGSUBパターンを体系化し、
3段階分析のフレームワークを確立しました。
精度は99%以上を達成しています。

そして最も重要なのは、社会的インパクトです。
このシステムは、台湾語教育の標準プラットフォームとなり、
教育部と国家教育研究院の公式システムとして採用されました。

台湾語という重要な言語を、次世代に継承するために、
Rubyが貢献できたことを、とても誇りに思っています。
-->

---

<!-- _class: center highlight -->

# 結論

**プログラミング言語の思考法は万能**

コンパイラ理論 → 自然言語処理
Ruby → 台湾語教育システム

Rubyで解決できない問題はない

<!--
Speaker Note:
最後に、この発表の結論をお伝えします。

プログラミング言語の思考法、特にコンパイラ理論の考え方は、
様々な問題領域に応用できます。

プログラミング言語の解析技術が、自然言語の処理にも使える。
Rubyで、台湾語教育システムを作ることができる。

私たちが学んだのは、Rubyで解決できない問題はない、ということです。

正規表現、メソッドチェーン、Railsエコシステム。
これらを組み合わせれば、どんな複雑な問題も解決できます。
-->

---

<!-- _class: center scale-95 -->

# ご清聴ありがとうございました

## リンク・連絡先
- ** X **: https://x.com/ryudoawaru
- **GitHub**: https://github.com/ryudoawaru
- **Email**: ryudo@5xruby.com
- **Company**: https://5xruby.com

**Rubyコミュニティブース出展中！**
ぜひお立ち寄りください

<!--
Speaker Note:
ご清聴ありがとうございました。

プロジェクトの詳細は、5xRubyのGitHubで公開しています。
（実際のコードはプライベートリポジトリですが、技術的な質問は大歓迎です）

また、今回のRubyWorld Conferenceでは、
Rubyコミュニティのブースを出展しております。
ぜひお立ち寄りいただき、直接お話しできれば嬉しいです。

そして、松江市とのMOUを通じて、今後も日台のRubyコミュニティの
交流を深めていきたいと思っています。

ありがとうございました！
-->

<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true });
</script>