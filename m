Return-Path: <linux-fsdevel+bounces-601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBE27CD8BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5282FB21246
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794D018C35;
	Wed, 18 Oct 2023 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYueOKcx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C918C16
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 10:00:14 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5B3B0;
	Wed, 18 Oct 2023 03:00:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso58586305e9.0;
        Wed, 18 Oct 2023 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697623211; x=1698228011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx+RlS47X3pEZGks8fmVGfUUr8kwPiO26j32N14XYVM=;
        b=iYueOKcxJpZpLiP6Y/XlDJaTsMuHeqjIzzp83J668IqtGff15rCjI4pjurOM/qxhtJ
         adG/9sGbBcCuVDY/jP7zvby7q1tNmTwCSkSVucRgGPvRoDfokzcVes7cBjdqC2AK0SRn
         lfk0BIhcpyjJCZTLUNsS5IHkx9zULYQlSEpPsKyQsshlst8Xszk5UziNN1Ul/lhf5LlS
         reCSRZaAXTfTw/h4FyHU/FkAQqfhnCN8JWw7aqjOxLcD4xG8XlqdwowOBsclsNBDjaX6
         ssijJIUvHtt+wrR4bjwVoqM5Hljrd4UkUIWTxsOca6wAlhC4zC7fkxW2bz6BNSJ7Lds/
         7NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697623211; x=1698228011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx+RlS47X3pEZGks8fmVGfUUr8kwPiO26j32N14XYVM=;
        b=lVJz4YG0tNMTPWgSZ3qSAnqe1APgqpoFoE2gAFdB5oEFpIqJ8afSKpoApNzxUY82MF
         S50HsewvwjEajOSLxlW5SpnX1kN4U95QIP+xIgCJciYiwluE1r3PqLgZr4xq6vw1nUUt
         cvrdjtinyj47NOi2qKAqvXZtCnSu7XY7uNnmYGZeBnjgy/zjGgfSgv5A2RMRtV1vQoRv
         HehS088J7XGlR+VjWOoeXSDOFW9utaOm6cZ0wHrjIShduHSH/1fTmDjOOvEa5CCB5NVz
         veW3MAzvCW5u+GhYdl3lk6D2XHc90yt5nB5oxNT/nwn7fq5IgCQ4IS+f6l798G+rlbji
         DRZA==
X-Gm-Message-State: AOJu0Yx/Ls5ocps4WFD+UYbaIwV9pta7Lc9Trvw21GHEOkul4eFK5PZ0
	NsP2FanoEOWLyWB6WrPOcus=
X-Google-Smtp-Source: AGHT+IFJF2E/fGv5Z6ATh11kB/T1HNwWL3eoowF20WT25ghgaRx+hrvHZWA3j5a2HZgCFBcEXoSp3w==
X-Received: by 2002:a05:600c:524a:b0:405:3dd0:6ee9 with SMTP id fc10-20020a05600c524a00b004053dd06ee9mr3619088wmb.34.1697623210803;
        Wed, 18 Oct 2023 03:00:10 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id y34-20020a05600c342200b004063977eccesm1222017wmp.42.2023.10.18.03.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:00:10 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
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
Subject: [PATCH 3/5] exportfs: make ->encode_fh() a mandatory method for NFS export
Date: Wed, 18 Oct 2023 12:59:58 +0300
Message-Id: <20231018100000.2453965-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018100000.2453965-1-amir73il@gmail.com>
References: <20231018100000.2453965-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

export_operations ->encode_fh() no longer has a default implementation to
encode FILEID_INO32_GEN* file handles.

Rename the default helper for encoding FILEID_INO32_GEN* file handles to
generic_encode_ino32_fh() and convert the filesystems that used the
default implementation to use the generic helper explicitly.

This is a step towards allowing filesystems to encode non-decodeable file
handles for fanotify without having to implement any export_operations.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/filesystems/nfs/exporting.rst |  7 ++-----
 Documentation/filesystems/porting.rst       |  9 +++++++++
 fs/affs/namei.c                             |  1 +
 fs/befs/linuxvfs.c                          |  1 +
 fs/efs/super.c                              |  1 +
 fs/erofs/super.c                            |  1 +
 fs/exportfs/expfs.c                         | 14 ++++++++------
 fs/ext2/super.c                             |  1 +
 fs/ext4/super.c                             |  1 +
 fs/f2fs/super.c                             |  1 +
 fs/fat/nfs.c                                |  1 +
 fs/jffs2/super.c                            |  1 +
 fs/jfs/super.c                              |  1 +
 fs/ntfs/namei.c                             |  1 +
 fs/ntfs3/super.c                            |  1 +
 fs/smb/client/export.c                      |  9 +++------
 fs/squashfs/export.c                        |  1 +
 fs/ufs/super.c                              |  1 +
 include/linux/exportfs.h                    |  4 +++-
 19 files changed, 39 insertions(+), 18 deletions(-)

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
index 4d05b9862451..197ef78a5014 100644
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
+Fillesystems that used the default implementation may use the generic helper
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
index 9ee205df8fa7..30da4539e257 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -343,20 +343,21 @@ static int get_name(const struct path *path, char *name, struct dentry *child)
 }
 
 /**
- * export_encode_fh - default export_operations->encode_fh function
+ * generic_encode_ino32_fh - generic export_operations->encode_fh function
  * @inode:   the object to encode
- * @fid:     where to store the file handle fragment
+ * @fh:      where to store the file handle fragment
  * @max_len: maximum length to store there
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
index 37c28415df1e..834e9c9197b4 100644
--- a/fs/smb/client/export.c
+++ b/fs/smb/client/export.c
@@ -41,13 +41,10 @@ static struct dentry *cifs_get_parent(struct dentry *dentry)
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
+/*	Following export operations are mandatory for NFS export support:
+	.fh_to_dentry = */
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
index 5b3c9f30b422..6b6e01321405 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -235,7 +235,7 @@ extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
 
 static inline bool exportfs_can_encode_fid(const struct export_operations *nop)
 {
-	return nop;
+	return nop && nop->encode_fh;
 }
 
 static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
@@ -279,6 +279,8 @@ extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 /*
  * Generic helpers for filesystems.
  */
+int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
+			    struct inode *parent);
 extern struct dentry *generic_fh_to_dentry(struct super_block *sb,
 	struct fid *fid, int fh_len, int fh_type,
 	struct inode *(*get_inode) (struct super_block *sb, u64 ino, u32 gen));
-- 
2.34.1


