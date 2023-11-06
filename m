Return-Path: <linux-fsdevel+bounces-2180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017757E2F92
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9921280EC5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED330CF5;
	Mon,  6 Nov 2023 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OpE++HsI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B430CEC
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:57 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2429310A
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:54 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-779fb118fe4so326924485a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308533; x=1699913333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZCWLuPRM7Thgi4A1NOtPXGJ/UOYIa1zCCk9HOaESuA=;
        b=OpE++HsIzvscjrqEcSby94A9qjv3ykutvH9ZCU4YE/6c1KCHzgqFllFdIacaCI77Yb
         lLXxcQwFjthYCSkYHnc735fpnOVzgUTklKFfJIJk6+cEM/VLpFRJaZZcqPLf2JvgokyL
         3tao27xy0kho0GXHtP5OERN7bGsELOk2k1C+4ZumQdRDUgD3G4loNn2W2hVKhqteag9g
         7pWGuRA9u6ak3j31pwVsZjx7DLNsHnXPFnsPdd0rr0b+tWM7r7eEaflJB2byrLGq6hgv
         kxj2pALK/yee6Z4Uwi28KecG8oWTFiyFS4ng6T+2n2lWBHq7uPItH2wT5iSXMeQhcRYe
         G1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308533; x=1699913333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZCWLuPRM7Thgi4A1NOtPXGJ/UOYIa1zCCk9HOaESuA=;
        b=mghWagCXQVI7MtKkzVotNsXc8DNjIWQM5PubHe8F08AWI+55YSnR9ALFfM24jG1gak
         4gzWKLfcW7jXvHm8n7Q4mEZF+FIoc+7vaxOEJug8lMxEr/B7ZylASY22ke4nGZYDxaBf
         H0zJ+fafez+F1otgzW3M1urO0ZxRL4Zh2pBA3eE95kE0f6/XPNznwwNb4K8AvWlWQkUS
         3TM7i6MXcR5DStpQxAYlSZaSZt8ojrDoTfknIy2NTSQ//z8EzzKsVaT8anAz9NM5r7R6
         snS+MUwhvl/0r4JRVdf00nIdi4I515IKNgvd+xidwLsIKu5SN2T2Sx+skGKicxqjKXZN
         7mWw==
X-Gm-Message-State: AOJu0YzadECgoMXmqW2B5CKFE/o0rt0B1G3mu01s3yWKV7sbGLBJPYYI
	Due1utG7Tlaw3yzkcxjpdkk8NFy32Ym6/MZ7G+js4A==
X-Google-Smtp-Source: AGHT+IG+MBvvG7HRsg7V/qEBPMXoBwscAmRUxrx2yDbOuOBrf6K1c+GatgwEPOmkCO/VWTGekJj2aQ==
X-Received: by 2002:a05:620a:1117:b0:779:f645:c203 with SMTP id o23-20020a05620a111700b00779f645c203mr30626738qkk.29.1699308533058;
        Mon, 06 Nov 2023 14:08:53 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d1-20020a37c401000000b0076f058f5834sm3658195qki.61.2023.11.06.14.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:52 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 16/18] btrfs: remove old mount API code
Date: Mon,  6 Nov 2023 17:08:24 -0500
Message-ID: <1ad828ba077084571689768f5fa02e047cf17be3.1699308010.git.josef@toxicpanda.com>
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

Now that we've switched to the new mount api, remove the old stuff.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/fs.h    |   14 -
 fs/btrfs/super.c | 1078 +---------------------------------------------
 fs/btrfs/super.h |    2 -
 3 files changed, 13 insertions(+), 1081 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index ecfa13a9c2cf..41be64e7c045 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -961,20 +961,6 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 #define btrfs_test_opt(fs_info, opt)	((fs_info)->mount_opt & \
 					 BTRFS_MOUNT_##opt)
 
-#define btrfs_set_and_info(fs_info, opt, fmt, args...)			\
-do {									\
-	if (!btrfs_test_opt(fs_info, opt))				\
-		btrfs_info(fs_info, fmt, ##args);			\
-	btrfs_set_opt(fs_info->mount_opt, opt);				\
-} while (0)
-
-#define btrfs_clear_and_info(fs_info, opt, fmt, args...)		\
-do {									\
-	if (btrfs_test_opt(fs_info, opt))				\
-		btrfs_info(fs_info, fmt, ##args);			\
-	btrfs_clear_opt(fs_info->mount_opt, opt);			\
-} while (0)
-
 static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
 {
 	/* Do it this way so we only ever do one test_bit in the normal case. */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e67578dc48de..6a9561a336f3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -65,19 +65,7 @@
 #include <trace/events/btrfs.h>
 
 static const struct super_operations btrfs_super_ops;
-
-/*
- * Types for mounting the default subvolume and a subvolume explicitly
- * requested by subvol=/path. That way the callchain is straightforward and we
- * don't have to play tricks with the mount options and recursive calls to
- * btrfs_mount.
- *
- * The new btrfs_root_fs_type also servers as a tag for the bdev_holder.
- */
 static struct file_system_type btrfs_fs_type;
-static struct file_system_type btrfs_root_fs_type;
-
-static int btrfs_remount(struct super_block *sb, int *flags, char *data);
 
 static void btrfs_put_super(struct super_block *sb)
 {
@@ -99,7 +87,7 @@ struct btrfs_fs_context {
 };
 
 enum {
-	Opt_acl, Opt_noacl,
+	Opt_acl,
 	Opt_clear_cache,
 	Opt_commit_interval,
 	Opt_compress,
@@ -109,27 +97,26 @@ enum {
 	Opt_degraded,
 	Opt_device,
 	Opt_fatal_errors,
-	Opt_flushoncommit, Opt_noflushoncommit,
+	Opt_flushoncommit,
 	Opt_max_inline,
-	Opt_barrier, Opt_nobarrier,
-	Opt_datacow, Opt_nodatacow,
-	Opt_datasum, Opt_nodatasum,
-	Opt_defrag, Opt_nodefrag,
-	Opt_discard, Opt_nodiscard,
+	Opt_barrier,
+	Opt_datacow,
+	Opt_datasum,
+	Opt_defrag,
+	Opt_discard,
 	Opt_discard_mode,
-	Opt_norecovery,
 	Opt_ratio,
 	Opt_rescan_uuid_tree,
 	Opt_skip_balance,
-	Opt_space_cache, Opt_no_space_cache,
+	Opt_space_cache,
 	Opt_space_cache_version,
-	Opt_ssd, Opt_nossd,
-	Opt_ssd_spread, Opt_nossd_spread,
+	Opt_ssd,
+	Opt_ssd_spread,
 	Opt_subvol,
 	Opt_subvol_empty,
 	Opt_subvolid,
 	Opt_thread_pool,
-	Opt_treelog, Opt_notreelog,
+	Opt_treelog,
 	Opt_user_subvol_rm_allowed,
 
 	/* Rescue options */
@@ -142,10 +129,10 @@ enum {
 
 	/* Deprecated options */
 	Opt_recovery,
-	Opt_inode_cache, Opt_noinode_cache,
+	Opt_inode_cache,
 
 	/* Debugging options */
-	Opt_enospc_debug, Opt_noenospc_debug,
+	Opt_enospc_debug,
 #ifdef CONFIG_BTRFS_DEBUG
 	Opt_fragment, Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
 #endif
@@ -155,88 +142,6 @@ enum {
 	Opt_err,
 };
 
-static const match_table_t tokens = {
-	{Opt_acl, "acl"},
-	{Opt_noacl, "noacl"},
-	{Opt_clear_cache, "clear_cache"},
-	{Opt_commit_interval, "commit=%u"},
-	{Opt_compress, "compress"},
-	{Opt_compress_type, "compress=%s"},
-	{Opt_compress_force, "compress-force"},
-	{Opt_compress_force_type, "compress-force=%s"},
-	{Opt_degraded, "degraded"},
-	{Opt_device, "device=%s"},
-	{Opt_fatal_errors, "fatal_errors=%s"},
-	{Opt_flushoncommit, "flushoncommit"},
-	{Opt_noflushoncommit, "noflushoncommit"},
-	{Opt_inode_cache, "inode_cache"},
-	{Opt_noinode_cache, "noinode_cache"},
-	{Opt_max_inline, "max_inline=%s"},
-	{Opt_barrier, "barrier"},
-	{Opt_nobarrier, "nobarrier"},
-	{Opt_datacow, "datacow"},
-	{Opt_nodatacow, "nodatacow"},
-	{Opt_datasum, "datasum"},
-	{Opt_nodatasum, "nodatasum"},
-	{Opt_defrag, "autodefrag"},
-	{Opt_nodefrag, "noautodefrag"},
-	{Opt_discard, "discard"},
-	{Opt_discard_mode, "discard=%s"},
-	{Opt_nodiscard, "nodiscard"},
-	{Opt_norecovery, "norecovery"},
-	{Opt_ratio, "metadata_ratio=%u"},
-	{Opt_rescan_uuid_tree, "rescan_uuid_tree"},
-	{Opt_skip_balance, "skip_balance"},
-	{Opt_space_cache, "space_cache"},
-	{Opt_no_space_cache, "nospace_cache"},
-	{Opt_space_cache_version, "space_cache=%s"},
-	{Opt_ssd, "ssd"},
-	{Opt_nossd, "nossd"},
-	{Opt_ssd_spread, "ssd_spread"},
-	{Opt_nossd_spread, "nossd_spread"},
-	{Opt_subvol, "subvol=%s"},
-	{Opt_subvol_empty, "subvol="},
-	{Opt_subvolid, "subvolid=%s"},
-	{Opt_thread_pool, "thread_pool=%u"},
-	{Opt_treelog, "treelog"},
-	{Opt_notreelog, "notreelog"},
-	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
-
-	/* Rescue options */
-	{Opt_rescue, "rescue=%s"},
-	/* Deprecated, with alias rescue=nologreplay */
-	{Opt_nologreplay, "nologreplay"},
-	/* Deprecated, with alias rescue=usebackuproot */
-	{Opt_usebackuproot, "usebackuproot"},
-
-	/* Deprecated options */
-	{Opt_recovery, "recovery"},
-
-	/* Debugging options */
-	{Opt_enospc_debug, "enospc_debug"},
-	{Opt_noenospc_debug, "noenospc_debug"},
-#ifdef CONFIG_BTRFS_DEBUG
-	{Opt_fragment_data, "fragment=data"},
-	{Opt_fragment_metadata, "fragment=metadata"},
-	{Opt_fragment_all, "fragment=all"},
-#endif
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
-	{Opt_ref_verify, "ref_verify"},
-#endif
-	{Opt_err, NULL},
-};
-
-static const match_table_t rescue_tokens = {
-	{Opt_usebackuproot, "usebackuproot"},
-	{Opt_nologreplay, "nologreplay"},
-	{Opt_ignorebadroots, "ignorebadroots"},
-	{Opt_ignorebadroots, "ibadroots"},
-	{Opt_ignoredatacsums, "ignoredatacsums"},
-	{Opt_ignoredatacsums, "idatacsums"},
-	{Opt_rescue_all, "all"},
-	{Opt_err, NULL},
-};
-
 enum {
 	Opt_fatal_errors_panic,
 	Opt_fatal_errors_bug,
@@ -846,660 +751,6 @@ static void set_device_specific_options(struct btrfs_fs_info *fs_info)
 		btrfs_set_opt(fs_info->mount_opt, DISCARD_ASYNC);
 }
 
-static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
-{
-	char *opts;
-	char *orig;
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int ret = 0;
-
-	opts = kstrdup(options, GFP_KERNEL);
-	if (!opts)
-		return -ENOMEM;
-	orig = opts;
-
-	while ((p = strsep(&opts, ":")) != NULL) {
-		int token;
-
-		if (!*p)
-			continue;
-		token = match_token(p, rescue_tokens, args);
-		switch (token){
-		case Opt_usebackuproot:
-			btrfs_info(info,
-				   "trying to use backup root at mount time");
-			btrfs_set_opt(info->mount_opt, USEBACKUPROOT);
-			break;
-		case Opt_nologreplay:
-			btrfs_set_and_info(info, NOLOGREPLAY,
-					   "disabling log replay at mount time");
-			break;
-		case Opt_ignorebadroots:
-			btrfs_set_and_info(info, IGNOREBADROOTS,
-					   "ignoring bad roots");
-			break;
-		case Opt_ignoredatacsums:
-			btrfs_set_and_info(info, IGNOREDATACSUMS,
-					   "ignoring data csums");
-			break;
-		case Opt_rescue_all:
-			btrfs_info(info, "enabling all of the rescue options");
-			btrfs_set_and_info(info, IGNOREDATACSUMS,
-					   "ignoring data csums");
-			btrfs_set_and_info(info, IGNOREBADROOTS,
-					   "ignoring bad roots");
-			btrfs_set_and_info(info, NOLOGREPLAY,
-					   "disabling log replay at mount time");
-			break;
-		case Opt_err:
-			btrfs_info(info, "unrecognized rescue option '%s'", p);
-			ret = -EINVAL;
-			goto out;
-		default:
-			break;
-		}
-
-	}
-out:
-	kfree(orig);
-	return ret;
-}
-
-/*
- * Regular mount options parser.  Everything that is needed only when
- * reading in a new superblock is parsed here.
- * XXX JDM: This needs to be cleaned up for remount.
- */
-int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
-			unsigned long new_flags)
-{
-	substring_t args[MAX_OPT_ARGS];
-	char *p, *num;
-	int intarg;
-	int ret = 0;
-	char *compress_type;
-	bool compress_force = false;
-	enum btrfs_compression_type saved_compress_type;
-	int saved_compress_level;
-	bool saved_compress_force;
-	int no_compress = 0;
-
-	/*
-	 * Even the options are empty, we still need to do extra check
-	 * against new flags
-	 */
-	if (!options)
-		goto out;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_degraded:
-			btrfs_info(info, "allowing degraded mounts");
-			btrfs_set_opt(info->mount_opt, DEGRADED);
-			break;
-		case Opt_subvol:
-		case Opt_subvol_empty:
-		case Opt_subvolid:
-		case Opt_device:
-			/*
-			 * These are parsed by btrfs_parse_subvol_options or
-			 * btrfs_parse_device_options and can be ignored here.
-			 */
-			break;
-		case Opt_nodatasum:
-			btrfs_set_and_info(info, NODATASUM,
-					   "setting nodatasum");
-			break;
-		case Opt_datasum:
-			if (btrfs_test_opt(info, NODATASUM)) {
-				if (btrfs_test_opt(info, NODATACOW))
-					btrfs_info(info,
-						   "setting datasum, datacow enabled");
-				else
-					btrfs_info(info, "setting datasum");
-			}
-			btrfs_clear_opt(info->mount_opt, NODATACOW);
-			btrfs_clear_opt(info->mount_opt, NODATASUM);
-			break;
-		case Opt_nodatacow:
-			if (!btrfs_test_opt(info, NODATACOW)) {
-				if (!btrfs_test_opt(info, COMPRESS) ||
-				    !btrfs_test_opt(info, FORCE_COMPRESS)) {
-					btrfs_info(info,
-						   "setting nodatacow, compression disabled");
-				} else {
-					btrfs_info(info, "setting nodatacow");
-				}
-			}
-			btrfs_clear_opt(info->mount_opt, COMPRESS);
-			btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
-			btrfs_set_opt(info->mount_opt, NODATACOW);
-			btrfs_set_opt(info->mount_opt, NODATASUM);
-			break;
-		case Opt_datacow:
-			btrfs_clear_and_info(info, NODATACOW,
-					     "setting datacow");
-			break;
-		case Opt_compress_force:
-		case Opt_compress_force_type:
-			compress_force = true;
-			fallthrough;
-		case Opt_compress:
-		case Opt_compress_type:
-			saved_compress_type = btrfs_test_opt(info,
-							     COMPRESS) ?
-				info->compress_type : BTRFS_COMPRESS_NONE;
-			saved_compress_force =
-				btrfs_test_opt(info, FORCE_COMPRESS);
-			saved_compress_level = info->compress_level;
-			if (token == Opt_compress ||
-			    token == Opt_compress_force ||
-			    strncmp(args[0].from, "zlib", 4) == 0) {
-				compress_type = "zlib";
-
-				info->compress_type = BTRFS_COMPRESS_ZLIB;
-				info->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
-				/*
-				 * args[0] contains uninitialized data since
-				 * for these tokens we don't expect any
-				 * parameter.
-				 */
-				if (token != Opt_compress &&
-				    token != Opt_compress_force)
-					info->compress_level =
-					  btrfs_compress_str2level(
-							BTRFS_COMPRESS_ZLIB,
-							args[0].from + 4);
-				btrfs_set_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, NODATACOW);
-				btrfs_clear_opt(info->mount_opt, NODATASUM);
-				no_compress = 0;
-			} else if (strncmp(args[0].from, "lzo", 3) == 0) {
-				compress_type = "lzo";
-				info->compress_type = BTRFS_COMPRESS_LZO;
-				info->compress_level = 0;
-				btrfs_set_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, NODATACOW);
-				btrfs_clear_opt(info->mount_opt, NODATASUM);
-				btrfs_set_fs_incompat(info, COMPRESS_LZO);
-				no_compress = 0;
-			} else if (strncmp(args[0].from, "zstd", 4) == 0) {
-				compress_type = "zstd";
-				info->compress_type = BTRFS_COMPRESS_ZSTD;
-				info->compress_level =
-					btrfs_compress_str2level(
-							 BTRFS_COMPRESS_ZSTD,
-							 args[0].from + 4);
-				btrfs_set_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, NODATACOW);
-				btrfs_clear_opt(info->mount_opt, NODATASUM);
-				btrfs_set_fs_incompat(info, COMPRESS_ZSTD);
-				no_compress = 0;
-			} else if (strncmp(args[0].from, "no", 2) == 0) {
-				compress_type = "no";
-				info->compress_level = 0;
-				info->compress_type = 0;
-				btrfs_clear_opt(info->mount_opt, COMPRESS);
-				btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
-				compress_force = false;
-				no_compress++;
-			} else {
-				btrfs_err(info, "unrecognized compression value %s",
-					  args[0].from);
-				ret = -EINVAL;
-				goto out;
-			}
-
-			if (compress_force) {
-				btrfs_set_opt(info->mount_opt, FORCE_COMPRESS);
-			} else {
-				/*
-				 * If we remount from compress-force=xxx to
-				 * compress=xxx, we need clear FORCE_COMPRESS
-				 * flag, otherwise, there is no way for users
-				 * to disable forcible compression separately.
-				 */
-				btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
-			}
-			if (no_compress == 1) {
-				btrfs_info(info, "use no compression");
-			} else if ((info->compress_type != saved_compress_type) ||
-				   (compress_force != saved_compress_force) ||
-				   (info->compress_level != saved_compress_level)) {
-				btrfs_info(info, "%s %s compression, level %d",
-					   (compress_force) ? "force" : "use",
-					   compress_type, info->compress_level);
-			}
-			compress_force = false;
-			break;
-		case Opt_ssd:
-			btrfs_set_and_info(info, SSD,
-					   "enabling ssd optimizations");
-			btrfs_clear_opt(info->mount_opt, NOSSD);
-			break;
-		case Opt_ssd_spread:
-			btrfs_set_and_info(info, SSD,
-					   "enabling ssd optimizations");
-			btrfs_set_and_info(info, SSD_SPREAD,
-					   "using spread ssd allocation scheme");
-			btrfs_clear_opt(info->mount_opt, NOSSD);
-			break;
-		case Opt_nossd:
-			btrfs_set_opt(info->mount_opt, NOSSD);
-			btrfs_clear_and_info(info, SSD,
-					     "not using ssd optimizations");
-			fallthrough;
-		case Opt_nossd_spread:
-			btrfs_clear_and_info(info, SSD_SPREAD,
-					     "not using spread ssd allocation scheme");
-			break;
-		case Opt_barrier:
-			btrfs_clear_and_info(info, NOBARRIER,
-					     "turning on barriers");
-			break;
-		case Opt_nobarrier:
-			btrfs_set_and_info(info, NOBARRIER,
-					   "turning off barriers");
-			break;
-		case Opt_thread_pool:
-			ret = match_int(&args[0], &intarg);
-			if (ret) {
-				btrfs_err(info, "unrecognized thread_pool value %s",
-					  args[0].from);
-				goto out;
-			} else if (intarg == 0) {
-				btrfs_err(info, "invalid value 0 for thread_pool");
-				ret = -EINVAL;
-				goto out;
-			}
-			info->thread_pool_size = intarg;
-			break;
-		case Opt_max_inline:
-			num = match_strdup(&args[0]);
-			if (num) {
-				info->max_inline = memparse(num, NULL);
-				kfree(num);
-
-				if (info->max_inline) {
-					info->max_inline = min_t(u64,
-						info->max_inline,
-						info->sectorsize);
-				}
-				btrfs_info(info, "max_inline at %llu",
-					   info->max_inline);
-			} else {
-				ret = -ENOMEM;
-				goto out;
-			}
-			break;
-		case Opt_acl:
-#ifdef CONFIG_BTRFS_FS_POSIX_ACL
-			info->sb->s_flags |= SB_POSIXACL;
-			break;
-#else
-			btrfs_err(info, "support for ACL not compiled in!");
-			ret = -EINVAL;
-			goto out;
-#endif
-		case Opt_noacl:
-			info->sb->s_flags &= ~SB_POSIXACL;
-			break;
-		case Opt_notreelog:
-			btrfs_set_and_info(info, NOTREELOG,
-					   "disabling tree log");
-			break;
-		case Opt_treelog:
-			btrfs_clear_and_info(info, NOTREELOG,
-					     "enabling tree log");
-			break;
-		case Opt_norecovery:
-		case Opt_nologreplay:
-			btrfs_warn(info,
-		"'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
-			btrfs_set_and_info(info, NOLOGREPLAY,
-					   "disabling log replay at mount time");
-			break;
-		case Opt_flushoncommit:
-			btrfs_set_and_info(info, FLUSHONCOMMIT,
-					   "turning on flush-on-commit");
-			break;
-		case Opt_noflushoncommit:
-			btrfs_clear_and_info(info, FLUSHONCOMMIT,
-					     "turning off flush-on-commit");
-			break;
-		case Opt_ratio:
-			ret = match_int(&args[0], &intarg);
-			if (ret) {
-				btrfs_err(info, "unrecognized metadata_ratio value %s",
-					  args[0].from);
-				goto out;
-			}
-			info->metadata_ratio = intarg;
-			btrfs_info(info, "metadata ratio %u",
-				   info->metadata_ratio);
-			break;
-		case Opt_discard:
-		case Opt_discard_mode:
-			if (token == Opt_discard ||
-			    strcmp(args[0].from, "sync") == 0) {
-				btrfs_clear_opt(info->mount_opt, DISCARD_ASYNC);
-				btrfs_set_and_info(info, DISCARD_SYNC,
-						   "turning on sync discard");
-			} else if (strcmp(args[0].from, "async") == 0) {
-				btrfs_clear_opt(info->mount_opt, DISCARD_SYNC);
-				btrfs_set_and_info(info, DISCARD_ASYNC,
-						   "turning on async discard");
-			} else {
-				btrfs_err(info, "unrecognized discard mode value %s",
-					  args[0].from);
-				ret = -EINVAL;
-				goto out;
-			}
-			btrfs_clear_opt(info->mount_opt, NODISCARD);
-			break;
-		case Opt_nodiscard:
-			btrfs_clear_and_info(info, DISCARD_SYNC,
-					     "turning off discard");
-			btrfs_clear_and_info(info, DISCARD_ASYNC,
-					     "turning off async discard");
-			btrfs_set_opt(info->mount_opt, NODISCARD);
-			break;
-		case Opt_space_cache:
-		case Opt_space_cache_version:
-			/*
-			 * We already set FREE_SPACE_TREE above because we have
-			 * compat_ro(FREE_SPACE_TREE) set, and we aren't going
-			 * to allow v1 to be set for extent tree v2, simply
-			 * ignore this setting if we're extent tree v2.
-			 *
-			 * For subpage blocksize we don't allow space cache v1,
-			 * and we'll turn on v2, so we can skip the settings
-			 * here as well.
-			 */
-			if (btrfs_fs_incompat(info, EXTENT_TREE_V2) ||
-			    info->sectorsize < PAGE_SIZE)
-				break;
-			if (token == Opt_space_cache ||
-			    strcmp(args[0].from, "v1") == 0) {
-				btrfs_clear_opt(info->mount_opt,
-						FREE_SPACE_TREE);
-				btrfs_set_and_info(info, SPACE_CACHE,
-					   "enabling disk space caching");
-			} else if (strcmp(args[0].from, "v2") == 0) {
-				btrfs_clear_opt(info->mount_opt,
-						SPACE_CACHE);
-				btrfs_set_and_info(info, FREE_SPACE_TREE,
-						   "enabling free space tree");
-			} else {
-				btrfs_err(info, "unrecognized space_cache value %s",
-					  args[0].from);
-				ret = -EINVAL;
-				goto out;
-			}
-			break;
-		case Opt_rescan_uuid_tree:
-			btrfs_set_opt(info->mount_opt, RESCAN_UUID_TREE);
-			break;
-		case Opt_no_space_cache:
-			/*
-			 * We cannot operate without the free space tree with
-			 * extent tree v2, ignore this option.
-			 */
-			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
-				break;
-			if (btrfs_test_opt(info, SPACE_CACHE)) {
-				btrfs_clear_and_info(info, SPACE_CACHE,
-					     "disabling disk space caching");
-			}
-			if (btrfs_test_opt(info, FREE_SPACE_TREE)) {
-				btrfs_clear_and_info(info, FREE_SPACE_TREE,
-					     "disabling free space tree");
-			}
-			break;
-		case Opt_inode_cache:
-		case Opt_noinode_cache:
-			btrfs_warn(info,
-	"the 'inode_cache' option is deprecated and has no effect since 5.11");
-			break;
-		case Opt_clear_cache:
-			/*
-			 * We cannot clear the free space tree with extent tree
-			 * v2, ignore this option.
-			 */
-			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
-				break;
-			btrfs_set_and_info(info, CLEAR_CACHE,
-					   "force clearing of disk cache");
-			break;
-		case Opt_user_subvol_rm_allowed:
-			btrfs_set_opt(info->mount_opt, USER_SUBVOL_RM_ALLOWED);
-			break;
-		case Opt_enospc_debug:
-			btrfs_set_opt(info->mount_opt, ENOSPC_DEBUG);
-			break;
-		case Opt_noenospc_debug:
-			btrfs_clear_opt(info->mount_opt, ENOSPC_DEBUG);
-			break;
-		case Opt_defrag:
-			btrfs_set_and_info(info, AUTO_DEFRAG,
-					   "enabling auto defrag");
-			break;
-		case Opt_nodefrag:
-			btrfs_clear_and_info(info, AUTO_DEFRAG,
-					     "disabling auto defrag");
-			break;
-		case Opt_recovery:
-		case Opt_usebackuproot:
-			btrfs_warn(info,
-			"'%s' is deprecated, use 'rescue=usebackuproot' instead",
-				   token == Opt_recovery ? "recovery" :
-				   "usebackuproot");
-			btrfs_info(info,
-				   "trying to use backup root at mount time");
-			btrfs_set_opt(info->mount_opt, USEBACKUPROOT);
-			break;
-		case Opt_skip_balance:
-			btrfs_set_opt(info->mount_opt, SKIP_BALANCE);
-			break;
-		case Opt_fatal_errors:
-			if (strcmp(args[0].from, "panic") == 0) {
-				btrfs_set_opt(info->mount_opt,
-					      PANIC_ON_FATAL_ERROR);
-			} else if (strcmp(args[0].from, "bug") == 0) {
-				btrfs_clear_opt(info->mount_opt,
-					      PANIC_ON_FATAL_ERROR);
-			} else {
-				btrfs_err(info, "unrecognized fatal_errors value %s",
-					  args[0].from);
-				ret = -EINVAL;
-				goto out;
-			}
-			break;
-		case Opt_commit_interval:
-			intarg = 0;
-			ret = match_int(&args[0], &intarg);
-			if (ret) {
-				btrfs_err(info, "unrecognized commit_interval value %s",
-					  args[0].from);
-				ret = -EINVAL;
-				goto out;
-			}
-			if (intarg == 0) {
-				btrfs_info(info,
-					   "using default commit interval %us",
-					   BTRFS_DEFAULT_COMMIT_INTERVAL);
-				intarg = BTRFS_DEFAULT_COMMIT_INTERVAL;
-			} else if (intarg > 300) {
-				btrfs_warn(info, "excessive commit interval %d",
-					   intarg);
-			}
-			info->commit_interval = intarg;
-			break;
-		case Opt_rescue:
-			ret = parse_rescue_options(info, args[0].from);
-			if (ret < 0) {
-				btrfs_err(info, "unrecognized rescue value %s",
-					  args[0].from);
-				goto out;
-			}
-			break;
-#ifdef CONFIG_BTRFS_DEBUG
-		case Opt_fragment_all:
-			btrfs_info(info, "fragmenting all space");
-			btrfs_set_opt(info->mount_opt, FRAGMENT_DATA);
-			btrfs_set_opt(info->mount_opt, FRAGMENT_METADATA);
-			break;
-		case Opt_fragment_metadata:
-			btrfs_info(info, "fragmenting metadata");
-			btrfs_set_opt(info->mount_opt,
-				      FRAGMENT_METADATA);
-			break;
-		case Opt_fragment_data:
-			btrfs_info(info, "fragmenting data");
-			btrfs_set_opt(info->mount_opt, FRAGMENT_DATA);
-			break;
-#endif
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
-		case Opt_ref_verify:
-			btrfs_info(info, "doing ref verification");
-			btrfs_set_opt(info->mount_opt, REF_VERIFY);
-			break;
-#endif
-		case Opt_err:
-			btrfs_err(info, "unrecognized mount option '%s'", p);
-			ret = -EINVAL;
-			goto out;
-		default:
-			break;
-		}
-	}
-out:
-	if (!ret && !btrfs_check_options(info, &info->mount_opt, new_flags))
-		ret = -EINVAL;
-	return ret;
-}
-
-/*
- * Parse mount options that are required early in the mount process.
- *
- * All other options will be parsed on much later in the mount process and
- * only when we need to allocate a new super block.
- */
-static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
-{
-	substring_t args[MAX_OPT_ARGS];
-	char *device_name, *opts, *orig, *p;
-	struct btrfs_device *device = NULL;
-	int error = 0;
-
-	lockdep_assert_held(&uuid_mutex);
-
-	if (!options)
-		return 0;
-
-	/*
-	 * strsep changes the string, duplicate it because btrfs_parse_options
-	 * gets called later
-	 */
-	opts = kstrdup(options, GFP_KERNEL);
-	if (!opts)
-		return -ENOMEM;
-	orig = opts;
-
-	while ((p = strsep(&opts, ",")) != NULL) {
-		int token;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		if (token == Opt_device) {
-			device_name = match_strdup(&args[0]);
-			if (!device_name) {
-				error = -ENOMEM;
-				goto out;
-			}
-			device = btrfs_scan_one_device(device_name, flags, false);
-			kfree(device_name);
-			if (IS_ERR(device)) {
-				error = PTR_ERR(device);
-				goto out;
-			}
-		}
-	}
-
-out:
-	kfree(orig);
-	return error;
-}
-
-/*
- * Parse mount options that are related to subvolume id
- *
- * The value is later passed to mount_subvol()
- */
-static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
-		u64 *subvol_objectid)
-{
-	substring_t args[MAX_OPT_ARGS];
-	char *opts, *orig, *p;
-	int error = 0;
-	u64 subvolid;
-
-	if (!options)
-		return 0;
-
-	/*
-	 * strsep changes the string, duplicate it because
-	 * btrfs_parse_device_options gets called later
-	 */
-	opts = kstrdup(options, GFP_KERNEL);
-	if (!opts)
-		return -ENOMEM;
-	orig = opts;
-
-	while ((p = strsep(&opts, ",")) != NULL) {
-		int token;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_subvol:
-			kfree(*subvol_name);
-			*subvol_name = match_strdup(&args[0]);
-			if (!*subvol_name) {
-				error = -ENOMEM;
-				goto out;
-			}
-			break;
-		case Opt_subvolid:
-			error = match_u64(&args[0], &subvolid);
-			if (error)
-				goto out;
-
-			/* we want the original fs_tree */
-			if (subvolid == 0)
-				subvolid = BTRFS_FS_TREE_OBJECTID;
-
-			*subvol_objectid = subvolid;
-			break;
-		default:
-			break;
-		}
-	}
-
-out:
-	kfree(orig);
-	return error;
-}
-
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid)
 {
@@ -1863,22 +1114,6 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	return 0;
 }
 
-static int btrfs_test_super(struct super_block *s, void *data)
-{
-	struct btrfs_fs_info *p = data;
-	struct btrfs_fs_info *fs_info = btrfs_sb(s);
-
-	return fs_info->fs_devices == p->fs_devices;
-}
-
-static int btrfs_set_super(struct super_block *s, void *data)
-{
-	int err = set_anon_super(s, data);
-	if (!err)
-		s->s_fs_info = data;
-	return err;
-}
-
 /*
  * subvolumes are identified by ino 256
  */
@@ -1954,200 +1189,6 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 	return root;
 }
 
-/*
- * Find a superblock for the given device / mount point.
- *
- * Note: This is based on mount_bdev from fs/super.c with a few additions
- *       for multiple device setup.  Make sure to keep it in sync.
- */
-static __maybe_unused struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
-		int flags, const char *device_name, void *data)
-{
-	struct block_device *bdev = NULL;
-	struct super_block *s;
-	struct btrfs_device *device = NULL;
-	struct btrfs_fs_devices *fs_devices = NULL;
-	struct btrfs_fs_info *fs_info = NULL;
-	void *new_sec_opts = NULL;
-	blk_mode_t mode = sb_open_mode(flags);
-	int error = 0;
-
-	if (data) {
-		error = security_sb_eat_lsm_opts(data, &new_sec_opts);
-		if (error)
-			return ERR_PTR(error);
-	}
-
-	/*
-	 * Setup a dummy root and fs_info for test/set super.  This is because
-	 * we don't actually fill this stuff out until open_ctree, but we need
-	 * then open_ctree will properly initialize the file system specific
-	 * settings later.  btrfs_init_fs_info initializes the static elements
-	 * of the fs_info (locks and such) to make cleanup easier if we find a
-	 * superblock with our given fs_devices later on at sget() time.
-	 */
-	fs_info = kvzalloc(sizeof(struct btrfs_fs_info), GFP_KERNEL);
-	if (!fs_info) {
-		error = -ENOMEM;
-		goto error_sec_opts;
-	}
-	btrfs_init_fs_info(fs_info);
-
-	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
-	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
-	if (!fs_info->super_copy || !fs_info->super_for_commit) {
-		error = -ENOMEM;
-		goto error_fs_info;
-	}
-
-	mutex_lock(&uuid_mutex);
-	error = btrfs_parse_device_options(data, mode);
-	if (error) {
-		mutex_unlock(&uuid_mutex);
-		goto error_fs_info;
-	}
-
-	/*
-	 * With 'true' passed to btrfs_scan_one_device() (mount time) we expect
-	 * either a valid device or an error.
-	 */
-	device = btrfs_scan_one_device(device_name, mode, true);
-	ASSERT(device != NULL);
-	if (IS_ERR(device)) {
-		mutex_unlock(&uuid_mutex);
-		error = PTR_ERR(device);
-		goto error_fs_info;
-	}
-
-	fs_devices = device->fs_devices;
-	fs_info->fs_devices = fs_devices;
-
-	error = btrfs_open_devices(fs_devices, mode, fs_type);
-	mutex_unlock(&uuid_mutex);
-	if (error)
-		goto error_fs_info;
-
-	if (!(flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
-		error = -EACCES;
-		goto error_close_devices;
-	}
-
-	bdev = fs_devices->latest_dev->bdev;
-	s = sget(fs_type, btrfs_test_super, btrfs_set_super, flags | SB_NOSEC,
-		 fs_info);
-	if (IS_ERR(s)) {
-		error = PTR_ERR(s);
-		goto error_close_devices;
-	}
-
-	if (s->s_root) {
-		btrfs_close_devices(fs_devices);
-		btrfs_free_fs_info(fs_info);
-		if ((flags ^ s->s_flags) & SB_RDONLY)
-			error = -EBUSY;
-	} else {
-		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
-		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
-					s->s_id);
-		btrfs_sb(s)->bdev_holder = fs_type;
-		error = btrfs_fill_super(s, fs_devices, data);
-	}
-	if (!error)
-		error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
-	security_free_mnt_opts(&new_sec_opts);
-	if (error) {
-		deactivate_locked_super(s);
-		return ERR_PTR(error);
-	}
-
-	return dget(s->s_root);
-
-error_close_devices:
-	btrfs_close_devices(fs_devices);
-error_fs_info:
-	btrfs_free_fs_info(fs_info);
-error_sec_opts:
-	security_free_mnt_opts(&new_sec_opts);
-	return ERR_PTR(error);
-}
-
-/*
- * Mount function which is called by VFS layer.
- *
- * In order to allow mounting a subvolume directly, btrfs uses mount_subtree()
- * which needs vfsmount* of device's root (/).  This means device's root has to
- * be mounted internally in any case.
- *
- * Operation flow:
- *   1. Parse subvol id related options for later use in mount_subvol().
- *
- *   2. Mount device's root (/) by calling vfs_kern_mount().
- *
- *      NOTE: vfs_kern_mount() is used by VFS to call btrfs_mount() in the
- *      first place. In order to avoid calling btrfs_mount() again, we use
- *      different file_system_type which is not registered to VFS by
- *      register_filesystem() (btrfs_root_fs_type). As a result,
- *      btrfs_mount_root() is called. The return value will be used by
- *      mount_subtree() in mount_subvol().
- *
- *   3. Call mount_subvol() to get the dentry of subvolume. Since there is
- *      "btrfs subvolume set-default", mount_subvol() is called always.
- */
-static __maybe_unused struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
-		const char *device_name, void *data)
-{
-	struct vfsmount *mnt_root;
-	struct dentry *root;
-	char *subvol_name = NULL;
-	u64 subvol_objectid = 0;
-	int error = 0;
-
-	error = btrfs_parse_subvol_options(data, &subvol_name,
-					&subvol_objectid);
-	if (error) {
-		kfree(subvol_name);
-		return ERR_PTR(error);
-	}
-
-	/* mount device's root (/) */
-	mnt_root = vfs_kern_mount(&btrfs_root_fs_type, flags, device_name, data);
-	if (PTR_ERR_OR_ZERO(mnt_root) == -EBUSY) {
-		if (flags & SB_RDONLY) {
-			mnt_root = vfs_kern_mount(&btrfs_root_fs_type,
-				flags & ~SB_RDONLY, device_name, data);
-		} else {
-			mnt_root = vfs_kern_mount(&btrfs_root_fs_type,
-				flags | SB_RDONLY, device_name, data);
-			if (IS_ERR(mnt_root)) {
-				root = ERR_CAST(mnt_root);
-				kfree(subvol_name);
-				goto out;
-			}
-
-			down_write(&mnt_root->mnt_sb->s_umount);
-			error = btrfs_remount(mnt_root->mnt_sb, &flags, NULL);
-			up_write(&mnt_root->mnt_sb->s_umount);
-			if (error < 0) {
-				root = ERR_PTR(error);
-				mntput(mnt_root);
-				kfree(subvol_name);
-				goto out;
-			}
-		}
-	}
-	if (IS_ERR(mnt_root)) {
-		root = ERR_CAST(mnt_root);
-		kfree(subvol_name);
-		goto out;
-	}
-
-	/* mount_subvol() will free subvol_name and mnt_root */
-	root = mount_subvol(subvol_name, subvol_objectid, mnt_root);
-
-out:
-	return root;
-}
-
 static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 				     u32 new_pool_size, u32 old_pool_size)
 {
@@ -2323,99 +1364,6 @@ static int btrfs_remount_ro(struct btrfs_fs_info *fs_info)
 	return btrfs_commit_super(fs_info);
 }
 
-static int btrfs_remount(struct super_block *sb, int *flags, char *data)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-	unsigned old_flags = sb->s_flags;
-	unsigned long old_opts = fs_info->mount_opt;
-	unsigned long old_compress_type = fs_info->compress_type;
-	u64 old_max_inline = fs_info->max_inline;
-	u32 old_thread_pool_size = fs_info->thread_pool_size;
-	u32 old_metadata_ratio = fs_info->metadata_ratio;
-	int ret;
-
-	sync_filesystem(sb);
-	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
-
-	if (data) {
-		void *new_sec_opts = NULL;
-
-		ret = security_sb_eat_lsm_opts(data, &new_sec_opts);
-		if (!ret)
-			ret = security_sb_remount(sb, new_sec_opts);
-		security_free_mnt_opts(&new_sec_opts);
-		if (ret)
-			goto restore;
-	}
-
-	ret = btrfs_parse_options(fs_info, data, *flags);
-	if (ret)
-		goto restore;
-
-	ret = btrfs_check_features(fs_info, !(*flags & SB_RDONLY));
-	if (ret < 0)
-		goto restore;
-
-	btrfs_remount_begin(fs_info, old_opts, *flags);
-	btrfs_resize_thread_pool(fs_info,
-		fs_info->thread_pool_size, old_thread_pool_size);
-
-	if ((bool)btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
-	    (bool)btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
-	    (!sb_rdonly(sb) || (*flags & SB_RDONLY))) {
-		btrfs_warn(fs_info,
-		"remount supports changing free space tree only from ro to rw");
-		/* Make sure free space cache options match the state on disk */
-		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
-			btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
-		}
-		if (btrfs_free_space_cache_v1_active(fs_info)) {
-			btrfs_clear_opt(fs_info->mount_opt, FREE_SPACE_TREE);
-			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
-		}
-	}
-
-	ret = 0;
-	if (!sb_rdonly(sb) && (*flags & SB_RDONLY))
-		ret = btrfs_remount_ro(fs_info);
-	else if (sb_rdonly(sb) && !(*flags & SB_RDONLY))
-		ret = btrfs_remount_rw(fs_info);
-	if (ret)
-		goto restore;
-
-	/*
-	 * We need to set SB_I_VERSION here otherwise it'll get cleared by VFS,
-	 * since the absence of the flag means it can be toggled off by remount.
-	 */
-	*flags |= SB_I_VERSION;
-
-	wake_up_process(fs_info->transaction_kthread);
-	btrfs_remount_cleanup(fs_info, old_opts);
-	btrfs_clear_oneshot_options(fs_info);
-	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
-
-	return 0;
-
-restore:
-	/* We've hit an error - don't reset SB_RDONLY */
-	if (sb_rdonly(sb))
-		old_flags |= SB_RDONLY;
-	if (!(old_flags & SB_RDONLY))
-		clear_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
-	sb->s_flags = old_flags;
-	fs_info->mount_opt = old_opts;
-	fs_info->compress_type = old_compress_type;
-	fs_info->max_inline = old_max_inline;
-	btrfs_resize_thread_pool(fs_info,
-		old_thread_pool_size, fs_info->thread_pool_size);
-	fs_info->metadata_ratio = old_metadata_ratio;
-	btrfs_remount_cleanup(fs_info, old_opts);
-	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
-
-	return ret;
-}
-
 static void btrfs_ctx_to_info(struct btrfs_fs_info *fs_info,
 			      struct btrfs_fs_context *ctx)
 {
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index 7f6577d69902..f18253ca280d 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -5,8 +5,6 @@
 
 bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
 			 unsigned long flags);
-int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
-			unsigned long new_flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
-- 
2.41.0


