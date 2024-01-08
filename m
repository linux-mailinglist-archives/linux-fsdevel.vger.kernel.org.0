Return-Path: <linux-fsdevel+bounces-7540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ECF826D78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815E31C22303
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F16740C1C;
	Mon,  8 Jan 2024 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JARV6rrm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B540BFE
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 65CC53F5B0
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704715811;
	bh=mADyhqp5Fy5mB38qoO1ZIXMT9rQkzzjtNQqjvzvAMZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=JARV6rrmrwl2dhrMxKwjtxHhcxrvvpFrG9B38kB6ZgU8sFjV0WvPP+N3Z8Qj7x8lP
	 2RRTd/AJAbC593xYTRenNmvwiXG+KbzjHUyvS9LcMczyqQHKrCLM51zAxWyrYUD50s
	 +irn3t+jwSALdadtoN7qtoJzpfluHp7N2qzVsq23BvqFPYt1aZlGjHAY76cRzeJtsB
	 zI6/pTboBLxHh0dq3ftvLHAuXz4cpxnlOpqPbppDPv+JxaGdME17pOh30y63bGpMT9
	 O4KGKqp9NNKGeZhqWbHNzbMh5sz+L40kiREgQcGLzuTcsIe3d9Nl6pFZxMxQct/ss9
	 ENsYu+ndcaTIg==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2cd1d820fe7so13859761fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 04:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715811; x=1705320611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mADyhqp5Fy5mB38qoO1ZIXMT9rQkzzjtNQqjvzvAMZk=;
        b=Ii8x9tbcXK5J2GIheeB1i8qxdZcEFzd5P/RV/LqdbEkP8f2t0007VT6A5PmLTrpe0t
         t7DimUoZNd7/NjDfV5KCosVkp8B8V6SOpYQPaCs+SnjMpin/DXZ5sZOVXqgsQHNpJB37
         fcKdyWdxFoJbRFBtOC3KAWVk5xuXP2Q1mxl1IgXIlXyyrK88S0icsNj/DFT1QXiQ9cTP
         b+PMwH+lxDY6mxdh8J91U9z1dpV4nOhbGvdAhVL1ed0UNfD1YhoditTHFMwx9lrm7ubL
         VyfEQXZmYfw4GNI8PBFtHp76xSeAYKcBa7j5uMG7GKIikUkZa15x6HSNyepGZ0id8jUb
         qzSQ==
X-Gm-Message-State: AOJu0YxAgwSl8lo8teTj1LrkC4w3D1zMD+9wPnh20xncThV1s/rKUedg
	k9JSUMVPEmO5IMvkw3jrM2RJKKSjDrIlFNeWo0R9nqqz586gjrLtx4z1zk5VFFUkd+u99jhgt2r
	jGTKJaqCumEVkN3oLgeoM+cBwV4mbqiA70e1Yv7myL8HsfBSCAA==
X-Received: by 2002:a2e:b384:0:b0:2cd:57ba:b4f2 with SMTP id f4-20020a2eb384000000b002cd57bab4f2mr489989lje.79.1704715810870;
        Mon, 08 Jan 2024 04:10:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXiihwIK3jmo6piZR/rMi5zufkqOFkZO264KCNFzXCABUwA04B3BKVjQVddj/nKgCIB6bAsg==
X-Received: by 2002:a2e:b384:0:b0:2cd:57ba:b4f2 with SMTP id f4-20020a2eb384000000b002cd57bab4f2mr489976lje.79.1704715810668;
        Mon, 08 Jan 2024 04:10:10 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056402551500b005578b816f20sm1767959edb.29.2024.01.08.04.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:10:09 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/9] fs/fuse: support idmapped getattr inode op
Date: Mon,  8 Jan 2024 13:08:19 +0100
Message-Id: <20240108120824.122178-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have to:
- pass an idmapping to the generic_fillattr()
to properly handle UIG/GID mapping for the userspace.
- pass -/- to fuse_fillattr() (analog of generic_fillattr() in fuse).

Difference between these two is that generic_fillattr() takes all
the stat() data from the inode directly, while fuse_fillattr() codepath
takes a fresh data just from the userspace reply on the FUSE_GETATTR request.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a0968f086b62..5efcf06622f0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1149,18 +1149,22 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	return err;
 }
 
-static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
-			  struct kstat *stat)
+static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
+			  struct fuse_attr *attr, struct kstat *stat)
 {
 	unsigned int blkbits;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	vfsuid_t vfsuid = make_vfsuid(idmap, fc->user_ns,
+				      make_kuid(fc->user_ns, attr->uid));
+	vfsgid_t vfsgid = make_vfsgid(idmap, fc->user_ns,
+				      make_kgid(fc->user_ns, attr->gid));
 
 	stat->dev = inode->i_sb->s_dev;
 	stat->ino = attr->ino;
 	stat->mode = (inode->i_mode & S_IFMT) | (attr->mode & 07777);
 	stat->nlink = attr->nlink;
-	stat->uid = make_kuid(fc->user_ns, attr->uid);
-	stat->gid = make_kgid(fc->user_ns, attr->gid);
+	stat->uid = vfsuid_into_kuid(vfsuid);
+	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->rdev = inode->i_rdev;
 	stat->atime.tv_sec = attr->atime;
 	stat->atime.tv_nsec = attr->atimensec;
@@ -1199,8 +1203,8 @@ static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
 	attr->blksize = sx->blksize;
 }
 
-static int fuse_do_statx(struct inode *inode, struct file *file,
-			 struct kstat *stat)
+static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
+			 struct file *file, struct kstat *stat)
 {
 	int err;
 	struct fuse_attr attr;
@@ -1253,15 +1257,15 @@ static int fuse_do_statx(struct inode *inode, struct file *file,
 		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
 		stat->btime.tv_sec = sx->btime.tv_sec;
 		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
-		fuse_fillattr(inode, &attr, stat);
+		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}
 
 	return 0;
 }
 
-static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
-			   struct file *file)
+static int fuse_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
+			   struct kstat *stat, struct file *file)
 {
 	int err;
 	struct fuse_getattr_in inarg;
@@ -1300,15 +1304,15 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 					       ATTR_TIMEOUT(&outarg),
 					       attr_version);
 			if (stat)
-				fuse_fillattr(inode, &outarg.attr, stat);
+				fuse_fillattr(idmap, inode, &outarg.attr, stat);
 		}
 	}
 	return err;
 }
 
-static int fuse_update_get_attr(struct inode *inode, struct file *file,
-				struct kstat *stat, u32 request_mask,
-				unsigned int flags)
+static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
+				struct file *file, struct kstat *stat,
+				u32 request_mask, unsigned int flags)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -1339,16 +1343,16 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 		forget_all_cached_acls(inode);
 		/* Try statx if BTIME is requested */
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
-			err = fuse_do_statx(inode, file, stat);
+			err = fuse_do_statx(idmap, inode, file, stat);
 			if (err == -ENOSYS) {
 				fc->no_statx = 1;
 				goto retry;
 			}
 		} else {
-			err = fuse_do_getattr(inode, stat, file);
+			err = fuse_do_getattr(idmap, inode, stat, file);
 		}
 	} else if (stat) {
-		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
+		generic_fillattr(idmap, request_mask, inode, stat);
 		stat->mode = fi->orig_i_mode;
 		stat->ino = fi->orig_ino;
 		if (test_bit(FUSE_I_BTIME, &fi->state)) {
@@ -1362,7 +1366,7 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 
 int fuse_update_attributes(struct inode *inode, struct file *file, u32 mask)
 {
-	return fuse_update_get_attr(inode, file, NULL, mask, 0);
+	return fuse_update_get_attr(&nop_mnt_idmap, inode, file, NULL, mask, 0);
 }
 
 int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
@@ -1506,7 +1510,7 @@ static int fuse_perm_getattr(struct inode *inode, int mask)
 		return -ECHILD;
 
 	forget_all_cached_acls(inode);
-	return fuse_do_getattr(inode, NULL, NULL);
+	return fuse_do_getattr(&nop_mnt_idmap, inode, NULL, NULL);
 }
 
 /*
@@ -2062,7 +2066,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
 			 */
-			ret = fuse_do_getattr(inode, NULL, file);
+			ret = fuse_do_getattr(&nop_mnt_idmap, inode, NULL, file);
 			if (ret)
 				return ret;
 
@@ -2119,7 +2123,7 @@ static int fuse_getattr(struct mnt_idmap *idmap,
 		return -EACCES;
 	}
 
-	return fuse_update_get_attr(inode, NULL, stat, request_mask, flags);
+	return fuse_update_get_attr(idmap, inode, NULL, stat, request_mask, flags);
 }
 
 static const struct inode_operations fuse_dir_inode_operations = {
-- 
2.34.1


