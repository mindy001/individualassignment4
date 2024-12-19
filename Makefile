# Define variables for reuse
WORDCOUNT_SCRIPT = scripts/wordcount.py
PLOTCNT_SCRIPT = scripts/plotcount.py
INPUT_FILES = data/isles.txt data/abyss.txt data/last.txt data/sierra.txt
OUTPUT_FILES = results/isles.dat results/abyss.dat results/last.dat results/sierra.dat
PLOT_FILES = results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png

# Default target (all the tasks to be completed when make is called)
all : report/count_report.html

# Word count for each novel
results/isles.dat : data/isles.txt $(WORDCOUNT_SCRIPT)
	python $(WORDCOUNT_SCRIPT) --input_file=data/isles.txt --output_file=results/isles.dat

results/abyss.dat : data/abyss.txt $(WORDCOUNT_SCRIPT)
	python $(WORDCOUNT_SCRIPT) --input_file=data/abyss.txt --output_file=results/abyss.dat

results/last.dat : data/last.txt $(WORDCOUNT_SCRIPT)
	python $(WORDCOUNT_SCRIPT) --input_file=data/last.txt --output_file=results/last.dat

results/sierra.dat : data/sierra.txt $(WORDCOUNT_SCRIPT)
	python $(WORDCOUNT_SCRIPT) --input_file=data/sierra.txt --output_file=results/sierra.dat

# Generate plots based on word count results
results/figure/isles.png : results/isles.dat $(PLOTCNT_SCRIPT)
	python $(PLOTCNT_SCRIPT) --input_file=results/isles.dat --output_file=results/figure/isles.png

results/figure/abyss.png : results/abyss.dat $(PLOTCNT_SCRIPT)
	python $(PLOTCNT_SCRIPT) --input_file=results/abyss.dat --output_file=results/figure/abyss.png

results/figure/last.png : results/last.dat $(PLOTCNT_SCRIPT)
	python $(PLOTCNT_SCRIPT) --input_file=results/last.dat --output_file=results/figure/last.png

results/figure/sierra.png : results/sierra.dat $(PLOTCNT_SCRIPT)
	python $(PLOTCNT_SCRIPT) --input_file=results/sierra.dat --output_file=results/figure/sierra.png

# Create the final report using quarto (depends on generated plots)
report/count_report.html : report/count_report.qmd $(PLOT_FILES)
	quarto render report/count_report.qmd

# Clean up generated files and reset to the initial state
clean :
	rm -f $(OUTPUT_FILES)
	rm -f $(PLOT_FILES)
	rm -rf report/count_report.html
