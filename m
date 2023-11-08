Return-Path: <linux-fsdevel+bounces-2418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF53F7E5E3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5981C20B94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B33374CE;
	Wed,  8 Nov 2023 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ETLBxNUH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07D37172
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:09:22 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7212110
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 11:09:21 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d0ea3e5b8so564756d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 11:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470561; x=1700075361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6T94WyWk3Zy26jisioKXt/NF7e6EzHgDufMAJz5NuM=;
        b=ETLBxNUHdVTmexOZP6TTpXB3ZCh7IFDBcExOLRAS6UIfHW9OA5FMwMlRuB8ObowxoD
         keB4CtEn//glyy9HniLPhWe8wj6z2KPRJHqh0FpnCEpzgE340WLWVfZu9vIFfEXKWVY8
         X75DV/lEplJ/IoK7S61lwmAHzHHk/YkHoRsI36meXzdrcxCu0S5kIo5NhRpCWtcQWCJI
         Isud+vDq5ituDQVMPRfcfuFNSelH5rV0AayA9De7IBRbXXf3l+z8QVn/Eo/iPc0JHEMd
         pTd6qTHWGhIRqDDtEbhZv7w7+se3ib9TBy+zVP3aSoa0yPuwqXTlWQZKhM1A/UnxCvao
         jZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470561; x=1700075361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6T94WyWk3Zy26jisioKXt/NF7e6EzHgDufMAJz5NuM=;
        b=wj31mjp0IfPftdWW/0vTcgiv5T77Y2scSBk6y59IceZDZ9PdDYnph+GJJ+HiMdvzfc
         UEGsdCGye0W/TT4z3KdffxHgNqqPv1xrpm77VWfb5Ou14y8WbIhe2igd0KOhJUXT5NTY
         8QnResd2sTP58quOegCxT2lHhBSX2BBdxukmzfdlahJcdlcqzhbYXxV+wCqnX8ijyOTW
         BvIQcu6GgCc5OeDAqQQRNAK3+5JKkxjCdGplZvH6Kzyo5zqvMPjRHg+OGUqcdB3AZpc/
         J9Lo45fEiGEt5KiQFCglAZII+wX4TFLsDydl/no/3XUWXkzVlifPpyVrhqoeFxwTbdwP
         QmLg==
X-Gm-Message-State: AOJu0YzZbXraAe8gQXnKgkN6f5RRxyvOkBRGVLf4Db/Qk8rgvFFmDImI
	53s7Z2zs/a5Pwk2rhqOjKEkcvYuwbcqfCcfUkuNczw==
X-Google-Smtp-Source: AGHT+IFQ5Al4R1ynU8qh+dArzZQGamLsItVMZzJYNvSe6+34TtUAm4YOYLMybaxb5tZt+MgR+gHe5g==
X-Received: by 2002:a05:6214:d4c:b0:65b:2660:f58b with SMTP id 12-20020a0562140d4c00b0065b2660f58bmr3386025qvr.12.1699470560842;
        Wed, 08 Nov 2023 11:09:20 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l8-20020a056214104800b0065d89f4d537sm1367939qvr.45.2023.11.08.11.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:20 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 05/18] btrfs: do not allow free space tree rebuild on extent tree v2
Date: Wed,  8 Nov 2023 14:08:40 -0500
Message-ID: <6a2c827b0ed8b24c3be1045ccac49b29e850118e.1699470345.git.josef@toxicpanda.com>
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


