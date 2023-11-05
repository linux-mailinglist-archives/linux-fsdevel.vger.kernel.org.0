Return-Path: <linux-fsdevel+bounces-1980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD697E1267
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 07:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758E01C209CB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 06:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246CB5249;
	Sun,  5 Nov 2023 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ/dLcjv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF31FD8
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 06:36:19 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688CB191
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 23:36:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6bcbfecf314so1146444b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Nov 2023 23:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699166177; x=1699770977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVV/JFrsHloD5JD0VwL780wmGKR3Lipa3n1XUu1O1fk=;
        b=CZ/dLcjviO/CwPqdRW0vpAbTBXj3lbFHdPAMU5TISN5aJBQUAcJLWBVCLal1LS9eqf
         eh1pnrWG9IQdJI4mI0/SuXcNjDX7MOrnk1v1dbd9lfCsBtgoIWnRKafdryUl7gGAS49Y
         m3baG+/YmHILJIrZjG/893eT9/0hI014ii4SrVgpyjN6d+rgqZpQpMb2cPf1xFLs9MAK
         8yC/NSIe0uN1mAgKgqhxAAkBbUtZHjtHdleF4gQOSqucoiv0uGUTx2pYTvrRSU/teKYJ
         IiwfbIBF1BZSTiWCftOL7n+OKWMGobrj/HzeIcfjymUxwBs3iBX4nmICGTr+ezWQoZLd
         u7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699166177; x=1699770977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVV/JFrsHloD5JD0VwL780wmGKR3Lipa3n1XUu1O1fk=;
        b=hg39u34r2qZWQ5avzM6YLR/BBwzY5swI2aV9m58fxTgNB9ds2jsje4Zxq/GVT/qyJo
         JDHA/8sKQPsw/NStOqr/kJsROCUdaBXhNqiSF4NGCBguQo3k0wb2bZrgX3Hh+utbt0eP
         Ip7lGyrV2CkLH1hJuB7MCkuL2/II34dYWTg0Z/SaqGQwMcxz/J/T6Slg5cVhuMwR2krl
         HJ17DpCmOZkZqnW7lxYmFhlzp9KKJB0qjOJnbvI/4uRd91lMnX+EtePXTh2MBnbGKBAY
         LNJ27GCFyYvXihiB+uovwS7IiEe+cvs8mEMfEe0RTClcO2gWuGLaI7zXLO8cbr14NMbx
         6RYg==
X-Gm-Message-State: AOJu0Yzef8p8WiOUmYXAd/EhGbKBNrBC5sCLewtEvHGqRAKoOmKNngwm
	1PHe0uN6faQO0jlrgNihJNBnyZ6a8Og=
X-Google-Smtp-Source: AGHT+IHvmNYKqJQZ4A4QiEtAUmKlb+OgctonTDH1BSYcQqWPd2lC9t2Lpci5o7zcHykhZgLhA/dfwA==
X-Received: by 2002:a05:6a21:788f:b0:16e:26fd:7c02 with SMTP id bf15-20020a056a21788f00b0016e26fd7c02mr33225410pzc.2.1699166176685;
        Sat, 04 Nov 2023 23:36:16 -0700 (PDT)
Received: from us-160370-mp13.lan ([73.241.216.146])
        by smtp.gmail.com with ESMTPSA id t23-20020a656097000000b005afdd58bab2sm3157412pgu.30.2023.11.04.23.36.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Nov 2023 23:36:16 -0700 (PDT)
From: obuil.liubo@gmail.com
To: fuse-devel@lists.sourceforge.net
Cc: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: fix stale data issue of virtiofs with dax
Date: Sat,  4 Nov 2023 23:36:08 -0700
Message-Id: <20231105063608.68114-1-obuil.liubo@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Bo <bo.liu@linux.alibaba.com>

In open(O_TRUNC), it doesn't cleanup the corresponding dax mapping of
an inode, which could expose stale data to users, which can be easily
reproduced by accessing overlayfs through virtiofs with dax.

The reproducer is,
0. mkdir /home/test/lower /home/test/upper /home/test/work
1. echo "aaaaaa" > /home/test/lower/foobar
2. sudo mount -t overlay overlay -olowerdir=/home/test/lower,upperdir=/home/test/upper,workdir=/home/test/work /mnt/ovl
3. start a guest VM configured with virtiofs passthrough(_dax_ enabled and cache policy is always)
   and use /mnt/ovl as the source directory.
4. ssh into the guest VM
5. mount virtiofs onto /mnt/test
5. cat /mnt/test/foobar
aaaaaa
6. echo "xxxx" > /mnt/test/foobar
7. cat /mnt/test/foobar

w/o this patch, step 7 shows "aaaa" rather than "xxxx".

Step 5 reads the content of file 'foobar' by setting up a dax mapping, and the
mapping eventually maps /home/test/lower/foobar because there is no copy up
at this moment.

In step 6, 'foobar' is opened with O_TRUNC and the viriofs daemon on host side
triggers a copy-up, "xxxx" is eventually written to /home/test/upper/foobar.
Since 'foobar' is truncated to size 0 when writting, writes go with non-dax io
path and update the file size in guest VM accordingly.

However, dax mapping still refers to the /home/test/lower/foobar, so what step
7 reads is /home/test/lower/foobar but with the new size, which shows "aaaa"
rather "xxxx".

Reported-by: Cameron <cameron@northflank.com>
Tested-by: Cameron <cameron@northflank.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 fs/fuse/dax.c    | 9 +++++++++
 fs/fuse/dir.c    | 5 +++++
 fs/fuse/fuse_i.h | 1 +
 3 files changed, 15 insertions(+)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 8e74f278a3f6..d7f9ec7f4597 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -385,6 +385,15 @@ void fuse_dax_inode_cleanup(struct inode *inode)
 	WARN_ON(fi->dax->nr);
 }
 
+/* Callers need to make sure fi->i_mmap_sem is held. */
+void fuse_dax_inode_cleanup_range(struct inode *inode, loff_t start)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	inode_reclaim_dmap_range(fc->dax, inode, start, -1);
+}
+
 static void fuse_fill_iomap_hole(struct iomap *iomap, loff_t length)
 {
 	iomap->addr = IOMAP_NULL_ADDR;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f67bef9d83c4..be7892e052b5 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1788,6 +1788,9 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 			 */
 			i_size_write(inode, 0);
 			truncate_pagecache(inode, 0);
+			if (fault_blocked && FUSE_IS_DAX(inode))
+				fuse_dax_inode_cleanup(inode);
+
 			goto out;
 		}
 		file = NULL;
@@ -1883,6 +1886,8 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	    S_ISREG(inode->i_mode) && oldsize != outarg.attr.size) {
 		truncate_pagecache(inode, outarg.attr.size);
 		invalidate_inode_pages2(mapping);
+		if (fault_blocked && FUSE_IS_DAX(inode))
+			fuse_dax_inode_cleanup_range(inode, outarg.attr.size);
 	}
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b7fc7d3c7f1..02fa7aa2bd56 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1305,6 +1305,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc);
 bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
 void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
 void fuse_dax_inode_cleanup(struct inode *inode);
+void fuse_dax_inode_cleanup_range(struct inode *inode, loff_t start);
 void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
 void fuse_dax_cancel_work(struct fuse_conn *fc);
-- 
2.32.1 (Apple Git-133)


