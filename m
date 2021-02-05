Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA2310434
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 05:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhBEExM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 23:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhBEExG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 23:53:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6434CC061786;
        Thu,  4 Feb 2021 20:52:26 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d2so3116248pjs.4;
        Thu, 04 Feb 2021 20:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ebf53u+tGmB5LJxdnIJv3XzWkYXHGYPoxBE+b+T9QNU=;
        b=Cvjz9vn3dF4SctIwPZU6fRm7gPveRochkIgB/zeFML4ybGIkiB2K6Txv9DiIagc7bJ
         6oTEqQxbEVFi9qcPRmDIOjCIQZBY1UAXliCpJTGcFxCeYAUHP6rFuzxflYdlazqnZtZF
         ofol6NUlV/8FxYzqCvJ7v5JweWgMNYBdh/UdCdoE3ZZjAWYIw0mQJMs1kxH39OtKpXx4
         CeoETJYJ1T38sA+m+6xQZRKWqllDemr7yIIGqFAHJQKNSgCad7r35zhru9bfVk/NYR/D
         t/Hl4gq93E95eu2/Fr+V1B02ir4fDW0lWyixTyOWXPJyg29qmGP7B1CD6prd5YBuIWya
         +c7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ebf53u+tGmB5LJxdnIJv3XzWkYXHGYPoxBE+b+T9QNU=;
        b=R+4nib7UFBqndiU/ayr4UzV9mgaFT9agkHqOvCDKbCDGXwzvLu1YiijjVEAoY+qhzp
         PppTlDLrDPeFj+ra0Y93C6+iMTj3ZM76lyUqZRg8Pv4F5uhO5pJ7B/MeWhdIZtVXZ2e9
         wlECPj0DIVh2sJllei7rfLdxbtxBwjCmLKFsnDszW6RfBEJ1ge63c/Jsu9hKQZAjNJF8
         Ma5BHeCqOO5gCeukmbr4KYGX7NT+7pRLHGgXcQhpdP7FlkdgZBlYY9GlZbVrB11ZUvln
         O8m1+2HWITLa9LCfSz2pdx7oHg+S66+8v3LN9r4DXgphbiDtsqus/eCUeEI6OETcchh6
         3x0Q==
X-Gm-Message-State: AOAM5331tXwluI/dNaFRtfiqmZdreUlmfKAIzrCSRj3qDl2eBF3I639c
        3soIQFX9aW+d9b5lAa6h/mobkxEQKwfQDw==
X-Google-Smtp-Source: ABdhPJzaiqbpmAVJdSS9XfZmYzHwyRg6TBP9ey1/xe6Cvtnwy494xIYkjZK8cK0NLnl11Nk1MJsANg==
X-Received: by 2002:a17:903:1c2:b029:de:ad0a:2dbf with SMTP id e2-20020a17090301c2b02900dead0a2dbfmr2553461plh.44.1612500745738;
        Thu, 04 Feb 2021 20:52:25 -0800 (PST)
Received: from amypc-samantha.home ([47.145.126.51])
        by smtp.gmail.com with ESMTPSA id s1sm6972440pjg.17.2021.02.04.20.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 20:52:25 -0800 (PST)
From:   Amy Parker <enbyamy@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Amy Parker <enbyamy@gmail.com>
Subject: [PATCH 1/3] fs/efs: Use correct brace styling for statements
Date:   Thu,  4 Feb 2021 20:52:15 -0800
Message-Id: <20210205045217.552927-2-enbyamy@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205045217.552927-1-enbyamy@gmail.com>
References: <20210205045217.552927-1-enbyamy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Many single-line statements have unnecessary braces, and some statement pairs have mismatched braces. This is a clear violation of the kernel style guide, which mandates that single line statements have no braces and that pairs with at least one multi-line block maintain their braces.

This patch fixes these style violations. Single-line statements that have braces have had their braces stripped. Pair single-line statements have been formatted per the style guide. Pair mixed-line statements have had their braces updated to conform.

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

