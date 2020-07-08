Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C162185BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgGHLMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgGHLMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D205CC08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:31 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so48446103wru.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SHcTUzc2xMMCSVX2qtFrRQqy5xK/SQtlJ+RwxoXkIZg=;
        b=nksO/NAJSKwmk/0zJ3qKx2HNfSEFir35n45TLOARDqDx5b/uMh/hBXDdEGrXP67aBD
         377Kpxpp0UK16Xo26wupNPhRHCo1ZoN6tf4bhP3CTc+VrYPLwy24XDPfPDEaNo3B2Q82
         fzzlRI+b9aZSK6xEqJGK+6o/rDboteziRFh8zCfcGDcckK0au3bppQRfMqxYCWUFEOg4
         SqT/VEW7qPf2aCHzliJxBsxwa32hTG8OrFddE5oTK72B8/ly5wWsdCMsuYfacXzm1PKH
         P2TgsyuRMwAxfmx1ypAHpJVgiVfvwUw60nZBpk0bf7p6IZ1hr5ieE3rteIWF39oYYToV
         46Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SHcTUzc2xMMCSVX2qtFrRQqy5xK/SQtlJ+RwxoXkIZg=;
        b=dnBuKDNjI0Lv9MviMaEIL2ttx/89qD4+7mKqKqO5nTmUWTj+2GYSDbK0XYZeh+qIzx
         5JLVuuCeV/0ohD6jShFz9DiyG5JMKNapvPQeSYLUb66fqABarkucUcz7tSfT92CxCpJQ
         kt0ELFKNGHLaY9ubetedb7tL603RMXpXw7mv47BR3BcExvE8tOFc0BZXVr3DkNWL3ZQW
         cRPe1wQ3Dc2/5p8F0K2rqKGzQdWYtmHgpxJHRTcakIbe12spKYS2KiX30Ter3BE+i6cA
         jCOfTFtYms88zL2YBJ8LKfnd+6W+CiwHzBwPJzm5hraz7/Yk10njQYRQ8+q4WlfTdhd9
         +zxA==
X-Gm-Message-State: AOAM531rYFP83aHvZKIV5AAJOHRi9PhVQqsO3i1xXXKztzqHgEnIvWHA
        +0X420FfMdJXOz0BFfg5wMTGweem
X-Google-Smtp-Source: ABdhPJyq7PeN9/WW1CnjBKvVByHOWI0TgYAvUWFsJiiB5zhx7vwkI4c0dnYSlR+6YLlZKDiZeWfjig==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr58845352wrp.415.1594206750541;
        Wed, 08 Jul 2020 04:12:30 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:29 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 17/20] fanotify: remove event FAN_DIR_MODIFY
Date:   Wed,  8 Jul 2020 14:11:52 +0300
Message-Id: <20200708111156.24659-17-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It was never enabled in uapi and its functionality is about to be
superseded by events FAN_CREATE, FAN_DETELE, FAN_MOVE with group
flag FAN_REPORT_NAME.

Keep a place holder variable name_event instead of removing the
name recording code.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    | 9 ++-------
 fs/notify/fsnotify.c             | 2 +-
 include/linux/fsnotify.h         | 6 ------
 include/linux/fsnotify_backend.h | 4 +---
 include/uapi/linux/fanotify.h    | 1 -
 5 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 3a82ddb63196..3885bf63976b 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -426,6 +426,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+	bool name_event = false;
 
 	/*
 	 * For queues with unlimited length lost events are not expected and
@@ -443,12 +444,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 
 	if (fanotify_is_perm_event(mask)) {
 		event = fanotify_alloc_perm_event(path, gfp);
-	} else if (mask & FAN_DIR_MODIFY && !(WARN_ON_ONCE(!file_name))) {
-		/*
-		 * For FAN_DIR_MODIFY event, we report the fid of the directory
-		 * and the name of the modified entry.
-		 * Allocate an fanotify_name_event struct and copy the name.
-		 */
+	} else if (name_event && file_name) {
 		event = fanotify_alloc_name_event(id, fsid, file_name, gfp);
 	} else if (fid_mode) {
 		event = fanotify_alloc_fid_event(id, fsid, gfp);
@@ -529,7 +525,6 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_MOVED_FROM != FS_MOVED_FROM);
 	BUILD_BUG_ON(FAN_CREATE != FS_CREATE);
 	BUILD_BUG_ON(FAN_DELETE != FS_DELETE);
-	BUILD_BUG_ON(FAN_DIR_MODIFY != FS_DIR_MODIFY);
 	BUILD_BUG_ON(FAN_DELETE_SELF != FS_DELETE_SELF);
 	BUILD_BUG_ON(FAN_MOVE_SELF != FS_MOVE_SELF);
 	BUILD_BUG_ON(FAN_EVENT_ON_CHILD != FS_EVENT_ON_CHILD);
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index e05f3b2cf664..51ada3cfd2ff 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -393,7 +393,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 26);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 316c9b820517..9b2566d273a9 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -30,12 +30,6 @@ static inline void fsnotify_name(struct inode *dir, __u32 mask,
 				 const struct qstr *name, u32 cookie)
 {
 	fsnotify(dir, mask, child, FSNOTIFY_EVENT_INODE, name, cookie);
-	/*
-	 * Send another flavor of the event without child inode data and
-	 * without the specific event type (e.g. FS_CREATE|FS_IS_DIR).
-	 * The name is relative to the dir inode the event is reported to.
-	 */
-	fsnotify(dir, FS_DIR_MODIFY, dir, FSNOTIFY_EVENT_INODE, name, 0);
 }
 
 static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 430d131d11c6..860c847c5bfa 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -47,7 +47,6 @@
 #define FS_OPEN_PERM		0x00010000	/* open event in an permission hook */
 #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
-#define FS_DIR_MODIFY		0x00080000	/* Directory entry was modified */
 
 #define FS_EXCL_UNLINK		0x04000000	/* do not send events if object is unlinked */
 /* This inode cares about things that happen to its children.  Always set for
@@ -67,8 +66,7 @@
  * The watching parent may get an FS_ATTRIB|FS_EVENT_ON_CHILD event
  * when a directory entry inside a child subdir changes.
  */
-#define ALL_FSNOTIFY_DIRENT_EVENTS	(FS_CREATE | FS_DELETE | FS_MOVE | \
-					 FS_DIR_MODIFY)
+#define ALL_FSNOTIFY_DIRENT_EVENTS	(FS_CREATE | FS_DELETE | FS_MOVE)
 
 #define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
 				  FS_OPEN_EXEC_PERM)
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index a88c7c6d0692..7f2f17eacbf9 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -24,7 +24,6 @@
 #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
 #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
-#define FAN_DIR_MODIFY		0x00080000	/* Directory entry was modified */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
-- 
2.17.1

