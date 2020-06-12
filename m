Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995911F7616
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgFLJe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgFLJeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:25 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BADC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:24 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so9394730ejd.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+U0p517LaJ7AQndHK8TkXE04tlPu9oRug/GnL/Qzzwg=;
        b=CF1R4YOPxSKn4YP565bjE+EkQxN3lzCkvE0W+/i4nY2MONamF8JJlzU2LAWxkjou5d
         vwKeXxonMlTv9MPVvNZ4DOYmt0K2Cn6RgUTCZpQXjci2+5rMAaSzK51B7WxABQATEHQh
         1ZgIpSOSm4kiuN5W1P++x2yYEMzyCVRsbA0JWvM1UVbv0pkPt3C6Dgmh5PAqksjr6AV7
         Oh4/hB7XDOE8fI7tfNJPjh9AOMqgsksWEPVhVLQd0h0K9rPd/L8mpgxH4aH8hXbgZLM4
         Ck51TX0lwEVLw0136J4IbM4oGhPEil7X/5kDReHiB1ibfI7h4MyjZwznj8K2vaXABtb1
         /jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+U0p517LaJ7AQndHK8TkXE04tlPu9oRug/GnL/Qzzwg=;
        b=XTfRKxqgrpVUM8qYPDuLR6HftzKnDQLwYYXT1PsWFqjKn8efIl0VS0k5We0uopn67R
         Rq+PcGYUYSR7JQGLgx3wIMTpl0T812hN5t+s/aQbErwQkMzSHq3FzuJRlGe/wZHic1Fr
         YTwkw0nWQkQYyDj9/pzKYRfDQ/EOpDCknQ2836bLLgZYGscBE8CwJhUFnRQUrUiCgSeh
         x9rllWklsVT0Uv0JA3P7hWoKM9CZ231XsEKbQS4VIOvACI0scQf0lOXWHe8+oxGYtWhE
         XTsBAWsmW+4cGpTxcOtogR0wVmw9FxKn6Zi4hq7pXElFjhlUm9lY3EhoN9d3e+ttkeP5
         Wg6g==
X-Gm-Message-State: AOAM531ZqzxBUIJzubJJ1aKbK3yKK6fJ/WDo77chW9QrbjTVqbgtHuxI
        1PVaDasnqRd3fffDYKsjg73oS77+
X-Google-Smtp-Source: ABdhPJymzExBxPzxRuVlsZ0LaKrWtqSKoiORi6VuyTyNhlpuAdq83Le0J6vsIygir8HqaNOKq05uNg==
X-Received: by 2002:a17:906:b88c:: with SMTP id hb12mr12097007ejb.483.1591954463145;
        Fri, 12 Jun 2020 02:34:23 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:22 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/20] fanotify: remove event FAN_DIR_MODIFY
Date:   Fri, 12 Jun 2020 12:33:40 +0300
Message-Id: <20200612093343.5669-18-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
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
index e73ae6117a61..dc68111ae856 100644
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
index f5dd6a03f869..738d669f6d6d 100644
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

