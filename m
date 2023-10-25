Return-Path: <linux-fsdevel+bounces-1164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 630DA7D6DA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F07B212B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 13:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782F728DC8;
	Wed, 25 Oct 2023 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRXhNJ6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCD28DBE
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 13:51:00 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899BD1AA;
	Wed, 25 Oct 2023 06:50:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso42161255e9.0;
        Wed, 25 Oct 2023 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698241854; x=1698846654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1diB7enl1V+4HSpm+PP9l4uUnLukeVGNUbE2JiZFbWw=;
        b=IRXhNJ6gKFzqJQGnTx8QG/hPPZjgh9j+v5LQAQVL4flFgvaiAfevLa0IvOG1ojO8gr
         +XsVUKSFD/vtqzQwK+uZFrNnVEZgd8wT1jSrW4v1K0a0vzEK4aqLTMAhwH6DYsqpRM/W
         vrWY631eviJs9+fITaJqQTTV7XdobVAd/7ezErQcq6vvZECGJLdWOvg5+BkJsQyiWDTN
         IRBsGdlmUhmK/6jLsBHSvhsz21MAhqTmDhOzAuEVE5uZ5yo1kKxNTquiJd8rNG06zuM5
         GEmxXmdG9AKbnCsTj4voVPk2yNNN3kkYWXayKz9jPv5veHYkRwuJFADgJmYmTXrK1lej
         O6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698241854; x=1698846654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1diB7enl1V+4HSpm+PP9l4uUnLukeVGNUbE2JiZFbWw=;
        b=fZxSaf2Sjd+h8o5I67mZ9PGVjI2GEeJQZ+ly02lk2QCE3eKN8bp+cXLdxCpde7rvWh
         wbX1nXQ5YiH8NKiuIB/C1tZ1J01IrcTtowpFTn6cBp+MlZk+C0k/CXv6xRP98iwSiCLy
         0xvDwwQcM/eKzc9s8fSvs+i7ty5hYZfiGVNMxkzaOoE2/d7rFl75zkRym4aIoYsVX15q
         q/m76zw5rCvRCAsvnTQsM9DucZOLrETssPpczqIubWWZggYT7Ey8wdD22UAgsRddRu+z
         k3h7qVZI3BATixhe8yRZicewwy91a/b2NnwFAi0fC0GMP05e1ixHw+MJ6s7i4wE+Iyd/
         0IZg==
X-Gm-Message-State: AOJu0Yy9BCdSU6ZozxxYIOVTHlcxgrXiRNWgTAn5D4PEX3vW+08+gB8T
	NP9x9luZvYTvh5SaBauTcC0=
X-Google-Smtp-Source: AGHT+IFk5k8WXH8olXg67BAIosb3J+eExXg18C/JJhSWDjFSFaYigso/d60rY33wbnCJWjncCVIFTg==
X-Received: by 2002:a5d:4686:0:b0:32d:b991:1a71 with SMTP id u6-20020a5d4686000000b0032db9911a71mr10032308wrq.0.1698241853542;
        Wed, 25 Oct 2023 06:50:53 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id t8-20020adff048000000b0032dc2110d01sm12143673wro.61.2023.10.25.06.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:50:53 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] fs: define a new super operation to get fsid
Date: Wed, 25 Oct 2023 16:50:46 +0300
Message-Id: <20231025135048.36153-2-amir73il@gmail.com>
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

If implemented, get_fsid() can be used as a cheaper way of getting
the f_fsid memeber of kstatfs, for callers that only care about fsid.

fanotify is going to make use of that to get btrfs fsid from inode on
every event.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230920110429.f4wkfuls73pd55pv@quack3/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/filesystems/locking.rst |  2 ++
 Documentation/filesystems/vfs.rst     |  4 ++++
 fs/statfs.c                           | 14 ++++++++++++++
 include/linux/fs.h                    |  1 +
 include/linux/statfs.h                |  2 ++
 5 files changed, 23 insertions(+)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 7be2900806c8..a367950ee755 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -169,6 +169,7 @@ prototypes::
 	int (*freeze_fs) (struct super_block *);
 	int (*unfreeze_fs) (struct super_block *);
 	int (*statfs) (struct dentry *, struct kstatfs *);
+	int (*get_fsid) (struct inode *, __kernel_fsid_t *);
 	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*umount_begin) (struct super_block *);
 	int (*show_options)(struct seq_file *, struct dentry *);
@@ -193,6 +194,7 @@ sync_fs:		read
 freeze_fs:		write
 unfreeze_fs:		write
 statfs:			maybe(read)	(see below)
+get_fsid:               no
 remount_fs:		write
 umount_begin:		no
 show_options:		no		(namespace_sem)
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 99acc2e98673..f30f39f056ab 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -267,6 +267,7 @@ filesystem.  The following members are defined:
 					enum freeze_wholder who);
 		int (*unfreeze_fs) (struct super_block *);
 		int (*statfs) (struct dentry *, struct kstatfs *);
+		int (*get_fsid) (struct inode *, __kernel_fsid_t *);
 		int (*remount_fs) (struct super_block *, int *, char *);
 		void (*umount_begin) (struct super_block *);
 
@@ -374,6 +375,9 @@ or bottom half).
 ``statfs``
 	called when the VFS needs to get filesystem statistics.
 
+``get_fsid``
+	called when the VFS needs to get only the f_fsid member of statfs.
+
 ``remount_fs``
 	called when the filesystem is remounted.  This is called with
 	the kernel lock held
diff --git a/fs/statfs.c b/fs/statfs.c
index 96d1c3edf289..60a6af7356b7 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -69,11 +69,25 @@ static int statfs_by_dentry(struct dentry *dentry, struct kstatfs *buf)
 	return retval;
 }
 
+int inode_get_fsid(struct inode *inode, __kernel_fsid_t *fsid)
+{
+	if (!inode->i_sb->s_op->get_fsid)
+		return -EOPNOTSUPP;
+
+	return inode->i_sb->s_op->get_fsid(inode, fsid);
+}
+EXPORT_SYMBOL(inode_get_fsid);
+
 int vfs_get_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
 {
 	struct kstatfs st;
 	int error;
 
+	/* Avoid statfs if fs supports cheaper get_fsid() */
+	error = inode_get_fsid(d_inode(dentry), fsid);
+	if (!error)
+		return 0;
+
 	error = statfs_by_dentry(dentry, &st);
 	if (error)
 		return error;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4a40823c3c67..30d7d3347c49 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2008,6 +2008,7 @@ struct super_operations {
 	int (*thaw_super) (struct super_block *, enum freeze_holder who);
 	int (*unfreeze_fs) (struct super_block *);
 	int (*statfs) (struct dentry *, struct kstatfs *);
+	int (*get_fsid)(struct inode *, __kernel_fsid_t *);
 	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*umount_begin) (struct super_block *);
 
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index 02c862686ea3..c07f6d726e39 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -43,7 +43,9 @@ struct kstatfs {
 #define ST_RELATIME	0x1000	/* update atime relative to mtime/ctime */
 #define ST_NOSYMFOLLOW	0x2000	/* do not follow symlinks */
 
+struct inode;
 struct dentry;
+extern int inode_get_fsid(struct inode *inode, __kernel_fsid_t *fsid);
 extern int vfs_get_fsid(struct dentry *dentry, __kernel_fsid_t *fsid);
 
 static inline __kernel_fsid_t u64_to_fsid(u64 v)
-- 
2.34.1


