Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE49ACD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404809AbfHWKMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:12:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404700AbfHWKMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555121; x=1598091121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RdZkysa1QaRudWUb1KxKJfLMLCLBayd8KddMUFlrxHI=;
  b=b9ZELsGsNQ0tozVormlF+tyRswrzvia7R9q7wnkooIs1cW2tug06uUhV
   URxakrdsER2yorEV6j+5ePKmtoYRvlXIb06p2cuCxpNeiIqu3/Jehoc65
   t5tGFKEagO9Aekiy9fWmQaCEFlKSYeejOV+w6l+g4rEJbg9fZnxkvwCv6
   f0PPxYYs9/9tf6l5kcHo1NUKwNXV14i/y3nzAHO/c+8EujJ0nZUciG37x
   AWf8bv9X+LelUHbf8ZeeuBSYk3EIp6el+m/zBdkywenrnGd34qz3Hht4V
   QIbuUUSKOuDZLU5CQqNdPDmGX1hjbXZVOgOUdoMZSXjnHAsES2WQ4x//R
   g==;
IronPort-SDR: 23QuFrqT8p3fuYNkeKyZJ2vWaVcyIdeMvR2ngWAyM2tQ1yaZvzPvoWMZ0wmu6lvd6lAmySdqB0
 wR7jbAU5YhgIEdbZmpJwFJAdR4OisO5Kclc3oid2N55woml1eLNcn0MTElmwlyfLYW+F0Ldp9d
 zegSGEtyN/zz8Ezm9/zUezqPMiHGKaTtP9l5Fa36/PV5jnTLBo/iyhiu+vCV6a6nE64Y4gRiM+
 Ha8/NCBElmaHdd0xILOQ7eM1Xes6Uq/BT8Tsd9xNCWq34tfEO6sr6mQaLNrIuJPkYQ8esUMLtQ
 LCc=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096276"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:12:01 +0800
IronPort-SDR: Oux4uM5pHp5GaQGcpRWC5CiW2KcG9FYQNuKKjrMYbBPV2Q23pAeIpLgS9MFOhrHXERr6ekwtK3
 +tXc7P6/SICRUGdYR0m4a/DuUi5jj+rx9/OH0923X3/pS9PEjG6P/xvV6hKpdJbCIdYoPXFdVI
 uYF2YBp2/OqdpBfnIk/2G4amK5aecY0LmlrcadVkg302WAYVurM4koOmWts/Y9BJNqop6Ehut3
 wDK8MPseLaxijBrjdUTvOC2fE/ECLXnolHxgAfSChhMzaG8//JDJBfPr1wmT9k7IAPjv3RwsXW
 0lN2HPKzDyqUanL2ce2LTnBL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:09:19 -0700
IronPort-SDR: EWvda8meFK+zGXV7Lj4HODNHZ2tSf2c1rl2e2j502bDqjB8VPtc29FNsO4ZwXv0XVuTkSZ1Hfy
 E8JL2xIfq4NeSvnif4o6CwnadHjUrPelUWZ6EEdM+pO0PgJlDoJ0Fv/MKEqPD0ljpwIp+DK3z9
 5JTGMEQkshWRvwIy77YvhCeyQSZ/h1tQ4OlfQYUJn47MpJxVsmikb69TPurfLMrqZVKlsH8Akj
 kvIk6V5TnZ94T4VgProrZksKcIrO4AENtY3k3UXX8MtLjdyxUBzCxdRLfM4DpcqqLBZnPwBhZ2
 Ha0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:12:00 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 25/27] btrfs: enable relocation in HMZONED mode
Date:   Fri, 23 Aug 2019 19:10:34 +0900
Message-Id: <20190823101036.796932-26-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To serialize allocation and submit_bio, we introduced mutex around them. As
a result, preallocation must be completely disabled to avoid a deadlock.

Since current relocation process relies on preallocation to move file data
extents, it must be handled in another way. In HMZONED mode, we just
truncate the inode to the size that we wanted to pre-allocate. Then, we
flush dirty pages on the file before finishing relocation process.
run_delalloc_hmzoned() will handle all the allocation and submit IOs to
the underlying layers.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7f219851fa23..d852e3389ee2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3152,6 +3152,34 @@ int prealloc_file_extent_cluster(struct inode *inode,
 	if (ret)
 		goto out;
 
+	/*
+	 * In HMZONED, we cannot preallocate the file region. Instead,
+	 * we dirty and fiemap_write the region.
+	 */
+
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED)) {
+		struct btrfs_root *root = BTRFS_I(inode)->root;
+		struct btrfs_trans_handle *trans;
+
+		end = cluster->end - offset + 1;
+		trans = btrfs_start_transaction(root, 1);
+		if (IS_ERR(trans))
+			return PTR_ERR(trans);
+
+		inode->i_ctime = current_time(inode);
+		i_size_write(inode, end);
+		btrfs_ordered_update_i_size(inode, end, NULL);
+		ret = btrfs_update_inode(trans, root, inode);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			btrfs_end_transaction(trans);
+			return ret;
+		}
+		ret = btrfs_end_transaction(trans);
+
+		goto out;
+	}
+
 	cur_offset = prealloc_start;
 	while (nr < cluster->nr) {
 		start = cluster->boundary[nr] - offset;
@@ -3340,6 +3368,10 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		btrfs_throttle(fs_info);
 	}
 	WARN_ON(nr != cluster->nr);
+	if (btrfs_fs_incompat(fs_info, HMZONED) && !ret) {
+		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
+		WARN_ON(ret);
+	}
 out:
 	kfree(ra);
 	return ret;
@@ -4180,8 +4212,12 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct btrfs_inode_item *item;
 	struct extent_buffer *leaf;
+	u64 flags = BTRFS_INODE_NOCOMPRESS | BTRFS_INODE_PREALLOC;
 	int ret;
 
+	if (btrfs_fs_incompat(trans->fs_info, HMZONED))
+		flags &= ~BTRFS_INODE_PREALLOC;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -4196,8 +4232,7 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	btrfs_set_inode_generation(leaf, item, 1);
 	btrfs_set_inode_size(leaf, item, 0);
 	btrfs_set_inode_mode(leaf, item, S_IFREG | 0600);
-	btrfs_set_inode_flags(leaf, item, BTRFS_INODE_NOCOMPRESS |
-					  BTRFS_INODE_PREALLOC);
+	btrfs_set_inode_flags(leaf, item, flags);
 	btrfs_mark_buffer_dirty(leaf);
 out:
 	btrfs_free_path(path);
-- 
2.23.0

