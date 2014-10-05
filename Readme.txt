Rayライブラリ Ver1.04

--内容物--
Rayフォルダ
├stdlib.lua		基本的(?)な関数が入ってる
├3Dline.lua		3次元空間に文字を書く関数が入ってる。(文字の回転とかできません)
├boot.lua		Rayライブラリのすべての機能を読み込める
├flight.lua		飛行機で目標追尾を比較的簡単に実装できるかもしれない関数 followから名称変更
├HUD.lua		HUDを比較的簡単に実装できるかもしれない関数(重い、3Dline.luaと同じで使いにくい)
├network.lua	ネットワーク接続時にプレイヤーの位置、速度のテーブルを返す関数
├2Dline.lua		デバッグ向けのグラフ、円グラフもどきを出力できる関数。
└Graphic		Smirnoff用の適当に作ったラッパ

--更新履歴--
1.01	follow関数の挙動を少し変更した
1.02	trace_nとcross_pos関数のバグ修正
1.03	ノイズ消し実装、3Dlineに"8","9","_","."を追加
		follow.luaをflight.luaに名称変更
		flight.lua内のfollow関数に編隊飛行アシスト機能を追加
1.04	stdlib:
			LEN2を削除(LENに引数2つで十分)
			PorMをsignへ変更(前から気に食わない名前だった)
			damageLevelを追加
		SmirnoffのラッパとしてGraphicを追加(手元のSmirnoffのバージョンが0.3だからない機能があるかも)
		
正直自分でも内容を把握できてない

設定方法も省きます。

ライブラリは偉大。

バグや不都合な点があれば下記の連絡先へ。
Twitter:@ray45422
mail:ray45422@gmail.com