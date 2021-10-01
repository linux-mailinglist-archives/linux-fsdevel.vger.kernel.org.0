Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E890341E57F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 02:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350706AbhJAA3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 20:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhJAA3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:29:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DD0C06176A;
        Thu, 30 Sep 2021 17:27:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k7so12629110wrd.13;
        Thu, 30 Sep 2021 17:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rFry4YMfnGtKO2BLHPEv7L7BiFvue1yJhDDVxeV1y/w=;
        b=JVKdKHx6mJ3qN/uOvPiUaiazAvbWUHf+mps3HFHvKAqwwZoiF3XFoVaLYiSULbE04z
         UBeCYrEjjrej6yLdnsq1mv8G+d2MHHbqOpJOQ1trME0tOuN4KDlJRLLcEg7hfzubKKtC
         RRNp8NSth0PlxTh+a69SDkCjrFU7xhm8HZ9qbJXTXK6i7wsCZ/SyRCTJycYgW3ALWRPb
         lVs59wuFbKuUxxyTplRxQlqHXZ/Q/cTOVznGHbHPVFrarG4RYK9w6QhoWHoFfLwqBAjw
         uV0WZY+qZ/SB8hN3onPOPjpG0aPrt/tISwnxcfh3UUO6ow5kofmnrnlMgZciUz6hUOjd
         f2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rFry4YMfnGtKO2BLHPEv7L7BiFvue1yJhDDVxeV1y/w=;
        b=gp6NhRZ1i9y0MqLqY3iU9kl9LhOYn5zAS+dmyytLOQJXdLbOROdUa3cMbbR+6k7NHm
         mwCOKD/rOW7vwo1i47C0fM/krsgkxbqqQCl/uHbT4RjCN8tn8EpZ146oLj5WUMlufbiQ
         B2NiGGNK/sRvKpuxPgGfCiBMxygZXXB2un1XOkOtrtt4jfNx+QPUaX2dKKwtnOaT9pN3
         DShZS4jy1eAcNvwwOUonmpQYWbAx8IjtRut5eXxmW3aRpYtgFEHJyptX6LujO7elsZVa
         XcO/LIoBjQxjOmQm3M1h+HJs8t5RlYFxM+wflc9PQF1q8i2V4QO4V8AYdCfq6/bcCtqn
         qc2Q==
X-Gm-Message-State: AOAM532qfcH8rrW/xZwLw7mhj0sq5lvZUbc/6InphH21D7oSsFlv1t+F
        LgiEHLgibzPIBdlA80FMaYKsLZpBLYbHYw==
X-Google-Smtp-Source: ABdhPJyaRLm+2y1TV2V6G19tGVbOt+PBv+vgWWeZ8ZkHWuG3RtmhpcgTXrIiYwD0rpnbTc4bFgISww==
X-Received: by 2002:adf:aa4e:: with SMTP id q14mr1806762wrd.100.1633048035259;
        Thu, 30 Sep 2021 17:27:15 -0700 (PDT)
Received: from localhost.localdomain ([197.49.49.194])
        by smtp.googlemail.com with ESMTPSA id o26sm6149801wmc.17.2021.09.30.17.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 17:27:14 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/affs: fix minor indentation and codestyle
Date:   Fri,  1 Oct 2021 02:27:01 +0200
Message-Id: <20211001002702.151056-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Errors found by checkpatch.pl

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 fs/affs/inode.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 2352a75bd9d6..69dc98d07e41 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -41,7 +41,7 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 		goto bad_inode;
 	}
 	if (affs_checksum_block(sb, bh) || be32_to_cpu(AFFS_HEAD(bh)->ptype) != T_SHORT) {
-		affs_warning(sb,"read_inode",
+		affs_warning(sb, "read_inode",
 			   "Checksum or type (ptype=%d) error on inode %d",
 			   AFFS_HEAD(bh)->ptype, block);
 		goto bad_inode;
@@ -151,7 +151,7 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 
 	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec
 		       = (be32_to_cpu(tail->change.days) * 86400LL +
-		         be32_to_cpu(tail->change.mins) * 60 +
+						 be32_to_cpu(tail->change.mins) * 60 +
 			 be32_to_cpu(tail->change.ticks) / 50 +
 			 AFFS_EPOCH_DELTA) +
 			 sys_tz.tz_minuteswest * 60;
@@ -182,7 +182,7 @@ affs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		return 0;
 	bh = affs_bread(sb, inode->i_ino);
 	if (!bh) {
-		affs_error(sb,"write_inode","Cannot read block %lu",inode->i_ino);
+		affs_error(sb, "write_inode", "Cannot read block %lu", inode->i_ino);
 		return -EIO;
 	}
 	tail = AFFS_TAIL(sb, bh);
@@ -263,6 +263,7 @@ void
 affs_evict_inode(struct inode *inode)
 {
 	unsigned long cache_page;
+
 	pr_debug("evict_inode(ino=%lu, nlink=%u)\n",
 		 inode->i_ino, inode->i_nlink);
 	truncate_inode_pages_final(&inode->i_data);
@@ -298,10 +299,12 @@ affs_new_inode(struct inode *dir)
 	u32			 block;
 	struct buffer_head	*bh;
 
-	if (!(inode = new_inode(sb)))
+	inode = new_inode(sb);
+	if (!inode)
 		goto err_inode;
 
-	if (!(block = affs_alloc_block(dir, dir->i_ino)))
+	block = affs_alloc_block(dir, dir->i_ino);
+	if (!block)
 		goto err_block;
 
 	bh = affs_getzeroblk(sb, block);
@@ -390,7 +393,8 @@ affs_add_entry(struct inode *dir, struct inode *inode, struct dentry *dentry, s3
 
 	if (inode_bh) {
 		__be32 chain;
-	       	chain = AFFS_TAIL(sb, inode_bh)->link_chain;
+
+		chain = AFFS_TAIL(sb, inode_bh)->link_chain;
 		AFFS_TAIL(sb, bh)->original = cpu_to_be32(inode->i_ino);
 		AFFS_TAIL(sb, bh)->link_chain = chain;
 		AFFS_TAIL(sb, inode_bh)->link_chain = cpu_to_be32(block);
-- 
2.25.1

