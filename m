Return-Path: <linux-fsdevel+bounces-56484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749EB17A89
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD12D626320
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EDF134CB;
	Fri,  1 Aug 2025 00:15:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236F1862
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 00:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007311; cv=none; b=lbIvXanjLVYxWTnCzcHkYIM/XBBaVKgHP56pZihN7qIZI7BYmDHq7IWpKsOcMvxG/nvy+JLqVv5N/0mSskkY1k36HBkIzTBLoQPn6OijgonABZ/qAFiyfQU5KeLN3hSBU6w6AH3MCSHvYtk7TgaOYWpo6IIygnEdqWMJB15idS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007311; c=relaxed/simple;
	bh=2ueVdTnYb0H3/GY1l1EqubntQXNZd6Zn4Uh/j6gr0jo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=br3O7cRwejrLaa1oyJXXS56ENjcbGewrtqcPc2pewTJCiM0QGweykpT0vFbtc0OThlut5NolSTMVrLUUAl93tuRIzd2lDNd58R6h48XgBgzUJYVRIu4pZn8CdWTRVv9atpws/C4Lyb9n4aD9TF8wGS2CEKEpUZX/oPORZ081zoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76b77a97a04so295589b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754007308; x=1754612108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24xubIswiAATp/Uqb0uX7ru5OUsp8Fk2ykzp8jo4uV0=;
        b=pC9wJSC2Np51I2Ty4WFs9W+pSE6N9UgqSUUWfZIuWrK2esOhFpDtn0WcvVsVYxOc9r
         un9V4CfSnAPaASfNTR9s6Og8zpsrmpM0aMhuGFuOKJuk1Rc+kYklAzQaLn9b0IGAtWu6
         3SgxWal1yxrSvFRhLlzTSnZxlTsDqmo7bB1jRo/TqgNUvKG6PWwOcs+sYWpghZF3pz/p
         6ues1d+PFkMquICvfbGJyRkmR46Oqq8NMO0Gu5PmIUHyhJ8leqOGVpqLPyYLt30A7MI9
         jW3shgeJ2RNu2CvDs2MgzINAHTk8T1S7ZsN6xe/N/Iki4Oyo8HEQcYdkfB4x2x9GO+Kc
         f9MQ==
X-Gm-Message-State: AOJu0YwAAvv+2dc7BYlsiiYhQShjfzhJdJkY7SfAD6/0Gy86zbnwthyi
	PsLhmsGsEGi0OPUQBd3y6hUbR2awcahRWEEjvfck96ri7TLzcETCGhJp
X-Gm-Gg: ASbGncuaE+OwrnYFNxWMOMoPM3RVbgvTPWQHj+lgRTXmo7/ciiFK5eLv3uOVjkwoYqK
	OQ5M88GBtDRujnYJ0yy+06fN3E+yWFV/Q8rdcG6lSSPFsKcq7a+7GzQMiCykgKRTC5rbXAVIkq5
	ZOYnKT74aKppE7hmGMl4axYrmhF2v1uVZ+Yk2Ggk+mbF1dgjgVHpyUo+rGyd12A1b29v+Vi/Df0
	eWUY+uwgGmVkH5BKN7FKJmLruztS71ANGGDwIoinKuo4JQ8IhE6ryISlgzHLJqs5gnq+s9kSQng
	3IfW/fBa1sB+feW20bPYp/JCkAnDY0IVrGhyULgW8YktHPN93H8tHEls2sed9mmwJBfNmiXE/Pd
	umr/HjGeEVAY0VPhpNH5AV/oLM8uJK1puZYXGQhLQOZt/vhFx
X-Google-Smtp-Source: AGHT+IFmmSYT3J3GmU3r3IMMSjRqhJm1B9GKmVvZ+CoGMYLVNab5+LjEgdvd0kODGGyYBcs8qwK/ug==
X-Received: by 2002:a05:6a00:1945:b0:769:a6a2:fe1e with SMTP id d2e1a72fcca58-76ab2938e65mr12044165b3a.11.1754007308486;
        Thu, 31 Jul 2025 17:15:08 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm2594680b3a.42.2025.07.31.17.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 17:15:07 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	Yuezhang.Mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] exfat: optimize allocation bitmap loading time
Date: Fri,  1 Aug 2025 09:14:52 +0900
Message-Id: <20250801001452.14105-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Loading the allocation bitmap is very slow if user set the small cluster
size on large partition.

For optimizing it, This patch uses sb_breadahead() read the allocation
bitmap. It will improve the mount time.

The following is the result of about 4TB partition(2KB cluster size)
on my target.

without patch:
real 0m41.746s
user 0m0.011s
sys 0m0.000s

with patch:
real 0m2.525s
user 0m0.008s
sys 0m0.008s

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/balloc.c   | 12 +++++++++++-
 fs/exfat/dir.c      |  1 -
 fs/exfat/exfat_fs.h |  1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index cc01556c9d9b..c40b73701941 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -30,9 +30,11 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 		struct exfat_dentry *ep)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct blk_plug plug;
 	long long map_size;
-	unsigned int i, need_map_size;
+	unsigned int i, j, need_map_size;
 	sector_t sector;
+	unsigned int max_ra_count = EXFAT_MAX_RA_SIZE >> sb->s_blocksize_bits;
 
 	sbi->map_clu = le32_to_cpu(ep->dentry.bitmap.start_clu);
 	map_size = le64_to_cpu(ep->dentry.bitmap.size);
@@ -57,6 +59,14 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 
 	sector = exfat_cluster_to_sector(sbi, sbi->map_clu);
 	for (i = 0; i < sbi->map_sectors; i++) {
+		/* Trigger the next readahead in advance. */
+		if (0 == (i % max_ra_count)) {
+			blk_start_plug(&plug);
+			for (j = i; j < min(max_ra_count, sbi->map_sectors - i) + i; j++)
+				sb_breadahead(sb, sector + j);
+			blk_finish_plug(&plug);
+		}
+
 		sbi->vol_amap[i] = sb_bread(sb, sector + i);
 		if (!sbi->vol_amap[i]) {
 			/* release all buffers and free vol_amap */
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index ee060e26f51d..e7a8550c0346 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -616,7 +616,6 @@ static int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir
 	return 0;
 }
 
-#define EXFAT_MAX_RA_SIZE     (128*1024)
 static int exfat_dir_readahead(struct super_block *sb, sector_t sec)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f8ead4d47ef0..d1792d5c9eed 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -13,6 +13,7 @@
 #include <uapi/linux/exfat.h>
 
 #define EXFAT_ROOT_INO		1
+#define EXFAT_MAX_RA_SIZE     (128*1024)
 
 /*
  * exfat error flags
-- 
2.25.1


