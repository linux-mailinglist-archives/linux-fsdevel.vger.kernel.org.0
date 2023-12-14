Return-Path: <linux-fsdevel+bounces-6036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C062D812861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 07:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB681F21BBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 06:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9263D2E4;
	Thu, 14 Dec 2023 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onHZnr5/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6CAB9
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 22:44:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dbcdf587bd6so839098276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 22:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702536285; x=1703141085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iko8D140eCOFohGA7VQkAes9lkzKAM1WQZ+wO/F/i90=;
        b=onHZnr5/C76u4WAUhTwmVougnLzUmAv+9rDMgFylCd+MXirdjLsJk5w4yOzvVXOhvZ
         /g4AgkKjfdC4HOcRAfYmhcxNmGi3z1q/mYVKugEQoEdI+7cnCh7BmqUhiWcm8wpQTLcF
         GDT2D35fDRC7k+3WdpAsL9WLmtbgEHqanb6JgPQZ0sZ8+55pWZS6XUdLfH6ROB7cQfyd
         w0u++OgNvwHPTjjoX1OQjlA4bDe4H0Zmmhzgk29gtNea1O5l1h5dYZ1fvhwCxdBxmqn3
         JjXg/r5fGVlmG2oXfsz1jwtMFdIAoJmAPCXVcBS8d18RwzjpOgr8RybW6a+nAXArzaXU
         kgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536285; x=1703141085;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iko8D140eCOFohGA7VQkAes9lkzKAM1WQZ+wO/F/i90=;
        b=VqG6Loojme+OcX5F8GK47X4V8wx+CBnQ5+Sz91F2ONnxVsFciM0hOC5bMaL3kc6hoZ
         KaaHtJ4UT0Rr6QHqdRrny508xcPFT4ezAtiJIqr2phC/a56cFf6lmkLRn9uE15zfkeZC
         K+C9mZz0mPg+qufuW6Ke54X6dxdMtpipnqy7q2WR7kOr66w5MT+Cx9tpXu9Be42NX5pF
         vL5tAaYvznn2bIl/iwzwrmsLMyEt1ejKdyedmlrE/G4MJeng4QiA+AE8Awm0s99aChaJ
         3U6fzlxoeskiyqOkr+9+ZVSAg+Y7ybzPelXl6beG5YcXcdATWwFLXkubzpbToe677bp9
         0KBw==
X-Gm-Message-State: AOJu0YzZJY66hj5NVI+d6rPvZFkuja3UPFP/GNKLqRq5zLepZLmBkfp1
	VmYCV4mNLi9h8HENeQ9ZT/mDkREwL/U=
X-Google-Smtp-Source: AGHT+IG0bWK9d5BDpYNZYAfiffy36nbfNQQS2AsIHHcETXtjO30MXnPlbJFmNayBbGuGgdo4DBpN1u3Fs3I=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:e986:a7c7:2814:c9a8])
 (user=avagin job=sendgmr) by 2002:a25:2d2:0:b0:dbc:ca4d:4c1 with SMTP id
 201-20020a2502d2000000b00dbcca4d04c1mr32671ybc.11.1702536285111; Wed, 13 Dec
 2023 22:44:45 -0800 (PST)
Date: Wed, 13 Dec 2023 22:44:38 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214064439.1023011-1-avagin@google.com>
Subject: [PATCH 1/2 v2] fs/proc: show correct device and inode numbers in /proc/pid/maps
From: Andrei Vagin <avagin@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

/proc/pid/maps shows device and inode numbers of vma->vm_file-s. Here is
an issue. If a mapped file is on a stackable file system (e.g.,
overlayfs), vma->vm_file is a backing file whose f_inode is on the
underlying filesystem. To show correct numbers, we need to get a user
file and shows its numbers. The same trick is used to show file paths in
/proc/pid/maps.

Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
v2: Amir explained that vfs_getattr isn't needed, because
file_user_inode(vma->vm_file).i_ino always matches an inode number
returned by statx.

 fs/proc/task_mmu.c |  3 ++-
 include/linux/fs.h | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 435b61054b5b..1801e409a061 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -273,7 +273,8 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 	const char *name = NULL;
 
 	if (file) {
-		struct inode *inode = file_inode(vma->vm_file);
+		const struct inode *inode = file_user_inode(vma->vm_file);
+
 		dev = inode->i_sb->s_dev;
 		ino = inode->i_ino;
 		pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..838ccfc63323 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2523,20 +2523,28 @@ struct file *backing_file_open(const struct path *user_path, int flags,
 struct path *backing_file_user_path(struct file *f);
 
 /*
- * file_user_path - get the path to display for memory mapped file
- *
  * When mmapping a file on a stackable filesystem (e.g., overlayfs), the file
  * stored in ->vm_file is a backing file whose f_inode is on the underlying
- * filesystem.  When the mapped file path is displayed to user (e.g. via
- * /proc/<pid>/maps), this helper should be used to get the path to display
- * to the user, which is the path of the fd that user has requested to map.
+ * filesystem.  When the mapped file path and inode number are displayed to
+ * user (e.g. via /proc/<pid>/maps), these helpers should be used to get the
+ * path and inode number to display to the user, which is the path of the fd
+ * that user has requested to map and the inode number that would be returned
+ * by fstat() on that same fd.
  */
+/* Get the path to display in /proc/<pid>/maps */
 static inline const struct path *file_user_path(struct file *f)
 {
 	if (unlikely(f->f_mode & FMODE_BACKING))
 		return backing_file_user_path(f);
 	return &f->f_path;
 }
+/* Get the inode whose inode number to display in /proc/<pid>/maps */
+static inline const struct inode *file_user_inode(struct file *f)
+{
+	if (unlikely(f->f_mode & FMODE_BACKING))
+		return d_inode(backing_file_user_path(f)->dentry);
+	return file_inode(f);
+}
 
 static inline struct file *file_clone_open(struct file *file)
 {
-- 
2.43.0.472.g3155946c3a-goog


