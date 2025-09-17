# 🎭 IMDB PT-BR Sentiment Dataset – Exploratory Data Analysis

This project analyzes a Brazilian Portuguese version of the IMDB movie reviews dataset. It was developed as part of a Big Data and Distributed Systems course using a virtual machine with **Hadoop**, **Apache Spark**, and **MariaDB**.

> ⚠️ This is a basic **data exploration** project — no machine learning or NLP techniques were applied.

---

## 📚 Dataset Description

The dataset was translated and published by [Luís Fred on Kaggle](https://www.kaggle.com/luisfredgs/imdb-ptbr), containing:

- ~50,000 movie reviews
- Columns:
  - `id` – unique identifier
  - `text_en` – original review (English)
  - `text_pt` – translated review (Portuguese)
  - `sentiment` – sentiment label (`pos` or `neg`)

---

## 🔍 What was done

- Dataset loading and basic inspection
- Sentiment distribution analysis
- Word frequency for positive vs. negative reviews
- Word cloud visualizations
- Storage in MariaDB (optional step in VM)

---

## 🧰 Tech Stack

- Python (Pandas, Matplotlib, Seaborn, WordCloud)
- Google Colab
- MariaDB (via VM)
- Hadoop & Spark (VM environment)

---

## 📁 Repository Structure

| File | Description |
|------|-------------|
| `imdb_ptbr_analysis.ipynb` | Jupyter Notebook with full analysis |
| `data/imdb-reviews-pt-br.zip` | Compressed version of the full dataset (ZIP format) |
| `README.md` | Project overview |

---

## 📎 Notes

- The complete IMDB PT-BR dataset is included in this repository as a ZIP file (/data/imdb_ptbr.zip), originally published on [Kaggle](https://www.kaggle.com/datasets/luisfredgs/imdb-ptbr) by Luís Fred.
- To test locally, use the sample dataset in `/data/`.

---

📁 Back to my [Portfolio](https://github.com/anneliseayres/portfolio)