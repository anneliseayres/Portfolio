# Project developed for the Computer Vision course in the Data Science program at Uninter University – Dice Face Counter

#Imported libraries
import cv2
import numpy as np

# Load the image
imgOrig = cv2.imread("images/img1.jpg")

# Convert the image to HSV
imgHSV = cv2.cvtColor(imgOrig, cv2.COLOR_BGR2HSV)

# Define the HSV range for the dice color (purple in this case)
minimum = np.array([100, 50, 50])
maximum = np.array([255, 90, 255])

# Create a binary mask
mask = cv2.inRange(imgHSV, minimum, maximum)

# Apply Laplacian filter
imgLaplace = cv2.Laplacian(mask, cv2.CV_8U)

# Detect circles using Hough Circle Transform
circles = cv2.HoughCircles(imgLaplace, cv2.HOUGH_GRADIENT, dp=1.2, minDist=10, param1=50, param2=20, minRadius=5, maxRadius=13)

# Count and print the number of detected circles
if circles is not None:
  circles = np.round(circles[0, :]).astype("int")
  total_sum = 0

  # Draw the detected circles on the original image
  for (x, y, r) in circles:
    cv2.circle(imgOrig, (x, y), r, (0, 255, 0), 2)  # green circle
    total_sum +=1
  print(f"Total circles detected: {total_sum}")

  # Show the image with the circles and the total
  try:
    from google.colab.patches import cv2_imshow
    cv2_imshow(imgOrig)
  except ImportError:
    cv2.imshow("Detected Dice", imgOrig)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
else:
  print("No circles detected.")