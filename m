Return-Path: <linux-fsdevel+bounces-2431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1757E5E59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24636281B7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720D43715E;
	Wed,  8 Nov 2023 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QNUxvfIp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7A39854
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:09:39 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D787210E
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 11:09:39 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77bac408851so96767385a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 11:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470578; x=1700075378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFhP1hKebiWECw4Ujtbs0/IzrYrCaUbc1GWQbdpeKs4=;
        b=QNUxvfIpp3An1r4/kmPhC74a0D0DsvxiOJuU1OTBCqv6fYow4NsQ9SgNap49MKc9JD
         jD1n8Lq/u+nqCrWTsXmqkTjWIDwElxq4D5TFDcP3rbK3+9y8Qr+MpE490KkxnPs7uGYo
         D2CDNLgZXV9JEW55HmtCoHZoT3Yww2eD1qyuZXJRUJbEnIZpgBBYbN22VJ+AVaujrmMy
         osSGO4vtTxIXfESV8dJF96mSuJUSTTYPhoHKkOIGMqgonnVjA1s7T4x69XeW8HEbV8/y
         Rs3IOjeyAxYjCvmVGYWFF6wXl1WChtW2QEwUiPqGhCUOmgs+YsyfKE3NCopDiAsznsc6
         lA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470578; x=1700075378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFhP1hKebiWECw4Ujtbs0/IzrYrCaUbc1GWQbdpeKs4=;
        b=KxnNOlSUQ+3QwGikBVKpzmjmHhYmZz6leeachKqYrfGew9Wy+yAV4RFUCZAdGCLdU/
         zEwKsvCqnlv64Qcdaw58E3i0xL3TYx+vm1bg1HWTPNDRXqP8z1Z2neBkk4tzKofN+ZIB
         +VWz2bBtIT9uoXReP4FiBiTWDhvjiv16ktswbJuz38jxtF7mel1pfXxGOKDjQYlSfgHE
         V0oOubpcuhskNGdvIcHMntlNBv4SXHHyWIRBdk1bkGmIH3jH6UCfoPOQ9R2QCeUHpekw
         9e7QHN+iQwXQyLr88tJpTmpn2BE2OpV8G47KTayn5wm50rstWkzOWb6BNGcWyens26DI
         ji9w==
X-Gm-Message-State: AOJu0YypHEstXtKlcoN0LhIqchdSOgHgmdsoHXowz55+X7lZm+S5Odio
	Vu9c7t+iCzYFcVzcIT/gLAXDmw==
X-Google-Smtp-Source: AGHT+IEFwUHcaGjFViWcQkhRCLF8vG3B0wRrzZMz98Qss2ZILOC/Kdc/KYLrVeXPXpC9LSanSDYkPQ==
X-Received: by 2002:a05:620a:4114:b0:779:d1a6:ee5c with SMTP id j20-20020a05620a411400b00779d1a6ee5cmr8340132qko.32.1699470578440;
        Wed, 08 Nov 2023 11:09:38 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ou32-20020a05620a622000b0076c96e571f3sm1353185qkn.26.2023.11.08.11.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:38 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 18/18] btrfs: set clear_cache if we use usebackuproot
Date: Wed,  8 Nov 2023 14:08:53 -0500
Message-ID: <f6f4ebd670ac2d70a45da4d688d9eaa5ce8853b1.1699470345.git.josef@toxicpanda.com>
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

We're currently setting this when we try to load the roots and we see
that usebackuproot is set.  Instead set this at mount option parsing
time.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c |  3 ---
 fs/btrfs/super.c   | 12 ++++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8f04d2d5f530..77f13543fa0e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2614,9 +2614,6 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 			 */
 			btrfs_set_super_log_root(sb, 0);
 
-			/* We can't trust the free space cache either */
-			btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
-
 			btrfs_warn(fs_info, "try to load backup roots slot %d", i);
 			ret = read_backup_root(fs_info, i);
 			backup_index = ret;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f45de65c3c0b..fe5badc9f6a7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -459,6 +459,12 @@ static int btrfs_parse_param(struct fs_context *fc,
 			btrfs_warn(NULL,
 				   "'recovery' is deprecated, use 'rescue=usebackuproot' instead");
 			btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
+
+			/*
+			 * If we're loading the backup roots we can't trust the
+			 * space cache.
+			 */
+			btrfs_set_opt(ctx->mount_opt, CLEAR_CACHE);
 		}
 		break;
 	case Opt_nologreplay:
@@ -557,6 +563,12 @@ static int btrfs_parse_param(struct fs_context *fc,
 		btrfs_warn(NULL,
 			   "'usebackuproot' is deprecated, use 'rescue=usebackuproot' instead");
 		btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
+
+		/*
+		 * If we're loading the backup roots we can't trust the space
+		 * cache.
+		 */
+		btrfs_set_opt(ctx->mount_opt, CLEAR_CACHE);
 		break;
 	case Opt_skip_balance:
 		btrfs_set_opt(ctx->mount_opt, SKIP_BALANCE);
-- 
2.41.0


