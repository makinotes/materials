"""MkDocs hook: auto-update '最后更新' date from file mtime at build time."""
import os
import re
from datetime import datetime


def on_page_markdown(markdown, page, config, files):
    src_path = page.file.abs_src_path
    real_path = os.path.realpath(src_path)  # resolve symlinks
    mtime = os.path.getmtime(real_path)
    date_str = datetime.fromtimestamp(mtime).strftime("%Y-%m-%d")

    # Replace "> 最后更新：YYYY-MM-DD" or "> 最后更新: YYYY-MM-DD"
    markdown = re.sub(
        r"(>\s*最后更新[：:]\s*)\d{4}-\d{2}-\d{2}",
        rf"\g<1>{date_str}",
        markdown,
    )
    return markdown
