Return-Path: <linux-fsdevel+bounces-2425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A205F7E5E4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E45B20C20
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CAD38F95;
	Wed,  8 Nov 2023 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="T79uEGq8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC838DDF
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:09:31 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595172110
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 11:09:31 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7781b176131so881685a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470570; x=1700075370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nlf0bSiqjA9HMF+s9IgKzL74hdmthSgXGqJxEm7KgSY=;
        b=T79uEGq8/h1qZRf3F6pFp15CklmK73t26fyzIhdGsC3aD4dFF9MnbwxrvSNfXejfO/
         RbqOc1EMFxvMafbc4h/Dd+nnj/rzbFGpW2iBeouMT01G66qKs2KN6CajE1Op0ko0sier
         jFLxiaOMPGw1H3Sn+EHJUbR6OQFYLA9OOKgPD+HVRD/FCAA3pqJxVO9MSQOz1oyPqRks
         30kAruu000i/JT1sRFFaUNvJgDlIEhZuG25ecMeDNPx9ADw33mMNZ2mUEWB3oRcH6e8T
         OWdzIcvBSsrrkmee3U/IOxOv2gTMOU1idk4/Zidl6/ph/3deEmJucYNKfGbV34g25it6
         zTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470570; x=1700075370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nlf0bSiqjA9HMF+s9IgKzL74hdmthSgXGqJxEm7KgSY=;
        b=lQrb7YqTQ1XjrEo9CM4idAHj5ZlHRgHHbTCbDmPYP5d5HqgITTE33LuX4lcNXujkRD
         VVo5HvFQA1y/N8Epf0EDmd0/BysQx1WUIJfi/Zki9W3gk429Lq1WJvcIMxiSEaMl6Y0/
         wgJJ5yUHRINmKsnlunayek+RvPtD2LnDGtLpfzLCvHwnFH0aBGwyeqBDwQxBfdNsMF/t
         UvjQmmoMc+zjKEcLvQytJCgXzAMmMhvqRvcKLw3ZCWL3ghZdi8Xenp7FjTna4e354TZT
         +6K0ClxCqOIRFpZnj74+dm+wnCTW2h4P8vzpNFUbcntdPYHEN3okVGG/mwdm7gGrz36j
         LL+g==
X-Gm-Message-State: AOJu0Yw0tU9/5ntn5E7w3fw/q0Fmk93uaH9NL0MZff+G+IW5bitO5ae4
	ZZBjbcNJfvJriKHkcoXPiqPUQJyN+xt7+syPLWOrtw==
X-Google-Smtp-Source: AGHT+IHhPzRKFeIsHyA+w64Qf56Ccunx6pHgfe+q4jU9hmFmtEL1KDsaDGBc89mM3uoxX7kUCmm2yw==
X-Received: by 2002:a05:620a:3908:b0:77a:1c6c:7924 with SMTP id qr8-20020a05620a390800b0077a1c6c7924mr2670800qkn.60.1699470570408;
        Wed, 08 Nov 2023 11:09:30 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g4-20020ae9e104000000b007743671a41fsm1341943qkm.72.2023.11.08.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:29 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 12/18] btrfs: add get_tree callback for new mount API
Date: Wed,  8 Nov 2023 14:08:47 -0500
Message-ID: <1dea0813411eb5c08ddcdefcdae006e751dd15eb.1699470345.git.josef@toxicpanda.com>
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

This is the actual mounting callback for the new mount API.  Implement
this using our current fill super as a guideline, making the appropriate
adjustments for the new mount API.

Our old mount operation had two fs_types, one to handle the actual
opening, and the one that we called to handle the actual opening and
then did the subvol lookup for returning the actual root dentry.  This
is mirrored here, but simply with different behaviors for ->get_tree.
We use the existence of ->s_fs_info to tell which part we're in.  The
initial call allocates the fs_info, then call mount_fc() with a
duplicated fc to do the actual open_ctree part.  Then we take that
vfsmount and use it to look up our subvolume that we're mounting and
return that as our s_root.  This idea was taken from Christians attempt
to convert us to the new mount api.

References: https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-2-045e9735a00b@kernel.org/
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 206 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b5067cf637a2..4ace42e08bff 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -95,6 +95,7 @@ struct btrfs_fs_context {
 	unsigned long mount_opt;
 	unsigned long compress_type:4;
 	unsigned int compress_level;
+	refcount_t refs;
 };
 
 enum {
@@ -2833,6 +2834,181 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
+static int btrfs_fc_test_super(struct super_block *s, struct fs_context *fc)
+{
+	struct btrfs_fs_info *p = fc->s_fs_info;
+	struct btrfs_fs_info *fs_info = btrfs_sb(s);
+
+	return fs_info->fs_devices == p->fs_devices;
+}
+
+static int btrfs_get_tree_super(struct fs_context *fc)
+{
+	struct btrfs_fs_info *fs_info = fc->s_fs_info;
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct btrfs_fs_devices *fs_devices = NULL;
+	struct block_device *bdev;
+	struct btrfs_device *device;
+	struct super_block *s;
+	blk_mode_t mode = sb_open_mode(fc->sb_flags);
+	int ret;
+
+	btrfs_ctx_to_info(fs_info, ctx);
+	mutex_lock(&uuid_mutex);
+
+	/*
+	 * With 'true' passed to btrfs_scan_one_device() (mount time) we expect
+	 * either a valid device or an error.
+	 */
+	device = btrfs_scan_one_device(fc->source, mode, true);
+	ASSERT(device != NULL);
+	if (IS_ERR(device)) {
+		mutex_unlock(&uuid_mutex);
+		return PTR_ERR(device);
+	}
+
+	fs_devices = device->fs_devices;
+	fs_info->fs_devices = fs_devices;
+
+	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+	mutex_unlock(&uuid_mutex);
+	if (ret)
+		return ret;
+
+	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
+		ret = -EACCES;
+		goto error;
+	}
+
+	bdev = fs_devices->latest_dev->bdev;
+
+	/*
+	 * If successful, this will transfer the fs_info into the super block,
+	 * and fc->s_fs_info will be NULL.  However if there's an existing
+	 * super, we'll still have fc->s_fs_info populated.  If we error
+	 * completely out it'll be cleaned up when we drop the fs_context,
+	 * otherwise it's tied to the lifetime of the super_block.
+	 *
+	 * Adding this comment because I was horribly confused about the error
+	 * handling from here on out.
+	 */
+	s = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
+	if (IS_ERR(s)) {
+		ret = PTR_ERR(s);
+		goto error;
+	}
+
+	if (s->s_root) {
+		btrfs_close_devices(fs_devices);
+		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY)
+			ret = -EBUSY;
+	} else {
+		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
+		shrinker_debugfs_rename(&s->s_shrink, "sb-btrfs:%s", s->s_id);
+		btrfs_sb(s)->bdev_holder = &btrfs_fs_type;
+		ret = btrfs_fill_super(s, fs_devices, NULL);
+	}
+
+	if (ret) {
+		deactivate_locked_super(s);
+		return ret;
+	}
+
+	fc->root = dget(s->s_root);
+	return 0;
+
+error:
+	btrfs_close_devices(fs_devices);
+	return ret;
+}
+
+static int btrfs_get_tree_subvol(struct fs_context *fc)
+{
+	struct btrfs_fs_info *fs_info = NULL;
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct fs_context *dup_fc;
+	struct dentry *dentry;
+	struct vfsmount *mnt;
+
+	/*
+	 * Setup a dummy root and fs_info for test/set super.  This is because
+	 * we don't actually fill this stuff out until open_ctree, but we need
+	 * then open_ctree will properly initialize the file system specific
+	 * settings later.  btrfs_init_fs_info initializes the static elements
+	 * of the fs_info (locks and such) to make cleanup easier if we find a
+	 * superblock with our given fs_devices later on at sget() time.
+	 */
+	fs_info = kvzalloc(sizeof(struct btrfs_fs_info), GFP_KERNEL);
+	if (!fs_info)
+		return -ENOMEM;
+
+	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
+	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
+	if (!fs_info->super_copy || !fs_info->super_for_commit) {
+		btrfs_free_fs_info(fs_info);
+		return -ENOMEM;
+	}
+	btrfs_init_fs_info(fs_info);
+
+	dup_fc = vfs_dup_fs_context(fc);
+	if (IS_ERR(dup_fc)) {
+		btrfs_free_fs_info(fs_info);
+		return PTR_ERR(dup_fc);
+	}
+
+	/*
+	 * When we do the sget_fc this gets transferred to the sb, so we only
+	 * need to set it on the dup_fc as this is what creates the super block.
+	 */
+	dup_fc->s_fs_info = fs_info;
+
+	/*
+	 * We'll do the security settings in our btrfs_get_tree_super() mount
+	 * loop, they were duplicated into dup_fc, we can drop the originals
+	 * here.
+	 */
+	security_free_mnt_opts(&fc->security);
+	fc->security = NULL;
+
+	mnt = fc_mount(dup_fc);
+	put_fs_context(dup_fc);
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+
+	/*
+	 * This free's ->subvol_name, because if it isn't set we have to
+	 * allocate a buffer to hold the subvol_name, so we just drop our
+	 * reference to it here.
+	 */
+	dentry = mount_subvol(ctx->subvol_name, ctx->subvol_objectid, mnt);
+	ctx->subvol_name = NULL;
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	fc->root = dentry;
+	return 0;
+}
+
+static int btrfs_get_tree(struct fs_context *fc)
+{
+	/*
+	 * Since we use mount_subtree to mount the default/specified subvol, we
+	 * have to do mounts in two steps.
+	 *
+	 * First pass through we call btrfs_get_tree_subvol(), this is just a
+	 * wrapper around fc_mount() to call back into here again, and this time
+	 * we'll call btrfs_get_tree_super().  This will do the open_ctree() and
+	 * everything to open the devices and file system.  Then we return back
+	 * with a fully constructed vfsmount in btrfs_get_tree_subvol(), and
+	 * from there we can do our mount_subvol() call, which will lookup
+	 * whichever subvol we're mounting and setup this fc with the
+	 * appropriate dentry for the subvol.
+	 */
+	if (fc->s_fs_info)
+		return btrfs_get_tree_super(fc);
+	return btrfs_get_tree_subvol(fc);
+}
+
 static void btrfs_kill_super(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
@@ -2843,17 +3019,42 @@ static void btrfs_kill_super(struct super_block *sb)
 static void btrfs_free_fs_context(struct fs_context *fc)
 {
 	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct btrfs_fs_info *fs_info = fc->s_fs_info;
 
-	if (!ctx)
-		return;
+	if (fs_info)
+		btrfs_free_fs_info(fs_info);
 
-	kfree(ctx->subvol_name);
-	kfree(ctx);
+	if (ctx && refcount_dec_and_test(&ctx->refs)) {
+		kfree(ctx->subvol_name);
+		kfree(ctx);
+	}
+}
+
+static int btrfs_dup_fs_context(struct fs_context *fc,
+				struct fs_context *src_fc)
+{
+	struct btrfs_fs_context *ctx = src_fc->fs_private;
+
+	/*
+	 * Give a ref to our ctx to this dup, as we want to keep it around for
+	 * our original fc so we can have the subvolume name or objectid.
+	 *
+	 * We unset ->source in the original fc because the dup needs it for
+	 * mounting, and then once we free the dup it'll free ->source, so we
+	 * need to make sure we're only pointing to it in one fc.
+	 */
+	refcount_inc(&ctx->refs);
+	fc->fs_private = ctx;
+	fc->source = src_fc->source;
+	src_fc->source = NULL;
+	return 0;
 }
 
 static const struct fs_context_operations btrfs_fs_context_ops = {
 	.parse_param	= btrfs_parse_param,
 	.reconfigure	= btrfs_reconfigure,
+	.get_tree	= btrfs_get_tree,
+	.dup		= btrfs_dup_fs_context,
 	.free		= btrfs_free_fs_context,
 };
 
@@ -2865,6 +3066,7 @@ static int __maybe_unused btrfs_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 
+	refcount_set(&ctx->refs, 1);
 	fc->fs_private = ctx;
 	fc->ops = &btrfs_fs_context_ops;
 
-- 
2.41.0


