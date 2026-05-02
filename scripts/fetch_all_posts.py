#!/usr/bin/env python3
"""Fetch all posts from jerrylove.qzz.io and extract content as markdown files."""
import re
import html
import subprocess
import json
import os

URLS = [
    # Page 1
    ("2026-02-03", "/talks/2026-02-04.md"),
    ("2026-01-25", "/talks/2026-01-26.md"),  # 偶遇 - already done, skip
    ("2026-01-23", "/talks/2026-01-24.md"),
    ("2026-01-13", "/talks/2026-01-14.md"),
    ("2026-01-11", "/talks/2026-01-12.md"),
    ("2026-01-08", "/talks/2026-01-09.md"),
    ("2026-01-03", "/talks/2026-01-04.md"),
    ("2025-12-30", "/talks/2025-12-31.md"),
    ("2025-12-30", "/talks/2025-12-30.md"),
    ("2025-12-26", "/talks/2025-12-26.md"),
    # Page 2
    ("2025-12-16", "/talks/2025-12-16.md"),
    ("2025-12-11", "/talks/2025-12-11.md"),
    ("2025-12-10", "/talks/2025-12-10.md"),
    ("2025-12-04", "/talks/2025-12-4.md"),
    ("2025-12-01", "/talks/2025-12-1.md"),
    ("2025-11-30", "/talks/2025-11-30-talk"),
    ("2025-11-28", "/talks/2025-11-28-talk"),
    ("2025-11-25", "/talks/2025-11-25-talk"),
    ("2025-11-24", "/talks/2025-11-24-talk"),
    ("2025-11-22", "/talks/2025-11-22-talk"),
    # Page 3
    ("2025-11-21", "/talks/2025-11-21-talk"),
    ("2025-11-20", "/talks/2025-11-20-talk"),
    ("2025-11-19", "/talks/2025-11-19-talk"),
    ("2025-11-18", "/talks/2025-11-18-talk"),
    ("2025-11-17", "/talks/2025-11-17-talk"),
    ("2025-10-23", "/talks/2025-9-25-talk"),
    ("2025-10-23", "/talks/2025-10-23-talk"),
    ("2025-09-29", "/2025/09/29/about/"),
    ("2025-09-25", "/talks/2025-9-25-talk"),
    ("2025-09-14", "/talks/2025-9-14-talk"),
    # Page 4
    ("2025-08-31", "/talks/2025-8-31-talk"),
    ("2025-08-25", "/talks/2025-8-25-talk"),
    ("2025-08-20", "/talks/2025-8-20-talk"),
    ("2025-08-18", "/talks/2025-8-18-talk"),
    ("2025-08-15", "/talks/2025-8-15-talk"),
    ("2025-08-11", "/talks/2025-8-11-talk"),
    ("2025-08-09", "/talks/2025-8-9-talk"),
    ("2025-08-07", "/talks/2025-8-7-talk"),
    ("2025-08-06", "/talks/2025-8-6-talk"),
    ("2025-08-04", "/talks/2025-8-4-talk"),
    # Page 5
    ("2025-08-03", "/talks/2025-8-3-talk"),
    ("2025-08-02", "/talks/2025-8-2-talk"),
    ("2025-08-01", "/talks/2025-8-1-1-talk"),
    ("2025-08-01", "/talks/2025-8-1-talk"),
    ("2025-07-30", "/talks/2025-7-30-talk"),
    ("2025-07-29", "/talks/2025-7-29-talk"),
    ("2025-07-28", "/talks/2025-7-28-talk"),
    ("2025-07-27", "/talks/2025-7-27-talk"),
    ("2025-07-26", "/talks/2025-7-26-talk"),
    ("2025-07-24", "/talks/2025-7-24-talk"),
    # Page 6
    ("2025-05-11", "/talks/2025-5-11-talk"),
    ("2025-05-03", "/talks/2025-5-3-talk"),
    ("2025-04-26", "/talks/2025-4-26-talk"),
    ("2025-04-24", "/talks/2025-4-24-talk"),
    ("2025-04-22", "/talks/2025-4-22-talk"),
    ("2025-04-21", "/talks/2025-4-21-talk"),
    ("2025-04-19", "/talks/2025-4-19-talk"),
    ("2025-04-18", "/2025/04/18/AI%E5%9B%BE%E5%83%8F%E5%B7%A5%E5%85%B7/"),
    ("2025-04-18", "/talks/2025-4-18-talk"),
    ("2025-04-18", "/2025/04/18/%E8%AF%BB%E6%B3%B0%E6%88%88%E5%B0%94%E8%AF%97%E4%B8%80%E9%A6%96/"),
    # Page 7
    ("2025-04-17", "/talks/2025-4-17-talk"),
    ("2025-02-11", "/talks/2025-2-11-talk"),
    ("2025-01-09", "/talks/2025-1-9-talk"),
    ("2024-12-26", "/talks/2024-12-26-talk"),
    ("2024-12-21", "/talks/2024-12-21-talk"),
    ("2024-12-12", "/talks/2024-12-12-talk"),
    ("2024-12-11", "/talks/2024-12-11-talk"),
    ("2024-12-10", "/talks/2024-12-10-talk"),
    ("2024-12-09", "/talks/2024-12-9-talk"),
    ("2024-12-02", "/talks/2024-12-2-talk"),
    # Page 8
    ("2024-11-29", "/talks/2024-11-29-talk"),
    ("2024-11-27", "/talks/2024-11-27-talk"),
    ("2024-11-25", "/talks/2024-11-25-talk"),
    ("2024-11-22", "/talks/2024-11-22-talk"),
    ("2024-11-21", "/talks/2024-11-21-talk"),
    ("2024-11-20", "/talks/2024-11-20-talk"),
    ("2024-11-19", "/talks/2024-11-19-talk-2"),
    ("2024-11-19", "/talks/2024-11-19-talk"),
    ("2024-05-08", "/talks/2024-5-8-talk"),
    ("2024-02-10", "/talks/2024-2-10-talk"),
]

BASE_URL = "https://jerrylove.qzz.io"
OUTPUT_DIR = "/workspaces/pastStory/.cache/fetched_posts"


def fetch_post(url):
    """Fetch a single post and extract metadata and body."""
    try:
        result = subprocess.run(
            ["curl", "-sL", "--max-time", "15", url],
            capture_output=True, text=True
        )
        html_content = result.stdout
    except Exception as e:
        print(f"ERROR fetching {url}: {e}")
        return None

    # Extract og:title
    title_match = re.search(r'<meta property="og:title" content="([^"]*)"', html_content)
    title = html.unescape(title_match.group(1)) if title_match else "Untitled"

    # Extract og:description (sometimes has full text)
    desc_match = re.search(r'<meta property="og:description" content="([^"]*)"', html_content)
    description = html.unescape(desc_match.group(1)) if desc_match else ""

    # Extract tags
    tag_matches = re.findall(r'<meta property="article:tag" content="([^"]*)"', html_content)
    tags = [html.unescape(t) for t in tag_matches]

    # Extract post body
    body_match = re.search(
        r'<div class="post-body" itemprop="articleBody">(.*?)</div>\s*</article>',
        html_content, re.DOTALL
    )
    if not body_match:
        # Try alternative: just the post-body div
        body_match = re.search(
            r'<div class="post-body" itemprop="articleBody">(.*?)</div>',
            html_content, re.DOTALL
        )

    raw_body = ""
    if body_match:
        raw_body = body_match.group(1)

    # Strip HTML tags but preserve paragraph breaks
    # Replace </p> and <br> with newlines
    text = re.sub(r'</p>\s*<p[^>]*>', '\n\n', raw_body)
    text = re.sub(r'<br\s*/?>', '\n', text)
    # Remove remaining HTML tags
    text = re.sub(r'<[^>]+>', '', text)
    # Unescape HTML entities
    text = html.unescape(text)
    # Clean up whitespace
    text = re.sub(r'\n{3,}', '\n\n', text)
    text = text.strip()

    # If body is empty but description has content, use description
    if not text and description:
        text = description

    return {
        "title": title,
        "tags": tags,
        "body": text,
        "url": url,
    }


def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    # Skip the one we already processed (偶遇)
    skip_urls = {"/talks/2026-01-26.md"}

    results = []
    for date, path in URLS:
        if path in skip_urls:
            print(f"SKIP (already done): {path}")
            continue

        url = BASE_URL + path
        print(f"FETCH: {url}")
        post = fetch_post(url)
        if post and post["body"]:
            # Create a safe filename
            safe_name = path.strip("/").replace("/", "_").replace(".md", "")
            out_path = os.path.join(OUTPUT_DIR, f"{safe_name}.json")
            post["date"] = date
            post["path"] = path
            with open(out_path, "w") as f:
                json.dump(post, f, ensure_ascii=False, indent=2)
            results.append(post)
            print(f"  OK: {post['title']} ({len(post['body'])} chars)")
        else:
            print(f"  EMPTY or ERROR: {post['title'] if post else 'None'}")

    print(f"\nDone. Fetched {len(results)} posts to {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
