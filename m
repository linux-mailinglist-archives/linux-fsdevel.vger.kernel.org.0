Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E5785E80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389685AbfHHJcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:32:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59666 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389565AbfHHJcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256721; x=1596792721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DU4KgyM/kRqpnP/dYGB14KvaBQspJzwf3tIDWQVOR+o=;
  b=II1O9VFNRQOcHCsL/w0f48JhKhoRJTqEeJdngwg/Na7kQ4nLYkOACECi
   ilKYukn+Psom0+YYO8PJ19rhpQXFaotUyPOUSCo1Ew/DmtMAktjjQTDBi
   tHBid91B4gVkEt4oyIdj4CdemU+BD4rBdfyS6A9j8qwtp8+0jotjUQ0Pj
   f1THMHlRuAYOAiH8wRHJMZe2eZl8DRGAzh/9v2Qfke0eU8zCV+JZpPKWD
   BdaK+o7WzTcwZE4vGq2Y7EsTYG79a9C9WrNGTyJPskUFxXooOQm0OC6tm
   PhE6gioDWMqm5lId7p39ODu4/nIsgCKU5fmk7rdxTmsJ2VuNMMbuW2Jql
   w==;
IronPort-SDR: xIC0DV49iQWFYdiylaeSclnYJ7O8xMCv3yODySinU5kq1U7/c9Jj0Bo4gJeYvvS47pZJXzCSMi
 NTiuAvag9Z1dOQps+n8P0hDNI/rLVcvuKFu/7LMw1t+n70VM4/sQsD83ycSn5uQEsYO8DktVuh
 T9kXtUt5h67Y56AV/SUhwzuiPbJ8rlLClQSUUeN2YJWIccYF+Hh/Zkp1mkmPE2OOHGRiVr5OcG
 edRJoRDWwRq3GM0lgUqgERs6+W35x0FJT+eW7PMCjWxfmWynwQUFJSGqxNawI6rIsFLvMbxBIl
 QSk=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363422"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:32:01 +0800
IronPort-SDR: J4SwgkOV9eQjQahWWC4gEiYGLrVDi6FakzoL9Nvnct9Y/WaCEfP/W3z2moisBihtr+c5QlX//S
 RcLoZDdfeGh17nwV5II+KgxDVz1siFhmUR2H0ISbDRx7GSWtgYpijt6Z9TDL8ir2cvc0LGTzbR
 nfAhIS8VFNiPVqrLwePJoLylnmZXfBxHY8URoPOa7ytlzuoKvJXIPNA9Kd1splugBo801Fao2T
 ZNgMpC7v6sCLMwZCnx+71JR766oOGHTqyB1wVfGb6ppnOzGS6CfaxxLyvNPYnBn9nhyoxZq9qV
 seTuMXaiY0pUth7txSpiQVDq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:45 -0700
IronPort-SDR: IkIdsbhSZKPuHdzcau+I8HYTRv0Z6i43TqdcOBxrbFQIg2dRAK+XwIwHPZCCaWIRWcnwQIwRlu
 jxhmSTM4WtsB+nVQCM451wa7dcXbxEOtLgvovyXftQPcuQsP61nw3JGyS3v7hYY20UFaRgjjQh
 TUS3ZRo8snmtiV3dSCYkZHh7JaIPLx4fEtAboLjZxrOqzP3vyOIIUy+JowoMddIRCZuDuwCFs4
 z8yIvYYGHBGGhOg6GvryNuFaEnOqu8w9gRa8Msc2vE9QMl2M6aWWCrCodWNSOpIDe1t5B2bmHR
 Vjc=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:32:00 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 25/27] btrfs: enable relocation in HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:36 +0900
Message-Id: <20190808093038.4163421-26-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
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
2.22.0

