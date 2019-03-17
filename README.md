# Zenrei for Emacs

[zenrei](https://github.com/typewriter/zenrei) client for Emacs.

## What's This

You can use [zenrei](https://github.com/typewriter/zenrei)'s API in Emacs.

![zenrei](https://i.gyazo.com/07e7d6fe8293de85911c043abf00db22.gif)

## Setup

### Requirements

This package requires [posframe.el](https://github.com/tumashu/posframe).  
You need to install `posframe` before.

### Settings

`git clone` and edit your init.el as below.

```elisp
(add-to-list 'load-path "/path/to/zenrei.el")
(require 'zenrei)
```

## Usage

### Search

`M-x zenrei-search RET YOUR_STRING`

### Suggest

`M-x zenrei-suggest RET YOUR_STRING`

### Synonyms

`M-x zenrei-synonyms RET YOUR_STRING`

### Delete posframe

`M-x zenrei-delete`
