Return-Path: <linux-fsdevel+bounces-2415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8897E5E36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F10B20DF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFC63715A;
	Wed,  8 Nov 2023 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uRyDClvv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54B36B1E
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:09:18 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A03210A
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 11:09:17 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66cfd874520so406786d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 11:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470557; x=1700075357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wju2KDo89W0KqnbnN0qwqJupbKYYoKpOCJuF9HTEAq4=;
        b=uRyDClvvXhHd3k7M/RgCwZz65rhYU4WYWaoinyTl+3EgPHDgq5LmGZ0hALxCsK1Cmt
         w4mDpsEouceT7079kc/vcOdsrZoEW4kSw20jdl3QxZdjjY8WMr3tP2V8vLqMrkHaP6AS
         9nUkck5pjQomLzf4QT6QqU31IFbuG0pggbd0NqTevookLm55nokHt1v2sfxDIkMLchBf
         M1SusJbJwiNIz7gKPTgkDDs21gfMZ3nQWjUVQL+PREZjbH8xoJBPW1+p2vkHBY1mRYc3
         EqwDm2sDnOgCDuNPwgLUsK2cbxZi/VDUCeenIG23oJwDrgUXL6LnKAXxwlx27OZCXM6S
         EzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470557; x=1700075357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wju2KDo89W0KqnbnN0qwqJupbKYYoKpOCJuF9HTEAq4=;
        b=FVsAIbNEp/8IeYlpl0efVaHyaWdIT5lNdacc1z82MQah4kr+sWPSfJ5R/waU8WQI3+
         ItH19I+jgefxINKcrsu5ssj4/aFi/01oQyxS/vGrV2NAucHBVq41w8aHHJK7dV4zlVs2
         HfWWC9bP6Tg7dxEL8ZmTJ6lWIlIIXqQyVI1zRhS0McYZ8XT559cBtY0K0+fYlojNYYBS
         Wzd3ALu2UJbhqZymT4Zaru29oDhEfq12/YpbZ0bFscUoM1kcNv6nRmi4AtVTIhMbXKNV
         7dphPC40qTT2yHxWoaFO0CkcraoyZnbpnnu9pHUs09QPs8SLHrS/ZlSFO4+Vm9rNrGsQ
         Zy9Q==
X-Gm-Message-State: AOJu0YwzNozNIfAbBQkfQah9GUzzCiSbrQ6wxi28kRLepD1F39ozyOe3
	dMRI3bpv2WsAWIC6QF+BmI67wg==
X-Google-Smtp-Source: AGHT+IHt4Oah385KFQK1VKUiP11Y0nIjrdVQdzbBfpnhvKSUfnu4hGAFWaasI8rWrjaOuYukVVTA3A==
X-Received: by 2002:a05:6214:5183:b0:66d:17a2:34cc with SMTP id kl3-20020a056214518300b0066d17a234ccmr2598056qvb.64.1699470556747;
        Wed, 08 Nov 2023 11:09:16 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id dy7-20020a05620a60c700b00770f2a690a8sm1337020qkb.53.2023.11.08.11.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:16 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 02/18] btrfs: split out the mount option validation code into its own helper
Date: Wed,  8 Nov 2023 14:08:37 -0500
Message-ID: <f30ace3052a298c6536453fed66577c308c72d2f.1699470345.git.josef@toxicpanda.com>
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

We're going to need to validate mount options after they're all parsed
with the new mount api, split this code out into its own helper so we
can use it when we swap over to the new mount api.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 64 ++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6ecf78d09694..639601d346d0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -233,6 +233,39 @@ static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
 	return false;
 }
 
+static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
+{
+	if (!(flags & SB_RDONLY) &&
+	    (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
+	     check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
+	     check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
+		return false;
+
+	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
+	    !btrfs_test_opt(info, CLEAR_CACHE)) {
+		btrfs_err(info, "cannot disable free space tree");
+		return false;
+	}
+	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
+	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
+		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
+		return false;
+	}
+
+	if (btrfs_check_mountopts_zoned(info))
+		return false;
+
+	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
+		if (btrfs_test_opt(info, SPACE_CACHE))
+			btrfs_info(info, "disk space caching is enabled");
+		if (btrfs_test_opt(info, FREE_SPACE_TREE))
+			btrfs_info(info, "using free space tree");
+	}
+
+	return true;
+}
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -311,7 +344,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	int saved_compress_level;
 	bool saved_compress_force;
 	int no_compress = 0;
-	const bool remounting = test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state);
 
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
@@ -330,7 +362,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	 * against new flags
 	 */
 	if (!options)
-		goto check;
+		goto out;
 
 	while ((p = strsep(&options, ",")) != NULL) {
 		int token;
@@ -774,35 +806,9 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			break;
 		}
 	}
-check:
-	/* We're read-only, don't have to check. */
-	if (new_flags & SB_RDONLY)
-		goto out;
-
-	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
-	    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
-	    check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums"))
-		ret = -EINVAL;
 out:
-	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
-	    !btrfs_test_opt(info, CLEAR_CACHE)) {
-		btrfs_err(info, "cannot disable free space tree");
+	if (!ret && !check_options(info, new_flags))
 		ret = -EINVAL;
-	}
-	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
-	     !btrfs_test_opt(info, FREE_SPACE_TREE)) {
-		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
-		ret = -EINVAL;
-	}
-	if (!ret)
-		ret = btrfs_check_mountopts_zoned(info);
-	if (!ret && !remounting) {
-		if (btrfs_test_opt(info, SPACE_CACHE))
-			btrfs_info(info, "disk space caching is enabled");
-		if (btrfs_test_opt(info, FREE_SPACE_TREE))
-			btrfs_info(info, "using free space tree");
-	}
 	return ret;
 }
 
-- 
2.41.0


