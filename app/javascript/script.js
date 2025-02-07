/*global $*/
$(document).on('turbolinks:load', function() {
  $(document).ready(function () {
    $("#nekoimages").skippr({
      // スライドショーの変化 ("fade" or "slide")
      transition : 'fade',
      // スライドショーの自動再生(falseで自動再生なし)
      autoPlay : true,
      // 変化に係る時間(ミリ秒)
      speed : 2000,
      // easingの種類
      easing : 'easeOutQuart',
      // ナビゲーションの形("block" or "bubble")
      navType : 'block',
      // 子要素の種類('div' or 'img')
      childrenElementType : 'div',
      // ナビゲーション矢印の表示(trueで表示)
      arrows : true,
      // 自動再生時のスライド切替間隔(ミリ秒)
      autoPlayDuration : 4500,
      // キーボードの矢印キーによるスライド送りの設定(trueで有効)
      keyboardOnAlways : false,
      // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
      hidePrevious : false
    });
  });
});