Return-Path: <linux-fsdevel+bounces-2170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE327E2F78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD561C208C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8682F2EB05;
	Mon,  6 Nov 2023 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="krXZnqio"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2F2EB1B
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:45 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9570FD6E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:40 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b52360cdf0so2348385b6e.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308520; x=1699913320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UexHohZT1zGNjOL7yf4hKV+PGAsUG8V/5z9hjR15Oqk=;
        b=krXZnqioVUXUBH/oA9IzT839MnVk148JbEdrCLGFgtFU5G2jBYuVkmQnWWFxaqrBOG
         7N+5RlT6cre9a4c6c4vOHHX0i/JYsHbcMMPWYG69EyYNlgD6+Qns30hs5PDbUzdyDLsF
         2RwrHSgVCcZAabAbvjxBRHbidW1t66eJaxIS2IiyNngTyqAfRJeq5avAGwcs3t0xvsCI
         rYMigHfG4qVrWt5cpIMAlpjakq/3ICd4wQCCD5PWvqWfU1T8lu05tawhoOsc/hdaPo/z
         hZ1wsVfBhE7M1MOaHfl1wVetrS2yb4AXzoUGHTPJB7WyGdHRMdz8UWesFSVxAe9CW766
         OAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308520; x=1699913320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UexHohZT1zGNjOL7yf4hKV+PGAsUG8V/5z9hjR15Oqk=;
        b=Smer+MGEo/sl5yHg9gBopk6qHi+hmRj7Zgptc3YH7P/9241MCDI4fkrQcGJGvZFuVI
         kT2GllwcxRqFNQ3goyzPNph1aRSR0dX9VrZ1n7eEEPbGunLKfQlDwfDbELB/Erw8gIa/
         qi8VUCpoe5ZmHtDD4BKIbTztgOHZUn3N8AsWJx1Wlusxt/zLtQqj8+/f52oNpDOy7es2
         7kll6gIoOFAzHBfMqlAn+xf+Jet4uS/isPq5ox2zQQJnfJMwmpDjkVTFbtoh78F9D+jS
         6em31JqbIs86kGUD+VoD1q81VErPZXOjgCce5jALnBT0WLj7WIyiWOqgBKfYQhEoLpcM
         e6wg==
X-Gm-Message-State: AOJu0YyYcAbvgorenmoGhP/4bwKcVI7bGLtRRcM1cpQhT4+pi81Jr4tc
	fJZwyU+FMbQO568vNLHZqLmVmQ==
X-Google-Smtp-Source: AGHT+IEsSkQwqGH/Z2C3WgO1lyNjDiET3eonjemQF3MKYBkI/sWtxgXvCPTVXcEr/xCJAp9Cp+tyDw==
X-Received: by 2002:a54:4592:0:b0:3af:26e3:92e with SMTP id z18-20020a544592000000b003af26e3092emr25756972oib.28.1699308519919;
        Mon, 06 Nov 2023 14:08:39 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u3-20020a0cb403000000b0064f43efc844sm3904755qve.32.2023.11.06.14.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:39 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 04/18] btrfs: move space cache settings into open_ctree
Date: Mon,  6 Nov 2023 17:08:12 -0500
Message-ID: <93c7e11e73d40b30cd086b0b32ad8b7a86060442.1699308010.git.josef@toxicpanda.com>
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

Currently we pre-load the space cache settings in btrfs_parse_options,
however when we switch to the new mount API the mount option parsing
will happen before we have the super block loaded.  Add a helper to set
the appropriate options based on the fs settings, this will allow us to
have consistent free space cache settings.

This also folds in the space cache related decisions we make for subpage
sectorsize support, so all of this is done in one place.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c          | 17 +++++---------
 fs/btrfs/free-space-cache.h |  1 +
 fs/btrfs/super.c            | 44 ++++++++++++++++++++++++++-----------
 fs/btrfs/super.h            |  1 +
 4 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 27bbe0164425..b486cbec492b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3287,6 +3287,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 
+	/*
+	 * Handle the space caching options appropriately now that we have the
+	 * super loaded and validated.
+	 */
+	btrfs_set_free_space_cache_settings(fs_info);
+
 	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
 	if (ret)
 		goto fail_alloc;
@@ -3298,17 +3304,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (sectorsize < PAGE_SIZE) {
 		struct btrfs_subpage_info *subpage_info;
 
-		/*
-		 * V1 space cache has some hardcoded PAGE_SIZE usage, and is
-		 * going to be deprecated.
-		 *
-		 * Force to use v2 cache for subpage case.
-		 */
-		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
-		btrfs_set_and_info(fs_info, FREE_SPACE_TREE,
-			"forcing free space tree for sector size %u with page size %lu",
-			sectorsize, PAGE_SIZE);
-
 		btrfs_warn(fs_info,
 		"read-write for sector size %u with page size %lu is experimental",
 			   sectorsize, PAGE_SIZE);
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 33b4da3271b1..dd0ed730fa7b 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -152,6 +152,7 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 
 bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info);
 int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool active);
+
 /* Support functions for running our sanity tests */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 int test_add_free_space_entry(struct btrfs_block_group *cache,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 639601d346d0..aef7e67538a3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -266,6 +266,31 @@ static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
 	return true;
 }
 
+void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
+{
+	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
+		btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+	else if (btrfs_free_space_cache_v1_active(fs_info)) {
+		if (btrfs_is_zoned(fs_info)) {
+			btrfs_info(fs_info,
+			"zoned: clearing existing space cache");
+			btrfs_set_super_cache_generation(fs_info->super_copy, 0);
+		} else {
+			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+	}
+
+	if (fs_info->sectorsize < PAGE_SIZE) {
+		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
+		if (!btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
+			btrfs_info(fs_info,
+				   "forcing free space tree for sector size %u with page size %lu",
+				   fs_info->sectorsize, PAGE_SIZE);
+			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+		}
+	}
+}
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -345,18 +370,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	bool saved_compress_force;
 	int no_compress = 0;
 
-	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
-		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
-	else if (btrfs_free_space_cache_v1_active(info)) {
-		if (btrfs_is_zoned(info)) {
-			btrfs_info(info,
-			"zoned: clearing existing space cache");
-			btrfs_set_super_cache_generation(info->super_copy, 0);
-		} else {
-			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
-		}
-	}
-
 	/*
 	 * Even the options are empty, we still need to do extra check
 	 * against new flags
@@ -649,8 +662,13 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			 * compat_ro(FREE_SPACE_TREE) set, and we aren't going
 			 * to allow v1 to be set for extent tree v2, simply
 			 * ignore this setting if we're extent tree v2.
+			 *
+			 * For subpage blocksize we don't allow space cache v1,
+			 * and we'll turn on v2, so we can skip the settings
+			 * here as well.
 			 */
-			if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
+			if (btrfs_fs_incompat(info, EXTENT_TREE_V2) ||
+			    info->sectorsize < PAGE_SIZE)
 				break;
 			if (token == Opt_space_cache ||
 			    strcmp(args[0].from, "v1") == 0) {
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index 8dbb909b364f..7c1cd7527e76 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -8,6 +8,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
+void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info);
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
 {
-- 
2.41.0


