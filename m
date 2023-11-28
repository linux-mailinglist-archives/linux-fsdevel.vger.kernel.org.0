Return-Path: <linux-fsdevel+bounces-4054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047E97FBEE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 17:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3401B1C20D1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398841E4BB;
	Tue, 28 Nov 2023 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWzajuFq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC652D5B
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 08:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701187445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omywh3uYUA+OP9xtT6bY+D59biyAwUJXDod3WOPdRWc=;
	b=KWzajuFqxzQRey8wsCi9uxiSzh2gXf1SVHxIa200eCucA1YDknxkxbD+IPET6hgKKr1RqR
	6EOhJ/VM/OmFUJnpprCRhxnZZcBXYvuGEzj8x3052UYjOEWCJi6WWKUeFuXXUct+wMFnVl
	JlJBv5u7GPXLe+eq6p4XLzXTSas5MBU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-smrg8S2cNb27phBZvmOGwQ-1; Tue, 28 Nov 2023 11:03:55 -0500
X-MC-Unique: smrg8S2cNb27phBZvmOGwQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-333112c1e72so429427f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 08:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187429; x=1701792229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omywh3uYUA+OP9xtT6bY+D59biyAwUJXDod3WOPdRWc=;
        b=kneQbWRalUnME/iKf4tb8WJ++Rxi227skaZuCskVRG1GQg9kMYKVGtP9WMSUIKzlXq
         JssVjUdDekFvKRFBPcIflkTUvFAGfgtu2DuhyFaeG+dF914q2hBdNcnzi8lzwQZW8S64
         NfqfgiJhi4z03VgfmI9OapOICkdmZtATVtJR9RB8ot7U94wHQykifI49FogEqyVbekGO
         9MMgrYRHmbZtQ2kGxR0sXYCNYn1/kbNlgDKeliSLQdRXeYG0Qi5HiyvHmnmQFkaaZfSq
         AIV4uzTM+8kCRCqWALgWpG09pQ2mVtDNO6b3XlqFCl1RGJmNFSz+6kmhBspxLU4/4Al7
         862A==
X-Gm-Message-State: AOJu0YwZLzLy4Vg5e3dDwmn/0YjFT8DpOjfngXuTzoJ83oICEJVACU/f
	yguA4F9ML1vJQQQt72s2zyZbhbnim5D5QUBFVxhxf+255PIeW+jt/Mq8v6PPyK0x/q0U32tu2ON
	sxHeh6zvIXzlzk+Vb0Dv14f+73w==
X-Received: by 2002:adf:f1c1:0:b0:333:57:52dc with SMTP id z1-20020adff1c1000000b00333005752dcmr6968619wro.28.1701187429400;
        Tue, 28 Nov 2023 08:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjBXrvjTmUnqUbvz6X5Z6wicgMGQwKTpwouHd6eOg+ohVwquafvdjG1qDYQ2HQi5uGrlK3bQ==
X-Received: by 2002:adf:f1c1:0:b0:333:57:52dc with SMTP id z1-20020adff1c1000000b00333005752dcmr6968581wro.28.1701187429027;
        Tue, 28 Nov 2023 08:03:49 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-163.pool.digikabel.hu. [89.148.117.163])
        by smtp.gmail.com with ESMTPSA id w27-20020adf8bdb000000b00332e5624a31sm14745352wra.84.2023.11.28.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:03:47 -0800 (PST)
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
Subject: [PATCH 3/4] listmount: small changes in semantics
Date: Tue, 28 Nov 2023 17:03:34 +0100
Message-ID: <20231128160337.29094-4-mszeredi@redhat.com>
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

1) Make permission checking consistent with statmount(2): fail if mount is
unreachable from current root.  Previously it failed if mount was
unreachable from root->mnt->mnt_root.

2) List all submounts, even if unreachable from current root.  This is
safe, since 1) will prevent listing unreachable mounts for unprivileged
users.

3) LSMT_ROOT is unchaged, it lists mounts under current root.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ad62cf7ee334..10cd651175b5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5004,37 +5004,26 @@ static struct mount *listmnt_next(struct mount *curr)
 	return node_to_mount(rb_next(&curr->mnt_node));
 }
 
-static ssize_t do_listmount(struct mount *first, struct vfsmount *mnt,
+static ssize_t do_listmount(struct mount *first, struct path *orig, u64 mnt_id,
 			    u64 __user *buf, size_t bufsize,
 			    const struct path *root)
 {
-	struct mount *r, *m = real_mount(mnt);
-	struct path rootmnt = {
-		.mnt = root->mnt,
-		.dentry = root->mnt->mnt_root
-	};
-	struct path orig;
+	struct mount *r;
 	ssize_t ctr;
 	int err;
 
-	if (!is_path_reachable(m, mnt->mnt_root, &rootmnt))
-		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
+	if (!capable(CAP_SYS_ADMIN) &&
+	    !is_path_reachable(real_mount(orig->mnt), orig->dentry, root))
+		return -EPERM;
 
-	err = security_sb_statfs(mnt->mnt_root);
+	err = security_sb_statfs(orig->dentry);
 	if (err)
 		return err;
 
-	if (root->mnt == mnt) {
-		orig = *root;
-	} else {
-		orig.mnt = mnt;
-		orig.dentry = mnt->mnt_root;
-	}
-
 	for (ctr = 0, r = first; r; r = listmnt_next(r)) {
-		if (r == m)
+		if (r->mnt_id_unique == mnt_id)
 			continue;
-		if (!is_path_reachable(r, r->mnt.mnt_root, &orig))
+		if (!is_path_reachable(r, r->mnt.mnt_root, orig))
 			continue;
 
 		if (ctr >= bufsize)
@@ -5053,9 +5042,8 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 {
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mnt_id_req kreq;
-	struct vfsmount *mnt;
 	struct mount *first;
-	struct path root;
+	struct path root, orig;
 	u64 mnt_id;
 	ssize_t ret;
 
@@ -5071,16 +5059,17 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	down_read(&namespace_sem);
 	get_fs_root(current->fs, &root);
 	if (mnt_id == LSMT_ROOT) {
-		mnt = root.mnt;
+		orig = root;
 	} else {
 		ret = -ENOENT;
-		mnt  = lookup_mnt_in_ns(mnt_id, ns);
-		if (!mnt)
+		orig.mnt  = lookup_mnt_in_ns(mnt_id, ns);
+		if (!orig.mnt)
 			goto err;
+		orig.dentry = orig.mnt->mnt_root;
 	}
 	first = node_to_mount(rb_first(&ns->mounts));
 
-	ret = do_listmount(first, mnt, buf, bufsize, &root);
+	ret = do_listmount(first, &orig, mnt_id, buf, bufsize, &root);
 err:
 	path_put(&root);
 	up_read(&namespace_sem);
-- 
2.41.0


