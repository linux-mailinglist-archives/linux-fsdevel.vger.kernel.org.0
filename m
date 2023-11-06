Return-Path: <linux-fsdevel+bounces-2175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05297E2F8D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862C5280DCB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D63E2FE2D;
	Mon,  6 Nov 2023 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mvOddxGG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8E2FE17
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:50 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729B2183
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:48 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-777719639adso324246385a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308527; x=1699913327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nn4wl6X2MY9lr0usk/p7POXX8Rwn7mGHQOs/SVjMcjI=;
        b=mvOddxGGsAxbmyqmRo+ZEofX4UTUy+A/zSCiepqu2HPhllDR44Vyw2ycwEHoHC1x0D
         q13tVauE+cRjedKWtLgXWD3p0o3H5jFzsdgdznGZO+wYlQ5cFuMdUMzhQVucUGjjUgME
         11tObZQZSls3y4YUgeePzPoC3luoE6DtU9YaqvXBI0pgU9LfDMLctOpUBkdn2snI3bwX
         194wjOcwOJkGxxxcWLsIjSrkmdu6JHqxnRDJ02RDG20n9/cp2yVzWYlgo0D+wvj57vzL
         BB2sD4VkxJO8ix0RKpy7aAwVyrUrFjC1aXOeTJGWaxf/N/A2wdj+1LkWjZ9URauDVRHI
         fkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308527; x=1699913327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nn4wl6X2MY9lr0usk/p7POXX8Rwn7mGHQOs/SVjMcjI=;
        b=kwBaBmn+3BQHC2fcgBDvqBhUYkKUKQo8FU3LtCy0nmVmLp0d3nDyzTQ9Zg1KcWRNB3
         /etwUiayMSMrL3HfODGVDbLHwT445D7So/mmYft/jwKzNOLtU0ht/WMzG51CHGq0z6z7
         KqlLl41Pmc0XvjM5cQFYimfkByaPDncWVBSHzhxQ+ADXuxG5mpyccrJ6oB+/SHDhUUfG
         J/4p8tb9tFUfSKRWU6l1RE5n/NuuY2gqcaVVBd/qv+Rcl5ZvzFKtn05VErbSGgK2HIce
         hFQmlWjiLTi0ZZkKmUx+y1vT1Bjr+1n5zn7fC1sHd/C5gc9mcqDaRJA2UHgj9AlVPLgd
         mcgQ==
X-Gm-Message-State: AOJu0YyjTlzDHn7uR0LbFWpARpkwbBkD0xpNgji3DuvA2TDIEJe0Hgfh
	lxfiRrUaBQ4BjKgrHTtDNcwG+A==
X-Google-Smtp-Source: AGHT+IGzmqgHg/NwwmcrhfPkj/ftVZmlblqqF5NLHLnUhn+ChPDmC97l0aqMyJ1ESpaa6EkzZ/havQ==
X-Received: by 2002:a05:620a:454d:b0:778:b3e5:f4b8 with SMTP id u13-20020a05620a454d00b00778b3e5f4b8mr35859953qkp.47.1699308527462;
        Mon, 06 Nov 2023 14:08:47 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m16-20020ae9e710000000b0076e1e2d6496sm3665958qka.104.2023.11.06.14.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:47 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 11/18] btrfs: add reconfigure callback for fs_context
Date: Mon,  6 Nov 2023 17:08:19 -0500
Message-ID: <1678ab93ebf666a47e42724908b09216f1789413.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is what is used to remount the file system with the new mount API.
Because the mount options are parsed separately and one at a time I've
added a helper to emit the mount options after the fact once the mount
is configured, this matches the dmesg output for what happens with the
old mount API.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 243 +++++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/zoned.c |  16 ++--
 fs/btrfs/zoned.h |   3 +-
 3 files changed, 234 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index facea4632a8d..b5067cf637a2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -734,10 +734,11 @@ static int btrfs_parse_param(struct fs_context *fc,
 	return 0;
 }
 
-static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
+static bool check_ro_option(struct btrfs_fs_info *fs_info,
+			    unsigned long mount_opt, unsigned long opt,
 			    const char *opt_name)
 {
-	if (fs_info->mount_opt & opt) {
+	if (mount_opt & opt) {
 		btrfs_err(fs_info, "%s must be used with ro mount option",
 			  opt_name);
 		return true;
@@ -745,33 +746,34 @@ static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
 	return false;
 }
 
-static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
+static bool check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
+			  unsigned long flags)
 {
 	if (!(flags & SB_RDONLY) &&
-	    (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
-	     check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
-	     check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
+	    (check_ro_option(info, *mount_opt, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
+	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
+	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
 		return false;
 
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, CLEAR_CACHE)) {
+	    !btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE) &&
+	    !btrfs_raw_test_opt(*mount_opt, CLEAR_CACHE)) {
 		btrfs_err(info, "cannot disable free space tree");
 		return false;
 	}
 	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
-	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
+	     !btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE)) {
 		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
 		return false;
 	}
 
-	if (btrfs_check_mountopts_zoned(info))
+	if (btrfs_check_mountopts_zoned(info, mount_opt))
 		return false;
 
 	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
-		if (btrfs_test_opt(info, SPACE_CACHE))
+		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
 			btrfs_info(info, "disk space caching is enabled");
-		if (btrfs_test_opt(info, FREE_SPACE_TREE))
+		if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
 			btrfs_info(info, "using free space tree");
 	}
 
@@ -1337,7 +1339,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		}
 	}
 out:
-	if (!ret && !check_options(info, new_flags))
+	if (!ret && !check_options(info, &info->mount_opt, new_flags))
 		ret = -EINVAL;
 	return ret;
 }
@@ -2377,6 +2379,203 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	return ret;
 }
 
+static void btrfs_ctx_to_info(struct btrfs_fs_info *fs_info,
+			      struct btrfs_fs_context *ctx)
+{
+	fs_info->max_inline = ctx->max_inline;
+	fs_info->commit_interval = ctx->commit_interval;
+	fs_info->metadata_ratio = ctx->metadata_ratio;
+	fs_info->thread_pool_size = ctx->thread_pool_size;
+	fs_info->mount_opt = ctx->mount_opt;
+	fs_info->compress_type = ctx->compress_type;
+	fs_info->compress_level = ctx->compress_level;
+}
+
+static void btrfs_info_to_ctx(struct btrfs_fs_info *fs_info,
+			      struct btrfs_fs_context *ctx)
+{
+	ctx->max_inline = fs_info->max_inline;
+	ctx->commit_interval = fs_info->commit_interval;
+	ctx->metadata_ratio = fs_info->metadata_ratio;
+	ctx->thread_pool_size = fs_info->thread_pool_size;
+	ctx->mount_opt = fs_info->mount_opt;
+	ctx->compress_type = fs_info->compress_type;
+	ctx->compress_level = fs_info->compress_level;
+}
+
+#define btrfs_info_if_set(fs_info, old_ctx, opt, fmt, args...)			\
+do {										\
+	if ((!old_ctx || !btrfs_raw_test_opt(old_ctx->mount_opt, opt)) &&	\
+	    btrfs_raw_test_opt(fs_info->mount_opt, opt))			\
+		btrfs_info(fs_info, fmt, ##args);				\
+} while (0)
+
+#define btrfs_info_if_unset(fs_info, old_ctx, opt, fmt, args...)	\
+do {									\
+	if ((old_ctx && btrfs_raw_test_opt(old_ctx->mount_opt, opt)) &&	\
+	    !btrfs_raw_test_opt(fs_info->mount_opt, opt))		\
+		btrfs_info(fs_info, fmt, ##args);			\
+} while (0)
+
+static void btrfs_emit_options(struct btrfs_fs_info *fs_info,
+			       struct btrfs_fs_context *old_ctx)
+{
+	btrfs_info_if_set(fs_info, old_ctx, NODATASUM, "setting nodatasum");
+	btrfs_info_if_set(fs_info, old_ctx, DEGRADED,
+			  "allowing degraded mounts");
+	btrfs_info_if_set(fs_info, old_ctx, NODATASUM, "setting nodatasum");
+	btrfs_info_if_set(fs_info, old_ctx, SSD, "enabling ssd optimizations");
+	btrfs_info_if_set(fs_info, old_ctx, SSD_SPREAD,
+			  "using spread ssd allocation scheme");
+	btrfs_info_if_set(fs_info, old_ctx, NOBARRIER, "turning off barriers");
+	btrfs_info_if_set(fs_info, old_ctx, NOTREELOG, "disabling tree log");
+	btrfs_info_if_set(fs_info, old_ctx, NOLOGREPLAY,
+			  "disabling log replay at mount time");
+	btrfs_info_if_set(fs_info, old_ctx, FLUSHONCOMMIT,
+			  "turning on flush-on-commit");
+	btrfs_info_if_set(fs_info, old_ctx, DISCARD_SYNC,
+			  "turning on sync discard");
+	btrfs_info_if_set(fs_info, old_ctx, DISCARD_ASYNC,
+			  "turning on async discard");
+	btrfs_info_if_set(fs_info, old_ctx, FREE_SPACE_TREE,
+			  "enabling free space tree");
+	btrfs_info_if_set(fs_info, old_ctx, SPACE_CACHE,
+			  "enabling disk space caching");
+	btrfs_info_if_set(fs_info, old_ctx, CLEAR_CACHE,
+			  "force clearing of disk cache");
+	btrfs_info_if_set(fs_info, old_ctx, AUTO_DEFRAG,
+			  "enabling auto defrag");
+	btrfs_info_if_set(fs_info, old_ctx, FRAGMENT_DATA,
+			  "fragmenting data");
+	btrfs_info_if_set(fs_info, old_ctx, FRAGMENT_METADATA,
+			  "fragmenting metadata");
+	btrfs_info_if_set(fs_info, old_ctx, REF_VERIFY,
+			  "doing ref verification");
+	btrfs_info_if_set(fs_info, old_ctx, USEBACKUPROOT,
+			  "trying to use backup root at mount time");
+	btrfs_info_if_set(fs_info, old_ctx, IGNOREBADROOTS,
+			  "ignoring bad roots");
+	btrfs_info_if_set(fs_info, old_ctx, IGNOREDATACSUMS,
+			  "ignoring data csums");
+
+	btrfs_info_if_unset(fs_info, old_ctx, NODATACOW, "setting datacow");
+	btrfs_info_if_unset(fs_info, old_ctx, SSD, "not using ssd optimizations");
+	btrfs_info_if_unset(fs_info, old_ctx, SSD_SPREAD,
+			    "not using spread ssd allocation scheme");
+	btrfs_info_if_unset(fs_info, old_ctx, NOBARRIER,
+			    "turning off barriers");
+	btrfs_info_if_unset(fs_info, old_ctx, NOTREELOG, "enabling tree log");
+	btrfs_info_if_unset(fs_info, old_ctx, SPACE_CACHE,
+			    "disabling disk space caching");
+	btrfs_info_if_unset(fs_info, old_ctx, FREE_SPACE_TREE,
+			    "disabling free space tree");
+	btrfs_info_if_unset(fs_info, old_ctx, AUTO_DEFRAG,
+			    "disabling auto defrag");
+	btrfs_info_if_unset(fs_info, old_ctx, COMPRESS,
+			    "use no compression");
+
+	/* Did the compression settings change? */
+	if (btrfs_test_opt(fs_info, COMPRESS) &&
+	    (!old_ctx ||
+	     old_ctx->compress_type != fs_info->compress_type ||
+	     old_ctx->compress_level != fs_info->compress_level ||
+	     (!btrfs_raw_test_opt(old_ctx->mount_opt, FORCE_COMPRESS) &&
+	      btrfs_raw_test_opt(fs_info->mount_opt, FORCE_COMPRESS)))) {
+		char *compress_type = "none";
+
+		switch (fs_info->compress_type) {
+		case BTRFS_COMPRESS_ZLIB:
+			compress_type = "zlib";
+			break;
+		case BTRFS_COMPRESS_LZO:
+			compress_type = "lzo";
+			break;
+		case BTRFS_COMPRESS_ZSTD:
+			compress_type = "zstd";
+			break;
+		}
+
+		btrfs_info(fs_info, "%s %s compression, level %d",
+			   btrfs_test_opt(fs_info, FORCE_COMPRESS) ? "force" : "use",
+			   compress_type, fs_info->compress_level);
+	}
+
+	if (fs_info->max_inline != BTRFS_DEFAULT_MAX_INLINE)
+		btrfs_info(fs_info, "max_inline at %llu",
+			   fs_info->max_inline);
+}
+
+static int btrfs_reconfigure(struct fs_context *fc)
+{
+	struct super_block *sb = fc->root->d_sb;
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct btrfs_fs_context old_ctx;
+	int ret = 0;
+
+	btrfs_info_to_ctx(fs_info, &old_ctx);
+
+	sync_filesystem(sb);
+	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+
+	if (!check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
+		return -EINVAL;
+
+	ret = btrfs_check_features(fs_info, !(fc->sb_flags & SB_RDONLY));
+	if (ret < 0)
+		return ret;
+
+	btrfs_ctx_to_info(fs_info, ctx);
+	btrfs_remount_begin(fs_info, old_ctx.mount_opt, fc->sb_flags);
+	btrfs_resize_thread_pool(fs_info, fs_info->thread_pool_size,
+				 old_ctx.thread_pool_size);
+
+	if ((bool)btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
+	    (bool)btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    (!sb_rdonly(sb) || (fc->sb_flags & SB_RDONLY))) {
+		btrfs_warn(fs_info,
+		"remount supports changing free space tree only from ro to rw");
+		/* Make sure free space cache options match the state on disk */
+		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+		if (btrfs_free_space_cache_v1_active(fs_info)) {
+			btrfs_clear_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+	}
+
+	ret = 0;
+	if (!sb_rdonly(sb) && (fc->sb_flags & SB_RDONLY))
+		ret = btrfs_remount_ro(fs_info);
+	else if (sb_rdonly(sb) && !(fc->sb_flags & SB_RDONLY))
+		ret = btrfs_remount_rw(fs_info);
+	if (ret)
+		goto restore;
+
+	/*
+	 * If we set the mask during the parameter parsing vfs would reject the
+	 * remount.  Here we can set the mask and the value will be updated
+	 * appropriately.
+	 */
+	if ((fc->sb_flags & SB_POSIXACL) != (sb->s_flags & SB_POSIXACL))
+		fc->sb_flags_mask |= SB_POSIXACL;
+
+	btrfs_emit_options(fs_info, &old_ctx);
+	wake_up_process(fs_info->transaction_kthread);
+	btrfs_remount_cleanup(fs_info, old_ctx.mount_opt);
+	btrfs_clear_oneshot_options(fs_info);
+	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+
+	return 0;
+restore:
+	btrfs_ctx_to_info(fs_info, &old_ctx);
+	btrfs_remount_cleanup(fs_info, old_ctx.mount_opt);
+	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
+	return ret;
+}
+
 /* Used to sort the devices by max_avail(descending sort) */
 static int btrfs_cmp_device_free_bytes(const void *a, const void *b)
 {
@@ -2654,6 +2853,7 @@ static void btrfs_free_fs_context(struct fs_context *fc)
 
 static const struct fs_context_operations btrfs_fs_context_ops = {
 	.parse_param	= btrfs_parse_param,
+	.reconfigure	= btrfs_reconfigure,
 	.free		= btrfs_free_fs_context,
 };
 
@@ -2665,17 +2865,18 @@ static int __maybe_unused btrfs_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->thread_pool_size = min_t(unsigned long, num_online_cpus() + 2, 8);
-	ctx->max_inline = BTRFS_DEFAULT_MAX_INLINE;
-	ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
-	ctx->subvol_objectid = BTRFS_FS_TREE_OBJECTID;
-#ifndef CONFIG_BTRFS_FS_POSIX_ACL
-	ctx->noacl = true;
-#endif
-
 	fc->fs_private = ctx;
 	fc->ops = &btrfs_fs_context_ops;
 
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+		btrfs_info_to_ctx(btrfs_sb(fc->root->d_sb), ctx);
+	} else {
+		ctx->thread_pool_size =
+			min_t(unsigned long, num_online_cpus() + 2, 8);
+		ctx->max_inline = BTRFS_DEFAULT_MAX_INLINE;
+		ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
+	}
+
 	return 0;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 188378ca19c7..77b065ce3ed3 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -781,7 +781,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	 * Check mount options here, because we might change fs_info->zoned
 	 * from fs_info->zone_size.
 	 */
-	ret = btrfs_check_mountopts_zoned(fs_info);
+	ret = btrfs_check_mountopts_zoned(fs_info, &fs_info->mount_opt);
 	if (ret)
 		return ret;
 
@@ -789,7 +789,8 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
+int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info,
+				unsigned long *mount_opt)
 {
 	if (!btrfs_is_zoned(info))
 		return 0;
@@ -798,18 +799,21 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 	 * Space cache writing is not COWed. Disable that to avoid write errors
 	 * in sequential zones.
 	 */
-	if (btrfs_test_opt(info, SPACE_CACHE)) {
+	if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
 		btrfs_err(info, "zoned: space cache v1 is not supported");
 		return -EINVAL;
 	}
 
-	if (btrfs_test_opt(info, NODATACOW)) {
+	if (btrfs_raw_test_opt(*mount_opt, NODATACOW)) {
 		btrfs_err(info, "zoned: NODATACOW not supported");
 		return -EINVAL;
 	}
 
-	btrfs_clear_and_info(info, DISCARD_ASYNC,
-			"zoned: async discard ignored and disabled for zoned mode");
+	if (btrfs_raw_test_opt(*mount_opt, DISCARD_ASYNC)) {
+		btrfs_info(info,
+			   "zoned: async discard ignored and disabled for zoned mode");
+		btrfs_clear_opt(*mount_opt, DISCARD_ASYNC);
+	}
 
 	return 0;
 }
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index b9cec523b778..80459d750080 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -45,7 +45,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_device *orig_dev);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
-int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
+int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info,
+				unsigned long *mount_opt);
 int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 			       u64 *bytenr_ret);
 int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
-- 
2.41.0


