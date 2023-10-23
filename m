Return-Path: <linux-fsdevel+bounces-949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109347D3E9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7DF2815E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECAB21365;
	Mon, 23 Oct 2023 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbDAUxVQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A021353
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:08:18 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE211BE;
	Mon, 23 Oct 2023 11:08:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c514cbbe7eso50275481fa.1;
        Mon, 23 Oct 2023 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698084493; x=1698689293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEu59smmc/TKlS1Th6b2TXJ2WG5bW+jZTBOrzgPJ0bM=;
        b=XbDAUxVQvDGXTUuhx3fkLN7L7fTthLEwnCVF2NBMtz/1HSyb8fxxJu4ZYuX1BohZw8
         AO2XwZeawgDHmqTADzcvrt90+1fXTrLO66a4RysSMG5a4bKiVI5Y6PfAnC5oJFg4CMu7
         kig0LU+Fr2WUKy14K/q0ekxTSvCjoZb3zmXc279/+QI6yCZfLiTH7D2d0H0dvC9RbnUy
         4IKJYbuQggudDw5waMWA43QQhuTtZEz3/vYE0uATSbTDQrBS/xKO3iI7MgK9lyhO33wK
         tVAEI5Pk8HLKgBUe7ggpUsKbjVNf8nkQ9N0dQdo6CAQLJgtRCvIXZovaZfqlVmy0/j7k
         XUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084493; x=1698689293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEu59smmc/TKlS1Th6b2TXJ2WG5bW+jZTBOrzgPJ0bM=;
        b=EKxi6mOfzFngGcR/g6oCkfh4m/SSMgb7cs4bKEVyhLGLO7U1SdmhonlnhyLwdWYaQT
         bTRnQhg7bDLBwf23KbToDeghz158/PlB9EuEg19DJVF98ZDO8mzUoZWW7+9whSVtE+5L
         iNtTav+jC88/oLGk8Yp0o4PveQQN614bYZuAjtAx9S4+oDrl30+dZb/zdFQz/zb/Ehry
         854qDVFusaJjz3sjgLCRO7o1uC2ZWClJ9bPnqy6UccJotc7qk5RObUv9UQzMOfFN2jxp
         qD6dyt5gILrCPNASE+O5DQJtCIXOSGEfp1ptBtMymaGc0YvZK1U1ZTQc1WhHx611WZyI
         3GRw==
X-Gm-Message-State: AOJu0YwBoYuk/SeskDs7gRqw2gBuszIaE0CbidWfakg8EqbfvABTkqPZ
	6DXUbqOCDpzvzo2V+1Lv31s=
X-Google-Smtp-Source: AGHT+IGN58aVQcrfzMhmTtaPzgtoWAhtEi6j+JzpsRl1CKA6OkKAQCbmG+9g4gSpQMqu9DBkNG5cYA==
X-Received: by 2002:a2e:bc12:0:b0:2c5:8b1:7561 with SMTP id b18-20020a2ebc12000000b002c508b17561mr8426044ljf.10.1698084492836;
        Mon, 23 Oct 2023 11:08:12 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id c39-20020a05600c4a2700b0040588d85b3asm14391492wmp.15.2023.10.23.11.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:08:11 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Dave Kleikamp <shaggy@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Altaparmakov <anton@tuxera.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Steve French <sfrench@samba.org>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Evgeniy Dushistov <dushistov@mail.ru>
Subject: [PATCH v2 2/4] exportfs: make ->encode_fh() a mandatory method for NFS export
Date: Mon, 23 Oct 2023 21:07:59 +0300
Message-Id: <20231023180801.2953446-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023180801.2953446-1-amir73il@gmail.com>
References: <20231023180801.2953446-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

export_operations ->encode_fh() no longer has a default implementation to
encode FILEID_INO32_GEN* file handles.

Rename the default helper for encoding FILEID_INO32_GEN* file handles to
generic_encode_ino32_fh() and convert the filesystems that used the
default implementation to use the generic helper explicitly.

This is a step towards allowing filesystems to encode non-decodeable file
handles for fanotify without having to implement any export_operations.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/filesystems/nfs/exporting.rst |  7 ++-----
 Documentation/filesystems/porting.rst       |  9 +++++++++
 fs/affs/namei.c                             |  1 +
 fs/befs/linuxvfs.c                          |  1 +
 fs/efs/super.c                              |  1 +
 fs/erofs/super.c                            |  1 +
 fs/exportfs/expfs.c                         | 16 +++++++++-------
 fs/ext2/super.c                             |  1 +
 fs/ext4/super.c                             |  1 +
 fs/f2fs/super.c                             |  1 +
 fs/fat/nfs.c                                |  1 +
 fs/jffs2/super.c                            |  1 +
 fs/jfs/super.c                              |  1 +
 fs/ntfs/namei.c                             |  1 +
 fs/ntfs3/super.c                            |  1 +
 fs/smb/client/export.c                      | 11 +++++------
 fs/squashfs/export.c                        |  1 +
 fs/ufs/super.c                              |  1 +
 include/linux/exportfs.h                    |  9 ++++++++-
 19 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index 4b30daee399a..de64d2d002a2 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -122,12 +122,9 @@ are exportable by setting the s_export_op field in the struct
 super_block.  This field must point to a "struct export_operations"
 struct which has the following members:
 
-  encode_fh (optional)
+  encode_fh (mandatory)
     Takes a dentry and creates a filehandle fragment which may later be used
-    to find or create a dentry for the same object.  The default
-    implementation creates a filehandle fragment that encodes a 32bit inode
-    and generation number for the inode encoded, and if necessary the
-    same information for the parent.
+    to find or create a dentry for the same object.
 
   fh_to_dentry (mandatory)
     Given a filehandle fragment, this should find the implied object and
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 4d05b9862451..9cc6cb27c4d5 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1045,3 +1045,12 @@ filesystem type is now moved to a later point when the devices are closed:
 As this is a VFS level change it has no practical consequences for filesystems
 other than that all of them must use one of the provided kill_litter_super(),
 kill_anon_super(), or kill_block_super() helpers.
+
+---
+
+**mandatory**
+
+export_operations ->encode_fh() no longer has a default implementation to
+encode FILEID_INO32_GEN* file handles.
+Filesystems that used the default implementation may use the generic helper
+generic_encode_ino32_fh() explicitly.
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index 2fe4a5832fcf..d6b9758ee23d 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -568,6 +568,7 @@ static struct dentry *affs_fh_to_parent(struct super_block *sb, struct fid *fid,
 }
 
 const struct export_operations affs_export_ops = {
+	.encode_fh = generic_encode_ino32_fh,
 	.fh_to_dentry = affs_fh_to_dentry,
 	.fh_to_parent = affs_fh_to_parent,
 	.get_parent = affs_get_parent,
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 9a16a51fbb88..410dcaffd5ab 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -96,6 +96,7 @@ static const struct address_space_operations befs_symlink_aops = {
 };
 
 static const struct export_operations befs_export_operations = {
+	.encode_fh	= generic_encode_ino32_fh,
 	.fh_to_dentry	= befs_fh_to_dentry,
 	.fh_to_parent	= befs_fh_to_parent,
 	.get_parent	= befs_get_parent,
diff --git a/fs/efs/super.c b/fs/efs/super.c
index b287f47c165b..f17fdac76b2e 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -123,6 +123,7 @@ static const struct super_operations efs_superblock_operations = {
 };
 
 static const struct export_operations efs_export_ops = {
+	.encode_fh	= generic_encode_ino32_fh,
 	.fh_to_dentry	= efs_fh_to_dentry,
 	.fh_to_parent	= efs_fh_to_parent,
 	.get_parent	= efs_get_parent,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3700af9ee173..edbe07a24156 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -626,6 +626,7 @@ static struct dentry *erofs_get_parent(struct dentry *child)
 }
 
 static const struct export_operations erofs_export_ops = {
+	.encode_fh = generic_encode_ino32_fh,
 	.fh_to_dentry = erofs_fh_to_dentry,
 	.fh_to_parent = erofs_fh_to_parent,
 	.get_parent = erofs_get_parent,
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 9ee205df8fa7..8f883c4758f5 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -343,20 +343,21 @@ static int get_name(const struct path *path, char *name, struct dentry *child)
 }
 
 /**
- * export_encode_fh - default export_operations->encode_fh function
+ * generic_encode_ino32_fh - generic export_operations->encode_fh function
  * @inode:   the object to encode
- * @fid:     where to store the file handle fragment
- * @max_len: maximum length to store there
+ * @fh:      where to store the file handle fragment
+ * @max_len: maximum length to store there (in 4 byte units)
  * @parent:  parent directory inode, if wanted
  *
- * This default encode_fh function assumes that the 32 inode number
+ * This generic encode_fh function assumes that the 32 inode number
  * is suitable for locating an inode, and that the generation number
  * can be used to check that it is still valid.  It places them in the
  * filehandle fragment where export_decode_fh expects to find them.
  */
-static int export_encode_fh(struct inode *inode, struct fid *fid,
-		int *max_len, struct inode *parent)
+int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
+			    struct inode *parent)
 {
+	struct fid *fid = (void *)fh;
 	int len = *max_len;
 	int type = FILEID_INO32_GEN;
 
@@ -380,6 +381,7 @@ static int export_encode_fh(struct inode *inode, struct fid *fid,
 	*max_len = len;
 	return type;
 }
+EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
 
 /**
  * exportfs_encode_inode_fh - encode a file handle from inode
@@ -402,7 +404,7 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 	if (nop && nop->encode_fh)
 		return nop->encode_fh(inode, fid->raw, max_len, parent);
 
-	return export_encode_fh(inode, fid, max_len, parent);
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
 
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index aaf3e3e88cb2..b9f158a34997 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -397,6 +397,7 @@ static struct dentry *ext2_fh_to_parent(struct super_block *sb, struct fid *fid,
 }
 
 static const struct export_operations ext2_export_ops = {
+	.encode_fh = generic_encode_ino32_fh,
 	.fh_to_dentry = ext2_fh_to_dentry,
 	.fh_to_parent = ext2_fh_to_parent,
 	.get_parent = ext2_get_parent,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dbebd8b3127e..c44db1915437 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1646,6 +1646,7 @@ static const struct super_operations ext4_sops = {
 };
 
 static const struct export_operations ext4_export_ops = {
+	.encode_fh = generic_encode_ino32_fh,
 	.fh_to_dentry = ext4_fh_to_dentry,
 	.fh_to_parent = ext4_fh_to_parent,
 	.get_parent = ext4_get_parent,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a8c8232852bb..60cfa11f65bf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3282,6 +3282,7 @@ static struct dentry *f2fs_fh_to_parent(struct super_block *sb, struct fid *fid,
 }
 
 static const struct export_operations f2fs_export_ops = {
+	.encode_fh = generic_encode_ino32_fh,
 	.fh_to_dentry = f2fs_fh_to_dentry,
 	.fh_to_parent = f2fs_fh_to_parent,
 	.get_parent = f2fs_get_parent,
diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
index 3626eb585a98..c52e63e10d35 100644
--- a/fs/fat/nfs.c
+++ b/fs/fat/nfs.c
@@ -279,6 +279,7 @@ static struct dentry *fat_get_parent(struct dentry *child_dir)
 }
 
 const struct export_operations fat_export_ops = {
+	.encode_fh	= generic_encode_ino32_fh,
 	.fh_to_dentry   = fat_fh_to_dentry,
 	.fh_to_parent   = fat_fh_to_parent,
 	.get_parent     = fat_get_parent,
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 7ea37f49f1e1..f99591a634b4 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -150,6 +150,7 @@ static struct dentry *jffs2_get_parent(struct dentry *child)
 }
 
 static const struct export_operations jffs2_export_ops = {
+	.encode_fh = generic_encode_ino32_fh,
 	.get_parent = jffs2_get_parent,
 	.fh_to_dentry = jffs2_fh_to_dentry,
 	.fh_to_parent = jffs2_fh_to_parent,
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 2e2f7f6d36a0..2cc2632f3c47 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -896,6 +896,7 @@ static const struct super_operations jfs_super_operations = {
 };
 
 static const struct export_operations jfs_export_operations = {
+	.encode_fh	= generic_encode_ino32_fh,
 	.fh_to_dentry	= jfs_fh_to_dentry,
 	.fh_to_parent	= jfs_fh_to_parent,
 	.get_parent	= jfs_get_parent,
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index ab44f2db533b..d7498ddc4a72 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -384,6 +384,7 @@ static struct dentry *ntfs_fh_to_parent(struct super_block *sb, struct fid *fid,
  * and due to using iget() whereas NTFS needs ntfs_iget().
  */
 const struct export_operations ntfs_export_ops = {
+	.encode_fh	= generic_encode_ino32_fh,
 	.get_parent	= ntfs_get_parent,	/* Find the parent of a given
 						   directory. */
 	.fh_to_dentry	= ntfs_fh_to_dentry,
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 5661a363005e..661ffb5aa1e0 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -789,6 +789,7 @@ static int ntfs_nfs_commit_metadata(struct inode *inode)
 }
 
 static const struct export_operations ntfs_export_ops = {
+	.encode_fh = generic_encode_ino32_fh,
 	.fh_to_dentry = ntfs_fh_to_dentry,
 	.fh_to_parent = ntfs_fh_to_parent,
 	.get_parent = ntfs3_get_parent,
diff --git a/fs/smb/client/export.c b/fs/smb/client/export.c
index 37c28415df1e..d606e8cbcb7d 100644
--- a/fs/smb/client/export.c
+++ b/fs/smb/client/export.c
@@ -41,13 +41,12 @@ static struct dentry *cifs_get_parent(struct dentry *dentry)
 }
 
 const struct export_operations cifs_export_ops = {
+	.encode_fh = generic_encode_ino32_fh,
 	.get_parent = cifs_get_parent,
-/*	Following five export operations are unneeded so far and can default:
-	.get_dentry =
-	.get_name =
-	.find_exported_dentry =
-	.decode_fh =
-	.encode_fs =  */
+/*
+ * Following export operations are mandatory for NFS export support:
+ *	.fh_to_dentry =
+ */
 };
 
 #endif /* CONFIG_CIFS_NFSD_EXPORT */
diff --git a/fs/squashfs/export.c b/fs/squashfs/export.c
index 723763746238..62972f0ff868 100644
--- a/fs/squashfs/export.c
+++ b/fs/squashfs/export.c
@@ -173,6 +173,7 @@ __le64 *squashfs_read_inode_lookup_table(struct super_block *sb,
 
 
 const struct export_operations squashfs_export_ops = {
+	.encode_fh = generic_encode_ino32_fh,
 	.fh_to_dentry = squashfs_fh_to_dentry,
 	.fh_to_parent = squashfs_fh_to_parent,
 	.get_parent = squashfs_get_parent
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 23377c1baed9..a480810cd4e3 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -137,6 +137,7 @@ static struct dentry *ufs_get_parent(struct dentry *child)
 }
 
 static const struct export_operations ufs_export_ops = {
+	.encode_fh = generic_encode_ino32_fh,
 	.fh_to_dentry	= ufs_fh_to_dentry,
 	.fh_to_parent	= ufs_fh_to_parent,
 	.get_parent	= ufs_get_parent,
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 5b3c9f30b422..85bd027494e5 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -235,7 +235,7 @@ extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
 
 static inline bool exportfs_can_encode_fid(const struct export_operations *nop)
 {
-	return nop;
+	return nop && nop->encode_fh;
 }
 
 static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
@@ -279,6 +279,13 @@ extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 /*
  * Generic helpers for filesystems.
  */
+#ifdef CONFIG_EXPORTFS
+int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
+			    struct inode *parent);
+#else
+#define generic_encode_ino32_fh NULL
+#endif
+
 extern struct dentry *generic_fh_to_dentry(struct super_block *sb,
 	struct fid *fid, int fh_len, int fh_type,
 	struct inode *(*get_inode) (struct super_block *sb, u64 ino, u32 gen));
-- 
2.34.1


