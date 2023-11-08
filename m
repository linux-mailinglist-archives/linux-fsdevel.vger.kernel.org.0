Return-Path: <linux-fsdevel+bounces-2428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1627E5E52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB011281781
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E243039841;
	Wed,  8 Nov 2023 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bT/wBbzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC9738F8A
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:09:35 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0875210E
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 11:09:34 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b565722c0eso19142b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 11:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470574; x=1700075374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WGcH+vh3MxMHVr4lGo2U8HngouNdzqsfhTQcZZzMkA=;
        b=bT/wBbzY227Xy+zbPa1ePt6whpv9H+SfuaL4yAJ+w5maUcZRXswmDL5+l1+MHedXJv
         /OWRtoht6jWpRjjd0cD69Jzg8AJo2C0Ayp+D/ciY2zCbD3wel4GzHHKHFmcJqUe6mU3R
         Q8xuffrXiWx9EDEtxaiLEAtPduuWK1uOXDg1E9yLAAeWXRfD6T3XonmAr7PlnHzUcaKV
         cdalMdF4ZFEuvWsuAhX4U9grsItG4kKLpThDbt9xCQaNm32dKoxdX78Wz6iRpz6b9LEc
         jfWkCmWvJTbfT9jneZSJoETwO8ISCk19cKcyrQUI30SgNi7BOScxRsmgnXOEygjtDzr3
         Qo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470574; x=1700075374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WGcH+vh3MxMHVr4lGo2U8HngouNdzqsfhTQcZZzMkA=;
        b=kvZ8Ht8VqT/LpkwPvioQW0pC5u8sjrlNfez3mppymzZfFqmMeMqf5FvnXDKrd0jyCe
         HzCxY9Ug4sc//O0FlGRMWlJFGIKo42/6yHLUjmLZKytBQpmrGK9PoCgFDuiaNzGASB/W
         plgqspXbf4Y9eW7v3FonJe3gEYbViU5SO2yZiRU+sN1OGtafiT9WZGlTtKnRAMXG8OmP
         kVQpTbR1ZelyiILQWIhaBfTsmyeBLXGmu6d43LIsiToFfEowoRNPw3hIvl1+wTiDifuZ
         XEeo/tfLEHmIO20YUgFMj3jPg0yOCRMdq8UM0Qvo7lNyneEooyTy7innC7+zrEknfWuq
         XYyA==
X-Gm-Message-State: AOJu0YwCg8i11MkSN81qZWDAed3tqxrXZeu++lY0YxDQXngdZmZqBJnY
	kQAE+qm+htDkpK0vF+Xvs4kEeA==
X-Google-Smtp-Source: AGHT+IESR9XGLOO688poD/IlDJXg9p38Nwmif5DC9D65IHPpKvY1ciDYmjiw/3KU6uvUh/dp0GjDvA==
X-Received: by 2002:a05:6808:2341:b0:3b2:db61:ff8e with SMTP id ef1-20020a056808234100b003b2db61ff8emr3136993oib.33.1699470573899;
        Wed, 08 Nov 2023 11:09:33 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m8-20020a05620a220800b00775afce4235sm1327729qkh.131.2023.11.08.11.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 15/18] btrfs: move the device specific mount options to super.c
Date: Wed,  8 Nov 2023 14:08:50 -0500
Message-ID: <be68ae40b612c046bd7ba843d7424411f02d788b.1699470345.git.josef@toxicpanda.com>
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

We add these mount options based on the fs_devices settings, which can
be set once we've opened the fs_devices.  Move these into their own
helper and call it from get_tree_super.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 23 -----------------------
 fs/btrfs/super.c   | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ce861f4baf47..50ed7ece0840 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3483,29 +3483,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_cleaner;
 	}
 
-	if (!btrfs_test_opt(fs_info, NOSSD) &&
-	    !fs_info->fs_devices->rotating) {
-		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
-	}
-
-	/*
-	 * For devices supporting discard turn on discard=async automatically,
-	 * unless it's already set or disabled. This could be turned off by
-	 * nodiscard for the same mount.
-	 *
-	 * The zoned mode piggy backs on the discard functionality for
-	 * resetting a zone. There is no reason to delay the zone reset as it is
-	 * fast enough. So, do not enable async discard for zoned mode.
-	 */
-	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
-	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
-	      btrfs_test_opt(fs_info, NODISCARD)) &&
-	    fs_info->fs_devices->discardable &&
-	    !btrfs_is_zoned(fs_info)) {
-		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
-				   "auto enabling async discard");
-	}
-
 	ret = btrfs_read_qgroup_config(fs_info);
 	if (ret)
 		goto fail_trans_kthread;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4ce07d255497..c6c2bd407f90 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -823,6 +823,29 @@ void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 		btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
 }
 
+static void set_device_specific_options(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_test_opt(fs_info, NOSSD) &&
+	    !fs_info->fs_devices->rotating)
+		btrfs_set_opt(fs_info->mount_opt, SSD);
+
+	/*
+	 * For devices supporting discard turn on discard=async automatically,
+	 * unless it's already set or disabled. This could be turned off by
+	 * nodiscard for the same mount.
+	 *
+	 * The zoned mode piggy backs on the discard functionality for
+	 * resetting a zone. There is no reason to delay the zone reset as it is
+	 * fast enough. So, do not enable async discard for zoned mode.
+	 */
+	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
+	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
+	      btrfs_test_opt(fs_info, NODISCARD)) &&
+	    fs_info->fs_devices->discardable &&
+	    !btrfs_is_zoned(fs_info))
+		btrfs_set_opt(fs_info->mount_opt, DISCARD_ASYNC);
+}
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -2913,6 +2936,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		goto error;
 	}
 
+	set_device_specific_options(fs_info);
+
 	if (s->s_root) {
 		btrfs_close_devices(fs_devices);
 		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY)
-- 
2.41.0


