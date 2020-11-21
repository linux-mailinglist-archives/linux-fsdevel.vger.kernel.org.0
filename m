Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9AD2BBF5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 14:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgKUN5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 08:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgKUN5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 08:57:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A4CC061A4A;
        Sat, 21 Nov 2020 05:57:47 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so13858797wrt.0;
        Sat, 21 Nov 2020 05:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6a1z7XonQ2cS2I/Jy3WeAqVi+Th8zgWS6ynCBcsLz98=;
        b=n4fGODwou2sJd3JSq/PGjSQgfAoN919dF/NbvR8AQH3/IaRLzuhVpi15UcInwdpBGE
         7x6c7TrssblHY/FcCmirCav3P3M3XS+UfFZ8aSWmmZWGep33W5A5tP+qX97CfTJ+Yg3J
         CkUU+Mvua5dCyARVWg06f5jvYVUFRN8cqtuDCxxLfIwH1ccaN6EIiPvV97q5hAU4tLJZ
         0FmYpasRQvnzH/EIQW2HyKf7lCSXXmdGOTB5BXR90A3Sqohxjxt8b6L8+/Ehxj5IQnkm
         9dDivSFbjOSs8gP5bdGNsshi7gFa8vjkzgcMqgZbBCV5PJfLCGsyRlvLYcFqweSe/65O
         uLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6a1z7XonQ2cS2I/Jy3WeAqVi+Th8zgWS6ynCBcsLz98=;
        b=Pwpop4dR7BSw5VYPQX7NDKKQkczOjNH25yO+837U4YC0qF29xQDVBJywuI6OVh0/xV
         WlQuKqkPK8Bl9fqlvFdh+3VYWDeuBCkh0ur9ie6G7k0Vbw6i6v6iGTCiW86h3LewOtq9
         EA9tR4EZhyLly9Ypt1Pxf5jECv3920QicqTqKzr/khh5Wdf80DZOtTMCKtZPJwV9odSD
         DmZ9+hXtB8LWO2FwLw5rONabkdDyUizWtf6IGaUQuJ5Pp1POHdZoterSs42PAECcXtvW
         Lk0PioftFHbuC7KIdhnx27JiLTY7TBy8s0sgoSsB3PEx1hqHFF6ju7u5q082oNmr7ti8
         WVmg==
X-Gm-Message-State: AOAM5335kodtfiE+gyO4/o5AbDcN9cTSl0UeKN+wb2bXAqxP5mP6Ov6i
        IYAIR9VM71Woy9DKUOAyPng=
X-Google-Smtp-Source: ABdhPJyFRr7Bz7zZhxXNDDK4uaRdC6KpUcFJKTkfIzMjlYZ2VTP9S60AchRdGLgDqfgARcs6UqKEZw==
X-Received: by 2002:a5d:4703:: with SMTP id y3mr22087592wrq.416.1605967066133;
        Sat, 21 Nov 2020 05:57:46 -0800 (PST)
Received: from localhost.localdomain ([170.253.49.0])
        by smtp.googlemail.com with ESMTPSA id 17sm41689951wma.3.2020.11.21.05.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 05:57:45 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] fs/attr.c, fs/bad_inode.c, fs/binfmt_aout.c, fs/binfmt_elf.c: Cosmetic
Date:   Sat, 21 Nov 2020 14:57:35 +0100
Message-Id: <20201121135736.295705-4-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201121135736.295705-1-alx.manpages@gmail.com>
References: <20201121135736.295705-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Slightly non-trivial changes:

- Move declarations to the top of function definitions.
- Split multiple assignments in a single line to
  multiple lines with a signle assignment each.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 fs/attr.c        |  5 ++---
 fs/bad_inode.c   |  5 +++--
 fs/binfmt_aout.c |  3 ++-
 fs/binfmt_elf.c  | 26 ++++++++++++++++----------
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index b32ad8c678a5..61f7a75ac330 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -62,13 +62,14 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
+	int error;
 
 	/*
 	 * First check size constraints.  These can't be overridden using
 	 * ATTR_FORCE.
 	 */
 	if (ia_valid & ATTR_SIZE) {
-		int error = inode_newsize_ok(inode, attr->ia_size);
+		error = inode_newsize_ok(inode, attr->ia_size);
 		if (error)
 			return error;
 	}
@@ -105,8 +106,6 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 kill_priv:
 	/* User has permission for the change */
 	if (ia_valid & ATTR_KILL_PRIV) {
-		int error;
-
 		error = security_inode_killpriv(dentry);
 		if (error)
 			return error;
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index f0457b6c17dc..4c5e677ec423 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -200,8 +200,9 @@ void make_bad_inode(struct inode *inode)
 	remove_inode_hash(inode);
 
 	inode->i_mode = S_IFREG;
-	inode->i_atime = inode->i_mtime = inode->i_ctime =
-		current_time(inode);
+	inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_ctime;
+	inode->i_atime = inode->i_ctime;
 	inode->i_op = &bad_inode_ops;
 	inode->i_opflags &= ~IOP_XATTR;
 	inode->i_fop = &bad_file_ops;
diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index 92d6b70ddab0..976d5f1565e1 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -97,7 +97,8 @@ static unsigned long __user *create_aout_tables(char __user *p, struct linux_bin
 		} while (c);
 	}
 	put_user(NULL, argv);
-	current->mm->arg_end = current->mm->env_start = (unsigned long)p;
+	current->mm->env_start = (unsigned long)p;
+	current->mm->arg_end = (unsigned long)p;
 	while (envc-- > 0) {
 		char c;
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 955927ac2b80..b5e1e0a0917a 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1035,13 +1035,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		unsigned long k, vaddr;
 		unsigned long total_size = 0;
 		unsigned long alignment;
+		unsigned long nbyte;
 
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
 
 		if (unlikely(elf_brk > elf_bss)) {
-			unsigned long nbyte;
-
 			/*
 			 * There was a PT_LOAD segment with p_memsz > p_filesz
 			 * before this one. Map anonymous pages, if needed,
@@ -1277,10 +1276,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		 */
 		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
 		    elf_ex->e_type == ET_DYN && !interpreter) {
-			mm->brk = mm->start_brk = ELF_ET_DYN_BASE;
+			mm->start_brk	= ELF_ET_DYN_BASE;
+			mm->brk		= ELF_ET_DYN_BASE;
 		}
 
-		mm->brk = mm->start_brk = arch_randomize_brk(mm);
+		mm->start_brk = arch_randomize_brk(mm);
+		mm->brk = mm->start_brk;
 #ifdef compat_brk_randomized
 		current->brk_randomized = 1;
 #endif
@@ -1506,7 +1507,8 @@ static void fill_note(struct memelfnote *note, const char *name, int type,
 static void fill_prstatus(struct elf_prstatus *prstatus,
 			  struct task_struct *p, long signr)
 {
-	prstatus->pr_info.si_signo = prstatus->pr_cursig = signr;
+	prstatus->pr_cursig = signr;
+	prstatus->pr_info.si_signo = signr;
 	prstatus->pr_sigpend = p->pending.signal.sig[0];
 	prstatus->pr_sighold = p->blocked.sig[0];
 	rcu_read_lock();
@@ -1618,6 +1620,7 @@ static int fill_files_note(struct memelfnote *note)
 	user_long_t *data;
 	user_long_t *start_end_ofs;
 	char *name_base, *name_curpos;
+	unsigned int shift_bytes;
 
 	/* *Estimated* file count and total data size needed */
 	count = mm->map_count;
@@ -1639,7 +1642,8 @@ static int fill_files_note(struct memelfnote *note)
 		return -ENOMEM;
 
 	start_end_ofs = data + 2;
-	name_base = name_curpos = ((char *)data) + names_ofs;
+	name_curpos = ((char *)data) + names_ofs;
+	name_base = name_curpos;
 	remaining = size - names_ofs;
 	count = 0;
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
@@ -1681,7 +1685,7 @@ static int fill_files_note(struct memelfnote *note)
 	 */
 	n = mm->map_count - count;
 	if (n != 0) {
-		unsigned shift_bytes = n * 3 * sizeof(data[0]);
+		shift_bytes = n * 3 * sizeof(data[0]);
 		memmove(name_base - shift_bytes, name_base,
 			name_curpos - name_base);
 		name_curpos -= shift_bytes;
@@ -1922,11 +1926,12 @@ static int write_note_info(struct elf_note_info *info,
 
 static void free_note_info(struct elf_note_info *info)
 {
+	struct elf_thread_core_info *t;
 	struct elf_thread_core_info *threads = info->thread;
+	unsigned int i;
 
 	while (threads) {
-		unsigned int i;
-		struct elf_thread_core_info *t = threads;
+		t = threads;
 		threads = t->next;
 		WARN_ON(t->notes[0].data && t->notes[0].data != &t->prstatus);
 		for (i = 1; i < info->thread_notes; ++i)
@@ -2209,7 +2214,8 @@ static int elf_core_dump(struct coredump_params *cprm)
 		offset += sz;
 	}
 
-	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
+	offset = roundup(offset, ELF_EXEC_PAGESIZE);
+	dataoff = offset;
 
 	offset += vma_data_size;
 	offset += elf_core_extra_data_size();
-- 
2.28.0

