Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DE349A6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCYTin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230267AbhCYTiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dz8GpdjTHLfmJ+KP6JMw0miZLxOdIaXkRM3nI3rcC/g=;
        b=F8cm0+K7q7GGNzUy1jb6uUi0PYB3dDV5aFLeJdLUMFxep3EtX9/i5NrTdrUDwOp+uRR0M0
        rNyOZy9L0LzJUAokiqN5yAuuHtuO3Ss8AqXdkSS6ueV+LQdNue7Dqf9tm0+VER5ufEDPQL
        6AiH/Dgm5cbqCeQ8dv1um2BCD6Fq5Jo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-5nZytXAMPBGz8ATth0I4xg-1; Thu, 25 Mar 2021 15:38:07 -0400
X-MC-Unique: 5nZytXAMPBGz8ATth0I4xg-1
Received: by mail-ej1-f71.google.com with SMTP id li22so3082555ejb.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dz8GpdjTHLfmJ+KP6JMw0miZLxOdIaXkRM3nI3rcC/g=;
        b=IpW2TNFNmpkdTvjb2LplquQz0NQ9gVSS29UNikL6uXXUe+z06aYnMOMSTG8iHeuf4G
         c7WolLYczNGqg+CFUMZc6E8cE3raLrZ3kZD1O74zV7wXgFDNyF2R72WTBb1fTjzxIrbC
         +W9d/7KlnUZeEDH5Mw3Spmedx0nN0GriY5P5sdFzEmniHAHvoxRyT5waE3aIOnC6KbEl
         +vpagASahPnKuTXIryGG2oaGofrmOetJWBT1VZWkWX4rcFXz8DyRheOH8Kfl88DbNm/B
         KNjX8PKakk5RYRYtcljaQx6Vz+tGBSMZv3d0Ja1q7S0gCrpDYEsmas5ZR5MX4Qhv00kJ
         M4xQ==
X-Gm-Message-State: AOAM531CZs3MdN4wYj2sx1ppu04uC6hB/z+xQqqMIFUlh/7vSYxnVtVI
        7TKkjP4Ysk+uZb6bXPXNHEDXd3XEyAcT3LQEtDV+rAsPzO6cFlBzAZ2QKPMIjgmxo5DXey3zJFl
        X2DnBVkkdDScLfPxd1gdxv2b2EiMEnIqh+vxDsPVmHVWM+SxThtRV2Z5AaCfj1IaVyBO6mwgEjt
        Vbcw==
X-Received: by 2002:a17:907:d1f:: with SMTP id gn31mr11159386ejc.536.1616701085395;
        Thu, 25 Mar 2021 12:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtFfzwSjY3WCNVkLF8q7SA6w0le8ITVNL6+0tmpKtXsmUe9yPugEagKWQesmcaLPOLYQCATA==
X-Received: by 2002:a17:907:d1f:: with SMTP id gn31mr11159359ejc.536.1616701085130;
        Thu, 25 Mar 2021 12:38:05 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:04 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3 07/18] f2fs: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:44 +0100
Message-Id: <20210325193755.294925-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325193755.294925-1-mszeredi@redhat.com>
References: <20210325193755.294925-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the fileattr API to let the VFS handle locking, permission checking and
conversion.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  |   3 +
 fs/f2fs/file.c  | 216 +++++++++---------------------------------------
 fs/f2fs/namei.c |   2 +
 3 files changed, 43 insertions(+), 178 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e2d302ae3a46..11a20dc505aa 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3194,6 +3194,9 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_precache_extents(struct inode *inode);
+int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int f2fs_fileattr_set(struct user_namespace *mnt_userns,
+		      struct dentry *dentry, struct fileattr *fa);
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d26ff2ae3f5e..b4e6f64d99f4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -22,6 +22,7 @@
 #include <linux/file.h>
 #include <linux/nls.h>
 #include <linux/sched/signal.h>
+#include <linux/fileattr.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -990,6 +991,8 @@ const struct inode_operations f2fs_file_inode_operations = {
 	.set_acl	= f2fs_set_acl,
 	.listxattr	= f2fs_listxattr,
 	.fiemap		= f2fs_fiemap,
+	.fileattr_get	= f2fs_fileattr_get,
+	.fileattr_set	= f2fs_fileattr_set,
 };
 
 static int fill_zero(struct inode *inode, pgoff_t index,
@@ -1871,13 +1874,16 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 	return 0;
 }
 
-/* FS_IOC_GETFLAGS and FS_IOC_SETFLAGS support */
+/* FS_IOC_[GS]ETFLAGS and FS_IOC_FS[GS]ETXATTR support */
 
 /*
  * To make a new on-disk f2fs i_flag gettable via FS_IOC_GETFLAGS, add an entry
  * for it to f2fs_fsflags_map[], and add its FS_*_FL equivalent to
  * F2FS_GETTABLE_FS_FL.  To also make it settable via FS_IOC_SETFLAGS, also add
  * its FS_*_FL equivalent to F2FS_SETTABLE_FS_FL.
+ *
+ * Translating flags to fsx_flags value used by FS_IOC_FSGETXATTR and
+ * FS_IOC_FSSETXATTR is done by the VFS.
  */
 
 static const struct {
@@ -1952,67 +1958,6 @@ static inline u32 f2fs_fsflags_to_iflags(u32 fsflags)
 	return iflags;
 }
 
-static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
-{
-	struct inode *inode = file_inode(filp);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	u32 fsflags = f2fs_iflags_to_fsflags(fi->i_flags);
-
-	if (IS_ENCRYPTED(inode))
-		fsflags |= FS_ENCRYPT_FL;
-	if (IS_VERITY(inode))
-		fsflags |= FS_VERITY_FL;
-	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
-		fsflags |= FS_INLINE_DATA_FL;
-	if (is_inode_flag_set(inode, FI_PIN_FILE))
-		fsflags |= FS_NOCOW_FL;
-
-	fsflags &= F2FS_GETTABLE_FS_FL;
-
-	return put_user(fsflags, (int __user *)arg);
-}
-
-static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
-{
-	struct inode *inode = file_inode(filp);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	u32 fsflags, old_fsflags;
-	u32 iflags;
-	int ret;
-
-	if (!inode_owner_or_capable(&init_user_ns, inode))
-		return -EACCES;
-
-	if (get_user(fsflags, (int __user *)arg))
-		return -EFAULT;
-
-	if (fsflags & ~F2FS_GETTABLE_FS_FL)
-		return -EOPNOTSUPP;
-	fsflags &= F2FS_SETTABLE_FS_FL;
-
-	iflags = f2fs_fsflags_to_iflags(fsflags);
-	if (f2fs_mask_flags(inode->i_mode, iflags) != iflags)
-		return -EOPNOTSUPP;
-
-	ret = mnt_want_write_file(filp);
-	if (ret)
-		return ret;
-
-	inode_lock(inode);
-
-	old_fsflags = f2fs_iflags_to_fsflags(fi->i_flags);
-	ret = vfs_ioc_setflags_prepare(inode, old_fsflags, fsflags);
-	if (ret)
-		goto out;
-
-	ret = f2fs_setflags_common(inode, iflags,
-			f2fs_fsflags_to_iflags(F2FS_SETTABLE_FS_FL));
-out:
-	inode_unlock(inode);
-	mnt_drop_write_file(filp);
-	return ret;
-}
-
 static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -3019,9 +2964,8 @@ int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
 	return err;
 }
 
-static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
+static int f2fs_ioc_setproject(struct inode *inode, __u32 projid)
 {
-	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *ipage;
@@ -3082,7 +3026,7 @@ int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
 	return 0;
 }
 
-static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
+static int f2fs_ioc_setproject(struct inode *inode, __u32 projid)
 {
 	if (projid != F2FS_DEF_PROJID)
 		return -EOPNOTSUPP;
@@ -3090,123 +3034,55 @@ static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 }
 #endif
 
-/* FS_IOC_FSGETXATTR and FS_IOC_FSSETXATTR support */
-
-/*
- * To make a new on-disk f2fs i_flag gettable via FS_IOC_FSGETXATTR and settable
- * via FS_IOC_FSSETXATTR, add an entry for it to f2fs_xflags_map[], and add its
- * FS_XFLAG_* equivalent to F2FS_SUPPORTED_XFLAGS.
- */
-
-static const struct {
-	u32 iflag;
-	u32 xflag;
-} f2fs_xflags_map[] = {
-	{ F2FS_SYNC_FL,		FS_XFLAG_SYNC },
-	{ F2FS_IMMUTABLE_FL,	FS_XFLAG_IMMUTABLE },
-	{ F2FS_APPEND_FL,	FS_XFLAG_APPEND },
-	{ F2FS_NODUMP_FL,	FS_XFLAG_NODUMP },
-	{ F2FS_NOATIME_FL,	FS_XFLAG_NOATIME },
-	{ F2FS_PROJINHERIT_FL,	FS_XFLAG_PROJINHERIT },
-};
-
-#define F2FS_SUPPORTED_XFLAGS (		\
-		FS_XFLAG_SYNC |		\
-		FS_XFLAG_IMMUTABLE |	\
-		FS_XFLAG_APPEND |	\
-		FS_XFLAG_NODUMP |	\
-		FS_XFLAG_NOATIME |	\
-		FS_XFLAG_PROJINHERIT)
-
-/* Convert f2fs on-disk i_flags to FS_IOC_FS{GET,SET}XATTR flags */
-static inline u32 f2fs_iflags_to_xflags(u32 iflags)
-{
-	u32 xflags = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(f2fs_xflags_map); i++)
-		if (iflags & f2fs_xflags_map[i].iflag)
-			xflags |= f2fs_xflags_map[i].xflag;
-
-	return xflags;
-}
-
-/* Convert FS_IOC_FS{GET,SET}XATTR flags to f2fs on-disk i_flags */
-static inline u32 f2fs_xflags_to_iflags(u32 xflags)
-{
-	u32 iflags = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(f2fs_xflags_map); i++)
-		if (xflags & f2fs_xflags_map[i].xflag)
-			iflags |= f2fs_xflags_map[i].iflag;
-
-	return iflags;
-}
-
-static void f2fs_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
+int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
+	struct inode *inode = d_inode(dentry);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	u32 fsflags = f2fs_iflags_to_fsflags(fi->i_flags);
 
-	simple_fill_fsxattr(fa, f2fs_iflags_to_xflags(fi->i_flags));
+	if (IS_ENCRYPTED(inode))
+		fsflags |= FS_ENCRYPT_FL;
+	if (IS_VERITY(inode))
+		fsflags |= FS_VERITY_FL;
+	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
+		fsflags |= FS_INLINE_DATA_FL;
+	if (is_inode_flag_set(inode, FI_PIN_FILE))
+		fsflags |= FS_NOCOW_FL;
+
+	fileattr_fill_flags(fa, fsflags & F2FS_GETTABLE_FS_FL);
 
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
 		fa->fsx_projid = from_kprojid(&init_user_ns, fi->i_projid);
-}
 
-static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
-{
-	struct inode *inode = file_inode(filp);
-	struct fsxattr fa;
-
-	f2fs_fill_fsxattr(inode, &fa);
-
-	if (copy_to_user((struct fsxattr __user *)arg, &fa, sizeof(fa)))
-		return -EFAULT;
 	return 0;
 }
 
-static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
+int f2fs_fileattr_set(struct user_namespace *mnt_userns,
+		      struct dentry *dentry, struct fileattr *fa)
 {
-	struct inode *inode = file_inode(filp);
-	struct fsxattr fa, old_fa;
+	struct inode *inode = d_inode(dentry);
+	u32 fsflags = fa->flags, mask = F2FS_SETTABLE_FS_FL;
 	u32 iflags;
 	int err;
 
-	if (copy_from_user(&fa, (struct fsxattr __user *)arg, sizeof(fa)))
-		return -EFAULT;
-
-	/* Make sure caller has proper permission */
-	if (!inode_owner_or_capable(&init_user_ns, inode))
-		return -EACCES;
-
-	if (fa.fsx_xflags & ~F2FS_SUPPORTED_XFLAGS)
+	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
+		return -EIO;
+	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(inode)))
+		return -ENOSPC;
+	if (fsflags & ~F2FS_GETTABLE_FS_FL)
 		return -EOPNOTSUPP;
+	fsflags &= F2FS_SETTABLE_FS_FL;
+	if (!fa->flags_valid)
+		mask &= FS_COMMON_FL;
 
-	iflags = f2fs_xflags_to_iflags(fa.fsx_xflags);
+	iflags = f2fs_fsflags_to_iflags(fsflags);
 	if (f2fs_mask_flags(inode->i_mode, iflags) != iflags)
 		return -EOPNOTSUPP;
 
-	err = mnt_want_write_file(filp);
-	if (err)
-		return err;
-
-	inode_lock(inode);
-
-	f2fs_fill_fsxattr(inode, &old_fa);
-	err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
-	if (err)
-		goto out;
-
-	err = f2fs_setflags_common(inode, iflags,
-			f2fs_xflags_to_iflags(F2FS_SUPPORTED_XFLAGS));
-	if (err)
-		goto out;
+	err = f2fs_setflags_common(inode, iflags, f2fs_fsflags_to_iflags(mask));
+	if (!err)
+		err = f2fs_ioc_setproject(inode, fa->fsx_projid);
 
-	err = f2fs_ioc_setproject(filp, fa.fsx_projid);
-out:
-	inode_unlock(inode);
-	mnt_drop_write_file(filp);
 	return err;
 }
 
@@ -4233,10 +4109,6 @@ static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
 static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
-	case FS_IOC_GETFLAGS:
-		return f2fs_ioc_getflags(filp, arg);
-	case FS_IOC_SETFLAGS:
-		return f2fs_ioc_setflags(filp, arg);
 	case FS_IOC_GETVERSION:
 		return f2fs_ioc_getversion(filp, arg);
 	case F2FS_IOC_START_ATOMIC_WRITE:
@@ -4285,10 +4157,6 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_flush_device(filp, arg);
 	case F2FS_IOC_GET_FEATURES:
 		return f2fs_ioc_get_features(filp, arg);
-	case FS_IOC_FSGETXATTR:
-		return f2fs_ioc_fsgetxattr(filp, arg);
-	case FS_IOC_FSSETXATTR:
-		return f2fs_ioc_fssetxattr(filp, arg);
 	case F2FS_IOC_GET_PIN_FILE:
 		return f2fs_ioc_get_pin_file(filp, arg);
 	case F2FS_IOC_SET_PIN_FILE:
@@ -4518,12 +4386,6 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return -ENOSPC;
 
 	switch (cmd) {
-	case FS_IOC32_GETFLAGS:
-		cmd = FS_IOC_GETFLAGS;
-		break;
-	case FS_IOC32_SETFLAGS:
-		cmd = FS_IOC_SETFLAGS;
-		break;
 	case FS_IOC32_GETVERSION:
 		cmd = FS_IOC_GETVERSION;
 		break;
@@ -4552,8 +4414,6 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_DEFRAGMENT:
 	case F2FS_IOC_FLUSH_DEVICE:
 	case F2FS_IOC_GET_FEATURES:
-	case FS_IOC_FSGETXATTR:
-	case FS_IOC_FSSETXATTR:
 	case F2FS_IOC_GET_PIN_FILE:
 	case F2FS_IOC_SET_PIN_FILE:
 	case F2FS_IOC_PRECACHE_EXTENTS:
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 17bd072a5d39..14bf4f65bcb3 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1327,6 +1327,8 @@ const struct inode_operations f2fs_dir_inode_operations = {
 	.set_acl	= f2fs_set_acl,
 	.listxattr	= f2fs_listxattr,
 	.fiemap		= f2fs_fiemap,
+	.fileattr_get	= f2fs_fileattr_get,
+	.fileattr_set	= f2fs_fileattr_set,
 };
 
 const struct inode_operations f2fs_symlink_inode_operations = {
-- 
2.30.2

