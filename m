Return-Path: <linux-fsdevel+bounces-2181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB227E2F94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C7E8B2112C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1DA30CED;
	Mon,  6 Nov 2023 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FX48Q+4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B99430CEF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:09:00 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F731D6E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:56 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7d9d357faso58211607b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308535; x=1699913335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXa7qR/dnYgVT16zl6Y+77lu5bJKpb7Bxori4DISc1s=;
        b=FX48Q+4/lGMAZNB77RVKon8McTyhTLKIqvXr0Zh5MTsf0edwrtGgWYbDLXp1Kwz+9k
         PGESS67j4V6FKabd85k4robqHMqmW1q/ej93eRutTmeizwqAhCRxE8NbESYIR2q4RZU7
         gmQmGOKh8XN+0EMaLwUqaMFVmP1NfDaEdfYSxfupJHlKAOufkkcT0YwO8zJsMrY9TYij
         Ci/ieEA90eLSzCIwFBaTDg3J7Qq9Gj5s/atsb1Dxldku/FnCHR97G6vweuUinKm7zTp4
         dVRWGwMO4vwibyNP8FBK69dwe7YdPLxgDLLXlNVE2w4aAPS6Wy8Q13GU9ToY+XkWXZvT
         z8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308535; x=1699913335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXa7qR/dnYgVT16zl6Y+77lu5bJKpb7Bxori4DISc1s=;
        b=tR4gWpc0EUGVw4XAj3XT/g2J627Pog0gcVKhclFn7iPE2Q1hKQ91LciD3fjRBY//qv
         WvdwEVZ4vDGiWG+8vmtUDxyZaRZmA2U/qEJoLf535zcbGH8RQ0J9u09MpJjmdtXrqcYQ
         aHmaNDswjBrpqUTolrzzQq72zGwpVp8GRYYtszmNCr/uJ7SMMwno8yYFY+DxHbhyXOBR
         kQNU5TtVzTcWfJTzy/EeF/cAB0N+Ho8AN6mO+YbyqzJItrginlI6ka+O4Hgw8xzgZZyU
         ceKb8eNXH44G1KKkENfH06PSWto+rI17nOYsTMRLQDrZu5tA0VwV0ZkX3BLM+y7jx+dt
         uLlA==
X-Gm-Message-State: AOJu0Yw6ClizcPIPmIyMiySXw8YG4QLbe7rPRhylyLYYCs3UzSEUsmfS
	cGp4P1ElaciGrTvcfgeOESXW3w==
X-Google-Smtp-Source: AGHT+IFtI8R7767Jp4wmekIuVY+aWRbp76qlLyNTBogEzaCjlS2v/IIqM+ql6g9s7ZfIoNNxeUSaRA==
X-Received: by 2002:a05:690c:fc1:b0:5b3:4264:416f with SMTP id dg1-20020a05690c0fc100b005b34264416fmr13295460ywb.27.1699308535285;
        Mon, 06 Nov 2023 14:08:55 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d24-20020a05620a141800b0077412ca0ae1sm3667431qkj.65.2023.11.06.14.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:54 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 18/18] btrfs: set clear_cache if we use usebackuproot
Date: Mon,  6 Nov 2023 17:08:26 -0500
Message-ID: <fa8bd832709bea92d427c104cc45686be347a150.1699308010.git.josef@toxicpanda.com>
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
index f2c90f022233..769c49f0ef97 100644
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


