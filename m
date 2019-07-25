Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7620749F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 11:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390566AbfGYJeD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 05:34:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41402 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390557AbfGYJeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564047242; x=1595583242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qUsOCDuXs+5QzRo+S0HO5zYWPQstgieQYtuT5P7Orqw=;
  b=hy2/1u074YF68Rm1gNfcBwUwAvvm/UNzIW5b1k/SUBt06NGV+NIkt2JF
   tHL1//vwza1yG+5LI2RdqRB+RVHluSEqTjmFNoeR2N59JHlaVGtR96de3
   NXBb5QzAEGhKY8s0DHP0QdvNPmStExlcdY5+vZfC6+31FZ0EtLo9d71LA
   gZX28BFa4sG7A1TgSAcF590vHm95Ev2MlYerFY9ZYmd3WzDBuJWgEvPuM
   HPj+sjqVozfT+x+fDrLeaZ2juR2qmnbhOZU2TiEPhrHE0oI46Iqv8WAfe
   TJadCR+hB2zeE7ouiEL36xjiE1YDoL+r7qnv76tk4Db/vb6j/NzW2995T
   w==;
IronPort-SDR: PMG0JJBjX/CfWnbE0QqzMgCTkv6PFW2++Y5gvRHYQ7arRsm+wzDiD6x9PagPsa02BnIfnkQPIy
 xvKJWbHPWSrFSamrrhKWfI2+hds+My9y9+O1S+3mS6ZOvkfg4X9TJJfwr3bAVvzi7T9dasKlK+
 F84aKk9+ZdnzcCAUmFEgwP7HESlf1RlaguLizDBX2uALnCe4uLnvOVxtGIo/z5wxjakaLac2q1
 gDdkKDrAY9zxZwWm6AZJSuSyZjoPa6DSJJZfFmQBSP5Qkmy2goXeQZk7qvxJZWli0SuEMzN3Wy
 gz4=
X-IronPort-AV: E=Sophos;i="5.64,306,1559491200"; 
   d="scan'208";a="118718899"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2019 17:34:01 +0800
IronPort-SDR: vlqaeLX+7jKxqVgCDzdeJX8wPBYOLwoAr2f6LfQ4alFHWias5mfJ+6P3Om3fQhxWb1LZv4/dN9
 vJHgw5LrbfNJpaTpOL3VtMzp5cuSVUkQN/vU1myiP4oso3Kj4OqvxFGUFTQuDndR6d1RZh5oRw
 NbM4VpMqSaIVyE36xx6nE7OVwR2XZSUj2TFt60YS+F8ejVTerpOWjOMw2LA0qQUuo7kw8AdnLS
 BzshEW6gk9sbkRskYOP8nM+LPU4L5SQ11b9y/NW5hXTSsbTS5apkuy2Md1DCS3p5lQ3vKos65c
 ja2WKrEpcb1o8MrLTdeiAK7z
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 25 Jul 2019 02:32:12 -0700
IronPort-SDR: BQxM+7SVLejzr93XUQnPHDQSzbG+QoRfGmF1y+cm/KleY1GKgyyFrSB+rF2y30+rWl0T1cwvMp
 Ym5toaQOA0gk9hLQF6d07+ugBsqTMxEP0MoF4BwotEltBsGC9CX2icOVxmaPC1ZHXwL/sSFZQa
 7dk4sXgNkfwAia1VA6mcnugJq/HfCADnd5gSK0oHCjooguJT4JX7N/EH4Hfb9ohC9Z/Ttfe05T
 /piWp/+msz7NaEj26WsJNDMHxNVt1FsOa4ynoC8tYODKdRNrxxblSrUIa+ATM7n+T/1ZUdHy+E
 V6o=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jul 2019 02:33:59 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
Subject: [PATCH] ext4: Fix deadlock on page reclaim
Date:   Thu, 25 Jul 2019 18:33:58 +0900
Message-Id: <20190725093358.30679-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In ext4_[da_]write_begin(), grab_cache_page_write_begin() is being
called without GFP_NOFS set for the context. This is considered adequate
as any eventual memory reclaim triggered by a page allocation is being
done before the transaction handle for the write operation is started.

However, with the following setup:

* fo creating and writing files on XFS
* XFS file system on top of dm-zoned target device
* dm-zoned target created on tcmu-runner emulated ZBC disk
* emulated ZBC disk backend file on ext4
* ext4 file system on regular SATA SSD

A deadlock was observed under the heavy file write workload generated
using fio. The deadlock is clearly apparent from the backtrace of the
tcmu-runner handler task backtrace:

tcmu-runner call Trace:
wait_for_completion+0x12c/0x170		<-- deadlock (see below text)
xfs_buf_iowait+0x39/0x1c0 [xfs]
__xfs_buf_submit+0x118/0x2e0 [xfs]	<-- XFS issues writes to
				            dm-zoned device, which in
					    turn will issue writes to
					    the emulated ZBC device
					    handled by tcmu-runner.
xfs_bwrite+0x25/0x60 [xfs]
xfs_reclaim_inode+0x303/0x330 [xfs]
xfs_reclaim_inodes_ag+0x223/0x450 [xfs]
xfs_reclaim_inodes_nr+0x31/0x40 [xfs]	<-- Absence of GFP_NOFS allows
					    reclaim to call in XFS
					    reclaim for the XFS file
					    system on the emulated
					    device
super_cache_scan+0x153/0x1a0
do_shrink_slab+0x17b/0x3c0
shrink_slab+0x170/0x2c0
shrink_node+0x1d6/0x4a0
do_try_to_free_pages+0xdb/0x3c0
try_to_free_pages+0x112/0x2e0		<-- Page reclaim triggers
__alloc_pages_slowpath+0x422/0x1020
__alloc_pages_nodemask+0x37f/0x400
pagecache_get_page+0xb4/0x390
grab_cache_page_write_begin+0x1d/0x40
ext4_da_write_begin+0xd6/0x530
generic_perform_write+0xc2/0x1e0
__generic_file_write_iter+0xf9/0x1d0
ext4_file_write_iter+0xc6/0x3b0
new_sync_write+0x12d/0x1d0
vfs_write+0xdb/0x1d0
ksys_pwrite64+0x65/0xa0		<-- tcmu-runner ZBC handler writes to
				    the backend file in response to
				    dm-zoned target write IO

When XFS reclaim issues write IOs to the dm-zoned target device,
dm-zoned issue write IOs to the tcmu-runner emulated device. However,
the tcmu ZBC handler is singled threaded and blocked waiting for the
completion of the started pwrite() call and so does not process the
newly issued write IOs necessary to complete page reclaim. The system
is in a deadlocked state. This problem is 100% reproducible, the
deadlock happening after fio running for a few minutes.

A similar deadlock was also observed for read operations into the ext4
backend file on page cache miss trigering a page allocation and page
reclaim. Switching the tcmu emulated ZBC disk backend file from an ext4
file to an XFS file, none of these deadlocks are observed.

Fix this problem by removing __GFP_FS from ext4 inode mapping gfp_mask.
The code used for this fix is borrowed from XFS xfs_setup_inode(). The
inode mapping gfp_mask initialization is added to ext4_set_aops().

Reported-by: Masato Suzuki <masato.suzuki@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/ext4/inode.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 420fe3deed39..f882929037df 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1292,8 +1292,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	 * grab_cache_page_write_begin() can take a long time if the
 	 * system is thrashing due to memory pressure, or if the page
 	 * is being written back.  So grab it first before we start
-	 * the transaction handle.  This also allows us to allocate
-	 * the page (if needed) without using GFP_NOFS.
+	 * the transaction handle.
 	 */
 retry_grab:
 	page = grab_cache_page_write_begin(mapping, index, flags);
@@ -3084,8 +3083,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	 * grab_cache_page_write_begin() can take a long time if the
 	 * system is thrashing due to memory pressure, or if the page
 	 * is being written back.  So grab it first before we start
-	 * the transaction handle.  This also allows us to allocate
-	 * the page (if needed) without using GFP_NOFS.
+	 * the transaction handle.
 	 */
 retry_grab:
 	page = grab_cache_page_write_begin(mapping, index, flags);
@@ -4003,6 +4001,8 @@ static const struct address_space_operations ext4_dax_aops = {
 
 void ext4_set_aops(struct inode *inode)
 {
+	gfp_t gfp_mask;
+
 	switch (ext4_inode_journal_mode(inode)) {
 	case EXT4_INODE_ORDERED_DATA_MODE:
 	case EXT4_INODE_WRITEBACK_DATA_MODE:
@@ -4019,6 +4019,14 @@ void ext4_set_aops(struct inode *inode)
 		inode->i_mapping->a_ops = &ext4_da_aops;
 	else
 		inode->i_mapping->a_ops = &ext4_aops;
+
+	/*
+	 * Ensure all page cache allocations are done from GFP_NOFS context to
+	 * prevent direct reclaim recursion back into the filesystem and blowing
+	 * stacks or deadlocking.
+	 */
+	gfp_mask = mapping_gfp_mask(inode->i_mapping);
+	mapping_set_gfp_mask(inode->i_mapping, (gfp_mask & ~(__GFP_FS)));
 }
 
 static int __ext4_block_zero_page_range(handle_t *handle,
-- 
2.21.0

