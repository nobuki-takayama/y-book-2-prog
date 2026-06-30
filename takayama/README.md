# 計算代数の基礎とモデリング, シミュレーション
## グレブナー基底で代数方程式を解く
### 順序とわり算アルゴリズム
### Buchbergerアルゴリズムとグレブナー基底
  - [buch-binom4.py](buch-binom4.py),  
   $cx^a$ は $[c,a_1, a_2, \ldots, a_N]$ とリストで表現.
   2項式は上記リストを成分とする長さ2のリスト.
   たとえば変数の数 $N=2$ として $x_1^2 x_2 - x_1 x_2^2$ は [[1,2,1],[-1,1,2]] と表現する.  
   以下の関数は 定数×モノミアル 専用.
   comp は lexicographic order での大小比較.
   is_reducible(a,b) は a が b で割れるか判定.
   mymul は掛け算.  
   このプログラムの以下の関数は2項式専用.
   normalForm の計算は reduce2. 
   spolynomial は S-多項式の計算.
   buchberger は Buchberger アルゴリズム(reduced basis は求めない).
   [Python版](https://www.python.org/).
  - [buch-binom4.rr](buch-binom4.rr),  [Risa/Asir](http://www.openxm.org) による同様な実装.
  - [buch-binom6.py](buch-binom6.py),  2項式のグレブナー基底計算関数 buchberger. Python版. buch-binom4.py の改良版.
  - [buch-binom6.rr](buch-binom6.rr),  Risa/Asir による同様な実装.
  - [toric-ex.rr](toric-ex.rr),     上記のプログラムの答え合わせ用データを出力. Risa/Asir版.
### 変数消去とグレブナー基底, 代数方程式の求解
  - [lex.m2](lex.m2),  [Macaulay2](https://macaulay2.com/) での変数消去, normalForm.
  - [lex.ml](lex.ml),  [Maple](https://www.maplesoft.com/) での変数消去, normalForm.
  - [lex.m](lex.m),   [Mathematica](https://www.wolfram.com/mathematica/) での変数消去, normalForm.
  - [lex.rr](lex.rr),  Risa/Asir での変数消去, normalForm.
  - [lex.txt](lex.txt), [Singular](https://www.singular.uni-kl.de/) での変数消去, normalForm.
### 参考: Homotopy continuation 法による代数方程式の求解
  - [phc-test1.txt](phc-test1.txt),  [phcpack](https://github.com/janverschelde/PHCpack) による連立代数方程式の求解 
## グレブナー基底による変数消去と微分方程式への応用
### 連立ODEを単独高階ODEへ
  - [prey_predator.py](prey_predator.py),  前半は Lotka-Volterra system の数値解.
  - [pp-sys.rr](pp-sys.rr),         y関数の単独高階ODEをグレブナー基底で求める.
  - [prey_predator.py](prey_predator.py),  後半はデータからパラメータを推定するプログラム.
### 差分代数, 差分スキーム, 消去法
  - [osci_simple.py](osci_simple.py), 単振動の方程式 $p'=-kq, q'=p$ を素朴な差分法で解くとエネルギーが増えていく例.
  - [osci_symp.py](osci_symp.py),  同じ方程式をシンプレクティック法で解く例. エネルギーは増えない.
  - [symp-difference-elim.rr](symp-difference-elim.rr), シンプレクティク法による差分スキームに消去法を適用して $q$ 変数のみの差分方程式を得る.
## 消去法の高速化
  - [fglm.rr](fglm.rr),  FGLM Risa/Asir 版.
  - [fglm.txt](fglm.txt),  FGLM Singular 版.

## 正確ベイズ解析, 基本.
  - [int2.rr](int2.rr), パラメータ付き積分 
    $g(x)=\int_{-\infty}^\infty \exp(-t^6+tx)dt$
   の満たす微分方程式を求める.
  - [bayesian-exp-example.m](bayesian-exp-example.m), 
      モデル分布は $w$ をパラメータとして $\exp(-w x^2)/\sqrt{\pi w}$.
      $\exp(-(w-1/2)^2)/\sqrt{\pi}$ を事前分布として事後分布を計算. 
      Mathematica.
  - [bayes-posterior-graph.m](bayes-posterior-graph.m), データ数 N=69 (nn=69)の場合の事後分布のグラフ. Mathematica.

## Twisted cohomology 群を計算するソフトウエア
  - [deRham.rr](deRham.rr), ex2b() は $f_1=p_1$, $f_2=z_0+z_1p_1+z_2p_1^2+z_3p_1^3$ の場合の twisted cohomology 群の基底の計算. $s_1, s_2$ は $15/2, -11/3$.  
 ex3b() は $f_1=p_1$, $f_2=p_2$, $f_3=z_0+z_1p_1^2+z_2p_2+z_3p_1p_2$ の場合の twisted cohomology 群の計算. $s_1=15/2$, $s_2=7/5$, $s_3=-11/3$.
  - [deRham.m2](deRham.m2), 上記 ex3b() を Macaulay2 で実行. 入力は上記のプログラムで生成. $f_1= p_1$, $f_2=p_2$, $f_3=z_0+z_1p_1^2+z_2p_2+z_3p_1 p_2$ の場合の twisted cohomology 群の基底の計算.


## holonomic 関数の立場からみたベータ関数
  - [diff-beta.m](diff-beta.m), HolonomicFunctions(https://www3.risc.jku.at/research/combinat/software/ergosum/RISC/HolonomicFunctions.html) パッケージを用いてベータ関数の満たす差分方程式を求める例. CreativeTelescoping の適用例.
  - [gen_ore.rr](gen_ore.rr), test_gaussHG() は $t^a (1-t)^b (1-tx)^c$ が満たす $x, t$ についての1階の線形偏微分方程式系を未定係数法で求め HolonomicFunctions パッケージ用の ann 変数にセットする. t についての積分は x についての常微分方程式を満たすがそれを求める.
  - [gen_ore_test.m](gen_ore_test.m), 上記プログラムの出力. Mathematica 用.
  - [bayesian_beta.py](bayesian_beta.py), データが増えて行く時の予測分布の変化.
