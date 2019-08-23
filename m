Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24CF9ACCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404662AbfHWKLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbfHWKLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555113; x=1598091113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nyP2IhXLDkEoP/6eGvL9pL2rjUrWDTQDi/O4CUxLhMM=;
  b=PG/PiTwAYmZYJyFPELoo1lnBI4BEhCJws1FtW8q/XKBR6v66KnQ1zW0f
   C1yOqoLDWV2De9WIv8qysgOIfPDfzs2mw4GJ4gUtvSMPZ6oApolxzr4Np
   x1tw5L+Ljdu8Prt9bzYefjGa+ZVHS/xNx1JPK20O5DbanWKEwkHPIcHw/
   xV7YFA32pBhCmuWUMUXM7IbiF2ERdk0fCHKOV7RvTxw0N5DWwRet0CITN
   MsfYXqqtt4YwnNUAG0rjrZMlgEmChFG5DgCaO9HYHfN1jTdKUEmsWoMqC
   AjYQLfSnQNEyxTairR1GbH1STBX21zEjq8OD3ksNyN9pNxBqxOZwkJMKg
   w==;
IronPort-SDR: XUdiFiH3piKKPl1YgNqwCwTBTCRM7ewkn5gWOC9igy3o+0LjS0evw6lT5Qm5ETEUNX7ArtcuED
 r8G/e5r3qZSRIs6TWdqNApRd4s5ucshTXGiOG3BKMQGwXIo+EIhllGQP8Miqo7cqDJidiXlHJD
 vzHTr95wM0sV6ThH45dbSTuLEfTng8uto8B6JAoxS//juLF37ky99x0vwh/ZlkUjcDLgKoKhjc
 wTY9XUZnt8y6Ylhe8TOEXb38jgVFIv8iUodtOzFPP+R63Clk11Nc8q1NmpQ4kuZA6UprhnD/cx
 wQA=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096267"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:53 +0800
IronPort-SDR: lSVgKL1oiTYPhuIrgGdAEUMuT0Aatu7oq09hpymO25KpnRPDavoHoAi2VgofmR3pAaCnbxMKkf
 xQZbyV6ECqXVPVJcj7yUw9Zb/gwEpXNibTdmTQGxB/e4/FnztrxJgAoAmFdFrZDig7m8vJdmjy
 qciqq8v0R9Lt69uxhfPF9corOfRWXCVCaWKuRow7+LqvYUsJIYGxEwtsNtfYADmpmka2U+XRcL
 oS0SZ+V7ZkGj092AvuVbZlkLBT3Gybv2AM+8eR2rD4K+bDno+byoFh8qZ28EJIasBPOcPDkbly
 akO4mcNGBHKu6WZoyEnfyE/z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:09:11 -0700
IronPort-SDR: k3E6vKlHWSJTn8kpTF13V7eZhyugyJJk2cl9nyOfzNei0lLhkPF0ehf5MiSA/nx+Nr6pK962iK
 7hEo/ezEq1TrKTYRYOvHrlEpNdnu6laDaGNR6H669IAz2yqNaHOg2cK4tsp4mKJ4jL+hteMKOx
 W8g1WFhFQpFbdygWzdg6At0rYOvy+K50+E4DTcNTIg5/STjsN4Qd6T1rYMq6+5lMUxchxOtFz6
 453r9uAnubqgEAGsXZLG0W589Y+ok6AitDmNw2rQ73VNQm65XX3Q4V4u0w8qbW9MPTcps4vFQe
 pLI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:51 -0700
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
Subject: [PATCH v4 21/27] btrfs: avoid async checksum/submit on HMZONED mode
Date:   Fri, 23 Aug 2019 19:10:30 +0900
Message-Id: <20190823101036.796932-22-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In HMZONED, btrfs use per-Block Group zone_io_lock to serialize the data
write IOs or use per-FS hmzoned_meta_io_lock to serialize the metadata
write IOs.

Even with these serialization, write bios sent from
{btree,btrfs}_write_cache_pages can be reordered by async checksum workers
as these workers are per CPU and not per zone.

To preserve write BIO ordering, we can disable async checksum on HMZONED.
This does not result in lower performance with HDDs as a single CPU core is
fast enough to do checksum for a single zone write stream with the maximum
possible bandwidth of the device. If multiple zones are being written
simultaneously, HDD seek overhead lowers the achievable maximum bandwidth,
resulting again in a per zone checksum serialization not affecting
performance.

Besides, this commit disable async_submit in
btrfs_submit_compressed_write() for the same reason. This part will be
unnecessary once btrfs get the "btrfs: fix cgroup writeback support"
series.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/compression.c | 5 +++--
 fs/btrfs/disk-io.c     | 2 ++
 fs/btrfs/inode.c       | 9 ++++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 60c47b417a4b..058dea5e432f 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -322,6 +322,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	struct block_device *bdev;
 	blk_status_t ret;
 	int skip_sum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
+	int async_submit = !btrfs_fs_incompat(fs_info, HMZONED);
 
 	WARN_ON(!PAGE_ALIGNED(start));
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
@@ -377,7 +378,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				BUG_ON(ret); /* -ENOMEM */
 			}
 
-			ret = btrfs_map_bio(fs_info, bio, 0, 1);
+			ret = btrfs_map_bio(fs_info, bio, 0, async_submit);
 			if (ret) {
 				bio->bi_status = ret;
 				bio_endio(bio);
@@ -408,7 +409,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
-	ret = btrfs_map_bio(fs_info, bio, 0, 1);
+	ret = btrfs_map_bio(fs_info, bio, 0, async_submit);
 	if (ret) {
 		bio->bi_status = ret;
 		bio_endio(bio);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a9632e455eb5..9bae051f9f44 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -873,6 +873,8 @@ static blk_status_t btree_submit_bio_start(void *private_data, struct bio *bio,
 static int check_async_write(struct btrfs_fs_info *fs_info,
 			     struct btrfs_inode *bi)
 {
+	if (btrfs_fs_incompat(fs_info, HMZONED))
+		return 0;
 	if (atomic_read(&bi->sync_writers))
 		return 0;
 	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 95f4ce8ac8d0..bb0ae3107e60 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2075,7 +2075,8 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 	enum btrfs_wq_endio_type metadata = BTRFS_WQ_ENDIO_DATA;
 	blk_status_t ret = 0;
 	int skip_sum;
-	int async = !atomic_read(&BTRFS_I(inode)->sync_writers);
+	int async = !atomic_read(&BTRFS_I(inode)->sync_writers) &&
+		!btrfs_fs_incompat(fs_info, HMZONED);
 
 	skip_sum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
 
@@ -8383,7 +8384,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 
 	/* Check btrfs_submit_bio_hook() for rules about async submit. */
 	if (async_submit)
-		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers);
+		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers) &&
+			!btrfs_fs_incompat(fs_info, HMZONED);
 
 	if (!write) {
 		ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
@@ -8448,7 +8450,8 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	}
 
 	/* async crcs make it difficult to collect full stripe writes. */
-	if (btrfs_data_alloc_profile(fs_info) & BTRFS_BLOCK_GROUP_RAID56_MASK)
+	if (btrfs_data_alloc_profile(fs_info) & BTRFS_BLOCK_GROUP_RAID56_MASK ||
+	    btrfs_fs_incompat(fs_info, HMZONED))
 		async_submit = 0;
 	else
 		async_submit = 1;
-- 
2.23.0

