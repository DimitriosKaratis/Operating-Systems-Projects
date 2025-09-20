# Operating Systems – Quizzes

This repository contains the implementation of four quizzes for the **Operating Systems** course at the **Department of Electrical and Computer Engineering, Aristotle University of Thessaloniki**, along with some lab work for this class.  

The quizzes cover fundamental shell scripting, file management, user handling, Git usage, and signal processing in C. Each quiz was designed to provide hands-on experience with Linux command-line tools and system-level programming.

---

## 📊 Quizzes Overview

### 🔹 Quiz 1 – Shell File Operations
- Compute the single-digit sum of the student ID (AEM).  
- Create a folder `quiz-1/` and generate `10+N` random files with randomized names.  
- Fill each file with `N+10` randomly chosen words from the set `{super, spider, bat}`.  
- Count word occurrences and produce a `report.txt` with the statistics.  
- Save all commands used into `quiz-1.txt`, enabling reproducibility by copy/paste.  

### 🔹 Quiz 2 – User Login History Script
- Bash/Fish script that reads a list of usernames from `usernames.txt`.  
- For each user, display:  
  1. Up to the last 20 login dates.  
  2. Up to the last 20 login IPs and hostnames.  
- The script can take `usernames.txt` as a command-line argument or use an internally declared variable.  

### 🔹 Quiz 3 – User File Search Script
- Bash/Fish script that takes two arguments:  
  1. A file containing usernames (e.g., `usernames.txt`).  
  2. A filename to search for in each user’s home directory.  
- For each user, the script outputs:  
  - **“File not found”** if the file does not exist.  
  - **“Permission denied”** if there is no access to the home directory.  
  - **“File found, size xxxx bytes”** if the file exists.  

### 🔹 Quiz 4 – Git & Signals
#### Part A: Git Exercise
- Create a repository `GitHashingExercise`.  
- Generate a unique 4-digit integer (e.g., last digits of student ID).  
- Implement `hash_script` to compute a hash (e.g., SHA-256) of the integer.  
- Save the result in `hash_output.txt`.  
- Use Git to add, commit, and push the files to GitHub.  

#### Part B: Signals in C
- `mysigcatch.c`: C program that catches **SIGINT** (`Ctrl+C`) and prints *"SIGINT signal caught!"*.  
- `mysigcatchmodified.c`: Enhanced version with a custom handler:  
  - Prints the signal number and a custom message.  
  - After catching **SIGINT** twice, restores default behavior and exits on the next signal.  
- Summaries for `/tmp/lab04/examples{1-5}.c`:  
  - Description of execution.  
  - Example usage and expected output.  
  - Brief explanation of the C code functionality.  
