from PIL import Image
import os

FOLDER = "assets/images"
W, H = 600, 400
MAX_W, MAX_H = int(W * 0.9), int(H * 0.8)

for nama in os.listdir(FOLDER):
    if not nama.lower().endswith(".png"):
        continue
    path = os.path.join(FOLDER, nama)
    img = Image.open(path).convert("RGBA")

    bbox = img.split()[3].getbbox()
    if bbox:
        img = img.crop(bbox)

    skala = min(MAX_W / img.width, MAX_H / img.height)
    img = img.resize(
        (int(img.width * skala), int(img.height * skala)), Image.LANCZOS
    )

    kanvas = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    kanvas.paste(img, ((W - img.width) // 2, (H - img.height) // 2), img)
    kanvas.save(path)
    print("selesai:", nama)