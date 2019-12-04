Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48274112482
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLDIUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:20:19 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32819 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfLDIUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447619; x=1606983619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xc6PNKHNLMT6cFXODCW5lJKtVCDGPT+JT7Ud3tXcFaQ=;
  b=JIohd1YgL0p1Cz+6wbYEa8hpZghI+6UbSIdizHe6pgByl04JAcF3eU7K
   EO3eiAmDAxtNhRO08czgv7/hiacwEkg9s4vIwxSTJDU+6T+to8l7p9VoQ
   2Wu8eSqOlE7IgqnIOT0tCBoNTwNwJwj4ugrw5hCc1JoCfeba/6s03x0lU
   ke+o9pMpc31pf1C0WENVRzuBEVmV3uwMY/SpkxlCRpgnUSA7foKb3FQI6
   krmc1GmU/mGJVq/gK7bDY6ttNUTF5MP8GgfUkEwM5OQC6jd/bY4oH+3ZZ
   jRPonkMWhxAxxJVqaZ4Rz6uZkPYIVI75KzvffiToIJDcpxJhk1z7AzxA7
   A==;
IronPort-SDR: Rvqr1H5AQh8hOB7AsX/xT8BeZmmJpfCvUiHHh4VEdCMGV0KGFVCrUZLghbPazuXxBon/ZbiDiL
 RsVHeYAoJcZb3KLEKgYqJ3kMLwr+/y945wWoY1zhiurl/6vnroW4FkSqeVDoOLUsQDkn4HPYgc
 OVlS+EhaNBAU9selhTYHxvds4CvZjA1oBYsHguEOh+24DVKtw7/2SbxAF8xxxxeOK8ju1QVvpb
 Ja2rYhIfI6EjuWp45X9bmSFm810XdkBPt9nJ08/n19gOon4qqlFhVPMtkF/PXhpe18qKHZL57a
 ymk=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355118"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:20:18 +0800
IronPort-SDR: UyILqiuiOyK0aDvb1ySDIgQ5Pi+6pNj4o3WVdP7LHehII0NZsKyKfPYRNtnVQPCe8BjzgX+TYN
 HoHuIJ2ogVHhTYRhE6hlV1PPWHfReuzJsK+3XfUzAx2wYYhr1huTySufm8Wcs3MEeB0VROyboj
 FgWRpXID2UTUD/1nM4bSoW9tdGgtiYI9NGi1E+KiDy2bYZBweGt1QKOn2B0KxE9sfLWNemtr1E
 aB6GaC6pfh5+Owt5tJ0jKjnhnZGT6CDztm7wSRdOHmXh3hz6HiqRi9rtiwdZe/BfWL3+7/nN9K
 5XhLOAqQTVtZAPqPQKlazCsf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:43 -0800
IronPort-SDR: aUg11jJ6vl3zroLC7+mYWqen82Kj/Q86rVCNmnK1ltzEDDWYsvHbOrJDsUwVF/jOno6P7I9tsv
 nNvR/YQXWWmlHqfy9UApKTAcLj/wFeQQK9H6zrZ9x8VIisguGUmPiZvhVBf01JASW5PV43ZhV/
 Hovt+c1kGBgBBaU9m59OeoS93uCHTnO41A5xfl+kSLoTyFg8q35QuQAMA+ETx6Y1c4q6T/sxe8
 zSXqJABMtKcXn768SmLIsAqKjyQJSTu3TCbtvXJxkWxy3eOlJU3iypZPjHZ7tHwK8VmAAofZ/d
 +oU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:20:15 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 24/28] btrfs: enable relocation in HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:31 +0900
Message-Id: <20191204081735.852438-25-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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
index d897a8e5e430..2d17b7566df4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3159,6 +3159,34 @@ int prealloc_file_extent_cluster(struct inode *inode,
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
@@ -3346,6 +3374,10 @@ static int relocate_file_extent_cluster(struct inode *inode,
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
@@ -4186,8 +4218,12 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
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
@@ -4202,8 +4238,7 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
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
2.24.0

