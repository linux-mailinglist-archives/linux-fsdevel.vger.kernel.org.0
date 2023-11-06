Return-Path: <linux-fsdevel+bounces-2167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11407E2F76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB99E1C20752
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAE12F503;
	Mon,  6 Nov 2023 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="v/RPI4Wn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306942EAFF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:44 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779DCD57
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:39 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6cf65093780so3252996a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308519; x=1699913319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehBDfIuN7LiSpCRECNrlmwLyhaoGnDe/cfSCFvX9BgQ=;
        b=v/RPI4Wnk/tEB6JRsCewvwq3vXTbPDvjuCPPhwSABEkdX6Q+UmeAUtdIC07xWPWz1y
         r6qUnsVRXeIKy0EaCp2GxrAb0y2trKdqJd1p1N/VNzZz523BMtk0lK440y7E3rHVz6Sz
         VqSeOqcGHFCCwyxVgYjZ/kgc392JD0I3LY/DqOk+USe1oa9RAssxhJeHbs5QAe/pULoY
         OyDJouLfXMk73T5grfbJABODTHDCaZqLvRd2sGHgNm+mdYVMUZm709++bLOVd3bRHIds
         2X6WiAebuZFPOVEg56jAOwXkonH8q/oYa2ZGsATOre24+hPM1LZtvaWu5SpjkfOCCmFZ
         CoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308519; x=1699913319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehBDfIuN7LiSpCRECNrlmwLyhaoGnDe/cfSCFvX9BgQ=;
        b=RWae0raNIPdueu1hvK/2PoW7l1x6NWkXd43seRgDdWn+YI67NjRdxXttD14jqtEh2B
         DQ8mRgUOx1gMr0OoTZxGjDGfYSO2dEcDlv3kxtphh9gW5I+qxSkegM+Gj49YHRKAU7x9
         HDfTZ4x0GIRg8DzpKrYoOfTYCokfL+Fj3MlyVLQrzG+dlKGk9oOloahrQvTtaYs+4B0n
         nk4P2xZwsT+igoTYtDcFV6ZtvN1E27/Sqg2B7Hh9er7q+PC7gbri45OvHbUDKSYeJbOy
         1jAkvIwjv0Cn0onnkTsM9bJCGj5qy+JKhEzx/7FwD9QwOqVzVr7UvIQ37tkLpMeetFWh
         DirA==
X-Gm-Message-State: AOJu0YzqAcThWfPS+o3FvkPrjMyX/wQdaCGbZJKhVujNhITH7zB+5dLk
	8ATuvBlbFqGNO/xHMhI9raUTTA==
X-Google-Smtp-Source: AGHT+IEgVlaYx/dgmuA2Odvi4lyhjcsKk7FPEE0yixJN6mnEoCCGvYnaMWr/hfwhHvssqOsQvuG5FA==
X-Received: by 2002:a9d:4e91:0:b0:6cc:fff0:8eb1 with SMTP id v17-20020a9d4e91000000b006ccfff08eb1mr31502509otk.23.1699308518798;
        Mon, 06 Nov 2023 14:08:38 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w20-20020ac87194000000b0041969bc2e4csm3792331qto.32.2023.11.06.14.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:38 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 03/18] btrfs: set default compress type at btrfs_init_fs_info time
Date: Mon,  6 Nov 2023 17:08:11 -0500
Message-ID: <2945ad89590218391019572440f2ec620725ebe3.1699308010.git.josef@toxicpanda.com>
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

With the new mount API we'll be setting our compression well before we
call open_ctree.  We don't want to overwrite our settings, so set the
default in btrfs_init_fs_info instead of open_ctree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 350e1b02cc8e..27bbe0164425 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2790,6 +2790,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->sectorsize_bits = ilog2(4096);
 	fs_info->stripesize = 4096;
 
+	/* Default compress algorithm when user does -o compress */
+	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
+
 	fs_info->max_extent_size = BTRFS_MAX_EXTENT_SIZE;
 
 	spin_lock_init(&fs_info->swapfile_pins_lock);
@@ -3271,13 +3274,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
 		WRITE_ONCE(fs_info->fs_error, -EUCLEAN);
 
-	/*
-	 * In the long term, we'll store the compression type in the super
-	 * block, and it'll be used for per file compression control.
-	 */
-	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
-
-
 	/* Set up fs_info before parsing mount options */
 	nodesize = btrfs_super_nodesize(disk_super);
 	sectorsize = btrfs_super_sectorsize(disk_super);
-- 
2.41.0


