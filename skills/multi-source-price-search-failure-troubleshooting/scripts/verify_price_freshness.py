#!/usr/bin/env python3
import re
from datetime import datetime, timedelta
from urllib.parse import urljoin
import requests
from bs4 import BeautifulSoup

def extract_date_from_html(html, base_url=""):
    """Attempt to extract publication/update date from HTML content."""
    soup = BeautifulSoup(html, 'html.parser')
    
    # Common meta tags
    for attr in ['article:published_time', 'pubdate', 'publishdate', 'date']:
        meta = soup.find('meta', attrs={'property': attr}) or soup.find('meta', attrs={'name': attr})
        if meta and meta.get('content'):
            try:
                return datetime.fromisoformat(meta['content'].rstrip('Z'))
            except:
                pass
    
    # Look for time tags
    time_tag = soup.find('time')
    if time_tag and time_tag.get('datetime'):
        try:
            return datetime.fromisoformat(time_tag['datetime'].rstrip('Z'))
        except:
            pass
    
    # Regex patterns in visible text (simplified)
    patterns = [
        r'(\d{4})[-/年](\d{1,2})[-/月](\d{1,2})日?',
        r'(\d{1,2})[-/](\d{1,2})[-/](\d{4})',
    ]
    
    text = soup.get_text()
    for pattern in patterns:
        match = re.search(pattern, text)
        if match:
            try:
                groups = match.groups()
                if len(groups[0]) == 4:  # YYYY-MM-DD
                    return datetime(int(groups[0]), int(groups[1]), int(groups[2]))
                else:  # MM/DD/YYYY
                    return datetime(int(groups[2]), int(groups[0]), int(groups[1]))
            except:
                continue
    
    return None

def is_result_fresh(url, max_age_days=7):
    """Check if a webpage's content is newer than max_age_days."""
    try:
        headers = {'User-Agent': 'Mozilla/5.0 (compatible; PriceBot/1.0)'}
        resp = requests.get(url, headers=headers, timeout=10)
        resp.raise_for_status()
        
        date = extract_date_from_html(resp.text, url)
        if date:
            age = datetime.now() - date
            return age <= timedelta(days=max_age_days), date
        else:
            # If no date found, assume stale
            return False, None
    except Exception as e:
        print(f"Warning: Failed to fetch {url}: {e}")
        return False, None

# Example usage (uncomment for standalone use)
# if __name__ == "__main__":
#     url = "https://example.com/product-page"
#     fresh, date = is_result_fresh(url, max_age_days=7)
#     print(f"URL: {url}")
#     print(f"Fresh: {fresh}, Date: {date}")
