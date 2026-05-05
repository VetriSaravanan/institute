# Payitragam Professional Institute — Complete Setup Guide

## Files Included
- `institute_index.html` — Main public website (all sections, Supabase-driven)
- `institute_admin.html` — Full admin dashboard (CRUD for everything)
- `supabase_setup.sql` — Database setup (run once in Supabase SQL Editor)
- `SETUP_GUIDE.md` — This guide

---

## Step 1: Supabase Database Setup

1. Go to [supabase.com](https://supabase.com) → your project
2. Click **SQL Editor** in the left sidebar
3. Click **New query**
4. Paste the entire contents of `supabase_setup.sql`
5. Click **Run** (green button)

This creates all 11 tables, seeds 30+ courses, branches, categories, benefits, and announcements.

---

## Step 2: Create Admin User

1. In Supabase → go to **Authentication** → **Users**
2. Click **Invite user** or **Add user**
3. Enter:
   - Email: `admin@gmail.com`
   - Password: `Admin123@`
4. Click **Create user**

---

## Step 3: Create Storage Buckets

In Supabase → **Storage** → create these buckets (all set to **Public**):

| Bucket Name | Purpose |
|-------------|---------|
| `logos` | School/institute logos |
| `gallery` | Gallery images |
| `course-thumbnails` | Course card images |
| `hero-images` | Hero section backgrounds |

To make each bucket public:
- Click bucket → **Policies** tab → Enable public access for SELECT

---

## Step 4: Supabase Credentials (Already configured)

```
URL:  https://sapxuilhtxlqxrmsskfg.supabase.co
KEY:  sb_publishable_b4HdXx0c6O6kK4lTiTm0OA_EcA7HSfZ
```

Both files already have these credentials embedded.

---

## Step 5: Deploy

### Option A — Netlify Drop (Easiest, Free)
1. Go to [netlify.com/drop](https://app.netlify.com/drop)
2. Drag and drop BOTH html files onto the page
3. Done! You get a live URL instantly

### Option B — GitHub Pages
1. Create a GitHub repository
2. Upload both HTML files
3. Go to Settings → Pages → Deploy from main branch

### Option C — Any Web Host
Upload both HTML files to any web hosting (Hostinger, cPanel, etc.)

---

## Step 6: First Login to Admin

1. Open `institute_admin.html` in browser
2. Login with: `admin@gmail.com` / `Admin123@`
3. Go to **Site Settings** and save your info
4. Upload your logo in Site Settings

---

## Admin Panel Features

### Site Settings
- Edit school name, tagline, phone numbers, email
- Social media links (Facebook, Instagram, YouTube, WhatsApp)
- Logo upload
- **Maintenance Mode Toggle** — one click to show/hide site from visitors

### Maintenance Mode
- Toggle ON/OFF in Site Settings or from Dashboard quick toggle
- Customise maintenance title and message
- When ON: all visitors see the branded maintenance page
- When OFF: full site is visible normally

### Courses Management
- Add/Edit/Delete all 30+ courses
- Filter by type (Certificate, Diploma, Para Medical, B-VOC, Vocational)
- Search by name
- Mark courses as featured
- Upload course thumbnails

### Gallery
- Upload multiple images at once
- Organise by categories (Campus, Events, Students, Certificates)
- Add custom gallery categories
- Delete images

### Enquiries
- View all form submissions
- Mark as read/unread
- Export to CSV
- Unread count badge in sidebar

---

## Public Website Features

### Mobile Navigation
- Professional slide-in drawer on mobile
- Hamburger → X animation
- All links with icons
- Phone numbers + Enquire Now button in drawer footer
- Closes when clicking outside or selecting a link

### Maintenance Page
- Full-screen branded page matching site colours
- Shows custom title and message set from admin
- Contact phone numbers
- Animated progress bar
- Affiliation text

### Course Catalog
- Filter by: All, Certificate, Para Medical, Diploma, B-VOC/M-VOC, Vocational
- Enquiry modal opens with course name pre-filled
- All course data loaded from Supabase

---

## Support
- Phone: 9003845060 / 9952740025
- Email: payitragam@gmail.com
