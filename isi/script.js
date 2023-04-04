function download() {
  const downloadBtn = document.querySelector('.download-btn');
  const loading = document.querySelector('.loading');

  downloadBtn.style.display = 'none';
  loading.style.display = 'block';

  const boong = document.createElement('div');
  boong.classList.add('boong');
  boong.innerText = 'TAPI BOONG!';
  downloadBtn.appendChild(boong);

  setTimeout(() => {
    loading.style.display = 'none';
    alert('Kamu terkena Prenk Ternyata wkwkkw!');
    boong.remove();
    downloadBtn.style.display = 'block';
  }, 3000);
}
