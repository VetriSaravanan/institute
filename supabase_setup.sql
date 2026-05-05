-- ================================================================
-- PAYITRAGAM PROFESSIONAL INSTITUTE — SUPABASE SETUP
-- Run entirely in Supabase SQL Editor
-- ================================================================

-- 1. SITE SETTINGS
CREATE TABLE IF NOT EXISTS inst_site_settings (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  institute_name text DEFAULT 'Payitragam Professional Institute',
  tagline text DEFAULT 'E for Education, P for Payitragam',
  logo_url text DEFAULT '',
  phone1 text DEFAULT '9003845060',
  phone2 text DEFAULT '9952740025',
  email text DEFAULT 'payitragam@gmail.com',
  wa_number text DEFAULT '919003845060',
  fb_url text DEFAULT '#',
  ig_url text DEFAULT '#',
  yt_url text DEFAULT '#',
  affiliation text DEFAULT 'Affiliated to Tamilnadu State Council of Professional Education, Approved by Central and State Government',
  updated_at timestamptz DEFAULT now()
);

-- 2. HERO CONTENT
CREATE TABLE IF NOT EXISTS inst_hero_content (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  headline text DEFAULT 'Build Your Career in Healthcare',
  subheadline text DEFAULT 'Government Certified Courses with 100% Job Placement Assistance. Stipend During Training · Safe Hostel Facility',
  cta1_text text DEFAULT 'Explore Courses',
  cta1_link text DEFAULT '#courses',
  cta2_text text DEFAULT 'Enquire Now',
  cta2_link text DEFAULT '#contact',
  hero_bg_url text DEFAULT '',
  stat_courses int DEFAULT 30,
  stat_placement int DEFAULT 100,
  stat_branches int DEFAULT 2,
  stat_students int DEFAULT 1000,
  updated_at timestamptz DEFAULT now()
);

-- 3. ABOUT CONTENT
CREATE TABLE IF NOT EXISTS inst_about_content (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  story text DEFAULT 'Payitragam Professional Institute is affiliated to Tamilnadu State Council of Professional Education and approved by Central and State Government and Ministry of Corporate Affairs. We offer industry-leading para-medical, vocational, and healthcare courses with guaranteed job placement assistance.',
  mission text DEFAULT 'To empower students with practical skills, government-certified qualifications, and real employment opportunities in the healthcare and vocational sectors.',
  vision text DEFAULT 'To become the most trusted professional training institute across Tamil Nadu with 100% placement guarantee.',
  affiliation_badges jsonb DEFAULT '["TNSCPE Affiliated","Ministry of Corporate Affairs","Central Govt Approved","State Govt Approved"]',
  updated_at timestamptz DEFAULT now()
);

-- 4. COURSE CATEGORIES
CREATE TABLE IF NOT EXISTS inst_course_categories (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text NOT NULL,
  slug text UNIQUE NOT NULL,
  color_hex text DEFAULT '#1565c0',
  icon text DEFAULT '📚',
  order_index int DEFAULT 0
);

-- 5. COURSES
CREATE TABLE IF NOT EXISTS inst_courses (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text NOT NULL,
  slug text UNIQUE NOT NULL,
  category_id uuid REFERENCES inst_course_categories(id) ON DELETE SET NULL,
  duration text NOT NULL,
  qualification text NOT NULL,
  description text DEFAULT '',
  thumbnail_url text DEFAULT '',
  course_type text DEFAULT 'Diploma' CHECK (course_type IN ('Certificate','Diploma','Para Medical','Vocational','B-VOC','M-VOC')),
  is_featured boolean DEFAULT false,
  order_index int DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- 6. BENEFITS
CREATE TABLE IF NOT EXISTS inst_benefits (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  icon text DEFAULT '✅',
  title text NOT NULL,
  description text DEFAULT '',
  color_hex text DEFAULT '#1565c0',
  order_index int DEFAULT 0
);

-- 7. BRANCHES
CREATE TABLE IF NOT EXISTS inst_branches (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  branch_name text NOT NULL,
  address text NOT NULL,
  phone text DEFAULT '',
  map_embed_url text DEFAULT '',
  order_index int DEFAULT 0
);

-- 8. GALLERY CATEGORIES
CREATE TABLE IF NOT EXISTS inst_gallery_categories (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text NOT NULL,
  slug text UNIQUE NOT NULL,
  order_index int DEFAULT 0
);

-- 9. GALLERY IMAGES
CREATE TABLE IF NOT EXISTS inst_gallery_images (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  image_url text NOT NULL,
  caption text DEFAULT '',
  category_id uuid REFERENCES inst_gallery_categories(id) ON DELETE SET NULL,
  order_index int DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- 10. ANNOUNCEMENTS
CREATE TABLE IF NOT EXISTS inst_announcements (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  title text NOT NULL,
  description text DEFAULT '',
  badge_color text DEFAULT '#1565c0',
  is_pinned boolean DEFAULT false,
  announcement_date date DEFAULT CURRENT_DATE,
  created_at timestamptz DEFAULT now()
);

-- 11. ENQUIRIES
CREATE TABLE IF NOT EXISTS inst_enquiries (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text NOT NULL,
  phone text NOT NULL,
  email text DEFAULT '',
  course_name text DEFAULT '',
  message text DEFAULT '',
  is_read boolean DEFAULT false,
  created_at timestamptz DEFAULT now()
);

-- ================================================================
-- ROW LEVEL SECURITY
-- ================================================================
ALTER TABLE inst_site_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE inst_hero_content ENABLE ROW LEVEL SECURITY;
ALTER TABLE inst_about_content ENABLE ROW LEVEL SECURITY;
ALTER TABLE inst_course_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE inst_courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE inst_benefits ENABLE ROW LEVEL SECURITY;
ALTER TABLE inst_branches ENABLE ROW LEVEL SECURITY;
ALTER TABLE inst_gallery_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE inst_gallery_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE inst_announcements ENABLE ROW LEVEL SECURITY;
ALTER TABLE inst_enquiries ENABLE ROW LEVEL SECURITY;

-- Public READ
CREATE POLICY "pub_read_settings" ON inst_site_settings FOR SELECT USING (true);
CREATE POLICY "pub_read_hero" ON inst_hero_content FOR SELECT USING (true);
CREATE POLICY "pub_read_about" ON inst_about_content FOR SELECT USING (true);
CREATE POLICY "pub_read_categories" ON inst_course_categories FOR SELECT USING (true);
CREATE POLICY "pub_read_courses" ON inst_courses FOR SELECT USING (true);
CREATE POLICY "pub_read_benefits" ON inst_benefits FOR SELECT USING (true);
CREATE POLICY "pub_read_branches" ON inst_branches FOR SELECT USING (true);
CREATE POLICY "pub_read_gal_cats" ON inst_gallery_categories FOR SELECT USING (true);
CREATE POLICY "pub_read_gal_imgs" ON inst_gallery_images FOR SELECT USING (true);
CREATE POLICY "pub_read_ann" ON inst_announcements FOR SELECT USING (true);
-- Public INSERT for enquiries (contact form)
CREATE POLICY "pub_insert_enquiries" ON inst_enquiries FOR INSERT WITH CHECK (true);
-- Authenticated FULL ACCESS
CREATE POLICY "auth_all_settings" ON inst_site_settings FOR ALL USING (auth.role()='authenticated');
CREATE POLICY "auth_all_hero" ON inst_hero_content FOR ALL USING (auth.role()='authenticated');
CREATE POLICY "auth_all_about" ON inst_about_content FOR ALL USING (auth.role()='authenticated');
CREATE POLICY "auth_all_categories" ON inst_course_categories FOR ALL USING (auth.role()='authenticated');
CREATE POLICY "auth_all_courses" ON inst_courses FOR ALL USING (auth.role()='authenticated');
CREATE POLICY "auth_all_benefits" ON inst_benefits FOR ALL USING (auth.role()='authenticated');
CREATE POLICY "auth_all_branches" ON inst_branches FOR ALL USING (auth.role()='authenticated');
CREATE POLICY "auth_all_gal_cats" ON inst_gallery_categories FOR ALL USING (auth.role()='authenticated');
CREATE POLICY "auth_all_gal_imgs" ON inst_gallery_images FOR ALL USING (auth.role()='authenticated');
CREATE POLICY "auth_all_ann" ON inst_announcements FOR ALL USING (auth.role()='authenticated');
CREATE POLICY "auth_all_enquiries" ON inst_enquiries FOR ALL USING (auth.role()='authenticated');

-- ================================================================
-- SEED DATA
-- ================================================================

-- Site Settings
INSERT INTO inst_site_settings (institute_name, tagline, phone1, phone2, email, wa_number, affiliation)
VALUES ('Payitragam Professional Institute','E for Education, P for Payitragam','9003845060','9952740025','payitragam@gmail.com','919003845060','Affiliated to Tamilnadu State Council of Professional Education, Approved by Central and State Government')
ON CONFLICT DO NOTHING;

-- Hero
INSERT INTO inst_hero_content (headline, subheadline, stat_courses, stat_placement, stat_branches, stat_students)
VALUES ('Build Your Career in Healthcare & Beyond','Government Certified Courses · 100% Job Placement Assistance · Stipend During Training · Safe Hostel Facility',30,100,2,1000)
ON CONFLICT DO NOTHING;

-- About
INSERT INTO inst_about_content (story, mission, vision)
VALUES ('Payitragam Professional Institute is affiliated to Tamilnadu State Council of Professional Education and approved by Central and State Government and Ministry of Corporate Affairs. We offer industry-leading para-medical, vocational, and healthcare courses with guaranteed job placement assistance and stipend support.',
'To empower students with practical skills, government-certified qualifications, and real employment opportunities in the healthcare and vocational sectors.',
'To become the most trusted professional training institute across Tamil Nadu with 100% placement guarantee.')
ON CONFLICT DO NOTHING;

-- Branches
-- map_embed_url derived from user-provided short links:
--   Branch 1: https://maps.app.goo.gl/CpDQAqGSBzSoaM9YA  → lat 8.7382652, lng 77.7103902
--   Branch 2: https://maps.app.goo.gl/k3SoQ3nE4tsHftkp9  → lat 8.7074811, lng 77.7461936
INSERT INTO inst_branches (branch_name, address, phone, map_embed_url, order_index) VALUES
(
  'Tirunelveli Branch 1',
  '122A, 6th Cross Street, South Balabkiya Nagar, Junction, Tirunelveli - 627001',
  '9003845060',
  'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3943!2d77.7103902!3d8.7382652!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sin!4v1746400000000',
  1
),
(
  'Tirunelveli Town Branch',
  '22A, South Car Street, Town, Tirunelveli - 627006',
  '9952740025',
  'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3943!2d77.7461936!3d8.7074811!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sin!4v1746400000000',
  2
)
ON CONFLICT DO NOTHING;

-- If branches already exist, run these to update the map URLs:
UPDATE inst_branches SET map_embed_url='https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3943!2d77.7103902!3d8.7382652!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sin!4v1746400000000' WHERE order_index=1;
UPDATE inst_branches SET map_embed_url='https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3943!2d77.7461936!3d8.7074811!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sin!4v1746400000000' WHERE order_index=2;

-- Benefits
INSERT INTO inst_benefits (icon, title, description, color_hex, order_index) VALUES
('🏛️','Government Certified','Central & State Government recognized certificate with national validity','#1565c0',1),
('💰','Stipend During Training','Earn while you learn with stipend support throughout your course duration','#00b4d8',2),
('🏠','Safe Hostel Facility','Secure and comfortable hostel accommodation available for outstation students','#1a1a6e',3),
('🎯','100% Job Placement','Guaranteed job placement assistance with our extensive hospital and industry network','#e63946',4),
('🎓','Expert Faculty','Experienced, certified trainers with real-world healthcare and industry expertise','#0f766e',5),
('📋','Practical Training','Hands-on clinical and field training integrated with theoretical curriculum','#7c3aed',6)
ON CONFLICT DO NOTHING;

-- Course Categories
INSERT INTO inst_course_categories (name, slug, color_hex, icon, order_index) VALUES
('Certificate','certificate','#0f766e','📜',1),
('Para Medical','para-medical','#e63946','🏥',2),
('Diploma','diploma','#1565c0','🎓',3),
('B-VOC / M-VOC','bvoc-mvoc','#7c3aed','🏆',4),
('Vocational','vocational','#d97706','🛠️',5)
ON CONFLICT (slug) DO NOTHING;

-- Gallery Categories
INSERT INTO inst_gallery_categories (name, slug, order_index) VALUES
('All','all',0),('Campus','campus',1),('Events','events',2),('Students','students',3),('Certificates','certificates',4)
ON CONFLICT (slug) DO NOTHING;

-- Announcements
INSERT INTO inst_announcements (title, description, badge_color, is_pinned, announcement_date) VALUES
('Admissions Open 2025-26!','New batch starting soon for all para-medical and vocational courses. Limited seats available!','#e63946',true,CURRENT_DATE),
('100% Placement Drive - June 2025','Campus placement drive scheduled for June 2025. 15+ hospitals participating.','#1565c0',false,CURRENT_DATE),
('Stipend Update','All enrolled students are now eligible for monthly stipend during training period.','#0f766e',false,CURRENT_DATE)
ON CONFLICT DO NOTHING;

-- COURSES: Certificate
WITH cat AS (SELECT id FROM inst_course_categories WHERE slug='certificate' LIMIT 1)
INSERT INTO inst_courses (name, slug, category_id, duration, qualification, description, course_type, order_index)
SELECT name, slug, cat.id, duration, qualification, description, 'Certificate', ord FROM cat, (VALUES
('Emergency Medical Technician','emergency-medical-technician','8 Months','12th','Train as a front-line EMT with hands-on emergency care skills and real ambulance experience.',1),
('Medical Nursing Assistant / GDA','medical-nursing-assistant-gda','6 Months','10th','Become a skilled General Duty Assistant with patient care, vital monitoring, and hospital support training.',2),
('Blood Bank Technician','blood-bank-technician','6 Months','12th (PCB)','Specialized training in blood collection, storage, typing, and laboratory procedures.',3),
('Dental Assistant','dental-assistant','6 Months','12th','Assist dentists in clinical procedures, sterilization, patient care, and dental office operations.',4),
('ECG Assistant','ecg-assistant','3 Months','12th','Learn to perform and interpret ECG recordings in clinical settings under physician supervision.',5),
('Patient Relations Associate','patient-relations-associate','9 Months','Graduate','Manage patient communication, medical records, billing, and hospital front-desk operations.',6),
('Pharmacy Assistant','pharmacy-assistant','6 Months','12th (PCB)','Support licensed pharmacists in dispensing, stock management, and patient medication counseling.',7),
('Phlebotomy Technician','phlebotomy-technician','6 Months','12th (PCB)','Master blood collection techniques, specimen handling, and laboratory safety protocols.',8),
('Physiotherapy Assistant','physiotherapy-assistant','7 Months','12th (PCB/PCM)','Assist physiotherapists with patient exercise programs, physical rehabilitation, and equipment operation.',9),
('Medical Dresser','medical-dresser','11 Months','10th','Learn wound care, dressing techniques, sterilization, and basic clinical assistance in hospitals.',10)
) AS v(name,slug,duration,qualification,description,ord)
ON CONFLICT (slug) DO NOTHING;

-- COURSES: Para Medical
WITH cat AS (SELECT id FROM inst_course_categories WHERE slug='para-medical' LIMIT 1)
INSERT INTO inst_courses (name, slug, category_id, duration, qualification, description, course_type, order_index)
SELECT name, slug, cat.id, duration, qualification, description, 'Para Medical', ord FROM cat, (VALUES
('Diploma in Nursing Assistant','diploma-nursing-assistant','2 Years','10th Standard Pass','Government certified diploma with stipend support. Training in patient care, medication, and hospital protocols.',11),
('Diploma in Health Care Assistant','diploma-health-care-assistant','2 Years','10th Standard Pass','Comprehensive healthcare assistance training with clinical placement and job guarantee.',12),
('Diploma in Medical Lab Technology','diploma-medical-lab-technology','2 Years','10th Standard Pass','Lab skills including sample collection, testing, and analysis with practical hospital training.',13),
('Diploma in CT Scan Technology','diploma-ct-scan-technology','2 Years','10th Standard Pass','Operate CT scan equipment, understand imaging principles, and assist radiologists in diagnosis.',14),
('Diploma in Pharmacy Assistant','diploma-pharmacy-assistant','2 Years','10th Standard Pass','Pharmacy operations, drug dispensing, inventory management, and patient counseling training.',15),
('Diploma in X-RAY Technology','diploma-xray-technology','2 Years','10th Standard Pass','Radiographic imaging, X-ray machine operation, safety protocols, and film processing training.',16),
('Diploma in Operation Theatre Technology','diploma-ot-technology','2 Years','10th Standard Pass','OT instruments, surgical assistance, sterile techniques, and anesthesia support training.',17)
) AS v(name,slug,duration,qualification,description,ord)
ON CONFLICT (slug) DO NOTHING;

-- COURSES: Diploma
WITH cat AS (SELECT id FROM inst_course_categories WHERE slug='diploma' LIMIT 1)
INSERT INTO inst_courses (name, slug, category_id, duration, qualification, description, course_type, order_index)
SELECT name, slug, cat.id, duration, qualification, description, 'Diploma', ord FROM cat, (VALUES
('Medical Laboratory Technician','mlt-diploma','24 Months','12th (PCB)','Advanced medical lab training covering hematology, biochemistry, microbiology, and immunology.',18),
('Cardiac Care Technician','cardiac-care-technician','24 Months','12th (PCB)','ECG, echocardiography, cardiac monitoring, and ICU support with clinical training.',19),
('Dialysis Technician','dialysis-technician','24 Months','12th','Hemodialysis machine operation, patient care during dialysis, and nephrology support.',20),
('Operation Theatre Technician','ot-technician-diploma','24 Months','12th (PCB)','Surgical instrument management, sterile techniques, and OT environment protocols.',21),
('Radiology Technician','radiology-technician','24 Months','12th (PCB)','X-ray, CT, MRI imaging principles, positioning techniques, and radiation safety.',22),
('X-Ray Technician','xray-technician','24 Months','12th','Radiographic procedures, image quality assessment, and diagnostic imaging support.',23)
) AS v(name,slug,duration,qualification,description,ord)
ON CONFLICT (slug) DO NOTHING;

-- COURSES: B-VOC / M-VOC
WITH cat AS (SELECT id FROM inst_course_categories WHERE slug='bvoc-mvoc' LIMIT 1)
INSERT INTO inst_courses (name, slug, category_id, duration, qualification, description, course_type, order_index)
SELECT name, slug, cat.id, duration, qualification, description, 'B-VOC', ord FROM cat, (VALUES
('Medical Laboratory Technology','bvoc-mlt','36 Months','12th','University level program covering all aspects of clinical lab science with industry internship.',24),
('Radiology & Medical Imaging Technology','bvoc-radiology','36 Months','12th','Comprehensive imaging sciences covering X-ray, CT, MRI, and ultrasound technology.',25),
('Operation Theater Technology','bvoc-ot','36 Months','12th (PCB)','Advanced surgical technology program with extensive OT exposure and clinical placement.',26),
('Optometry Technology','bvoc-optometry','36 Months','12th (PCB)','Eye examination, refraction, contact lens fitting, and vision care technology program.',27),
('Dialysis Technology','bvoc-dialysis','36 Months','12th','In-depth renal replacement therapy, patient assessment, and dialysis machine expertise.',28),
('Cardiac Care Technology','bvoc-cardiac','36 Months','12th (PCB)','Advanced cardiac diagnostics, ICU monitoring, catheterization assistance, and patient care.',29),
('Hospital Sterilization','bvoc-sterilization','36 Months','12th','CSSD operations, sterilization methods, infection control, and hospital waste management.',30),
('Patient Care Management','bvoc-patient-care','36 Months','12th','Holistic patient management, hospital administration, and care coordination program.',31),
('Medical Record Technology','bvoc-medical-records','36 Months','12th','Health information management, coding, billing, and hospital documentation systems.',32),
('Emergency & Trauma Care Technology','bvoc-emergency-trauma','36 Months','10+2 Any Stream','Pre-hospital emergency care, trauma management, and critical care support training.',33),
('Hospital Management','mvoc-hospital-mgmt','24 Months','B.Sc / B.Voc','Healthcare administration, hospital operations, HR management, and strategic planning.',34)
) AS v(name,slug,duration,qualification,description,ord)
ON CONFLICT (slug) DO NOTHING;

-- COURSES: Vocational
WITH cat AS (SELECT id FROM inst_course_categories WHERE slug='vocational' LIMIT 1)
INSERT INTO inst_courses (name, slug, category_id, duration, qualification, description, course_type, order_index)
SELECT name, slug, cat.id, duration, qualification, description, 'Vocational', ord FROM cat, (VALUES
('Hotel Management & Catering','hotel-management-catering','1 Year','10th','Front office, housekeeping, food production, and hospitality operations with industry placement.',35),
('Fire & Safety Management','fire-safety-management','1 Year','10th','Industrial safety, fire prevention, hazard identification, and emergency response training.',36),
('Tailoring','tailoring','6 Months','10th','Garment construction, pattern making, stitching techniques, and fashion fundamentals.',37),
('Fashion Designing','fashion-designing','1 Year','12th','Design principles, garment sketching, textile knowledge, and fashion industry exposure.',38),
('Beautician Training','beautician-training','6 Months','10th','Hair styling, makeup artistry, skin care, and salon management with hands-on practice.',39),
('Lab Technician','lab-technician-voc','1 Year','12th (PCB)','Basic clinical lab skills, sample handling, equipment operation, and quality control.',40),
('Health Assistant','health-assistant-voc','1 Year','10th','Community health support, first aid, patient monitoring, and health record maintenance.',41)
) AS v(name,slug,duration,qualification,description,ord)
ON CONFLICT (slug) DO NOTHING;

-- ================================================================
-- MAINTENANCE MODE (add to site settings)
-- ================================================================
ALTER TABLE inst_site_settings ADD COLUMN IF NOT EXISTS maintenance_mode boolean DEFAULT false;
ALTER TABLE inst_site_settings ADD COLUMN IF NOT EXISTS maintenance_title text DEFAULT 'Site Under Maintenance';
ALTER TABLE inst_site_settings ADD COLUMN IF NOT EXISTS maintenance_message text DEFAULT 'We are currently updating our website to serve you better. We will be back shortly!';
ALTER TABLE inst_site_settings ADD COLUMN IF NOT EXISTS favicon_url text DEFAULT '';


-- ================================================================
-- STORAGE BUCKETS SETUP
-- ================================================================
-- Run these below manually or use the Supabase Dashboard Storage UI to create buckets:
-- 1. logos (Public)
-- 2. course-thumbnails (Public)
-- 3. gallery (Public)

INSERT INTO storage.buckets (id, name, public) VALUES ('logos', 'logos', true) ON CONFLICT DO NOTHING;
INSERT INTO storage.buckets (id, name, public) VALUES ('course-thumbnails', 'course-thumbnails', true) ON CONFLICT DO NOTHING;
INSERT INTO storage.buckets (id, name, public) VALUES ('gallery', 'gallery', true) ON CONFLICT DO NOTHING;

CREATE POLICY "Allow public read" ON storage.objects FOR SELECT USING (bucket_id IN ('logos', 'course-thumbnails', 'gallery'));
CREATE POLICY "Allow auth insert" ON storage.objects FOR INSERT WITH CHECK (bucket_id IN ('logos', 'course-thumbnails', 'gallery') AND auth.role() = 'authenticated');
CREATE POLICY "Allow auth update" ON storage.objects FOR UPDATE USING (bucket_id IN ('logos', 'course-thumbnails', 'gallery') AND auth.role() = 'authenticated');
CREATE POLICY "Allow auth delete" ON storage.objects FOR DELETE USING (bucket_id IN ('logos', 'course-thumbnails', 'gallery') AND auth.role() = 'authenticated');

