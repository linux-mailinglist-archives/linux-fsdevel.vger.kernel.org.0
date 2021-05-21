Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9538BDFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 07:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbhEUFto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 01:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhEUFtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 01:49:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F7BC061574;
        Thu, 20 May 2021 22:48:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f22so5757551pfn.0;
        Thu, 20 May 2021 22:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WyzWGEeYzzvpqZN1QCFWv+jHG4VPcbJh+9cEDFW/gA0=;
        b=WbWWyNeTBBJm/+5k8GgdUmiGsoClJIZYRin0hwdlUL97wYZ/h180ci/TVg/pnsvtxp
         YNSLRwWGPPKWCQaGoaAirGXWhd9rS/++6VaKEYLMfE20yGWdPp6DBjuf+ETade9qXwLA
         HU+KKNWZEc8F6Juso5nMSeg5kurIro+wdTfzysLLHJLprpulJSsVs2IfVC+sKzSrxA2r
         E/4LWrTgYf1I6r5xYcRGGJb9Lv85lix0Ml7K0E3HedexoIP4AYmrXofy3P+HMSUzSO5h
         eJYpfm7207xXCnVkeOfIwOz0nbtexi9AEtl6RJTb9U4M8SSsQIs9fRYmxRigTzwwevFG
         mJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WyzWGEeYzzvpqZN1QCFWv+jHG4VPcbJh+9cEDFW/gA0=;
        b=cgpJdE3EXn7oTgNkeDkhjALN0dajUhhAaDEC8Vo/y+0SEuqcOfpUPJR9rUMzrErXxg
         GMlz6YKYWVkhtIXVBmFewzXrfST8jFnuW7U74yFfu6QAlxkHMAG3vyFn4c5KDBfm3B+x
         XoHwmP5Gy/oLQUh+GrjnBy25syHXZQPBd+6+l2LkX/wqbuLbgM5X1i1HoR6iwMWdzEYb
         6/rT1CLy/J6arf9tlXvBs6fZC4aZDikuCXwE5Wpb8XbL0WmPEkQ50ckEqROI4bjepjZW
         Vzns9ta1C2qbThqFjpN6w2sYy8a+4j3cEpbL0U4ET5wpila48s5c/6QdFk9aaAYfVQBZ
         vSOA==
X-Gm-Message-State: AOAM531EKCATU5uHAakWJ7DywSKiTldmDipR2wj2HjgyxFNWaVLnfv5Q
        fdlIG0hjghBBhGh0C4IC/iQ=
X-Google-Smtp-Source: ABdhPJxPhENPmi/M0XXzNOPEvXgAS7q3LOPaCUQMONMv5rx/nJILGjuJfrzlm7gpXYslq5i4rh46WA==
X-Received: by 2002:a63:aa48:: with SMTP id x8mr7933150pgo.359.1621576099711;
        Thu, 20 May 2021 22:48:19 -0700 (PDT)
Received: from localhost.localdomain ([139.167.194.135])
        by smtp.gmail.com with ESMTPSA id 5sm7847234pjo.17.2021.05.20.22.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 22:48:19 -0700 (PDT)
From:   aviral14112001 <shiv14112001@gmail.com>
To:     viro@zeniv.linux.org.uk, shuah@kernal.org
Cc:     aviral14112001 <shiv14112001@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] This commit fixes the following checkpatch.pl errors and warnings : >>ERROR: switch and case should be at the same indent +    switch (whence) { +             case 1: [...] +         case 0: [...] +  default:
Date:   Fri, 21 May 2021 11:18:57 +0530
Message-Id: <20210521054857.7784-1-shiv14112001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>ERROR: code indent should use tabs where possible
+                              void (*callback)(struct dentry *))$

>>WARNING: Prefer [subsystem eg: netdev]_warn([subsystem]dev, ... then dev_warn(dev, ... then pr_warn(...  to printk(KERN_WARNING ...
+			printk(KERN_WARNING "%s: %s passed in a files array"

>>WARNING: break quoted strings at a space character
+			printk(KERN_WARNING "%s: %s passed in a files array"
+				"with an index of 1!\n", __func__,

>>WARNING: Symbolic permissions 'S_IRUSR | S_IWUSR' are not preferred. Consider using octal permissions '0600'.
+	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;

>>WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+			loff_t pos, unsigned len, unsigned flags,

>>WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+			loff_t pos, unsigned len, unsigned flags,

>>WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+		unsigned from = pos & (PAGE_SIZE - 1);

>>WARNING: Block comments use a trailing */ on a separate line
+ * to set the attribute specific access operations. */

>>WARNING: Symbolic permissions 'S_IRUGO | S_IXUGO' are not preferred. Consider using octal permissions '0555'.
+	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;

>>Several other warnings (WARNING: Missing a blank line after declarations)

Signed-off-by: aviral14112001 <shiv14112001@gmail.com>
---
 fs/libfs.c | 66 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index e9b29c6ffccb..a3b6bd803b7d 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -32,6 +32,7 @@ int simple_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		   unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+
 	generic_fillattr(&init_user_ns, inode, stat);
 	stat->blocks = inode->i_mapping->nrpages << (PAGE_SHIFT - 9);
 	return 0;
@@ -137,16 +138,17 @@ static struct dentry *scan_positives(struct dentry *cursor,
 loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
 {
 	struct dentry *dentry = file->f_path.dentry;
+
 	switch (whence) {
-		case 1:
-			offset += file->f_pos;
-			fallthrough;
-		case 0:
-			if (offset >= 0)
-				break;
-			fallthrough;
-		default:
-			return -EINVAL;
+	case 1:
+		offset += file->f_pos;
+		fallthrough;
+	case 0:
+		if (offset >= 0)
+			break;
+		fallthrough;
+	default:
+		return -EINVAL;
 	}
 	if (offset != file->f_pos) {
 		struct dentry *cursor = file->private_data;
@@ -251,6 +253,7 @@ static struct dentry *find_next_child(struct dentry *parent, struct dentry *prev
 	spin_lock(&parent->d_lock);
 	while ((p = p->next) != &parent->d_subdirs) {
 		struct dentry *d = container_of(p, struct dentry, d_child);
+
 		if (simple_positive(d)) {
 			spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
 			if (simple_positive(d))
@@ -266,9 +269,10 @@ static struct dentry *find_next_child(struct dentry *parent, struct dentry *prev
 }
 
 void simple_recursive_removal(struct dentry *dentry,
-                              void (*callback)(struct dentry *))
+			void (*callback)(struct dentry *))
 {
 	struct dentry *this = dget(dentry);
+
 	while (true) {
 		struct dentry *victim = NULL, *child;
 		struct inode *inode = this->d_inode;
@@ -338,7 +342,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	 * max_reserved of 1 to iunique).
 	 */
 	root->i_ino = 1;
-	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
+	root->i_mode = S_IFDIR | 0600;
 	root->i_atime = root->i_mtime = root->i_ctime = current_time(root);
 	s->s_root = d_make_root(root);
 	if (!s->s_root)
@@ -523,7 +527,7 @@ int simple_readpage(struct file *file, struct page *page)
 EXPORT_SYMBOL(simple_readpage);
 
 int simple_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+			loff_t pos, unsigned int len, unsigned int flags,
 			struct page **pagep, void **fsdata)
 {
 	struct page *page;
@@ -538,7 +542,7 @@ int simple_write_begin(struct file *file, struct address_space *mapping,
 	*pagep = page;
 
 	if (!PageUptodate(page) && (len != PAGE_SIZE)) {
-		unsigned from = pos & (PAGE_SIZE - 1);
+		unsigned int from = pos & (PAGE_SIZE - 1);
 
 		zero_user_segments(page, 0, from, from + len, PAGE_SIZE);
 	}
@@ -549,12 +553,12 @@ EXPORT_SYMBOL(simple_write_begin);
 /**
  * simple_write_end - .write_end helper for non-block-device FSes
  * @file: See .write_end of address_space_operations
- * @mapping: 		"
- * @pos: 		"
- * @len: 		"
- * @copied: 		"
- * @page: 		"
- * @fsdata: 		"
+ * @mapping:		"
+ * @pos:		"
+ * @len:		"
+ * @copied:		"
+ * @page:		"
+ * @fsdata:		"
  *
  * simple_write_end does the minimum needed for updating a page after writing is
  * done. It has the same API signature as the .write_end of
@@ -569,7 +573,7 @@ EXPORT_SYMBOL(simple_write_begin);
  * Use *ONLY* with simple_readpage()
  */
 int simple_write_end(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
+			loff_t pos, unsigned int len, unsigned int copied,
 			struct page *page, void *fsdata)
 {
 	struct inode *inode = page->mapping->host;
@@ -578,7 +582,7 @@ int simple_write_end(struct file *file, struct address_space *mapping,
 	/* zero the stale part of the page if we did a short copy */
 	if (!PageUptodate(page)) {
 		if (copied < len) {
-			unsigned from = pos & (PAGE_SIZE - 1);
+			unsigned int from = pos & (PAGE_SIZE - 1);
 
 			zero_user(page, from + copied, len - copied);
 		}
@@ -640,9 +644,8 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 
 		/* warn if it tries to conflict with the root inode */
 		if (unlikely(i == 1))
-			printk(KERN_WARNING "%s: %s passed in a files array"
-				"with an index of 1!\n", __func__,
-				s->s_type->name);
+			pr_warn("%s: %s passed in a files array with an index of 1!\n"
+			, __func__, s->s_type->name);
 
 		dentry = d_alloc_name(root, files->name);
 		if (!dentry)
@@ -673,6 +676,7 @@ static DEFINE_SPINLOCK(pin_fs_lock);
 int simple_pin_fs(struct file_system_type *type, struct vfsmount **mount, int *count)
 {
 	struct vfsmount *mnt = NULL;
+
 	spin_lock(&pin_fs_lock);
 	if (unlikely(!*mount)) {
 		spin_unlock(&pin_fs_lock);
@@ -694,6 +698,7 @@ EXPORT_SYMBOL(simple_pin_fs);
 void simple_release_fs(struct vfsmount **mount, int *count)
 {
 	struct vfsmount *mnt;
+
 	spin_lock(&pin_fs_lock);
 	mnt = *mount;
 	if (!--*count)
@@ -888,8 +893,10 @@ struct simple_attr {
 	struct mutex mutex;	/* protects access to these buffers */
 };
 
-/* simple_attr_open is called by an actual attribute open file operation
- * to set the attribute specific access operations. */
+/*
+ * simple_attr_open is called by an actual attribute open file operation
+ * to set the attribute specific access operations.
+ */
 int simple_attr_open(struct inode *inode, struct file *file,
 		     int (*get)(void *, u64 *), int (*set)(void *, u64),
 		     const char *fmt)
@@ -1133,7 +1140,7 @@ EXPORT_SYMBOL(generic_file_fsync);
  * block size of 2**@blocksize_bits) is addressable by the sector_t
  * and page cache of the system.  Return 0 if so and -EFBIG otherwise.
  */
-int generic_check_addressable(unsigned blocksize_bits, u64 num_blocks)
+int generic_check_addressable(unsigned int blocksize_bits, u64 num_blocks)
 {
 	u64 last_fs_block = num_blocks - 1;
 	u64 last_fs_page =
@@ -1237,7 +1244,7 @@ struct inode *alloc_anon_inode(struct super_block *s)
 	 * that it already _is_ on the dirty list.
 	 */
 	inode->i_state = I_DIRTY;
-	inode->i_mode = S_IRUSR | S_IWUSR;
+	inode->i_mode = 0600;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
 	inode->i_flags |= S_PRIVATE;
@@ -1303,6 +1310,7 @@ static int empty_dir_getattr(struct user_namespace *mnt_userns,
 			     u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+
 	generic_fillattr(&init_user_ns, inode, stat);
 	return 0;
 }
@@ -1349,7 +1357,7 @@ static const struct file_operations empty_dir_operations = {
 void make_empty_dir_inode(struct inode *inode)
 {
 	set_nlink(inode, 2);
-	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	inode->i_mode = S_IFDIR | 0555;
 	inode->i_uid = GLOBAL_ROOT_UID;
 	inode->i_gid = GLOBAL_ROOT_GID;
 	inode->i_rdev = 0;
-- 
2.25.1

