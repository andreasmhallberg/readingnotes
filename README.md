# README

**Important:**

1. **Only some of these notes are complete summaries of the respective reference. Often they only contain notes on what I found interesting in the particular reference.**
3. **The headers with the complete bibliographical reference have yet to be properly formatted. Many still have Swedish formatting and lack italics for titles.** 


## General description

These are my research related reading-notes on books and articles relating to Arabic Linguistics. I continuously add to and edit these notes as I read and re-read things. I have placed them here primarily as a backup and to make them accessible on different devices. I also want to make these notes accessible to colleges and students, although I am not sure how useful they might be.

Since these notes are related to my research there is i focus on:

- Arabic linguistics (quite broadly)
- diglossia
- speech
- language ideology
- eye-tracking
- reading

Not all of these notes are complete summaries and they should not be read as such. I typically only note things that are of interest to what I am doing, meaning that some notes only record a specific detail of a paper or book.

For bibtex references, see the file [`bibliotek.bib`](https://github.com/andreasmhallberg/mylatexstuff/blob/master/bibliotek.bib) in the [`mylatexstuff`](https://github.com/andreasmhallberg/mylatexstuff) repo. This is my general bibtex database where I dump all references without any particular order.

## Directories

**Under evaluation**

The following directories are used to keep the root directory a bit less bloated. Notes of references that does not fit any of the descriptions below are placed in the root folder.

- `eye-tracking`: included here are studies using or discussing eye-tracking techniques, but that do not deal specifically with Arabic.

## Structure and format

Each file contains notes from one single reference. They are formatted in [markdown](https://daringfireball.net/projects/markdown/syntax) (a plain text format similar to .txt). As such they can be easily converted via [Pandoc](http://pandoc.org) or a similar tool to other formats, such as HTML (which is how they are displayed on the GitHub page), .doc, .pdf, or whatever. 

### File name

File names have the following form:

```
<author last name>, <year>. <title>.md
```

For example:

> Ferguson, 1959. Diglossia.md

If there are several authors, the file name only contains the first author, without "et\ al.".

Subtitles are separated from main title with ` - ` rather than the more common `: ` for compatibility reasons. There is some inconsistencies as to whether the subtitle is kept in the file name or not.

### Header

Each file begins with the complete biographical reference in Chicago author-date format as header (i.e. marked with initial `#` in markdown). No other header levels are used. In some notes the header is followed by some general information or comments about the reference.

### Contents

The actual notes referencing the content of the article or book are organized as nested lists. (More than 4 list levels make Pandoc protest and are best avoided.)

Page reference are given at the end of lines. No page reference at the end of a line means that it is on the same page as previous item. 

When the original wording is important (and also when I have been lazy) it is quoted rather then summarized. Longish quotes are in block quotes (marked in markdown with initial `>`) nested (with indentation) under a list item which presents a very brief summary of the quote. This summary of the quote is intended to make the content quickly skimmable.

Material in square brackets are my comments.

Lists and tables are sometimes quoted in markdown format.

### Keywords

At the end of each file one or more keywords are listed. Each keyword begins with `@` and is on a new line. See the file [`keywords.md`](https://github.com/andreasmhallberg/readingnotes/blob/master/Keywords.md) for a list of keywords. 

Hyphens are used in place of spaces in keywords.

Colon is used for sub-keywords. Primarily this is used for varieties of Arabic, e.g. `@Arabic:Egyptian`.

Keywords are added by me and are not those of the original author. There are some inconsistencies in how they are applied.

## Searching

To search for a term in the notes online on the GitHub page, type in the search term at the top of [the repo page](https://github.com/andreasmhallberg/readingnotes) and choose "In this repository".
