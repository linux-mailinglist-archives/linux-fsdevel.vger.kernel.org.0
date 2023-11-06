Return-Path: <linux-fsdevel+bounces-2168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6F17E2F77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEC21C20821
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECD32F50D;
	Mon,  6 Nov 2023 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="hW7JSU2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C62EB00
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:45 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C10E1BC
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:41 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ce2cc39d12so3147786a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308521; x=1699913321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6T94WyWk3Zy26jisioKXt/NF7e6EzHgDufMAJz5NuM=;
        b=hW7JSU2XPVE4h7T/hFb2gkLHehvl63D14CVeDZO4QdfPvaLUGh2U1DE8RnD2NC9Arz
         fNuMA45/uOZkklxeocim24ngD7RsxIQYaSFGLmnLI3Zvx6qlzn2Kn0DjVNOt6+tc8q05
         i2SrbkLYA+JGq/bFMXCr3gE+AOp4TizT7K0zMA3qBV0i5JgKTaOE49gvlVk/puVVrRo+
         MEP08tZaAb5fC1q4gOUCQtZ5tr4BH0e9knsDf/UlVeQxC69xkBieT8pVDq9VfDzcgpkk
         SW9OT5Izesk4Kb2kxHtIehkOFWHOL1eKg+ipAdHgOv+GqiOFpYZ5MxRW5Mqr1cDQgT8y
         YBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308521; x=1699913321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6T94WyWk3Zy26jisioKXt/NF7e6EzHgDufMAJz5NuM=;
        b=dMB4LntqM3wbA4KCFIc3GYTN5vCUCPZkWDtVbfzqvQChtabTLKbbJRBTSu9c5MnJ3C
         fPqU8d6VKjjZztkzQx7irQDDY4P7j2sSJ57QQTuQVW6LV8kLoYOHZ00l0IuRSqnGYZb4
         DNtHSuXR/ZIrk2g9WLN/ryClriHAlLU9o6ud03d3araLRxkYNgHnZUWUJmifKzsYe/ef
         Y8aJpmM94x4XNd+K0Ohzwn9cZoxyDZrv8MIpsv6gTInvT6TqiMX8GkFYrds88IQRYbHB
         kFFwoWgiChO6Ai1aejbpQJfmSHOnR008UYixSEox4vtwohlwDytvgcUIN1OxrH9XJTjr
         ZNfw==
X-Gm-Message-State: AOJu0YyyJBxaY58mvgsuhVMJ3p16J3WzNDvbq2UahoI4pM0n9lRXxyL8
	A3tpCc0REiUzR323rTOXVGfhPQ==
X-Google-Smtp-Source: AGHT+IFf5q3nHxRPUyYMj7n7bYDMtzLSSCOnnSKvWN4mZIj4cNKJ6+P4Po20QjIkN/mV2dU1uu3A/Q==
X-Received: by 2002:a05:6830:438a:b0:6d3:165d:f19c with SMTP id s10-20020a056830438a00b006d3165df19cmr24314205otv.11.1699308520924;
        Mon, 06 Nov 2023 14:08:40 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d18-20020a05622a15d200b0041e211c5d0bsm3772506qty.6.2023.11.06.14.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:40 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 05/18] btrfs: do not allow free space tree rebuild on extent tree v2
Date: Mon,  6 Nov 2023 17:08:13 -0500
Message-ID: <2d268c17698104d5ae0b1d355a10ff20223b2bff.1699308010.git.josef@toxicpanda.com>
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

We currently don't allow these options to be set if we're extent tree v2
via the mount option parsing.  However when we switch to the new mount
API we'll no longer have the super block loaded, so won't be able to
make this distinction at mount option parsing time.  Address this by
checking for extent tree v2 at the point where we make the decision to
rebuild the free space tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b486cbec492b..072c45811c41 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2951,7 +2951,8 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 	bool rebuild_free_space_tree = false;
 
 	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
-	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
 		rebuild_free_space_tree = true;
 	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
 		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
-- 
2.41.0


