# 

## Team members

* Jiapan Wang    #29322674
* Hanliang Liu   #86009776
* Catherine Cai  #52204310
* Jack Guo       #57752750


## Description of the data 

We want to explore how the customers' purchase be affected.
Here we have 2240 observations with 9 predictor variables and one response variable.
The 9 predictor variables are ID, Year_Birth, Education, Marital_Status, Income, Kidhome,
Teenhome, Dt_Customer and Recency, which is the number of days since last purchase. The response variable is the amount spent on wine.


## Precise description of the question(s)

We are going to explore how the aspects that affect the amount spent on wine. And we are aiming to find out the best model that fits with given variables.

**TA comment: you said the response variable is recency, which conflicts with 'We are going to explore how the aspects that affect the amount spent on wine.' Please discuss within your team and decide on which one is the actual response variable based on your question.**

## Why this question/dataset

It would be a positive help that knowing the relationship between salary and purchasing power in future career. Besides, the data looks nice to be analyzed.

## Reading list 

1. A quick view to the data and the description, be familiar with the datasets and factors.
   (https://www.kaggle.com/imakash3011/customer-personality-analysis?select=marketing_campaign.csv)
2. Books recommended by this class:The Element of statistical learning, An Introduction to Statistical learing.
   Be familiar with the course material and tools for the further analysis.
   
## Team contract. 

For each area, write 1-2 sentences and including any rules to which your team collectively agrees (e.g. "We agree to make 1 commit per week." or "We agree to meet in the library every other Friday.")

**Participation**  
We agree that each member of our team will make contribution to our final product.

**Communication**  
We agree to interact and consult with every team members for each part of our project.

**Meetings**  
We agree to make at least 1 committee per week to discuss our project..

**Conduct**  
We agree to meet in the library or online every week and finish each part efficiently before the deadline.


***
Do not make any changes from here on. Only the TAs will edit the following.


# Checkpoint 1 grade

(5 / 5)



# Checkpoint 2 grade

__Total__ (27 / 30)

__Words__ (6 / 6) The text is laid out cleanly, with clear divisions
and transitions between sections and sub-sections. The writing itself
is well-organized, free of grammatical and other mechanical errors,
divided into complete sentences logically grouped into paragraphs and
sections, and easy to follow from the presumed level of knowledge. 

__Numbers__ (1 / 1) All numerical results or summaries are reported to
suitable precision, and with appropriate measures of uncertainty
attached when applicable. 

__Pictures__ (6 / 7) Figures and ~tables~ are easy to read, with
informative captions, axis labels and legends, and are placed near the
relevant pieces of text or referred to with convenient labels. 

__Code__ (4 / 4) The code is formatted and organized so that it is easy
for others to read and understand. It is indented, commented, and uses
meaningful names. It only includes computations which are actually
needed to answer the analytical questions, and avoids redundancy. Code
borrowed from the notes, from books, or from resources found online is
explicitly acknowledged and sourced in the comments. Functions or
procedures not directly taken from the notes have accompanying tests
which check whether the code does what it is supposed to. The text of
the report is free of intrusive blocks of code. With regards to R Markdown,
all calculations are actually done in the file as it knits, and only
relevant results are shown.

__Exploratory data analysis__ (10 / 12) Variables are examined individually and
bivariately. Features/observations are ~discussed~ with appropriate
figure or tables. ~The relevance of the EDA to the questions~ and
potential models is clearly explained.

## Comments:

1. Why are those selected explanatory variables are plausible for making plots?
Should give more explanations about this selection. And it's good to make a summary
table for summarizing the dataset but not listing all of them. 
2. Expected more explanations after the plots for plausible explanatory variables. What
do you find after plotting them? What conclusion can you make after the correlation plots?
It's better to use a heatmap to demonstrate the correlations for continuous variable. 
3. Table for AICs are from the raw outputs directly and they are running out of the margin.
Better to summarize them by yourselves and only extract what you are interested in.
4. What do you conclude after the risk against models? 

# Checkpoint 3 grade

__Total__ (65 / 65)

__Words__ (8 / 8) The text is laid out cleanly, with clear divisions and
transitions between sections and sub-sections.  The writing itself is
well-organized, free of grammatical and other mechanical errors, divided into
complete sentences logically grouped into paragraphs and sections, and easy to
follow from the presumed level of knowledge.

__Numbers__ (1 / 1) All numerical results or summaries are reported to
suitable precision, and with appropriate measures of uncertainty attached when
applicable.

__Pictures__ (7 / 7) Figures and tables are easy to read, with informative
captions, axis labels and legends, and are placed near the relevant pieces of
text.

__Code__ (4 / 4) The code is formatted and organized so that it is easy
for others to read and understand.  It is indented, commented, and uses
meaningful names.  It only includes computations which are actually needed to
answer the analytical questions, and avoids redundancy.  Code borrowed from the
notes, from books, or from resources found online is explicitly acknowledged
and sourced in the comments.  Functions or procedures not directly taken from
the notes have accompanying tests which check whether the code does what it is
supposed to. The text of the report is free of intrusive blocks of code.  If
you use R Markdown, all calculations are actually done in the file as it knits,
and only relevant results are shown. 

__Exploratory Data Analysis__ (12 / 12) Variables are examined individually and
bivariately. Features/observations are discussed with appropriate
figure or tables. The relevance of the EDA to the questions and
potential models is clearly explained.

__Results and analysis__ (25 / 25) The statistical summaries
are clearly related to, or possibly derive from, the substantive questions of interest.  Any
assumptions are checked by means of appropriate diagnostic plots or
formal tests. Limitations from un-fixable problems are
clearly noted. The actual estimation
of parameters, predictions, or other calculations are technically correct.  All calculations
based on estimates are clearly explained, and also technically correct.  All
estimates or derived quantities are accompanied with appropriate measures of
uncertainty. 

__Conclusions__ (8 / 8) The substantive questions are answered as
precisely as the data and the model allow.  The chain of reasoning from
estimation results about models, or derived quantities, to substantive
conclusions is both clear and convincing.  Contingent answers ("if $X$, then
$Y$, but if $Z$, then $W$") are likewise described as warranted by the
and data.  If uncertainties in the data mean the answers to some
questions must be imprecise, this too is reflected in the conclusions.
