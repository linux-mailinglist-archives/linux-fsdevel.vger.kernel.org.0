Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357E7310464
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 06:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhBEFPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 00:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhBEFPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:15:18 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9C0C061786;
        Thu,  4 Feb 2021 21:14:38 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nm1so2996495pjb.3;
        Thu, 04 Feb 2021 21:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GtCmnlmMaSfLvRDQiIOP+AzSoIHYRwy5meyrdlnaWg=;
        b=vOTRBeqlp+bx/9CPz54N4PlLtazw2RPMGv3zGn5rISn9uY2l5sNl8HUKgxSvIU5fDb
         ak9MFE0BTqmFA8PU+M/F+kO+MY6aAX6pPOl4yWfBvrhBRY5rZcH3OsmLVcB2k6czkrQY
         aYl24ApSTeLKVxuISfG6GpWUeOeeTzE49pKtoHZbsuhXPnZBbISUfbF6o65iILvOXr8M
         czcqLMH1WZ50xLc0DXRSQc7+Hq9bDB9IEQQD6l8Jttwg5GcYGE1+z3QWeC/eq+6NwDtc
         9jboQBg+FppV6M5I2Twyi0JJ99bd1wjtKyBK5fZ6pqf6/vQpoQaooXBWSxg1cZJS1Vbl
         VFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GtCmnlmMaSfLvRDQiIOP+AzSoIHYRwy5meyrdlnaWg=;
        b=c6KAGKI5qgWLqfeiSztoU3Vu7cm9eLY6ku0udcsy6kNIPlbhLKXEZEyk3i4zmIOzA9
         qJEs+J3viTJ8fpgo7XRSf5FrR7FMs7vvMgK3hQLpUrA4ahpHt9LVQJ7AuuL94RjYeIGr
         AxHUfwTzvqxD782uB1Y1bpD1b/1SYbfUoAQikUnYE6KYyu2ZlDsXzrVFT/j1imUFuc+c
         BBdyHsZKh5h5cKgTiWtJ+tfLWEUSYpAq/EXIAyJqplAvpbPebBaZL36PU+ZFw/zpMlHo
         LzYD+5fYaqkUJ9Rml/BSdJJncPjH2o6lszN5/Bu5UhW3+VsLDKXDE59+VcSfE9YCbtjJ
         u++A==
X-Gm-Message-State: AOAM531FZ9thG5buxTr3HqgceGBXOhgCkC1mcVXIll2mHzERK2rafS5k
        mmhY6th+URrhYzWeE1zG6Jb/XVdEwFvrCg==
X-Google-Smtp-Source: ABdhPJzJiL/n19BLuXSTaI7XAv5LxHgwB0+OTccIi2gVfEMuOCve1N6bCi9ukmcbOKm3sTgCvnDwxQ==
X-Received: by 2002:a17:902:d691:b029:e1:561e:f8af with SMTP id v17-20020a170902d691b02900e1561ef8afmr2647785ply.23.1612502077748;
        Thu, 04 Feb 2021 21:14:37 -0800 (PST)
Received: from amypc-samantha.home ([47.145.126.51])
        by smtp.gmail.com with ESMTPSA id v126sm5905000pfv.163.2021.02.04.21.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 21:14:37 -0800 (PST)
From:   Amy Parker <enbyamy@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Amy Parker <enbyamy@gmail.com>
Subject: [PATCH v2 1/3] fs/efs: Use correct brace styling for statements
Date:   Thu,  4 Feb 2021 21:14:27 -0800
Message-Id: <20210205051429.553657-2-enbyamy@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205051429.553657-1-enbyamy@gmail.com>
References: <20210205051429.553657-1-enbyamy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Many single-line statements have unnecessary braces, and some statement 
pairs have mismatched braces. This is a clear violation of the kernel 
style guide, which mandates that single line statements have no braces 
and that pairs with at least one multi-line block maintain their braces.

This patch fixes these style violations. Single-line statements that 
have braces have had their braces stripped. Pair single-line statements 
have been formatted per the style guide. Pair mixed-line statements have 
had their braces updated to conform.

Signed-off-by: Amy Parker <enbyamy@gmail.com>
---
 fs/efs/inode.c | 10 ++++++----
 fs/efs/super.c | 15 ++++++---------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 89e73a6f0d36..36d6c45046e2 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -107,11 +107,11 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = 0;
 
 	/* this is the number of blocks in the file */
-	if (inode->i_size == 0) {
+	if (inode->i_size == 0)
 		inode->i_blocks = 0;
-	} else {
+	else
 		inode->i_blocks = ((inode->i_size - 1) >> EFS_BLOCKSIZE_BITS) + 1;
-	}
+
 
 	rdev = be16_to_cpu(efs_inode->di_u.di_dev.odev);
 	if (rdev == 0xffff) {
@@ -120,8 +120,10 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 			device = 0;
 		else
 			device = MKDEV(sysv_major(rdev), sysv_minor(rdev));
-	} else
+	}
+	else {
 		device = old_decode_dev(rdev);
+	}
 
 	/* get the number of extents for this object */
 	in->numextents = be16_to_cpu(efs_inode->di_numextents);
diff --git a/fs/efs/super.c b/fs/efs/super.c
index 62b155b9366b..874d82096b2f 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -160,14 +160,13 @@ static efs_block_t efs_validate_vh(struct volume_header *vh) {
 	struct pt_types	*pt_entry;
 	int		pt_type, slice = -1;
 
-	if (be32_to_cpu(vh->vh_magic) != VHMAGIC) {
+	if (be32_to_cpu(vh->vh_magic) != VHMAGIC)
 		/*
 		 * assume that we're dealing with a partition and allow
 		 * read_super() to try and detect a valid superblock
 		 * on the next block.
 		 */
 		return 0;
-	}
 
 	ui = ((__be32 *) (vh + 1)) - 1;
 	for(csum = 0; ui >= ((__be32 *) vh);) {
@@ -191,11 +190,11 @@ static efs_block_t efs_validate_vh(struct volume_header *vh) {
 		}
 		name[j] = (char) 0;
 
-		if (name[0]) {
+		if (name[0])
 			pr_debug("vh: %8s block: 0x%08x size: 0x%08x\n",
 				name, (int) be32_to_cpu(vh->vh_vd[i].vd_lbn),
 				(int) be32_to_cpu(vh->vh_vd[i].vd_nbytes));
-		}
+
 	}
 #endif
 
@@ -219,15 +218,14 @@ static efs_block_t efs_validate_vh(struct volume_header *vh) {
 		}
 	}
 
-	if (slice == -1) {
+	if (slice == -1)
 		pr_notice("partition table contained no EFS partitions\n");
 #ifdef DEBUG
-	} else {
+	else
 		pr_info("using slice %d (type %s, offset 0x%x)\n", slice,
 			(pt_entry->pt_name) ? pt_entry->pt_name : "unknown",
 			sblock);
 #endif
-	}
 	return sblock;
 }
 
@@ -284,9 +282,8 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
 	sb->fs_start = efs_validate_vh((struct volume_header *) bh->b_data);
 	brelse(bh);
 
-	if (sb->fs_start == -1) {
+	if (sb->fs_start == -1)
 		return -EINVAL;
-	}
 
 	bh = sb_bread(s, sb->fs_start + EFS_SUPER);
 	if (!bh) {
-- 
2.29.2

