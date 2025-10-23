# Deployment Setup Guide

This document explains how to configure GitHub Pages and custom domain for the RubyWorld Conference 2025 slides.

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                      GitHub Repository                       │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Main Branch (production)                                   │
│  ├─ Triggers: deploy-production.yml                         │
│  └─ Deploys to: rwc2025.ryudo.tw                           │
│                                                              │
│  Pull Requests (preview)                                    │
│  ├─ Triggers: preview-pr.yml                                │
│  └─ Generates: Downloadable artifact                        │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Step 1: GitHub Pages Configuration

### 1.1 Enable GitHub Pages

1. Go to your GitHub repository
2. Click **Settings** (top navigation)
3. Click **Pages** (left sidebar)
4. Under **Source**, select **GitHub Actions**
   - ⚠️ **NOT** "Deploy from a branch"
   - ✅ Select **"GitHub Actions"**

Screenshot example:
```
Settings > Pages > Source
  ○ Deploy from a branch
  ● GitHub Actions  ← Select this
```

### 1.2 Configure Custom Domain (Optional but Recommended)

In the same **Pages** settings:

1. Under **Custom domain**, enter: `rwc2025.ryudo.tw`
2. Click **Save**
3. Wait for DNS check to complete
4. Enable **Enforce HTTPS** (checkbox)

## Step 2: DNS Configuration

Configure DNS records for your domain `ryudo.tw`.

### Option A: CNAME Record (Recommended)

```
Type:  CNAME
Name:  rwc2025
Value: <your-github-username>.github.io
TTL:   3600 (or default)
```

Example:
```
Type:  CNAME
Name:  rwc2025
Value: ryudo.github.io
```

### Option B: A Records (Alternative)

If CNAME doesn't work, use A records:

```
Type:  A
Name:  rwc2025
Value: 185.199.108.153

Type:  A
Name:  rwc2025
Value: 185.199.109.153

Type:  A
Name:  rwc2025
Value: 185.199.110.153

Type:  A
Name:  rwc2025
Value: 185.199.111.153
```

### DNS Verification

After configuring DNS, verify with:

```bash
# Check CNAME
dig rwc2025.ryudo.tw CNAME

# Check A records
dig rwc2025.ryudo.tw A

# Check if DNS propagated
nslookup rwc2025.ryudo.tw
```

⏰ DNS propagation can take **5 minutes to 48 hours**.

## Step 3: Workflow Files

Two workflow files are included in `.github/workflows/`:

### 3.1 Production Deployment (`deploy-production.yml`)

**Triggers on:**
- Push to `main` branch
- Changes to `*.md`, `5xruby.css`, or `images/**`

**Actions:**
1. Checkout code
2. Install Marp CLI
3. Generate HTML from `rubyworld-2025-taigi-parser.md`
4. Deploy to GitHub Pages

**Deployment URL:**
- Primary: `https://rwc2025.ryudo.tw` (custom domain)
- Fallback: `https://<username>.github.io/rwc2025-slide/`

### 3.2 PR Preview (`preview-pr.yml`)

**Triggers on:**
- Pull request opened/updated
- Changes to `*.md`, `5xruby.css`, or `images/**`

**Actions:**
1. Checkout PR branch
2. Install Marp CLI
3. Generate HTML preview
4. Upload as artifact (30-day retention)
5. Comment on PR with download link

**Preview Access:**
- Download artifact from Actions tab
- Extract and open `index.html` locally

## Step 4: Testing the Setup

### 4.1 Test Production Deployment

1. Make a small change to `rubyworld-2025-taigi-parser.md` on `main` branch
2. Push to GitHub
3. Go to **Actions** tab
4. Watch the **"Deploy to Production"** workflow
5. Once completed, visit `https://rwc2025.ryudo.tw`

### 4.2 Test PR Preview

1. Create a new branch: `git checkout -b test-preview`
2. Make a small change to any slide
3. Push and create a Pull Request
4. Check the PR for automated comment
5. Download the artifact from Actions tab
6. Open `index.html` to preview

## Step 5: Troubleshooting

### DNS Not Resolving

**Problem:** Custom domain shows 404 or DNS error

**Solutions:**
1. Wait longer (DNS propagation takes time)
2. Check DNS records are correctly configured
3. In GitHub Pages settings, remove and re-add custom domain
4. Clear your browser cache: `Ctrl+Shift+R` (Windows) / `Cmd+Shift+R` (Mac)

### Workflow Fails

**Problem:** GitHub Actions workflow shows red X

**Solutions:**
1. Check **Actions** tab for error logs
2. Common issues:
   - Missing permissions (check `permissions:` in workflow)
   - Invalid Marp syntax in markdown
   - Missing image files
3. Re-run failed workflow: Click "Re-run jobs"

### HTTPS Certificate Error

**Problem:** "Your connection is not private" warning

**Solutions:**
1. Wait 24 hours for certificate provisioning
2. Ensure **Enforce HTTPS** is checked in Pages settings
3. GitHub provisions Let's Encrypt certificates automatically

### Artifact Not Available

**Problem:** Can't download preview from PR

**Solutions:**
1. Check workflow completed successfully (green checkmark)
2. Artifacts expire after 30 days
3. Download from: Repo → Actions → Select workflow run → Scroll to "Artifacts"

## File Structure

```
rwc2025-slide/
├── .github/
│   └── workflows/
│       ├── deploy-production.yml    # Main branch → Production
│       └── preview-pr.yml           # PR → Artifact preview
├── images/                          # Slide images
├── experimental/                    # Parser implementations
├── test_data/                      # Test datasets
├── rubyworld-2025-taigi-parser.md  # Main slide file
├── 5xruby.css                      # Custom theme
├── DEPLOYMENT.md                   # This file
└── README.md                       # Project documentation
```

## Workflow Permissions

Both workflows require these permissions:

### Production Workflow
```yaml
permissions:
  contents: read      # Read repository
  pages: write        # Deploy to Pages
  id-token: write     # OIDC token for deployment
```

### PR Preview Workflow
```yaml
permissions:
  contents: read      # Read repository
  pull-requests: write # Comment on PR
```

## Security Notes

1. **No secrets required** - Workflows use GitHub's built-in tokens
2. **HTTPS enforced** - All production traffic uses TLS
3. **Limited permissions** - Each workflow has minimal required permissions
4. **Artifact retention** - PR previews auto-delete after 30 days

## URLs Summary

| Environment | URL | Trigger | Deployment Method |
|-------------|-----|---------|-------------------|
| **Production** | `https://rwc2025.ryudo.tw` | Push to `main` | GitHub Pages |
| **Production (fallback)** | `https://ryudo.github.io/rwc2025-slide/` | Push to `main` | GitHub Pages |
| **PR Preview** | Download artifact | Pull Request | Artifact upload |

## Maintenance

### Update Slide Content
1. Edit `rubyworld-2025-taigi-parser.md`
2. Commit and push to `main`
3. Deployment happens automatically

### Update Theme
1. Edit `5xruby.css`
2. Commit and push to `main`
3. Deployment happens automatically

### Add Images
1. Add files to `images/` directory
2. Reference in markdown: `![alt](images/filename.png)`
3. Commit and push

## Support

For issues related to:
- **GitHub Actions**: Check [GitHub Status](https://www.githubstatus.com/)
- **DNS Configuration**: Contact your DNS provider
- **Marp CLI**: See [Marp CLI Documentation](https://github.com/marp-team/marp-cli)
- **Project-specific**: Open an issue in this repository

---

**Last Updated:** 2025-10-23
**Maintained by:** 5xRuby Development Team
