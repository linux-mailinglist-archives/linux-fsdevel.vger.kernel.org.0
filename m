Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6144685E78
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfHHJbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59666 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732443AbfHHJby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256713; x=1596792713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6qSbdTxWdz4jPmP4l08UWJ2wxWWR037KJ+Tc0/MK7LE=;
  b=ckXLDopBidI/eTABtZDN5Kv4PNJMs4riRJ1onlWDGP020b6sBBOshqYR
   lRWW/L70fEWs4JDMhqhAqiU1F4EJjhVPkRf6PU6phW+jGdtcy3y+nJ/8g
   jB0VCkGtk+KLSphPAZ5mm9a8tMGhqPh1Bzyngx7Faz+Q0rfD83RfdyA/g
   v4gYFpcDYim1OT6xgYn8Z4bQhl3TmbXKLKHaQ8Bp9no3I64pM4F38rVPx
   0lTlSB2+97hrNo51iJ670Dwv/f2WcYiMy5+UCG3dihqkDW8LWYzSMgVkN
   xBN/IN/xgOmj15WXacnZJGCT3qT4rMty4lnAaoL0AI3RlN8yKEkSV53FZ
   Q==;
IronPort-SDR: sAEcKPOwhOpPD3TKi0yz42aOcdu0TcYmsqd2TVp+5/vkcif34cuuk4IWiNBOMl4ltF9kwprWlu
 XreJ2AyzhckaLqOjRrVsT1D3YrCGds82Bu4GVdD7Oj44GaXT1/dzod1Ox7PT2WafvQ6MsR21iT
 SHYrfFBfGbMVxJ5rtJ5e0emlX7xhqSCWvL4d2JF89iZWHNJiblIKDbrbLzxfP2RofjKereqaVF
 hqSoW5T/klmFHoZeK7ch9h2iWi8TY2eHsuefP+oKV2/ULqT0mrMAK7v89mtWS+R4Eub7C1T4/s
 NPo=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363406"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:53 +0800
IronPort-SDR: Ip/neW9unGANmBZN0rcVOSs8DsRv34+81m1SbZqwSX3nxJPISlCSrKjTDCbrE98gSUlJ7lyOLw
 Ep2+NRmGE5CpRfjFzfdA9O8c7CssGOMjy13Un/x/LNzW8AnY/GMQO4bBjfUEhCGyJV9J0oT8H7
 f4pqgtCvdc2hmNeM3im8JqsPioqqhWmnRkihzvMIt2MVFmZM0LGyO0g2Jo8hiu8kgAsfWIYdVi
 KaPqu/YTkc0ZapzCiPLsooGIIMQditL7YKSBmzqweKEjpcyWEh/dq5gpwPZO2uT8jFuHvpMf3a
 nJV2qquIAUCCgvg9nPQ3qfAM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:37 -0700
IronPort-SDR: fSF3l/pMF5ycW0YuQxoDgtIamqZFRIj5lXbShNPLHrz2mWoFeMoRXDtqCX+49TgHcjYnSNCYa7
 HjhICeZblC2XIRsaLT8OrvIN6yLjXr4GiQKdxlEMv7LDkMZrwagDHJfkpYkkHurE9ZqH+NUbSg
 NTZ0cNQ+Mq+XgbIKOXZM3jYowCX7Af7lNeWPAt+pCsdQJ1ZaAD24YxVWuiYjbjaKnl8nRBif+E
 ACbLyUp31PmQaRsMRPFM6hOmeDqmL+Ap4L1g3ALStHMHg7X/auQITtTJS7MXJhP0xapn+vr3Sn
 LSM=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:52 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 21/27] btrfs: avoid async checksum/submit on HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:32 +0900
Message-Id: <20190808093038.4163421-22-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
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
index 63dd4670aba6..a8d7e81ccad1 100644
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
2.22.0

