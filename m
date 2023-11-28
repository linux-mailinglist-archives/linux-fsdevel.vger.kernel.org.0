Return-Path: <linux-fsdevel+bounces-4051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C26D7FBED9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 17:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1511C20C4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 16:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0B25C8EE;
	Tue, 28 Nov 2023 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WP1hlcyP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F32A1BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 08:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701187427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0zwWzL4LnouvSC6RVe208OxiX7Lwfh27TloREnRbLc=;
	b=WP1hlcyP2EonH8zWsECQ5W22Hhp8bpwOTFDIRi8rFGRd0uXQ2/3do1vnoRO1FbFHPxcc7U
	hgOAmgx9TJdx36sdr1ZKHmMPCeuzAWWWUnfFRuZ7Pbl1iWFYXG5W6lyTjDL+PsKhHYgmyO
	u9EH8IAGmqXQ1ZUad627UaAAZFxwZAQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-fg1t2DiLMAaJnsnyQI7ZSA-1; Tue, 28 Nov 2023 11:03:45 -0500
X-MC-Unique: fg1t2DiLMAaJnsnyQI7ZSA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332fab597afso1901830f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 08:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187425; x=1701792225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0zwWzL4LnouvSC6RVe208OxiX7Lwfh27TloREnRbLc=;
        b=LOr7pEUU05RcIHofwwHvkp1xix8RgIGbr8BFS57NIurXSWq0pMmfKnMix2CQWCYxGN
         FB/2GDipp6HTt8i1kxOxNu7a5rIY0bKwgVwp01S3XFMS8ypiCU82WOjG8PBbjn1jffcd
         ZAV0BYnkSwXbvwm7gwlBmoX4jQokk+Qt5xlnDkz9C3NxWJUTXfQy7YOWqlR4LG1i5qIu
         M0LRTPwPkhOInKKacSrpBWJI0uZvsi3UNDe7zQob2GbB1ikc/dI1+kckw7YT6Gg+fei4
         DOgNqggG8GAcKYNkF0IA+KFKCKl1+ojzZpgczUmABD3x5fKKVeVHQox1NsiNXEEsgcWp
         7i2w==
X-Gm-Message-State: AOJu0Yypu3/Xp7Ke2kYvZT5JqEVfCwHPGeGFT8IArwA9/p6Wj6erdswb
	XzueJ/UEo15sMe0Kvzqp2JG9i4ZnnxnV28UDgVFAcXg0M5CWLc1kSDx3uPV56gQWF4otwOwMuAd
	ynpMJqUrCqQw9FAR11kEuO2yEiA==
X-Received: by 2002:a5d:6da7:0:b0:333:13ce:dc8c with SMTP id u7-20020a5d6da7000000b0033313cedc8cmr399078wrs.13.1701187424798;
        Tue, 28 Nov 2023 08:03:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiOfaV75sGNSINsDpeEEds9KGbjsyagDyEpffjIbzoesRBATKMzILUEn1SQPtaalN7o6I1qQ==
X-Received: by 2002:a5d:6da7:0:b0:333:13ce:dc8c with SMTP id u7-20020a5d6da7000000b0033313cedc8cmr399051wrs.13.1701187424562;
        Tue, 28 Nov 2023 08:03:44 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-163.pool.digikabel.hu. [89.148.117.163])
        by smtp.gmail.com with ESMTPSA id w27-20020adf8bdb000000b00332e5624a31sm14745352wra.84.2023.11.28.08.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:03:43 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/4] listmount: rip out flags
Date: Tue, 28 Nov 2023 17:03:32 +0100
Message-ID: <20231128160337.29094-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128160337.29094-1-mszeredi@redhat.com>
References: <20231128160337.29094-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LISTMOUNT_UNREACHABLE will be achieved differently in a following patch.

LISTMOUNT_RECURSIVE becomes the default.  If non-recursive listing turns
out to be needed, it can be added later.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c             | 49 +++++++++++++-------------------------
 include/uapi/linux/mount.h |  4 ----
 2 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cb338ab18db9..9b4cb25c25ed 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5004,18 +5004,13 @@ static struct mount *listmnt_first(struct mount *root)
 	return list_first_entry_or_null(&root->mnt_mounts, struct mount, mnt_child);
 }
 
-static struct mount *listmnt_next(struct mount *curr, struct mount *root, bool recurse)
+static struct mount *listmnt_next(struct mount *curr, struct mount *root)
 {
-	if (recurse)
-		return next_mnt(curr, root);
-	if (!list_is_head(curr->mnt_child.next, &root->mnt_mounts))
-		return list_next_entry(curr, mnt_child);
-	return NULL;
+	return next_mnt(curr, root);
 }
 
 static ssize_t do_listmount(struct vfsmount *mnt, u64 __user *buf,
-			    size_t bufsize, const struct path *root,
-			    unsigned int flags)
+			    size_t bufsize, const struct path *root)
 {
 	struct mount *r, *m = real_mount(mnt);
 	struct path rootmnt = {
@@ -5023,26 +5018,17 @@ static ssize_t do_listmount(struct vfsmount *mnt, u64 __user *buf,
 		.dentry = root->mnt->mnt_root
 	};
 	ssize_t ctr;
-	bool reachable_only = true;
-	bool recurse = flags & LISTMOUNT_RECURSIVE;
 	int err;
 
-	if (flags & LISTMOUNT_UNREACHABLE) {
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		reachable_only = false;
-	}
-
-	if (reachable_only && !is_path_reachable(m, mnt->mnt_root, &rootmnt))
+	if (!is_path_reachable(m, mnt->mnt_root, &rootmnt))
 		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
 
 	err = security_sb_statfs(mnt->mnt_root);
 	if (err)
 		return err;
 
-	for (ctr = 0, r = listmnt_first(m); r; r = listmnt_next(r, m, recurse)) {
-		if (reachable_only &&
-		    !is_path_reachable(r, r->mnt.mnt_root, root))
+	for (ctr = 0, r = listmnt_first(m); r; r = listmnt_next(r, m)) {
+		if (!is_path_reachable(r, r->mnt.mnt_root, root))
 			continue;
 
 		if (ctr >= bufsize)
@@ -5065,7 +5051,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	u64 mnt_id;
 	ssize_t ret;
 
-	if (flags & ~(LISTMOUNT_UNREACHABLE | LISTMOUNT_RECURSIVE))
+	if (flags)
 		return -EINVAL;
 
 	if (copy_from_user(&kreq, req, sizeof(kreq)))
@@ -5075,20 +5061,17 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	mnt_id = kreq.mnt_id;
 
 	down_read(&namespace_sem);
-	if (mnt_id == LSMT_ROOT)
-		mnt = &current->nsproxy->mnt_ns->root->mnt;
-	else
-		mnt = lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
-	if (!mnt) {
-		up_read(&namespace_sem);
-		return -ENOENT;
-	}
-
 	get_fs_root(current->fs, &root);
-	/* Skip unreachable for LSMT_ROOT */
-	if (mnt_id == LSMT_ROOT && !(flags & LISTMOUNT_UNREACHABLE))
+	if (mnt_id == LSMT_ROOT) {
 		mnt = root.mnt;
-	ret = do_listmount(mnt, buf, bufsize, &root, flags);
+	} else {
+		ret = -ENOENT;
+		mnt = lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
+		if (!mnt)
+			goto err;
+	}
+	ret = do_listmount(mnt, buf, bufsize, &root);
+err:
 	path_put(&root);
 	up_read(&namespace_sem);
 	return ret;
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 7a5bd0b24a62..f6b35a15b7dd 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -191,10 +191,6 @@ struct mnt_id_req {
 #define STATMOUNT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
 #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
 
-/* listmount(2) flags */
-#define LISTMOUNT_UNREACHABLE	0x01U	/* List unreachable mounts too */
-#define LISTMOUNT_RECURSIVE	0x02U	/* List a mount tree */
-
 /*
  * Special @mnt_id values that can be passed to listmount
  */
-- 
2.41.0


