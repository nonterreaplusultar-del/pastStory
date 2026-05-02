# AGENTS.md — AI Agent Guide

This is a personal memoir project.

## Main rules

- Public memoir content lives in year folders: 2017/, 2018/, 2020/, 2025/, 2026/.
- README.md is the GitBook landing page.
- SUMMARY.md controls the GitBook table of contents.
- drafts/ contains draft content.
- _private/ must never be read, modified, summarized, committed, or referenced.
- Never expose API keys, tokens, passwords, private chats, phone numbers, addresses, or identity documents.

## Writing style

Use sincere, restrained, literary Chinese.

Preserve the author's voice.

Avoid generic motivational writing and obvious AI-style expressions.

## Before publishing

Run:

- ./scripts/check-privacy.sh
- npm run build
- git status

## Default behavior

When uncertain, create a draft instead of modifying public content.
