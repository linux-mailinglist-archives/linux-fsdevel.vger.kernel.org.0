Return-Path: <linux-fsdevel+bounces-7661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35438828E26
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 20:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2565288C09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809FB3D556;
	Tue,  9 Jan 2024 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf2lSkAU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A563D3A2
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e461c1f44so28071265e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 11:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704829703; x=1705434503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KxOxGQTgDOm/AM1G1JkCmy8q7gWSWCaewbxLEb+dup0=;
        b=kf2lSkAUspQUXIMCZhBZa49YlsRAexnyZWIxXoU/HrNbb5aMXiXWDcMqJQIx1TXfoM
         /3ljv6QG6iy8DZ752dUTFfmBSbCXj6xH4tQBBMtw4X2/K0k5K0fy/3PS4AnM9wZdkwvi
         mkSkxvZrpF338bZ7KuhNHcfcIEkszZKmkIYybm7LmHljAAg3B5iYTbD6/UYWnBJDFGJi
         FYCM7+86Q3xt9qVBEWEdxE/adTF+ejdWIzB4c+S62uZIbKm96U+TJj3ISHHQQhubOmiP
         KsSzj6LOTKjA9BZ8T9OY1JGmyGsooNr/83mQFbzedmylPtKEXHC6vHjz3GIVQselFeZB
         ay8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704829703; x=1705434503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxOxGQTgDOm/AM1G1JkCmy8q7gWSWCaewbxLEb+dup0=;
        b=otJd8xbtPGmmTQ2363hg8LiEyULfCxET9rDiImT+FAsAZxkSN+Yg+FZ+OQeCTBRjVX
         p67TI/7I5c9amF8W7jmC1hTfX9YM04ak0UIvceOg5uhh32FtYkdYX85s2ByRVfwddKun
         By/HPy9S8umARSu8pxK8olBiMKfCHycbtnnQwYntsG3x+oiv4fb+/lcSSwj7NHhh0aet
         mSvtv0ZX+YPie14KWyTfmrvE2+STwLHhNj/sTljSsaF+DgtlNFctevnP+Zagy5ALT42m
         lolYF+vH87PHlsnBxhdRJPKu0SoTUtyVAdQFhPKUes9U1jHFruC7QpfNuLDeZ2/0wl+w
         pzCw==
X-Gm-Message-State: AOJu0YyTFte6h0k8aTRDeORnfJtwRIbLIhoPxlapVBM8s8O/dXCpTH1p
	rpnRIoGmtG56YUgLoXih/D+uo9LcuWA=
X-Google-Smtp-Source: AGHT+IEJtQWkgh04vMoox7JVo6FSyyWo0vIR9EgPMPbYzWiYea9h/rdZGaCVqMtg1b3x4JLoN/y8FA==
X-Received: by 2002:a05:600c:5247:b0:40b:351b:fcc2 with SMTP id fc7-20020a05600c524700b0040b351bfcc2mr2899625wmb.19.1704829703150;
        Tue, 09 Jan 2024 11:48:23 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b0040e4ca7fcb4sm4542211wmg.37.2024.01.09.11.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:48:22 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH] fsnotify: optimize the case of no access event watchers
Date: Tue,  9 Jan 2024 21:48:18 +0200
Message-Id: <20240109194818.91465-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
optimized the case where there are no fsnotify watchers on any of the
filesystem's objects.

It is quite common for a system to have a single local filesystem and
it is quite common for the system to have some inotify watches on some
config files or directories, so the optimization of no marks at all is
often not in effect.

Access event watchers are far less common, so optimizing the case of
no marks with access events could improve performance for more systems,
especially for the performance sensitive hot io path.

Maintain a per-sb counter of objects that have marks with access
events in their mask and use that counter to optimize out the call to
fsnotify() in fsnotify access hooks.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jens,

You may want to try if this patch improves performance for your workload
with SECURITY=Y and FANOTIFY_ACCESS_PERMISSIONS=Y.

I am not at all sure that access events are the right thing to optimize.
I am pretty sure that access event watchers are rare in the wild, unlike
FS_MODIFY watchers that are common (e.g. tail -f).

Let me know how this patch works for you and we can continue the
discussion with Jan from there.

Thanks,
Amir.

 fs/notify/mark.c                 | 27 ++++++++++++++++++++++++++-
 include/linux/fs.h               |  1 +
 include/linux/fsnotify.h         | 14 +++++++++++---
 include/linux/fsnotify_backend.h |  2 ++
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index d6944ff86ffa..14dc581df414 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -153,9 +153,29 @@ static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
 	return inode;
 }
 
+/*
+ * To avoid the performance penalty of rare access event watchers in the hot
+ * io path, keep track of whether any such watchers exists on the filesystem.
+ */
+static void fsnotify_update_sb_watchers(struct fsnotify_mark_connector *conn,
+					u32 old_mask, u32 new_mask)
+{
+	struct super_block *sb = fsnotify_connector_sb(conn);
+	bool old_watchers = old_mask & ALL_FSNOTIFY_ACCESS_EVENTS;
+	bool new_watchers = new_mask & ALL_FSNOTIFY_ACCESS_EVENTS;
+
+	if (!sb || old_watchers == new_watchers)
+		return;
+
+	if (new_watchers)
+		atomic_long_inc(&sb->s_fsnotify_access_watchers);
+	else
+		atomic_long_dec(&sb->s_fsnotify_access_watchers);
+}
+
 static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
-	u32 new_mask = 0;
+	u32 old_mask, new_mask = 0;
 	bool want_iref = false;
 	struct fsnotify_mark *mark;
 
@@ -163,6 +183,7 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	/* We can get detached connector here when inode is getting unlinked. */
 	if (!fsnotify_valid_obj_type(conn->type))
 		return NULL;
+	old_mask = fsnotify_conn_mask(conn);
 	hlist_for_each_entry(mark, &conn->list, obj_list) {
 		if (!(mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED))
 			continue;
@@ -172,6 +193,7 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 			want_iref = true;
 	}
 	*fsnotify_conn_mask_p(conn) = new_mask;
+	fsnotify_update_sb_watchers(conn, old_mask, new_mask);
 
 	return fsnotify_update_iref(conn, want_iref);
 }
@@ -243,11 +265,13 @@ static void *fsnotify_detach_connector_from_object(
 					unsigned int *type)
 {
 	struct inode *inode = NULL;
+	u32 old_mask;
 
 	*type = conn->type;
 	if (conn->type == FSNOTIFY_OBJ_TYPE_DETACHED)
 		return NULL;
 
+	old_mask = fsnotify_conn_mask(conn);
 	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = fsnotify_conn_inode(conn);
 		inode->i_fsnotify_mask = 0;
@@ -261,6 +285,7 @@ static void *fsnotify_detach_connector_from_object(
 		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
 	}
 
+	fsnotify_update_sb_watchers(conn, old_mask, 0);
 	fsnotify_put_sb_connectors(conn);
 	rcu_assign_pointer(*(conn->obj), NULL);
 	conn->obj = NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 42298095b7a5..643d2aeb037d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1282,6 +1282,7 @@ struct super_block {
 	 * inodes objects are currently double-accounted.
 	 */
 	atomic_long_t s_fsnotify_connectors;
+	atomic_long_t s_fsnotify_access_watchers;
 
 	/* Read-only state of the superblock is being changed */
 	int s_readonly_remount;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 8300a5286988..9dba2e038017 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -17,6 +17,14 @@
 #include <linux/slab.h>
 #include <linux/bug.h>
 
+/* Are there any inode/mount/sb objects that are being watched? */
+static inline int fsnotify_sb_has_watchers(struct super_block *sb, __u32 mask)
+{
+	if (mask & ALL_FSNOTIFY_ACCESS_EVENTS)
+		return atomic_long_read(&sb->s_fsnotify_access_watchers);
+	return atomic_long_read(&sb->s_fsnotify_connectors);
+}
+
 /*
  * Notify this @dir inode about a change in a child directory entry.
  * The directory entry may have turned positive or negative or its inode may
@@ -30,7 +38,7 @@ static inline int fsnotify_name(__u32 mask, const void *data, int data_type,
 				struct inode *dir, const struct qstr *name,
 				u32 cookie)
 {
-	if (atomic_long_read(&dir->i_sb->s_fsnotify_connectors) == 0)
+	if (!fsnotify_sb_has_watchers(dir->i_sb, mask))
 		return 0;
 
 	return fsnotify(mask, data, data_type, dir, name, NULL, cookie);
@@ -44,7 +52,7 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
 
 static inline void fsnotify_inode(struct inode *inode, __u32 mask)
 {
-	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
+	if (!fsnotify_sb_has_watchers(inode->i_sb, mask))
 		return;
 
 	if (S_ISDIR(inode->i_mode))
@@ -59,7 +67,7 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
 {
 	struct inode *inode = d_inode(dentry);
 
-	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
+	if (!fsnotify_sb_has_watchers(inode->i_sb, mask))
 		return 0;
 
 	if (S_ISDIR(inode->i_mode)) {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 7f63be5ca0f1..5e0e76cbd7ee 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -77,6 +77,8 @@
  */
 #define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE | FS_RENAME)
 
+#define ALL_FSNOTIFY_ACCESS_EVENTS (FS_ACCESS | FS_ACCESS_PERM)
+
 #define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
 				  FS_OPEN_EXEC_PERM)
 
-- 
2.34.1


