# 🎲 Dice Face Counter – Computer Vision with OpenCV

This project implements a simple system in Python that reads an image containing dice and calculates the total number of visible dots (pips) using image processing techniques.

## 📌 Overview

The goal is to use computer vision strategies to identify the circular faces (dots) on each die and compute their sum.

## 🧰 Technologies Used

- Python 3
- OpenCV
- NumPy

## 🧪 Approach

1. Load and convert the input image to HSV.
2. Apply a color filter to isolate the dice.
3. Use Laplacian filtering to detect edges.
4. Detect circles using the Hough Transform.
5. Count the number of detected circles.

## 📂 Project Structure

```
dice_counter_project/
│
├── images/                # Sample images of dice (e.g., img4.jpg)
├── src/
│   └── dice_counter.py    # Main script to run the detection
└── README.md              # Project documentation
```

## ▶️ How to Run

1. Install dependencies:
   ```bash
   pip install opencv-python numpy
   ```

2. Place your input image in the `images/` folder (e.g., `img4.jpg`).

3. Run the script:
   ```bash
   python src/dice_counter.py
   ```

## 🖼️ Example Output

If there are 12 dots visible in total:
```
Total circles detected: 12
```

---

🔙 [Back to Portfolio](https://github.com/anneliseayres/portfolio)
