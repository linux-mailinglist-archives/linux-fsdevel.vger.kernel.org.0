Return-Path: <linux-fsdevel+bounces-2427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC37E5E51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5250E2818C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B258F38FBC;
	Wed,  8 Nov 2023 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bkAx70Vu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F838F80
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:09:34 +0000 (UTC)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB9B1FEA
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 11:09:33 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-45db31f9156so36034137.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 11:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470573; x=1700075373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kv2e4JctZWOSYuSE9iPPyONLdsaG8qpkJScP9R9SQ8s=;
        b=bkAx70VupbluFzYuD1H81lPaA0/NmEh+4UJ3hqgEaGJl96yANDMWEXOBWsGtlFJ9r9
         Q4blnfwGZPCgtYQYajLRRvGJBYutBW76RMrhRlT6NThgjhGTADdZIlqRETivq6j2XzPb
         N7i9T+BEeeVPj84aIqy1g1ZUMy9o+avdFUwBQHVGZDjuaBWHl8OdKgJOL2ghettSDDzQ
         96irMSNOm/eLxPNpd+FgPE+3uZwgw/ZJpXKCYuqjeCEY77d+1HAHSE84hxL4NVBKrGM1
         rmttMoeBEJL2t1eWmaxqi7LmAjX2e1Ieu1En6k4EO1j40WBMfXIS+yumilyyN+syJJrh
         2vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470573; x=1700075373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv2e4JctZWOSYuSE9iPPyONLdsaG8qpkJScP9R9SQ8s=;
        b=Ywxmo3YGYc7bXu2UonjNfbrJX7DURHZxUECTVE7LKL+W/OnBk4RnYCfzZYYlvAW2hX
         0LEKmlS3pdCq9Ab6M3crDt3OfISSzFBUMlzhl7MPVAffz5Jxm0ZoXcsFWA/UuBt6zpcO
         53k8WhKElddKnIO4WCQJgsqlT5/7/oOV7LSFRDXL3zbMIkHHPA5zcimMXZp4rsV/083L
         H1KVH0m2s5jEAdZvLYxJ377zXx/sbJqVeUUwb0/xolyoa/0/Qfnwa2PVtfWVgbSkd9qh
         sLSAF9W5dcxF+/boNYQVBENgZ9DJ6YfSBH3Z7ITXk7AvUN701etQKOKQj+GpFB2D1xxQ
         Xwqw==
X-Gm-Message-State: AOJu0YymfhVu9I9ld7fW4LpwKIilZ/CXDaFnBC0NgPIp5UJ+2+Zx0EAx
	0i2StdqHA/WW0ZAA3mHhqMZrwZtoNWkxUhgd73lqDg==
X-Google-Smtp-Source: AGHT+IGPHX5VEZSaC6FlJem968YVHZJ+nfkwaK+TrzGJgmdpygEju9ZyuMbVF/z30N75xQLF4hr1aA==
X-Received: by 2002:a05:6102:23f9:b0:45f:5bc6:21f1 with SMTP id p25-20020a05610223f900b0045f5bc621f1mr2211484vsc.35.1699470572891;
        Wed, 08 Nov 2023 11:09:32 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c16-20020ac853d0000000b0041eef6cacf4sm1176475qtq.81.2023.11.08.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:32 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 14/18] btrfs: switch to the new mount API
Date: Wed,  8 Nov 2023 14:08:49 -0500
Message-ID: <91b21253b778c6df98fa1f9057b9a486c8e7b81b.1699470345.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699470345.git.josef@toxicpanda.com>
References: <cover.1699470345.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have all of the parts in place to use the new mount API,
switch our fs_type to use the new callbacks.

There are a few things that have to be done at the same time because of
the order of operations changes that come along with the new mount API.
These must be done in the same patch otherwise things will go wrong.

1. Export and use btrfs_check_options in open_ctree().  This is because
   the options are done ahead of time, and we need to check them once we
   have the feature flags loaded.
2. Update the free space cache settings.  Since we're coming in with the
   options already set we need to make sure we don't undo what the user
   has asked for.
3. Set our sb_flags at init_fs_context time, the fs_context stuff is
   trying to manage the sb_flagss itself, so move that into
   init_fs_context and out of the fill super part.

Additionally I've marked the unused functions with __maybe_unused and
will remove them in a future patch.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c |  5 +--
 fs/btrfs/super.c   | 88 ++++++++++++++++++++++++++--------------------
 fs/btrfs/super.h   |  2 ++
 3 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c70e507a28d0..ce861f4baf47 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3295,9 +3295,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	btrfs_set_free_space_cache_settings(fs_info);
 
-	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
-	if (ret)
+	if (!btrfs_check_options(fs_info, &fs_info->mount_opt, sb->s_flags)) {
+		ret = -EINVAL;
 		goto fail_alloc;
+	}
 
 	ret = btrfs_check_features(fs_info, !sb_rdonly(sb));
 	if (ret < 0)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7a49a61fc50a..4ce07d255497 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -304,7 +304,7 @@ static const struct constant_table btrfs_parameter_fragment[] = {
 };
 #endif
 
-static const struct fs_parameter_spec btrfs_fs_parameters[] __maybe_unused = {
+static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	fsparam_flag_no("acl", Opt_acl),
 	fsparam_flag("clear_cache", Opt_clear_cache),
 	fsparam_u32("commit", Opt_commit_interval),
@@ -747,8 +747,8 @@ static bool check_ro_option(struct btrfs_fs_info *fs_info,
 	return false;
 }
 
-static bool check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
-			  unsigned long flags)
+bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
+			 unsigned long flags)
 {
 	if (!(flags & SB_RDONLY) &&
 	    (check_ro_option(info, *mount_opt, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
@@ -783,18 +783,6 @@ static bool check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
 
 void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 {
-	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
-		btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
-	else if (btrfs_free_space_cache_v1_active(fs_info)) {
-		if (btrfs_is_zoned(fs_info)) {
-			btrfs_info(fs_info,
-			"zoned: clearing existing space cache");
-			btrfs_set_super_cache_generation(fs_info->super_copy, 0);
-		} else {
-			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
-		}
-	}
-
 	if (fs_info->sectorsize < PAGE_SIZE) {
 		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
 		if (!btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
@@ -804,6 +792,35 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
 		}
 	}
+
+	/*
+	 * At this point our mount options are populated, so we only mess with
+	 * these settings if we don't have any settings already.
+	 */
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+		return;
+
+	if (btrfs_is_zoned(fs_info) &&
+	    btrfs_free_space_cache_v1_active(fs_info)) {
+		btrfs_info(fs_info, "zoned: clearing existing space cache");
+		btrfs_set_super_cache_generation(fs_info->super_copy, 0);
+		return;
+	}
+
+	if (btrfs_test_opt(fs_info, SPACE_CACHE))
+		return;
+
+	if (btrfs_test_opt(fs_info, NOSPACECACHE))
+		return;
+
+	/*
+	 * At this point we don't have explicit options set by the user, set
+	 * them ourselves based on the state of the file system.
+	 */
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
+		btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+	else if (btrfs_free_space_cache_v1_active(fs_info))
+		btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
 }
 
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
@@ -1340,7 +1357,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		}
 	}
 out:
-	if (!ret && !check_options(info, &info->mount_opt, new_flags))
+	if (!ret && !btrfs_check_options(info, &info->mount_opt, new_flags))
 		ret = -EINVAL;
 	return ret;
 }
@@ -1641,10 +1658,6 @@ static int btrfs_fill_super(struct super_block *sb,
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
-#ifdef CONFIG_BTRFS_FS_POSIX_ACL
-	sb->s_flags |= SB_POSIXACL;
-#endif
-	sb->s_flags |= SB_I_VERSION;
 	sb->s_iflags |= SB_I_CGROUPWB;
 
 	err = super_setup_bdi(sb);
@@ -1924,7 +1937,7 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
  * Note: This is based on mount_bdev from fs/super.c with a few additions
  *       for multiple device setup.  Make sure to keep it in sync.
  */
-static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
+static __maybe_unused struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		int flags, const char *device_name, void *data)
 {
 	struct block_device *bdev = NULL;
@@ -2057,7 +2070,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
  *   3. Call mount_subvol() to get the dentry of subvolume. Since there is
  *      "btrfs subvolume set-default", mount_subvol() is called always.
  */
-static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
+static __maybe_unused struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
 		const char *device_name, void *data)
 {
 	struct vfsmount *mnt_root;
@@ -2521,7 +2534,7 @@ static int btrfs_reconfigure(struct fs_context *fc)
 	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
 	if (!mount_reconfigure &&
-	    !check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
+	    !btrfs_check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
 		return -EINVAL;
 
 	ret = btrfs_check_features(fs_info, !(fc->sb_flags & SB_RDONLY));
@@ -3189,7 +3202,7 @@ static const struct fs_context_operations btrfs_fs_context_ops = {
 	.free		= btrfs_free_fs_context,
 };
 
-static int __maybe_unused btrfs_init_fs_context(struct fs_context *fc)
+static int btrfs_init_fs_context(struct fs_context *fc)
 {
 	struct btrfs_fs_context *ctx;
 
@@ -3210,24 +3223,22 @@ static int __maybe_unused btrfs_init_fs_context(struct fs_context *fc)
 		ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
 	}
 
+#ifdef CONFIG_BTRFS_FS_POSIX_ACL
+	fc->sb_flags |= SB_POSIXACL;
+#endif
+	fc->sb_flags |= SB_I_VERSION;
+
 	return 0;
 }
 
 static struct file_system_type btrfs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "btrfs",
-	.mount		= btrfs_mount,
-	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
-};
-
-static struct file_system_type btrfs_root_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "btrfs",
-	.mount		= btrfs_mount_root,
-	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
-};
+	.owner			= THIS_MODULE,
+	.name			= "btrfs",
+	.init_fs_context	= btrfs_init_fs_context,
+	.parameters		= btrfs_fs_parameters,
+	.kill_sb		= btrfs_kill_super,
+	.fs_flags		= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
+ };
 
 MODULE_ALIAS_FS("btrfs");
 
@@ -3440,7 +3451,6 @@ static const struct super_operations btrfs_super_ops = {
 	.destroy_inode	= btrfs_destroy_inode,
 	.free_inode	= btrfs_free_inode,
 	.statfs		= btrfs_statfs,
-	.remount_fs	= btrfs_remount,
 	.freeze_fs	= btrfs_freeze,
 	.unfreeze_fs	= btrfs_unfreeze,
 };
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index 7c1cd7527e76..7f6577d69902 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_SUPER_H
 #define BTRFS_SUPER_H
 
+bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
+			 unsigned long flags);
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
-- 
2.41.0


