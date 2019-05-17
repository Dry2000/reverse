# reverse
翔泳社様のSpriteKitで始める2Dゲームプログラミング(https://www.shoeisha.co.jp/book/detail/9784798139517) を参考に書いたオセロゲーム。

使用画像は一度完成したのちに素材を集めるため、現時点では上のものそのまま
発行年が2015年と古いので現在の文法に逐次変更しながら書いている。

# 主な変更点
Board:Printable→Board:CustomStringConvertible Printableが使用できなくなっていたため

join(" ",A)→A.joined(separator:" ") 文字を結合させるjoin関数の文法の変化のため

convertPointOnLayerの中身　Xcode 8.0以降よりSpriteKitの座標系の変更による座標変換の変更

AIの実装で現在挫折
