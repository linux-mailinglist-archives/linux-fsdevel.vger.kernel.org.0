Return-Path: <linux-fsdevel+bounces-7545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3710826D89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED07A1C22354
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7F3405C0;
	Mon,  8 Jan 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ME1wlTxe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702FA44373
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BFE6B3F373
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704715824;
	bh=5YU1NX55EkC+kEj5EffEs5H2AwvURtGdQ/HYjkwRM8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=ME1wlTxeCrq7VypFX8QeCIX9CrWDmtHj3rCV7u52LprNG24j5mRPU1v0quLW8Yp6X
	 GIa1SUT3GdEZLo47aA2gHLg/zC/3vUqjWtZQyi5V45qQ7AOayOlIRSbKZ/OytvW34h
	 GK+ScFaONHEUNA5TgQZBZaB/zexMemv8THw/icOkRqS4rJvrZmKPV/fs2+LvFHSw6Y
	 Z3CK69KZQtloqdiNrmipkdd4j03+B9GBFNPeLqTcr5Bdk5CN/HUT0JGJfjwebT1alb
	 ZcLDCuaEvnUCzM/FyLVl9R6IQTtjmGtlpI7GOnVcugOkvVvRP981hYQWMR/DjqPhtt
	 6mZadzbd03egw==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-557d1641101so248857a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 04:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715824; x=1705320624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YU1NX55EkC+kEj5EffEs5H2AwvURtGdQ/HYjkwRM8I=;
        b=dJbWJzJAYBNaRdx5SIIK7qu+6Bp7WmAom47lU/PJQjlgJxwTVgdXaaw415wuoW8/Eh
         zHdcl14R/T9xULDQamZWfG1pO8zvF8Anj3Sjut+A8FE1pkIURrZMyrWPdHZVBPU0hOMH
         66jQu0rsJTIk+nkeM3T+LMn+EZx5fYryQhddli3mKqj8+68bj5I8xB0J1nc6pzB68zS2
         WBEgZgXHoTxotcDxuDCykBRC7YLJsAQb1aEGJKWfxtbX09EtHpZtKDeIj9lv8z67yk0W
         rne55iHAJKZ7EUgo6Mey6SgkoN/0d46B385dEMwwjsj7XcuwM5cj3Fyb0DBfzHUyIvMQ
         F4jA==
X-Gm-Message-State: AOJu0Yyj8Gxwm6qvFZ1lzFtLQ//xBlp0/Caf65LRI6fVxgu5yfyow8eq
	M0X/WLN5jFemMXDqLJcDImz0BwyZ+ylH866z+CuuB1u8SaC8nCG3JPsqkxU9nEPfEt6DivB7A5Q
	kNDy8aL1aK/IfoIau1mo6byRxysRLP8+5uUOkc2Pm9rW7SqUUng==
X-Received: by 2002:a50:951e:0:b0:552:fcca:ee11 with SMTP id u30-20020a50951e000000b00552fccaee11mr1322933eda.74.1704715824430;
        Mon, 08 Jan 2024 04:10:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbkDQ81TrJrfcIXQl9SZ1Mnhsn8K0v5xkp/foSnlY+Kqttn18YIQ5m+/IG2qQHswCxHJux4g==
X-Received: by 2002:a50:951e:0:b0:552:fcca:ee11 with SMTP id u30-20020a50951e000000b00552fccaee11mr1322918eda.74.1704715823978;
        Mon, 08 Jan 2024 04:10:23 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056402551500b005578b816f20sm1767959edb.29.2024.01.08.04.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:10:22 -0800 (PST)
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
Subject: [PATCH v1 9/9] fs/fuse: allow idmapped mounts
Date: Mon,  8 Jan 2024 13:08:24 +0100
Message-Id: <20240108120824.122178-10-aleksandr.mikhalitsyn@canonical.com>
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

Now we have everything in place and we can allow idmapped mounts
by setting the FS_ALLOW_IDMAP flag. Notice that real availability
of idmapped mounts will depend on the fuse daemon. Fuse daemon
have to set FUSE_ALLOW_IDMAP flag in the FUSE_INIT reply.

To discuss:
- we enable idmapped mounts support only if "default_permissions" mode is enabled,
because otherwise we would need to deal with UID/GID mappings in the userspace side OR
provide the userspace with idmapped req->in.h.uid/req->in.h.gid values which is not
something that we probably want to. Idmapped mounts phylosophy is not about faking
caller uid/gid.

- We have a small offlist discussion with Christian around adding fs_type->allow_idmap
hook. Christian pointed that it would be nice to have a superblock flag instead like
SB_I_NOIDMAP and we can set this flag during mount time if we see that filesystem does not
support idmappings. But, unfortunately I didn't succeed here because the kernel will
know if the filesystem supports idmapping or not after FUSE_INIT request, but FUSE_INIT request
is being sent at the end of mounting process, so mount and superblock will exist and
visible by the userspace in that time. It seems like setting SB_I_NOIDMAP flag in this
case is too late as user may do the trick with creating a idmapped mount while it wasn't
restricted by SB_I_NOIDMAP. Alternatively, we can introduce a "positive" version SB_I_ALLOWIDMAP
and "weak" version of FS_ALLOW_IDMAP like FS_MAY_ALLOW_IDMAP. So if FS_MAY_ALLOW_IDMAP is set,
then SB_I_ALLOWIDMAP has to be set on the superblock to allow creation of an idmapped mount.
But that's a matter of our discussion.

Some extra links and examples:

- libfuse support
https://github.com/mihalicyn/libfuse/commits/idmap_support

- fuse-overlayfs support:
https://github.com/mihalicyn/fuse-overlayfs/commits/idmap_support

- cephfs-fuse conversion example
https://github.com/mihalicyn/ceph/commits/fuse_idmap

- glusterfs conversion example
https://github.com/mihalicyn/glusterfs/commits/fuse_idmap

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           | 22 +++++++++++++++++++---
 include/uapi/linux/fuse.h |  5 ++++-
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 94b25ea5344a..9317b8c35191 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -809,6 +809,9 @@ struct fuse_conn {
 	/* Add owner_{u,g}id info when creating a new inode */
 	unsigned int owner_uid_gid_ext:1;
 
+	/* Allow creation of idmapped mounts */
+	unsigned int allow_idmap:1;
+
 	/* Does the filesystem support per inode DAX? */
 	unsigned int inode_dax:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 08cd3714b32d..47e32a8baed3 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1286,6 +1286,12 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->direct_io_allow_mmap = 1;
 			if (flags & FUSE_OWNER_UID_GID_EXT)
 				fc->owner_uid_gid_ext = 1;
+			if (flags & FUSE_ALLOW_IDMAP) {
+				if (fc->owner_uid_gid_ext && fc->default_permissions)
+					fc->allow_idmap = 1;
+				else
+					ok = false;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1332,7 +1338,8 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
-		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP | FUSE_OWNER_UID_GID_EXT;
+		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
+		FUSE_OWNER_UID_GID_EXT | FUSE_ALLOW_IDMAP;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1915,12 +1922,20 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 	fuse_mount_destroy(get_fuse_mount_super(sb));
 }
 
+static bool fuse_allow_idmap(struct super_block *sb)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+
+	return fc->allow_idmap;
+}
+
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
+	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
 	.init_fs_context = fuse_init_fs_context,
 	.parameters	= fuse_fs_parameters,
+	.allow_idmap	= fuse_allow_idmap,
 	.kill_sb	= fuse_kill_sb_anon,
 };
 MODULE_ALIAS_FS("fuse");
@@ -1938,8 +1953,9 @@ static struct file_system_type fuseblk_fs_type = {
 	.name		= "fuseblk",
 	.init_fs_context = fuse_init_fs_context,
 	.parameters	= fuse_fs_parameters,
+	.allow_idmap	= fuse_allow_idmap,
 	.kill_sb	= fuse_kill_sb_blk,
-	.fs_flags	= FS_REQUIRES_DEV | FS_HAS_SUBTYPE,
+	.fs_flags	= FS_REQUIRES_DEV | FS_HAS_SUBTYPE | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("fuseblk");
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index ebe82104b172..d8e1235d9796 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -215,6 +215,7 @@
  *  7.40
  *  - add FUSE_EXT_OWNER_UID_GID
  *  - add FUSE_OWNER_UID_GID_EXT
+ *  - add FUSE_ALLOW_IDMAP
  */
 
 #ifndef _LINUX_FUSE_H
@@ -250,7 +251,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 39
+#define FUSE_KERNEL_MINOR_VERSION 40
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -416,6 +417,7 @@ struct fuse_file_lock {
  * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
  * FUSE_OWNER_UID_GID_EXT: add inode owner UID/GID info to create, mkdir,
  *			   symlink and mknod
+ * FUSE_ALLOW_IDMAP: allow creation of idmapped mounts
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -459,6 +461,7 @@ struct fuse_file_lock {
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
 #define FUSE_OWNER_UID_GID_EXT	(1ULL << 37)
+#define FUSE_ALLOW_IDMAP	(1ULL << 38)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.34.1


