Return-Path: <linux-fsdevel+bounces-2417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370D7E5E3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D18B21155
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5CF374C7;
	Wed,  8 Nov 2023 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="z0/7VsqD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A243715C
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:09:20 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E95E210A
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 11:09:20 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7789cb322deso413285a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 11:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470559; x=1700075359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6zdQIel5R7Qiyn/LF1Av1t5wi6OCpF6lh425HLYYx4=;
        b=z0/7VsqDPZ4LCLT6ruzh6d6oM8vPdoANJ/Tsw3bYf1+oXB5PeOsFWsdn9qqC/0AhiC
         uCfY8z5TjmzaML77e5AjMpCssC0Tlg098k39N0O6Lliz12VkbSX4f7wFD7cKEPSoIkZl
         usceA1rkb5K77uNxsFktz+bT+trWK38y919nUFy19CNDnr4v10k/DP1fLHyWxHJJrZeo
         AiVHW6LZJQOqJF+J8vugHC+yACejCUIyef61GC2/qPq2hTNTGkljjDukikgoRRg067lH
         S4gLMuNxHQRU4jPIpImOQS8GFghyxKkFMdNVmElW3KKoxGPLyziauUOskQy1SizpmECd
         zifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470559; x=1700075359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6zdQIel5R7Qiyn/LF1Av1t5wi6OCpF6lh425HLYYx4=;
        b=YGc5hKmEPiq4YR8MjEKJktjvtyTBP7Mu7R8C6f5imhQIzdw+0/rvU0ach4Q0sMpbUt
         dk4lNEI8quB31pGAYIrYDvWplu/y8VCA/Ar8NzUZH744DwdbLCxnDiNXNhdZg5Geaj+8
         1ck37tKYIGSZimk1AyttwdkSPMe3iA+KivD/w8PxyGFADSGlZXjqKlwNicna9Zguficd
         MN9hkmXMq8djTFpv9vlLfo5lYkiJ8IE4AwRG4d50f6irOsxp4iTBcJXuc0vIYtS7ULfT
         yljQaAsAafJ3RKdDIPCqPDrYNcAl+j95hCdEdMSrIDlOXh1EKagkpi7iK+Ck5BpjodWM
         Uf2Q==
X-Gm-Message-State: AOJu0YxR7A2oibqpAibEPsglx2C4wij/Sa1H5eDxFf/hRsjl9uULXQAL
	+tYSbFZu9R1R3Qqw7GBSx2qmAQ==
X-Google-Smtp-Source: AGHT+IH0HF+YFFjzr7aPQoFQjdrKZYje720kOc+ldqKZljKweZuP0mOWDLzo/A1KK8U3JXCmfvj5ew==
X-Received: by 2002:a05:620a:4250:b0:778:99d8:6adb with SMTP id w16-20020a05620a425000b0077899d86adbmr2598380qko.44.1699470559347;
        Wed, 08 Nov 2023 11:09:19 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r30-20020a05620a03de00b007759a81d88esm1332003qkm.50.2023.11.08.11.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:18 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 04/18] btrfs: move space cache settings into open_ctree
Date: Wed,  8 Nov 2023 14:08:39 -0500
Message-ID: <c1f4384e79a163e4aef516472a8d6574dc54545d.1699470345.git.josef@toxicpanda.com>
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

Currently we pre-load the space cache settings in btrfs_parse_options,
however when we switch to the new mount API the mount option parsing
will happen before we have the super block loaded.  Add a helper to set
the appropriate options based on the fs settings, this will allow us to
have consistent free space cache settings.

This also folds in the space cache related decisions we make for subpage
sectorsize support, so all of this is done in one place.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 17 ++++++-----------
 fs/btrfs/super.c   | 44 +++++++++++++++++++++++++++++++-------------
 fs/btrfs/super.h   |  1 +
 3 files changed, 38 insertions(+), 24 deletions(-)

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


