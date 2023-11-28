Return-Path: <linux-fsdevel+bounces-4052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EE67FBEDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 17:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1196B21576
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6366058AC1;
	Tue, 28 Nov 2023 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHl2RhqE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0503712A
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 08:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701187434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHWP4CgGMGQMa05oAicwuViSFvoHVKUifmpkz3RoaX8=;
	b=bHl2RhqEz3YKH8lD6v1Pp8G5P/dSKy+kkpQS2EypRehQqd+2+XZEsA02W5sbTDnJIhmFiW
	avnfMOOjp55JhHQSpkf5WSSm8/mTwgr8L36RlYZQWeHebOJjJj+RPoxQdcIbam1lH9CIOL
	saMYAw40hKXRTFEtUvGFZ5lSx7WMjeo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-6NSE9PPjOHKTYrUr2jGkng-1; Tue, 28 Nov 2023 11:03:49 -0500
X-MC-Unique: 6NSE9PPjOHKTYrUr2jGkng-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b346a11d9so32045445e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 08:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187427; x=1701792227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHWP4CgGMGQMa05oAicwuViSFvoHVKUifmpkz3RoaX8=;
        b=oaqtW+mK7IVdeagdmGwZHfO7CUgBBbZ5YgcZ562EiGPUpzq35cCB6buTOYMqB1V2w6
         TF0oMi9IAopzPLnNGt8XQ3PyE4XgBj3sb7ol5H2j6EiuANXhhSiO+PcrXURc6TrWi0wW
         IesTxVh3Ogd9Di2wp4M1PU9gk35gm/XI58YiGt83HLJWZOLtuuNQG+4CmhL+VNRx8tKo
         SqWNqchUachS0eJ7KIRCgtnbp/0OWy8tno6N2iapvaCcj70X3xsONnGnnO9BqUgxIeqa
         OssF24OgyzKIE9phIBsu/vQla4r9O2F2z67+6zOLK85nvq2IcTuQaKmujk6w2yVzuIpu
         3pvg==
X-Gm-Message-State: AOJu0YxRoJOM3AlN80ODM0cOo269bMOEhW8VsiqZq5WF2b2esQBs8cCX
	YbvgoJrW0KmlXVmYdkcuHb16NYqN3hSFOcjsgALs5595wvkAv290DFyD+dRmVf63tyJiE90dYrB
	h8+1xt8ytIt5mxMvJmX5qKumqYYwYKVspcQ==
X-Received: by 2002:a5d:6346:0:b0:332:f3c9:1c8b with SMTP id b6-20020a5d6346000000b00332f3c91c8bmr6888837wrw.35.1701187427207;
        Tue, 28 Nov 2023 08:03:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeAuJxAOs5c/9tnwUokFzgY0Drl2v1Y2ITVtVNS8ZYHkGucf8lZeJyedz1R9kZoZu7mu1PWg==
X-Received: by 2002:a5d:6346:0:b0:332:f3c9:1c8b with SMTP id b6-20020a5d6346000000b00332f3c91c8bmr6888808wrw.35.1701187426874;
        Tue, 28 Nov 2023 08:03:46 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-163.pool.digikabel.hu. [89.148.117.163])
        by smtp.gmail.com with ESMTPSA id w27-20020adf8bdb000000b00332e5624a31sm14745352wra.84.2023.11.28.08.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:03:45 -0800 (PST)
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
Subject: [PATCH 2/4] listmount: list mounts in ID order
Date: Tue, 28 Nov 2023 17:03:33 +0100
Message-ID: <20231128160337.29094-3-mszeredi@redhat.com>
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

This is needed to allow continuing from a midpoint.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9b4cb25c25ed..ad62cf7ee334 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1010,7 +1010,7 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
 
 static inline struct mount *node_to_mount(struct rb_node *node)
 {
-	return rb_entry(node, struct mount, mnt_node);
+	return node ? rb_entry(node, struct mount, mnt_node) : NULL;
 }
 
 static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
@@ -4999,24 +4999,21 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	return ret;
 }
 
-static struct mount *listmnt_first(struct mount *root)
+static struct mount *listmnt_next(struct mount *curr)
 {
-	return list_first_entry_or_null(&root->mnt_mounts, struct mount, mnt_child);
+	return node_to_mount(rb_next(&curr->mnt_node));
 }
 
-static struct mount *listmnt_next(struct mount *curr, struct mount *root)
-{
-	return next_mnt(curr, root);
-}
-
-static ssize_t do_listmount(struct vfsmount *mnt, u64 __user *buf,
-			    size_t bufsize, const struct path *root)
+static ssize_t do_listmount(struct mount *first, struct vfsmount *mnt,
+			    u64 __user *buf, size_t bufsize,
+			    const struct path *root)
 {
 	struct mount *r, *m = real_mount(mnt);
 	struct path rootmnt = {
 		.mnt = root->mnt,
 		.dentry = root->mnt->mnt_root
 	};
+	struct path orig;
 	ssize_t ctr;
 	int err;
 
@@ -5027,8 +5024,17 @@ static ssize_t do_listmount(struct vfsmount *mnt, u64 __user *buf,
 	if (err)
 		return err;
 
-	for (ctr = 0, r = listmnt_first(m); r; r = listmnt_next(r, m)) {
-		if (!is_path_reachable(r, r->mnt.mnt_root, root))
+	if (root->mnt == mnt) {
+		orig = *root;
+	} else {
+		orig.mnt = mnt;
+		orig.dentry = mnt->mnt_root;
+	}
+
+	for (ctr = 0, r = first; r; r = listmnt_next(r)) {
+		if (r == m)
+			continue;
+		if (!is_path_reachable(r, r->mnt.mnt_root, &orig))
 			continue;
 
 		if (ctr >= bufsize)
@@ -5045,8 +5051,10 @@ static ssize_t do_listmount(struct vfsmount *mnt, u64 __user *buf,
 SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 		u64 __user *, buf, size_t, bufsize, unsigned int, flags)
 {
+	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mnt_id_req kreq;
 	struct vfsmount *mnt;
+	struct mount *first;
 	struct path root;
 	u64 mnt_id;
 	ssize_t ret;
@@ -5066,11 +5074,13 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 		mnt = root.mnt;
 	} else {
 		ret = -ENOENT;
-		mnt = lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
+		mnt  = lookup_mnt_in_ns(mnt_id, ns);
 		if (!mnt)
 			goto err;
 	}
-	ret = do_listmount(mnt, buf, bufsize, &root);
+	first = node_to_mount(rb_first(&ns->mounts));
+
+	ret = do_listmount(first, mnt, buf, bufsize, &root);
 err:
 	path_put(&root);
 	up_read(&namespace_sem);
-- 
2.41.0


