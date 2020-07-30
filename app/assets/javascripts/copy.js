// コピーボックス
function copyToClipboard() {
  let copyTarget = document.getElementById("copyTarget");
  copyTarget.select();
  document.execCommand("Copy");
  alert("コピーできました！URL入力欄に貼り付けてみましょう！");
}