Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0772BBF59
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 14:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgKUN5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 08:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbgKUN5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 08:57:46 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C2EC0613CF;
        Sat, 21 Nov 2020 05:57:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 23so13776380wrc.8;
        Sat, 21 Nov 2020 05:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBdOOGrn/h8+p7aSFzuIlfuYm/AP2B2TwuDG4m/SEKM=;
        b=iSnyeTTpiZrN90iOME8h0UtVWZ9MZLPNX3DO1Yu/mdMYgReiLPspvnV+L4B4sZK4Jr
         qOuCHciajhkpNWJmnojpLifGbHGSUX7gONY/WyjBADL1qS8MZahx6uE4wwjXrzYQmtvk
         F/iXZMWFz4PCXJZ0Lh3uBNP9cA74Nou3+t0em30gp4BKBxbzOxyeqU1PTx/KULZ3TpCz
         71jdH1APskKAkLHgpipWutHXIQOdYfGWMyiwK5DOXh+ANZbQrRykLPppvVRuJ7niabqd
         jvO4SjZlN9VYFkcIZ9n1chge+HsYQqvSE58+LR7Xp81L5CwHZ8Sap1WNv4qVMXYA0ZDO
         dF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBdOOGrn/h8+p7aSFzuIlfuYm/AP2B2TwuDG4m/SEKM=;
        b=APBsLLC5g7bq36SgmJHYQMjlchj2k8zLNUgfRd93y/24VvxOygQFzCYEc4N1HnZ5aP
         JkIpFZhsYAizhs6Imjxs6EgT9OSAzk5nHiT2NDRnTUV4niupgb+tHq7LHFGGhG5jcIsZ
         5MnuMkQlchMk5wjXFzNi1KpZo3ooKY2ukMO34lBY2xxWzZldZJQgsrew7zD4h27qhXS0
         73wyEPGqETWvy2UBGelSip4HQZZaJtNk45geWtETwORiJx6/rqc8CBlTgUnIJl6bXL+/
         iCS6Ig1qioJbI93ZKiTdJECIl2bNi+oAqCfu3EsmhmNngyRwt6uy2NMNSWsAmasc4LfR
         T02w==
X-Gm-Message-State: AOAM531tjD4AUtvFKlg7QCUuqUlD2bHfSXaArGtcsR+iIh6gkB2t5VCH
        emeCWjbUsKy+Xu1t5RPhZ4w=
X-Google-Smtp-Source: ABdhPJzl+T77MXUYUdUKaZj+wmpF+iqlKC2EwzOdBGmiXu+Jd6Vz/rqKqdGos7QT6mdBmSFYMY1d6A==
X-Received: by 2002:a5d:4fc1:: with SMTP id h1mr22972821wrw.226.1605967064807;
        Sat, 21 Nov 2020 05:57:44 -0800 (PST)
Received: from localhost.localdomain ([170.253.49.0])
        by smtp.googlemail.com with ESMTPSA id 17sm41689951wma.3.2020.11.21.05.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 05:57:44 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] fs/anon_inodes.c, fs/attr.c, fs/bad_inode.c, fs/binfmt_aout.c, fs/binfmt_elf.c: Cosmetic
Date:   Sat, 21 Nov 2020 14:57:34 +0100
Message-Id: <20201121135736.295705-3-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201121135736.295705-1-alx.manpages@gmail.com>
References: <20201121135736.295705-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch contains only trivial changes:
Some of them found with checkpatch.pl in strict mode.

- Remove trailing whitespace.
- Remove spaces coming before tabs.
- Fix typos in comments.
- Convert spaces into tabs.
- Add a space around operators that should have them,
  and remove them when they shouldn't have them sround,
  according to coding_style.rst.
- Use braces accordint to coding_style.rst.
- Align multi-line function prototypes, and other similar cases.
- Remove or add blank lines:
	* Add blank lines after declarations, and before code.
	* Remove blank lines after function definitions and before
	  EXPORT_SYMBOL().
- Remove redundant parentheses, when the don't improve readability.
- Fix comments' style according to coding_style.rst.
- Simplify comparisons against NULL, using '!' (or nothing at all).
- Use C89 comments (/* */), instead of C99 (//).

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 fs/anon_inodes.c |   1 +
 fs/attr.c        |   7 +--
 fs/bad_inode.c   |  50 +++++++++---------
 fs/binfmt_aout.c |  94 +++++++++++++++++-----------------
 fs/binfmt_elf.c  | 129 ++++++++++++++++++++++++-----------------------
 5 files changed, 143 insertions(+), 138 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 7609d208bb53..bef68dbcbb88 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -43,6 +43,7 @@ static const struct dentry_operations anon_inodefs_dentry_operations = {
 static int anon_inodefs_init_fs_context(struct fs_context *fc)
 {
 	struct pseudo_fs_context *ctx = init_pseudo(fc, ANON_INODE_FS_MAGIC);
+
 	if (!ctx)
 		return -ENOMEM;
 	ctx->dops = &anon_inodefs_dentry_operations;
diff --git a/fs/attr.c b/fs/attr.c
index b4bbdbd4c8ca..b32ad8c678a5 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -64,7 +64,7 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 	unsigned int ia_valid = attr->ia_valid;
 
 	/*
-	 * First check size constraints.  These can't be overriden using
+	 * First check size constraints.  These can't be overridden using
 	 * ATTR_FORCE.
 	 */
 	if (ia_valid & ATTR_SIZE) {
@@ -220,7 +220,8 @@ EXPORT_SYMBOL(setattr_copy);
  * the file open for write, as there can be no conflicting delegation in
  * that case.
  */
-int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **delegated_inode)
+int notify_change(struct dentry *dentry, struct iattr *attr,
+		  struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	umode_t mode = inode->i_mode;
@@ -284,7 +285,7 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	 * no function will ever call notify_change with both ATTR_MODE and
 	 * ATTR_KILL_S*ID set.
 	 */
-	if ((ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID)) &&
+	if ((ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID)) &&
 	    (ia_valid & ATTR_MODE))
 		BUG();
 
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 54f0ce444272..f0457b6c17dc 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -22,25 +22,25 @@ static int bad_file_open(struct inode *inode, struct file *filp)
 	return -EIO;
 }
 
-static const struct file_operations bad_file_ops =
-{
+static const struct file_operations bad_file_ops = {
 	.open		= bad_file_open,
 };
 
-static int bad_inode_create (struct inode *dir, struct dentry *dentry,
-		umode_t mode, bool excl)
+static int bad_inode_create(struct inode *dir, struct dentry *dentry,
+			    umode_t mode, bool excl)
 {
 	return -EIO;
 }
 
 static struct dentry *bad_inode_lookup(struct inode *dir,
-			struct dentry *dentry, unsigned int flags)
+				       struct dentry *dentry,
+				       unsigned int flags)
 {
 	return ERR_PTR(-EIO);
 }
 
-static int bad_inode_link (struct dentry *old_dentry, struct inode *dir,
-		struct dentry *dentry)
+static int bad_inode_link(struct dentry *old_dentry, struct inode *dir,
+			  struct dentry *dentry)
 {
 	return -EIO;
 }
@@ -50,25 +50,25 @@ static int bad_inode_unlink(struct inode *dir, struct dentry *dentry)
 	return -EIO;
 }
 
-static int bad_inode_symlink (struct inode *dir, struct dentry *dentry,
-		const char *symname)
+static int bad_inode_symlink(struct inode *dir, struct dentry *dentry,
+			     const char *symname)
 {
 	return -EIO;
 }
 
 static int bad_inode_mkdir(struct inode *dir, struct dentry *dentry,
-			umode_t mode)
+			   umode_t mode)
 {
 	return -EIO;
 }
 
-static int bad_inode_rmdir (struct inode *dir, struct dentry *dentry)
+static int bad_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	return -EIO;
 }
 
-static int bad_inode_mknod (struct inode *dir, struct dentry *dentry,
-			umode_t mode, dev_t rdev)
+static int bad_inode_mknod(struct inode *dir, struct dentry *dentry,
+			   umode_t mode, dev_t rdev)
 {
 	return -EIO;
 }
@@ -81,7 +81,7 @@ static int bad_inode_rename2(struct inode *old_dir, struct dentry *old_dentry,
 }
 
 static int bad_inode_readlink(struct dentry *dentry, char __user *buffer,
-		int buflen)
+			      int buflen)
 {
 	return -EIO;
 }
@@ -103,7 +103,7 @@ static int bad_inode_setattr(struct dentry *direntry, struct iattr *attrs)
 }
 
 static ssize_t bad_inode_listxattr(struct dentry *dentry, char *buffer,
-			size_t buffer_size)
+				   size_t buffer_size)
 {
 	return -EIO;
 }
@@ -152,8 +152,7 @@ static int bad_inode_set_acl(struct inode *inode, struct posix_acl *acl,
 	return -EIO;
 }
 
-static const struct inode_operations bad_inode_ops =
-{
+static const struct inode_operations bad_inode_ops = {
 	.create		= bad_inode_create,
 	.lookup		= bad_inode_lookup,
 	.link		= bad_inode_link,
@@ -181,12 +180,12 @@ static const struct inode_operations bad_inode_ops =
 /*
  * When a filesystem is unable to read an inode due to an I/O error in
  * its read_inode() function, it can call make_bad_inode() to return a
- * set of stubs which will return EIO errors as required. 
+ * set of stubs which will return EIO errors as required.
  *
  * We only need to do limited initialisation: all other fields are
  * preinitialised to zero automatically.
  */
- 
+
 /**
  *	make_bad_inode - mark an inode bad due to an I/O error
  *	@inode: Inode to mark bad
@@ -195,7 +194,7 @@ static const struct inode_operations bad_inode_ops =
  *	failure this function makes the inode "bad" and causes I/O operations
  *	on it to fail from this point on.
  */
- 
+
 void make_bad_inode(struct inode *inode)
 {
 	remove_inode_hash(inode);
@@ -203,9 +202,9 @@ void make_bad_inode(struct inode *inode)
 	inode->i_mode = S_IFREG;
 	inode->i_atime = inode->i_mtime = inode->i_ctime =
 		current_time(inode);
-	inode->i_op = &bad_inode_ops;	
+	inode->i_op = &bad_inode_ops;
 	inode->i_opflags &= ~IOP_XATTR;
-	inode->i_fop = &bad_file_ops;	
+	inode->i_fop = &bad_file_ops;
 }
 EXPORT_SYMBOL(make_bad_inode);
 
@@ -214,19 +213,18 @@ EXPORT_SYMBOL(make_bad_inode);
  * &bad_inode_ops to cover the case of invalidated inodes as well as
  * those created by make_bad_inode() above.
  */
- 
+
 /**
  *	is_bad_inode - is an inode errored
  *	@inode: inode to test
  *
  *	Returns true if the inode in question has been marked as bad.
  */
- 
+
 bool is_bad_inode(struct inode *inode)
 {
-	return (inode->i_op == &bad_inode_ops);	
+	return (inode->i_op == &bad_inode_ops);
 }
-
 EXPORT_SYMBOL(is_bad_inode);
 
 /**
diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index 3e84e9bb9084..92d6b70ddab0 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -32,7 +32,7 @@
 #include <asm/cacheflush.h>
 
 static int load_aout_binary(struct linux_binprm *);
-static int load_aout_library(struct file*);
+static int load_aout_library(struct file *);
 
 static struct linux_binfmt aout_format = {
 	.module		= THIS_MODULE,
@@ -56,7 +56,7 @@ static int set_brk(unsigned long start, unsigned long end)
  * memory and creates the pointer tables from them, and puts their
  * addresses on the "stack", returning the new stack pointer value.
  */
-static unsigned long __user *create_aout_tables(char __user *p, struct linux_binprm * bprm)
+static unsigned long __user *create_aout_tables(char __user *p, struct linux_binprm *bprm)
 {
 	char __user * __user *argv;
 	char __user * __user *envp;
@@ -64,7 +64,7 @@ static unsigned long __user *create_aout_tables(char __user *p, struct linux_bin
 	int argc = bprm->argc;
 	int envc = bprm->envc;
 
-	sp = (void __user *)((-(unsigned long)sizeof(char *)) & (unsigned long) p);
+	sp = (void __user *)((-(unsigned long)sizeof(char *)) & (unsigned long)p);
 #ifdef __alpha__
 /* whee.. test-programs are so much fun. */
 	put_user(0, --sp);
@@ -78,34 +78,36 @@ static unsigned long __user *create_aout_tables(char __user *p, struct linux_bin
 	put_user(bprm->exec, --sp);
 	put_user(1001, --sp);
 #endif
-	sp -= envc+1;
+	sp -= envc + 1;
 	envp = (char __user * __user *) sp;
-	sp -= argc+1;
+	sp -= argc + 1;
 	argv = (char __user * __user *) sp;
 #ifndef __alpha__
-	put_user((unsigned long) envp,--sp);
-	put_user((unsigned long) argv,--sp);
+	put_user((unsigned long)envp, --sp);
+	put_user((unsigned long)argv, --sp);
 #endif
-	put_user(argc,--sp);
-	current->mm->arg_start = (unsigned long) p;
-	while (argc-->0) {
+	put_user(argc, --sp);
+	current->mm->arg_start = (unsigned long)p;
+	while (argc-- > 0) {
 		char c;
-		put_user(p,argv++);
+
+		put_user(p, argv++);
 		do {
-			get_user(c,p++);
+			get_user(c, p++);
 		} while (c);
 	}
-	put_user(NULL,argv);
-	current->mm->arg_end = current->mm->env_start = (unsigned long) p;
-	while (envc-->0) {
+	put_user(NULL, argv);
+	current->mm->arg_end = current->mm->env_start = (unsigned long)p;
+	while (envc-- > 0) {
 		char c;
-		put_user(p,envp++);
+
+		put_user(p, envp++);
 		do {
-			get_user(c,p++);
+			get_user(c, p++);
 		} while (c);
 	}
-	put_user(NULL,envp);
-	current->mm->env_end = (unsigned long) p;
+	put_user(NULL, envp);
+	current->mm->env_end = (unsigned long)p;
 	return sp;
 }
 
@@ -114,7 +116,7 @@ static unsigned long __user *create_aout_tables(char __user *p, struct linux_bin
  * libraries.  There is no binary dependent code anywhere else.
  */
 
-static int load_aout_binary(struct linux_binprm * bprm)
+static int load_aout_binary(struct linux_binprm *bprm)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct exec ex;
@@ -123,11 +125,14 @@ static int load_aout_binary(struct linux_binprm * bprm)
 	unsigned long rlim;
 	int retval;
 
-	ex = *((struct exec *) bprm->buf);		/* exec-header */
+	ex = *(struct exec *)bprm->buf;		/* exec-header */
 	if ((N_MAGIC(ex) != ZMAGIC && N_MAGIC(ex) != OMAGIC &&
 	     N_MAGIC(ex) != QMAGIC && N_MAGIC(ex) != NMAGIC) ||
 	    N_TRSIZE(ex) || N_DRSIZE(ex) ||
-	    i_size_read(file_inode(bprm->file)) < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
+	    i_size_read(file_inode(bprm->file)) < ex.a_text +
+						  ex.a_data +
+						  N_SYMSIZE(ex) +
+						  N_TXTOFF(ex)) {
 		return -ENOEXEC;
 	}
 
@@ -174,7 +179,6 @@ static int load_aout_binary(struct linux_binprm * bprm)
 	if (retval < 0)
 		return retval;
 
-
 	if (N_MAGIC(ex) == OMAGIC) {
 		unsigned long text_addr, map_size;
 		loff_t pos;
@@ -183,35 +187,34 @@ static int load_aout_binary(struct linux_binprm * bprm)
 
 #ifdef __alpha__
 		pos = fd_offset;
-		map_size = ex.a_text+ex.a_data + PAGE_SIZE - 1;
+		map_size = ex.a_text + ex.a_data + PAGE_SIZE - 1;
 #else
 		pos = 32;
-		map_size = ex.a_text+ex.a_data;
+		map_size = ex.a_text + ex.a_data;
 #endif
 		error = vm_brk(text_addr & PAGE_MASK, map_size);
 		if (error)
 			return error;
 
 		error = read_code(bprm->file, text_addr, pos,
-				  ex.a_text+ex.a_data);
+				  ex.a_text + ex.a_data);
 		if ((signed long)error < 0)
 			return error;
 	} else {
 		if ((ex.a_text & 0xfff || ex.a_data & 0xfff) &&
-		    (N_MAGIC(ex) != NMAGIC) && printk_ratelimit())
-		{
+				(N_MAGIC(ex) != NMAGIC) &&
+				printk_ratelimit()) {
 			printk(KERN_NOTICE "executable not page aligned\n");
 		}
 
-		if ((fd_offset & ~PAGE_MASK) != 0 && printk_ratelimit())
-		{
-			printk(KERN_WARNING 
+		if ((fd_offset & ~PAGE_MASK) != 0 && printk_ratelimit()) {
+			printk(KERN_WARNING
 			       "fd_offset is not page aligned. Please convert program: %pD\n",
 			       bprm->file);
 		}
 
-		if (!bprm->file->f_op->mmap||((fd_offset & ~PAGE_MASK) != 0)) {
-			error = vm_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
+		if (!bprm->file->f_op->mmap || ((fd_offset & ~PAGE_MASK) != 0)) {
+			error = vm_brk(N_TXTADDR(ex), ex.a_text + ex.a_data);
 			if (error)
 				return error;
 
@@ -221,9 +224,9 @@ static int load_aout_binary(struct linux_binprm * bprm)
 		}
 
 		error = vm_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
-			PROT_READ | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
-			fd_offset);
+				PROT_READ | PROT_EXEC,
+				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
+				fd_offset);
 
 		if (error != N_TXTADDR(ex))
 			return error;
@@ -243,7 +246,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
 		return retval;
 
 	current->mm->start_stack =
-		(unsigned long) create_aout_tables((char __user *) bprm->p, bprm);
+		(unsigned long)create_aout_tables((char __user *)bprm->p, bprm);
 #ifdef __alpha__
 	regs->gp = ex.a_gpvalue;
 #endif
@@ -254,7 +257,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
 
 static int load_aout_library(struct file *file)
 {
-	struct inode * inode;
+	struct inode *inode;
 	unsigned long bss, start_addr, len;
 	unsigned long error;
 	int retval;
@@ -271,7 +274,8 @@ static int load_aout_library(struct file *file)
 	/* We come in here for the regular a.out style of shared libraries */
 	if ((N_MAGIC(ex) != ZMAGIC && N_MAGIC(ex) != QMAGIC) || N_TRSIZE(ex) ||
 	    N_DRSIZE(ex) || ((ex.a_entry & 0xfff) && N_MAGIC(ex) == ZMAGIC) ||
-	    i_size_read(inode) < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
+	    i_size_read(inode) < ex.a_text + ex.a_data + N_SYMSIZE(ex) +
+				 N_TXTOFF(ex)) {
 		goto out;
 	}
 
@@ -285,15 +289,15 @@ static int load_aout_library(struct file *file)
 	if (N_FLAGS(ex))
 		goto out;
 
-	/* For  QMAGIC, the starting address is 0x20 into the page.  We mask
-	   this off to get the starting address for the page */
-
+	/*
+	 * For  QMAGIC, the starting address is 0x20 into the page.
+	 * We mask this off to get the starting address for the page
+	 */
 	start_addr =  ex.a_entry & 0xfffff000;
 
 	if ((N_TXTOFF(ex) & ~PAGE_MASK) != 0) {
-		if (printk_ratelimit())
-		{
-			printk(KERN_WARNING 
+		if (printk_ratelimit()) {
+			printk(KERN_WARNING
 			       "N_TXTOFF is not page aligned. Please convert library: %pD\n",
 			       file);
 		}
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fa50e8936f5f..955927ac2b80 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1025,10 +1025,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	start_data = 0;
 	end_data = 0;
 
-	/* Now we do a little grungy work by mmapping the ELF image into
-	   the correct location in memory. */
-	for(i = 0, elf_ppnt = elf_phdata;
-	    i < elf_ex->e_phnum; i++, elf_ppnt++) {
+	/*
+	 * Now we do a little grungy work by mmapping the ELF image into
+	 * the correct location in memory.
+	 */
+	for (i = 0, elf_ppnt = elf_phdata; i < elf_ex->e_phnum;
+					   i++, elf_ppnt++) {
 		int elf_prot, elf_flags;
 		unsigned long k, vaddr;
 		unsigned long total_size = 0;
@@ -1037,12 +1039,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
 
-		if (unlikely (elf_brk > elf_bss)) {
+		if (unlikely(elf_brk > elf_bss)) {
 			unsigned long nbyte;
-	            
-			/* There was a PT_LOAD segment with p_memsz > p_filesz
-			   before this one. Map anonymous pages, if needed,
-			   and clear the area.  */
+
+			/*
+			 * There was a PT_LOAD segment with p_memsz > p_filesz
+			 * before this one. Map anonymous pages, if needed,
+			 * and clear the area.
+			 */
 			retval = set_brk(elf_bss + load_bias,
 					 elf_brk + load_bias,
 					 bss_prot);
@@ -1139,7 +1143,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				elf_prot, elf_flags, total_size);
 		if (BAD_ADDR(error)) {
 			retval = IS_ERR((void *)error) ?
-				PTR_ERR((void*)error) : -EINVAL;
+				PTR_ERR((void *)error) : -EINVAL;
 			goto out_free_dentry;
 		}
 
@@ -1252,7 +1256,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
 	retval = create_elf_tables(bprm, elf_ex,
-			  load_addr, interp_load_addr, e_entry);
+				   load_addr, interp_load_addr, e_entry);
 	if (retval < 0)
 		goto out;
 
@@ -1283,10 +1287,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	}
 
 	if (current->personality & MMAP_PAGE_ZERO) {
-		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
-		   and some applications "depend" upon this behavior.
-		   Since we do not have the power to recompile these, we
-		   emulate the SVr4 behavior. Sigh. */
+		/*
+		 * Why this, you ask???  Well SVr4 maps page 0 as read-only,
+		 * and some applications "depend" upon this behavior.
+		 * Since we do not have the power to recompile these, we
+		 * emulate the SVr4 behavior. Sigh.
+		 */
 		error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
 	}
@@ -1325,8 +1331,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 }
 
 #ifdef CONFIG_USELIB
-/* This is really simpleminded and specialized - we are loading an
-   a.out library that is given an ELF header. */
+/*
+ * This is really simpleminded and specialized - we are loading an
+ * a.out library that is given an ELF header.
+ */
 static int load_elf_library(struct file *file)
 {
 	struct elf_phdr *elf_phdata;
@@ -1366,7 +1374,7 @@ static int load_elf_library(struct file *file)
 	if (retval < 0)
 		goto out_free_ph;
 
-	for (j = 0, i = 0; i<elf_ex.e_phnum; i++)
+	for (j = 0, i = 0; i < elf_ex.e_phnum; i++)
 		if ((eppnt + i)->p_type == PT_LOAD)
 			j++;
 	if (j != 1)
@@ -1418,8 +1426,7 @@ static int load_elf_library(struct file *file)
  */
 
 /* An ELF note in memory */
-struct memelfnote
-{
+struct memelfnote {
 	const char *name;
 	int type;
 	unsigned int datasz;
@@ -1440,6 +1447,7 @@ static int notesize(struct memelfnote *en)
 static int writenote(struct memelfnote *men, struct coredump_params *cprm)
 {
 	struct elf_note en;
+
 	en.n_namesz = strlen(men->name) + 1;
 	en.n_descsz = men->datasz;
 	en.n_type = men->type;
@@ -1482,8 +1490,8 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, loff_t offset)
 	phdr->p_align = 0;
 }
 
-static void fill_note(struct memelfnote *note, const char *name, int type, 
-		unsigned int sz, void *data)
+static void fill_note(struct memelfnote *note, const char *name, int type,
+		      unsigned int sz, void *data)
 {
 	note->name = name;
 	note->type = type;
@@ -1496,7 +1504,7 @@ static void fill_note(struct memelfnote *note, const char *name, int type,
  * registers which need to be filled up separately.
  */
 static void fill_prstatus(struct elf_prstatus *prstatus,
-		struct task_struct *p, long signr)
+			  struct task_struct *p, long signr)
 {
 	prstatus->pr_info.si_signo = prstatus->pr_cursig = signr;
 	prstatus->pr_sigpend = p->pending.signal.sig[0];
@@ -1534,17 +1542,17 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 {
 	const struct cred *cred;
 	unsigned int i, len;
-	
+
 	/* first copy the parameters from user space */
 	memset(psinfo, 0, sizeof(struct elf_prpsinfo));
 
 	len = mm->arg_end - mm->arg_start;
 	if (len >= ELF_PRARGSZ)
-		len = ELF_PRARGSZ-1;
+		len = ELF_PRARGSZ - 1;
 	if (copy_from_user(&psinfo->pr_psargs,
-		           (const char __user *)mm->arg_start, len))
+			   (const char __user *)mm->arg_start, len))
 		return -EFAULT;
-	for(i = 0; i < len; i++)
+	for (i = 0; i < len; i++)
 		if (psinfo->pr_psargs[i] == 0)
 			psinfo->pr_psargs[i] = ' ';
 	psinfo->pr_psargs[len] = 0;
@@ -1568,14 +1576,15 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
 	rcu_read_unlock();
 	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
-	
+
 	return 0;
 }
 
 static void fill_auxv_note(struct memelfnote *note, struct mm_struct *mm)
 {
-	elf_addr_t *auxv = (elf_addr_t *) mm->saved_auxv;
+	elf_addr_t *auxv = (elf_addr_t *)mm->saved_auxv;
 	int i = 0;
+
 	do
 		i += 2;
 	while (auxv[i - 2] != AT_NULL);
@@ -1583,13 +1592,13 @@ static void fill_auxv_note(struct memelfnote *note, struct mm_struct *mm)
 }
 
 static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
-		const kernel_siginfo_t *siginfo)
+			      const kernel_siginfo_t *siginfo)
 {
 	copy_siginfo_to_external(csigdata, siginfo);
 	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
 }
 
-#define MAX_FILE_NOTE_SIZE (4*1024*1024)
+#define MAX_FILE_NOTE_SIZE (4 * 1024 * 1024)
 /*
  * Format of NT_FILE note:
  *
@@ -1605,7 +1614,7 @@ static int fill_files_note(struct memelfnote *note)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned count, size, names_ofs, remaining, n;
+	unsigned int count, size, names_ofs, remaining, n;
 	user_long_t *data;
 	user_long_t *start_end_ofs;
 	char *name_base, *name_curpos;
@@ -1633,7 +1642,7 @@ static int fill_files_note(struct memelfnote *note)
 	name_base = name_curpos = ((char *)data) + names_ofs;
 	remaining = size - names_ofs;
 	count = 0;
-	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		struct file *file;
 		const char *filename;
 
@@ -1739,7 +1748,8 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 	 */
 	fill_prstatus(&t->prstatus, t->task, signr);
 	regset0_size = regset_get(t->task, &view->regsets[0],
-		   sizeof(t->prstatus.pr_reg), &t->prstatus.pr_reg);
+				  sizeof(t->prstatus.pr_reg),
+				  &t->prstatus.pr_reg);
 	if (regset0_size < 0)
 		return 0;
 
@@ -1762,7 +1772,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 		int ret;
 
 		do_thread_regset_writeback(t->task, regset);
-		if (!note_type) // not for coredumps
+		if (!note_type) /* not for coredumps */
 			continue;
 		if (regset->active && regset->active(t->task, regset) <= 0)
 			continue;
@@ -1798,16 +1808,14 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	info->thread = NULL;
 
 	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
-	if (psinfo == NULL) {
+	if (!psinfo) {
 		info->psinfo.data = NULL; /* So we don't free this wrongly */
 		return 0;
 	}
 
 	fill_note(&info->psinfo, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
 
-	/*
-	 * Figure out how many notes we're going to need for each thread.
-	 */
+	/* Figure out how many notes we're going to need for each thread. */
 	info->thread_notes = 0;
 	for (i = 0; i < view->n; ++i)
 		if (view->regsets[i].core_note_type != 0)
@@ -1823,15 +1831,11 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 		return 0;
 	}
 
-	/*
-	 * Initialize the ELF file header.
-	 */
+	/* Initialize the ELF file header. */
 	fill_elf_header(elf, phdrs,
 			view->e_machine, view->e_flags);
 
-	/*
-	 * Allocate a structure for each thread.
-	 */
+	/* Allocate a structure for each thread. */
 	for (ct = &dump_task->mm->core_state->dumper; ct; ct = ct->next) {
 		t = kzalloc(offsetof(struct elf_thread_core_info,
 				     notes[info->thread_notes]),
@@ -1853,16 +1857,12 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 		}
 	}
 
-	/*
-	 * Now fill in each thread's information.
-	 */
-	for (t = info->thread; t != NULL; t = t->next)
+	/* Now fill in each thread's information. */
+	for (t = info->thread; t; t = t->next)
 		if (!fill_thread_core_info(t, view, siginfo->si_signo, &info->size))
 			return 0;
 
-	/*
-	 * Fill in the two process-wide notes.
-	 */
+	/* Fill in the two process-wide notes. */
 	fill_psinfo(psinfo, dump_task->group_leader, dump_task->mm);
 	info->size += notesize(&info->psinfo);
 
@@ -1905,8 +1905,7 @@ static int write_note_info(struct elf_note_info *info,
 			return 0;
 		if (first && !writenote(&info->auxv, cprm))
 			return 0;
-		if (first && info->files.data &&
-				!writenote(&info->files, cprm))
+		if (first && info->files.data && !writenote(&info->files, cprm))
 			return 0;
 
 		for (i = 1; i < info->thread_notes; ++i)
@@ -1924,6 +1923,7 @@ static int write_note_info(struct elf_note_info *info,
 static void free_note_info(struct elf_note_info *info)
 {
 	struct elf_thread_core_info *threads = info->thread;
+
 	while (threads) {
 		unsigned int i;
 		struct elf_thread_core_info *t = threads;
@@ -1940,8 +1940,7 @@ static void free_note_info(struct elf_note_info *info)
 #else
 
 /* Here is the structure in which status of each thread is captured. */
-struct elf_thread_status
-{
+struct elf_thread_status {
 	struct list_head list;
 	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
 	elf_fpregset_t fpu;		/* NT_PRFPREG */
@@ -1959,20 +1958,21 @@ static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
 {
 	int sz = 0;
 	struct task_struct *p = t->thread;
+
 	t->num_notes = 0;
 
 	fill_prstatus(&t->prstatus, p, signr);
-	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);	
-	
+	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
+
 	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
-		  &(t->prstatus));
+		  &t->prstatus);
 	t->num_notes++;
 	sz += notesize(&t->notes[0]);
 
-	if ((t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, NULL,
-								&t->fpu))) {
+	t->prstatus.pr_fpvalid = elf_core_copy_task_fpregs(p, NULL, &t->fpu);
+	if (t->prstatus.pr_fpvalid) {
 		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu),
-			  &(t->fpu));
+			  &t->fpu);
 		t->num_notes++;
 		sz += notesize(&t->notes[1]);
 	}
@@ -2179,7 +2179,8 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	/* If segs > PN_XNUM(0xffff), then e_phnum overflows. To avoid
 	 * this, kernel supports extended numbering. Have a look at
-	 * include/linux/elf.h for further information. */
+	 * include/linux/elf.h for further information.
+	 */
 	e_phnum = segs > PN_XNUM ? PN_XNUM : segs;
 
 	/*
@@ -2257,7 +2258,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	if (!elf_core_write_extra_phdrs(cprm, offset))
 		goto end_coredump;
 
- 	/* write out the notes section */
+	/* write out the notes section */
 	if (!write_note_info(&info, cprm))
 		goto end_coredump;
 
-- 
2.28.0

