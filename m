Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9FA2CBC77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 13:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbgLBMIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 07:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbgLBMIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:08:40 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6C3C061A4E
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 04:07:23 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id f23so3815465ejt.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 04:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKX6zQetXJJsGxnh7QuN6U7Lzwh5cZLmRJU5pvdk5sw=;
        b=H7Gdcw7W+9XSFD/M3qw6HvvvyITY8Eqk9/j64+s+kxWkYDsrN5WNddeeIDXZl211B/
         OgKmnc0ZWbhYq7nCTf+UMHfvuZKt26bkdqMoSt1pIQIo/jKOQJITORalM9RSSIWR9fo8
         vyygk/qDSFoa668+XXSdi3Lszuj1ICfpevTGjE+i8FkJuXx2Jc2incX39umSk+4Im6Zi
         5XHNVnDNey6u+8YNs42z3zf8K94T64ymVWLua8TrKVSA04YVl0PnyGnqnUHoE2GbK5n4
         MDx82wEnCyiV09sEIPDxx0HDwOvWv0Vk7K3z5fO4mkhhLoL8t9rziR8aV5lk9EE8IZBt
         oXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKX6zQetXJJsGxnh7QuN6U7Lzwh5cZLmRJU5pvdk5sw=;
        b=n5syL0i8aJihLDIDS7fUguDV5zAi9ufmwaXw7VT19sLBGGnjxo3/z28hYPYAFHqH5/
         WBy+R+dbMRPDrkxskLpSJnn+FiwcrDtby/f7fXVqBCI27doYJoBSgpXfjxI30dssa1RC
         TbRdgm75a6eSGkSy4ep3hi45egkmRJbuswSpzxUQ1HIaJznwkKV6rwsFHX560fu4VG8v
         H46clN/Sgxt+lcEykHung6xTMkXepDhuv06Beu7d5dGXdaDkJ706Q5MJtLcHSWBInHua
         c/TJkzek4yOV8D+mPmdQ6GpXxkqFQ1YF5uKg17BoFextEM3UQ4JGk7RkQ8SYiuR+nwwd
         E6wA==
X-Gm-Message-State: AOAM531g+IcId2BFcv0yBHu1Qmrpg/N7W+6wplqTBlpSG8ygM+eDqjcV
        36XeNQkrK8Mu/pG/+E18IY3FlSZTNnM=
X-Google-Smtp-Source: ABdhPJzURIecKIwgylI3ov4nPTqpyuyvpNc/reNdeYKFOCZuDdqmucdE4CEgMUMAtLNW7FpggFT+yw==
X-Received: by 2002:a17:906:d9cf:: with SMTP id qk15mr2026678ejb.453.1606910842614;
        Wed, 02 Dec 2020 04:07:22 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id b7sm1058227ejj.85.2020.12.02.04.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:07:22 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/7] fsnotify: clarify object type argument
Date:   Wed,  2 Dec 2020 14:07:10 +0200
Message-Id: <20201202120713.702387-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202120713.702387-1-amir73il@gmail.com>
References: <20201202120713.702387-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for separating object type from iterator type, rename
some 'type' arguments in functions to 'obj_type' and remove the unused
interface to clear marks by object type mask.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c |  8 ++++----
 fs/notify/group.c                  |  2 +-
 fs/notify/mark.c                   | 24 ++++++++++++------------
 include/linux/fsnotify_backend.h   | 25 ++++++++++---------------
 4 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3e01d8f2ab90..f9c74fa82038 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -819,7 +819,7 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   fsnotify_connp_t *connp,
-						   unsigned int type,
+						   unsigned int obj_type,
 						   __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *mark;
@@ -833,7 +833,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 		return ERR_PTR(-ENOMEM);
 
 	fsnotify_init_mark(mark, group);
-	ret = fsnotify_add_mark_locked(mark, connp, type, 0, fsid);
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0, fsid);
 	if (ret) {
 		fsnotify_put_mark(mark);
 		return ERR_PTR(ret);
@@ -844,7 +844,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 
 
 static int fanotify_add_mark(struct fsnotify_group *group,
-			     fsnotify_connp_t *connp, unsigned int type,
+			     fsnotify_connp_t *connp, unsigned int obj_type,
 			     __u32 mask, unsigned int flags,
 			     __kernel_fsid_t *fsid)
 {
@@ -854,7 +854,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
 	if (!fsn_mark) {
-		fsn_mark = fanotify_add_new_mark(group, connp, type, fsid);
+		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, fsid);
 		if (IS_ERR(fsn_mark)) {
 			mutex_unlock(&group->mark_mutex);
 			return PTR_ERR(fsn_mark);
diff --git a/fs/notify/group.c b/fs/notify/group.c
index a4a4b1c64d32..8255b4c45802 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -58,7 +58,7 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
 	fsnotify_group_stop_queueing(group);
 
 	/* Clear all marks for this group and queue them for destruction */
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_ALL_TYPES_MASK);
+	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_ANY);
 
 	/*
 	 * Some marks can still be pinned when waiting for response from
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 8387937b9d01..7792f5486d61 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -474,7 +474,7 @@ int fsnotify_compare_groups(struct fsnotify_group *a, struct fsnotify_group *b)
 }
 
 static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
-					       unsigned int type,
+					       unsigned int obj_type,
 					       __kernel_fsid_t *fsid)
 {
 	struct inode *inode = NULL;
@@ -485,7 +485,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		return -ENOMEM;
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
-	conn->type = type;
+	conn->type = obj_type;
 	conn->obj = connp;
 	/* Cache fsid of filesystem containing the object */
 	if (fsid) {
@@ -545,7 +545,7 @@ static struct fsnotify_mark_connector *fsnotify_grab_connector(
  * priority, highest number first, and then by the group's location in memory.
  */
 static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
-				  fsnotify_connp_t *connp, unsigned int type,
+				  fsnotify_connp_t *connp, unsigned int obj_type,
 				  int allow_dups, __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *lmark, *last = NULL;
@@ -553,7 +553,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 	int cmp;
 	int err = 0;
 
-	if (WARN_ON(!fsnotify_valid_obj_type(type)))
+	if (WARN_ON(!fsnotify_valid_obj_type(obj_type)))
 		return -EINVAL;
 
 	/* Backend is expected to check for zero fsid (e.g. tmpfs) */
@@ -565,7 +565,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 	conn = fsnotify_grab_connector(connp);
 	if (!conn) {
 		spin_unlock(&mark->lock);
-		err = fsnotify_attach_connector_to_object(connp, type, fsid);
+		err = fsnotify_attach_connector_to_object(connp, obj_type, fsid);
 		if (err)
 			return err;
 		goto restart;
@@ -638,7 +638,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
  * event types should be delivered to which group.
  */
 int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
-			     fsnotify_connp_t *connp, unsigned int type,
+			     fsnotify_connp_t *connp, unsigned int obj_type,
 			     int allow_dups, __kernel_fsid_t *fsid)
 {
 	struct fsnotify_group *group = mark->group;
@@ -660,7 +660,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	fsnotify_get_mark(mark); /* for g_list */
 	spin_unlock(&mark->lock);
 
-	ret = fsnotify_add_mark_list(mark, connp, type, allow_dups, fsid);
+	ret = fsnotify_add_mark_list(mark, connp, obj_type, allow_dups, fsid);
 	if (ret)
 		goto err;
 
@@ -681,13 +681,13 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 }
 
 int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
-		      unsigned int type, int allow_dups, __kernel_fsid_t *fsid)
+		      unsigned int obj_type, int allow_dups, __kernel_fsid_t *fsid)
 {
 	int ret;
 	struct fsnotify_group *group = mark->group;
 
 	mutex_lock(&group->mark_mutex);
-	ret = fsnotify_add_mark_locked(mark, connp, type, allow_dups, fsid);
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, allow_dups, fsid);
 	mutex_unlock(&group->mark_mutex);
 	return ret;
 }
@@ -722,14 +722,14 @@ EXPORT_SYMBOL_GPL(fsnotify_find_mark);
 
 /* Clear any marks in a group with given type mask */
 void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
-				   unsigned int type_mask)
+				   unsigned int obj_type)
 {
 	struct fsnotify_mark *lmark, *mark;
 	LIST_HEAD(to_free);
 	struct list_head *head = &to_free;
 
 	/* Skip selection step if we want to clear all marks. */
-	if (type_mask == FSNOTIFY_OBJ_ALL_TYPES_MASK) {
+	if (obj_type == FSNOTIFY_OBJ_TYPE_ANY) {
 		head = &group->marks_list;
 		goto clear;
 	}
@@ -744,7 +744,7 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 	 */
 	mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
 	list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
-		if ((1U << mark->connector->type) & type_mask)
+		if (mark->connector->type == obj_type)
 			list_move(&mark->g_list, &to_free);
 	}
 	mutex_unlock(&group->mark_mutex);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a2e42d3cd87c..72bc120a65bc 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -277,6 +277,7 @@ static inline const struct path *fsnotify_data_path(const void *data,
 }
 
 enum fsnotify_obj_type {
+	FSNOTIFY_OBJ_TYPE_ANY = -1,
 	FSNOTIFY_OBJ_TYPE_INODE,
 	FSNOTIFY_OBJ_TYPE_PARENT,
 	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
@@ -285,15 +286,9 @@ enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_DETACHED = FSNOTIFY_OBJ_TYPE_COUNT
 };
 
-#define FSNOTIFY_OBJ_TYPE_INODE_FL	(1U << FSNOTIFY_OBJ_TYPE_INODE)
-#define FSNOTIFY_OBJ_TYPE_PARENT_FL	(1U << FSNOTIFY_OBJ_TYPE_PARENT)
-#define FSNOTIFY_OBJ_TYPE_VFSMOUNT_FL	(1U << FSNOTIFY_OBJ_TYPE_VFSMOUNT)
-#define FSNOTIFY_OBJ_TYPE_SB_FL		(1U << FSNOTIFY_OBJ_TYPE_SB)
-#define FSNOTIFY_OBJ_ALL_TYPES_MASK	((1U << FSNOTIFY_OBJ_TYPE_COUNT) - 1)
-
-static inline bool fsnotify_valid_obj_type(unsigned int type)
+static inline bool fsnotify_valid_obj_type(unsigned int obj_type)
 {
-	return (type < FSNOTIFY_OBJ_TYPE_COUNT);
+	return (obj_type < FSNOTIFY_OBJ_TYPE_COUNT);
 }
 
 struct fsnotify_iter_info {
@@ -326,7 +321,7 @@ static inline void fsnotify_iter_set_report_type_mark(
 static inline struct fsnotify_mark *fsnotify_iter_##name##_mark( \
 		struct fsnotify_iter_info *iter_info) \
 { \
-	return (iter_info->report_mask & FSNOTIFY_OBJ_TYPE_##NAME##_FL) ? \
+	return (iter_info->report_mask & (1U << FSNOTIFY_OBJ_TYPE_##NAME)) ? \
 		iter_info->marks[FSNOTIFY_OBJ_TYPE_##NAME] : NULL; \
 }
 
@@ -520,11 +515,11 @@ extern int fsnotify_get_conn_fsid(const struct fsnotify_mark_connector *conn,
 				  __kernel_fsid_t *fsid);
 /* attach the mark to the object */
 extern int fsnotify_add_mark(struct fsnotify_mark *mark,
-			     fsnotify_connp_t *connp, unsigned int type,
+			     fsnotify_connp_t *connp, unsigned int obj_type,
 			     int allow_dups, __kernel_fsid_t *fsid);
 extern int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 				    fsnotify_connp_t *connp,
-				    unsigned int type, int allow_dups,
+				    unsigned int obj_type, int allow_dups,
 				    __kernel_fsid_t *fsid);
 
 /* attach the mark to the inode */
@@ -554,21 +549,21 @@ extern void fsnotify_free_mark(struct fsnotify_mark *mark);
 /* Wait until all marks queued for destruction are destroyed */
 extern void fsnotify_wait_marks_destroyed(void);
 /* run all the marks in a group, and clear all of the marks attached to given object type */
-extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group, unsigned int type);
+extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group, unsigned int obj_type);
 /* run all the marks in a group, and clear all of the vfsmount marks */
 static inline void fsnotify_clear_vfsmount_marks_by_group(struct fsnotify_group *group)
 {
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_VFSMOUNT_FL);
+	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_VFSMOUNT);
 }
 /* run all the marks in a group, and clear all of the inode marks */
 static inline void fsnotify_clear_inode_marks_by_group(struct fsnotify_group *group)
 {
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_INODE_FL);
+	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_INODE);
 }
 /* run all the marks in a group, and clear all of the sn marks */
 static inline void fsnotify_clear_sb_marks_by_group(struct fsnotify_group *group)
 {
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_SB_FL);
+	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_SB);
 }
 extern void fsnotify_get_mark(struct fsnotify_mark *mark);
 extern void fsnotify_put_mark(struct fsnotify_mark *mark);
-- 
2.25.1

