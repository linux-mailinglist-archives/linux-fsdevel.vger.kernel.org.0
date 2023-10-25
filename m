Return-Path: <linux-fsdevel+bounces-1166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9597D6DA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5351A280EC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A228DCA;
	Wed, 25 Oct 2023 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAwL0g3R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03828DBB
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 13:51:06 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED271B5;
	Wed, 25 Oct 2023 06:50:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d9d8284abso3776957f8f.3;
        Wed, 25 Oct 2023 06:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698241856; x=1698846656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91nAEvCKcJvzkrpWMMB/KXjz6VNwzA38eTclBHG/U2o=;
        b=NAwL0g3Rzz0SXrGpvsvaDkHvG68uLjIjxbAx1yP0lhpmVgtoDpN7/i+3AAubnWhyap
         5Sn88VHn+CgSNGi6bOZLs7DiwSTehRFkV9Ou+zESDIG8SSaLukORvvKtWvop/n8ozS7D
         9tK+b6qDi1FVtJHQF7g9JSfcpPlSvDBBgaoClAQ3iVY9HvrlRqzGixPDIHpYjc1ALKqW
         9B6ed1yOkinA0kzRgw22u3vOE4wLaee/vd/myrerxMEUIz2lh0i/lp5DsbO7M6acU9f8
         y0a7jdsiOXSPKW9mvDINUsU/eI/0/p1KND+7Z6rTQiuBEYpy7Q0ANXXzlIxJrY2HrhzC
         Xu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698241856; x=1698846656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91nAEvCKcJvzkrpWMMB/KXjz6VNwzA38eTclBHG/U2o=;
        b=tE6SiDzJERvScw1FSMCSpGwyyon9DOkbKv86rb+ueQy7/tPOz4nNlUf9gKlyhCTXLk
         yWMO+JfG1hwHXFwRqbsXS5iNv4arkfvXgyzMb9PTzktNLEIstTuAbGxz7ul6baODoA8h
         uNciPDaq7WAzB22bMZCFbIqFiyk9lDfno4LXmBzFdGCCTW642OASG4AcrO/VIedJbQn/
         QFOsmj4s1vVtNaoryMtGK/PXaskn0uDXSGTX+MFm0jSRdDKm5vXLwiPi9N7gHwpRpaqP
         fKlUOA7JdT9RmxhnY1BrcOG93F7ronrrUv55kmN4fVgXggyIdZLvProHz1/PZ64aP0qu
         NlIQ==
X-Gm-Message-State: AOJu0YwDahsrQU+AmBSSTdh/5m+/4DJSnifnF031BzDcvQUP+AfGgkDd
	lB7cVxGaA9U0o6nWByb9+6M=
X-Google-Smtp-Source: AGHT+IFDrYCgdccz69WUMHgXYj7KX+OhvzBcYbaetpCMZnVvqC94ZEPTrBCpnE/32qS2Q+Ktj/2j5w==
X-Received: by 2002:adf:e7c6:0:b0:32d:a2d6:4058 with SMTP id e6-20020adfe7c6000000b0032da2d64058mr10569608wrn.62.1698241856136;
        Wed, 25 Oct 2023 06:50:56 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id t8-20020adff048000000b0032dc2110d01sm12143673wro.61.2023.10.25.06.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:50:55 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] fanotify: support reporting events with fid on btrfs sub-volumes
Date: Wed, 25 Oct 2023 16:50:48 +0300
Message-Id: <20231025135048.36153-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025135048.36153-1-amir73il@gmail.com>
References: <20231025135048.36153-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting fanotify marks that report events with fid on btrfs sub-volumes
is not supported, because in the case of btrfs sub-volumes, there is no
uniform fsid that can be cached in the sb connector.

If filesystem supports the cheap ->get_fsid() operation, do not use the
cached fsid in connector and query fsid from inode on every event.
This allows setting fanotify marks that report events with fid on btrfs
sub-volumes.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 28 +++++++++++++++++++++-------
 fs/notify/fanotify/fanotify_user.c | 14 ++++++++++----
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 9dac7f6e72d2..25282ca0173d 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -535,6 +535,21 @@ static struct inode *fanotify_dfid_inode(u32 event_mask, const void *data,
 	return dir;
 }
 
+/*
+ * If @inode is available and if filesystem supports ->get_fsid(), return the
+ * fsid associated with the inode.  Otherwise, return the pre cached fsid.
+ */
+static __kernel_fsid_t fanotify_inode_fsid(struct inode *inode,
+					   __kernel_fsid_t *fsid)
+{
+	__kernel_fsid_t __fsid;
+
+	if (inode && inode_get_fsid(inode, &__fsid) == 0)
+		return __fsid;
+
+	return *fsid;
+}
+
 static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
 							unsigned int *hash,
 							gfp_t gfp)
@@ -586,8 +601,8 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 		return NULL;
 
 	ffe->fae.type = FANOTIFY_EVENT_TYPE_FID;
-	ffe->fsid = *fsid;
-	*hash ^= fanotify_hash_fsid(fsid);
+	ffe->fsid = fanotify_inode_fsid(id, fsid);
+	*hash ^= fanotify_hash_fsid(&ffe->fsid);
 	fanotify_encode_fh(&ffe->object_fh, id, fanotify_encode_fh_len(id),
 			   hash, gfp);
 
@@ -627,8 +642,8 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 		return NULL;
 
 	fne->fae.type = FANOTIFY_EVENT_TYPE_FID_NAME;
-	fne->fsid = *fsid;
-	*hash ^= fanotify_hash_fsid(fsid);
+	fne->fsid = fanotify_inode_fsid(dir, fsid);
+	*hash ^= fanotify_hash_fsid(&fne->fsid);
 	info = &fne->info;
 	fanotify_info_init(info);
 	if (dir_fh_len) {
@@ -691,9 +706,10 @@ static struct fanotify_event *fanotify_alloc_error_event(
 	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
 	fee->error = report->error;
 	fee->err_count = 1;
-	fee->fsid = *fsid;
 
 	inode = report->inode;
+	fee->fsid = fanotify_inode_fsid(inode, fsid);
+	*hash ^= fanotify_hash_fsid(&fee->fsid);
 	fh_len = fanotify_encode_fh_len(inode);
 
 	/* Bad fh_len. Fallback to using an invalid fh. Should never happen. */
@@ -702,8 +718,6 @@ static struct fanotify_event *fanotify_alloc_error_event(
 
 	fanotify_encode_fh(&fee->object_fh, inode, fh_len, NULL, 0);
 
-	*hash ^= fanotify_hash_fsid(fsid);
-
 	return &fee->fae;
 }
 
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0eb9622e8a9f..ed67e5f973ab 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1570,16 +1570,22 @@ static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
 		return -ENODEV;
 
 	/*
-	 * Make sure dentry is not of a filesystem subvolume (e.g. btrfs)
-	 * which uses a different fsid than sb root.
+	 * If dentry is on a filesystem subvolume (e.g. btrfs), which uses a
+	 * different fsid than sb root, then make sure that filesytem supports
+	 * getting fsid from inode.
 	 */
 	err = vfs_get_fsid(dentry->d_sb->s_root, &root_fsid);
 	if (err)
 		return err;
 
 	if (root_fsid.val[0] != fsid->val[0] ||
-	    root_fsid.val[1] != fsid->val[1])
-		return -EXDEV;
+	    root_fsid.val[1] != fsid->val[1]) {
+		if (!dentry->d_sb->s_op->get_fsid)
+			return -EXDEV;
+
+		/* Cache root fsid in case inode is not available on event */
+		*fsid = root_fsid;
+	}
 
 	return 0;
 }
-- 
2.34.1


