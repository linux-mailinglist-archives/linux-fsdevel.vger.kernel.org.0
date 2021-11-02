Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E578A4437C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 22:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhKBV1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 17:27:34 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:36705 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231240AbhKBV1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:27:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1B7E33201E1E;
        Tue,  2 Nov 2021 17:24:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 Nov 2021 17:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=AOp5yWJmgReXc
        Sl3nGlPUzrOEaCesSXEB6EBEqFCYdo=; b=SxSidvL+PkIoqlrpJxTUbpuCOizLj
        ueU3B9gKujKjf1YZaand76FuqvVLQej8T5F5B4wMPrBlx0ux7hq7A+AXJjKYjB81
        rvwEPKhiwO/fFNa8r49v8Mf1de54jw3NmfYfyijBaphzYuFB39FYhAu+u/UcNLul
        Zj0sWNKr/U8M9HAz219ZYtGowqNlzFVN8YY18jdXQ4V7XRyoxYJlFu7Z8u2J+LH5
        jF5GqXgY91w1/kzzdwnrqP4jBsmJZNgTGT86lao5pRWpqG7HaueLoxKmaDz5sRAG
        /vCU0TCXHLKzbm8VTNqq7unI8ymINVdDiXwopKw/QQGja4Q1iz+cQAL8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=AOp5yWJmgReXcSl3nGlPUzrOEaCesSXEB6EBEqFCYdo=; b=c/SoheMT
        sFQ6U61d5sGVFyZZH5bA52ldkYxOV3pC3Uuf1kaKLkKV6o4wW8ZMEjgObsBEd9No
        RaZGSukia7C1iMJmCw3JeXaOGd4mLk8Fw+Zm/VHOKtPetYM0xO5HWQBIytj4di4b
        bVw1nNOxqbHLX8P14ohq48TrJU8vpl4NZTmgEp9rp6ytnor+IaejLk2TQcshaMwC
        9sc1dNI3P10U9G2fHZcfAUtQuDh+OMdcNdsiDmMJGv6k+tP32o9iy9ODINLZHadM
        ElafIKaoFwA7nd84RNtDtafQt7kLowzIX+idUdIfRNKcCgbqhD6ipwk1E9ORARbr
        bEECorNoUJBeUA==
X-ME-Sender: <xms:qayBYUKdPXUgzHhYCds1huTT-yx8jaWD0-bd0RIY_Ow2F69Alxa8UA>
    <xme:qayBYUJdU8Oz0o-PEiZpclgcXamIHR4x7Ms-kcMiWhiyAO1OiCmwOpeVXLAAHFnkV
    bMQ4feSntUbyLoVhw>
X-ME-Received: <xmr:qayBYUtZgDwfTPlhk6WgQML41pz3tVAWE-gT8NUwfafXT6p97A2V4dJCbBsfwjS-aZFBjzp2qb8wA0TSIORlPbxwlp9HtmYWzTTgP1av>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtddtgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhhrihhs
    thhophhhvgcugghuqdeurhhughhivghruceotghvuhgsrhhughhivghrsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekjeettefgieetvdekudevudduvddvueet
    lefhieevffehudfhveeutdevgfekffenucevlhhushhtvghrufhiiigvpeefnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtvhhusghruhhgihgvrhesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:qayBYRbT5rIiZHkQXhLVcglDUfBTeTP49sLGLU617us8z6pTmC1Ryw>
    <xmx:qayBYbZoeXZuymMPtXsKqqT3H3PzAm52UGQTe8izaWvnrVpyOr5sJw>
    <xmx:qayBYdC1c2IUarDXXFcSPE2qNGZKyVhCEVsm-5xw5jQ-jkf_H_xr0w>
    <xmx:qayBYamWyJasMLfditwELDXmTb54UaVAJ_2JhQSFYKVUnB51zmYLhg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Nov 2021 17:24:56 -0400 (EDT)
From:   Christophe Vu-Brugier <cvubrugier@fastmail.fm>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
Subject: [PATCH 4/4] exfat: reuse exfat_inode_info variable instead of calling EXFAT_I()
Date:   Tue,  2 Nov 2021 22:23:58 +0100
Message-Id: <20211102212358.3849-5-cvubrugier@fastmail.fm>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211102212358.3849-1-cvubrugier@fastmail.fm>
References: <20211102212358.3849-1-cvubrugier@fastmail.fm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>

Also add a local "struct exfat_inode_info *ei" variable to
exfat_truncate() to simplify the code.

Signed-off-by: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
---
 fs/exfat/file.c  | 14 +++++++-------
 fs/exfat/inode.c |  9 ++++-----
 fs/exfat/namei.c |  6 +++---
 fs/exfat/super.c |  6 +++---
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 6af0191b648f..848166d6d5e9 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -110,8 +110,7 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 	exfat_set_volume_dirty(sb);
 
 	num_clusters_new = EXFAT_B_TO_CLU_ROUND_UP(i_size_read(inode), sbi);
-	num_clusters_phys =
-		EXFAT_B_TO_CLU_ROUND_UP(EXFAT_I(inode)->i_size_ondisk, sbi);
+	num_clusters_phys = EXFAT_B_TO_CLU_ROUND_UP(ei->i_size_ondisk, sbi);
 
 	exfat_chain_set(&clu, ei->start_clu, num_clusters_phys, ei->flags);
 
@@ -228,12 +227,13 @@ void exfat_truncate(struct inode *inode, loff_t size)
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
 	unsigned int blocksize = i_blocksize(inode);
 	loff_t aligned_size;
 	int err;
 
 	mutex_lock(&sbi->s_lock);
-	if (EXFAT_I(inode)->start_clu == 0) {
+	if (ei->start_clu == 0) {
 		/*
 		 * Empty start_clu != ~0 (not allocated)
 		 */
@@ -260,11 +260,11 @@ void exfat_truncate(struct inode *inode, loff_t size)
 		aligned_size++;
 	}
 
-	if (EXFAT_I(inode)->i_size_ondisk > i_size_read(inode))
-		EXFAT_I(inode)->i_size_ondisk = aligned_size;
+	if (ei->i_size_ondisk > i_size_read(inode))
+		ei->i_size_ondisk = aligned_size;
 
-	if (EXFAT_I(inode)->i_size_aligned > i_size_read(inode))
-		EXFAT_I(inode)->i_size_aligned = aligned_size;
+	if (ei->i_size_aligned > i_size_read(inode))
+		ei->i_size_aligned = aligned_size;
 	mutex_unlock(&sbi->s_lock);
 }
 
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 98292b38c6e2..5c442182f516 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -114,10 +114,9 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 	unsigned int local_clu_offset = clu_offset;
 	unsigned int num_to_be_allocated = 0, num_clusters = 0;
 
-	if (EXFAT_I(inode)->i_size_ondisk > 0)
+	if (ei->i_size_ondisk > 0)
 		num_clusters =
-			EXFAT_B_TO_CLU_ROUND_UP(EXFAT_I(inode)->i_size_ondisk,
-			sbi);
+			EXFAT_B_TO_CLU_ROUND_UP(ei->i_size_ondisk, sbi);
 
 	if (clu_offset >= num_clusters)
 		num_to_be_allocated = clu_offset - num_clusters + 1;
@@ -416,10 +415,10 @@ static int exfat_write_end(struct file *file, struct address_space *mapping,
 
 	err = generic_write_end(file, mapping, pos, len, copied, pagep, fsdata);
 
-	if (EXFAT_I(inode)->i_size_aligned < i_size_read(inode)) {
+	if (ei->i_size_aligned < i_size_read(inode)) {
 		exfat_fs_error(inode->i_sb,
 			"invalid size(size(%llu) > aligned(%llu)\n",
-			i_size_read(inode), EXFAT_I(inode)->i_size_aligned);
+			i_size_read(inode), ei->i_size_aligned);
 		return -EIO;
 	}
 
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 24b41103d1cc..9d8ada781250 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -395,9 +395,9 @@ static int exfat_find_empty_entry(struct inode *inode,
 
 		/* directory inode should be updated in here */
 		i_size_write(inode, size);
-		EXFAT_I(inode)->i_size_ondisk += sbi->cluster_size;
-		EXFAT_I(inode)->i_size_aligned += sbi->cluster_size;
-		EXFAT_I(inode)->flags = p_dir->flags;
+		ei->i_size_ondisk += sbi->cluster_size;
+		ei->i_size_aligned += sbi->cluster_size;
+		ei->flags = p_dir->flags;
 		inode->i_blocks += 1 << sbi->sect_per_clus_bits;
 	}
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 5539ffc20d16..1a2115d73a48 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -366,9 +366,9 @@ static int exfat_read_root(struct inode *inode)
 
 	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1))
 			& ~(sbi->cluster_size - 1)) >> inode->i_blkbits;
-	EXFAT_I(inode)->i_pos = ((loff_t)sbi->root_dir << 32) | 0xffffffff;
-	EXFAT_I(inode)->i_size_aligned = i_size_read(inode);
-	EXFAT_I(inode)->i_size_ondisk = i_size_read(inode);
+	ei->i_pos = ((loff_t)sbi->root_dir << 32) | 0xffffffff;
+	ei->i_size_aligned = i_size_read(inode);
+	ei->i_size_ondisk = i_size_read(inode);
 
 	exfat_save_attr(inode, ATTR_SUBDIR);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = ei->i_crtime =
-- 
2.20.1

