Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF09511DCF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbfLMELY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:24 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11924 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbfLMELX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210284; x=1607746284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gv9q0DDDj86eEUSslQJev/ik3Quaqy64bmbJlpcYfcY=;
  b=W85iN9wOurXKPLWnqgHJpAEfy5HZBpRyM3q4uUCw8zQxWbOHQI2cSdPZ
   hdBsyBYoffQTrNL4AdrAK1TGIZmVMv72NKVeOkOD25ifv8k3tKiCG50Jg
   KTI3APCOhRLBb8OCGDAxDYkogtsl+ozPQ0Nzj4GSLqdeSLpWvLV5mBYPC
   xxFIiz62Vi+TdvFBxA0JNA1dnY2KCz7Z4QpZAS9zi9XAbftdQZrocorzC
   BiVyix1seb3sQXe5KJZqnfm8gfCtlS/CdjavpWlziyZOycrkktKP8mWaV
   eqQcq0JoaN7+6Xg5i1fP6RkWPy0NTS/pCDQEpwSfX8VQfnulftWv6FhuQ
   w==;
IronPort-SDR: 6KCi3Ex+KJvxLAQSA65i0IbhLPslAAYIr9Is1C8vr6aRQRwkmiHHuOIUnQzbETkrjP+ZZKKcxz
 SwrCaFy9RS8hLcPTydiI2rGLx8ywCOiYiBNOYzdtfNuvpLH0nTNpv/CN1+ApkwKctbARXjFuvx
 mqLpitQlHsyywdY4Vk7KT/cpJ/eZXBM3y6HAn0q15dz31f5yt/OYaJa+BryoazPoOowc5pq5ig
 618uLIUaZCj8h6ilHKBbSnsOEeWWdau2zNH9o2R9WscLBMFgrTEyiiWbfn2sfGxbNn0IUkma9A
 DdI=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860153"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:24 +0800
IronPort-SDR: yfjbylusxPpA9bhf7wDYEYuLAlrJ3wmWO0T6zX+WRuVpRt5hDWdNyT75CLPq+P63VVm9HRUlI9
 0I/Fvl27aFmQZdPlm+B8XQq+2USfi3TVU4LCXhPDKfUBagWEFq7iGwaXMSmp+bp7iiSM4uOomI
 FexhGwrmLFpnFtIQrSyRWRAW15GmXfK6Ozge0X54/2uOnm228V2Kz+BBih+pQYhOmesHbznbFe
 goM8PnmJlCDQQ8S4jW+oCp4mSWlItYisC9ecrsLiENmHAgbYXV+A8xhTrkHrDZYCNh+XVJhIGu
 DppREmfVP++Zv6Q9Y5AyG03i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:55 -0800
IronPort-SDR: nR7bSYGrpYzRhq/dvqqmE/2hol6O0UXdk9VUWBOAhZl07KqzF79lYJ1Gb+ydmFiYNVpGS8kmvC
 ox16BOvvtqfP6t30uJTRuk+Q7Qdi1ZZoui25OOoDrAt4jE1Uf8k+cYex0UoQ7n3o0r2llBML6V
 /OwF6nAM27isDBX/CNHk8zbjJhqg1/vnFgz9p5PcmWSaPr+DLlyCjetWVqppi6RUDQbk4Er1Z+
 v/ZTn4v9zc5+MpVeGX+oqFmLXfrDj0G9hZl34QH5M9gZ7hVZJTnEgAinG+pUA1jcCaPdk/qKrt
 ov4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:21 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 20/28] btrfs: avoid async checksum on HMZONED mode
Date:   Fri, 13 Dec 2019 13:09:07 +0900
Message-Id: <20191213040915.3502922-21-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 2 ++
 fs/btrfs/inode.c   | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4abadd9317d1..c3d8fc10d11d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -882,6 +882,8 @@ static blk_status_t btree_submit_bio_start(void *private_data, struct bio *bio,
 static int check_async_write(struct btrfs_fs_info *fs_info,
 			     struct btrfs_inode *bi)
 {
+	if (btrfs_fs_incompat(fs_info, HMZONED))
+		return 0;
 	if (atomic_read(&bi->sync_writers))
 		return 0;
 	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e7fc217be095..bd3384200fc9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2166,7 +2166,8 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 	enum btrfs_wq_endio_type metadata = BTRFS_WQ_ENDIO_DATA;
 	blk_status_t ret = 0;
 	int skip_sum;
-	int async = !atomic_read(&BTRFS_I(inode)->sync_writers);
+	int async = !atomic_read(&BTRFS_I(inode)->sync_writers) &&
+		!btrfs_fs_incompat(fs_info, HMZONED);
 
 	skip_sum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
 
@@ -8457,7 +8458,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 
 	/* Check btrfs_submit_bio_hook() for rules about async submit. */
 	if (async_submit)
-		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers);
+		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers) &&
+			!btrfs_fs_incompat(fs_info, HMZONED);
 
 	if (!write) {
 		ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
@@ -8522,7 +8524,8 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	}
 
 	/* async crcs make it difficult to collect full stripe writes. */
-	if (btrfs_data_alloc_profile(fs_info) & BTRFS_BLOCK_GROUP_RAID56_MASK)
+	if (btrfs_data_alloc_profile(fs_info) & BTRFS_BLOCK_GROUP_RAID56_MASK ||
+	    btrfs_fs_incompat(fs_info, HMZONED))
 		async_submit = 0;
 	else
 		async_submit = 1;
-- 
2.24.0

