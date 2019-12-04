Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F7011247A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfLDIUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:20:11 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfLDIUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447609; x=1606983609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gv9q0DDDj86eEUSslQJev/ik3Quaqy64bmbJlpcYfcY=;
  b=Tpf884GXdIh3ncZQ1PY/thhFyx7Lw1YdAUeDt+zNm4ywGjjV4wZ4K/Bj
   0a4Kdp8xJcCtVfM1PQKEbsf9O04zkoyrd+EdWWJgm4JmZC0TqzK9zQix3
   gEPkFYzyCQL//TrLuqWhv3YbsrGFpCVReTqELomiWmGb4SPq0WBgYbqcb
   QnZOIKJVjI0UlDJ+0R3chtpWO2M0Ey9zAztjR0ek9HW7BeuRdAsEqPeP1
   wgebhsvxEStVAN5hVp0XVKC1xSMOGPjrpXNJ0d0fxYgL3QPpJRmkhB541
   cndGbR6D8lgLuu4KVeVfIURLqguHOvjxv24YB5wK01BMwdWz5EYN7GeMb
   w==;
IronPort-SDR: xVQrUn/3icwv1zCIjgJkhafzza5StsCy1gEUX9Y8cCp3wqKnrur/sVq0tdwWT7h8JCIQgdsjKH
 rQONtpqda5iIqZ6R+iXcgWiUfEo8/ITHRcSremhb0L0CHRrFfWEL1KSCNN/WfFPtraTWZkUj26
 HYM+QrjGNNCGe8qiklI0+fipuIePiwGvn9UIvUUX0PjnNPFK+TPL8ctDKTdbwn13hv+2DDrIZg
 T5YIkjXhu8uCapH0p7R/izWuXce8aw3kkB1D9TbS5M2VXWD2napza+kUR3tYlHHW/XXJ1AOpCF
 XJ4=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355105"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:20:09 +0800
IronPort-SDR: bFgcRCFJoh6ooYnyEurHJdHf68ZvToX8rIPf8U9DSQciTlvlpti7KPnBi+uDG73mecHRiB9X/J
 ARa0DQgTEjQ4Xc94hDKueqV6YQHquKdGEsK8FUDFqmzw6CfnbsNqVwGCTWUp0+46+mDfKf4ajz
 +GzYwIxEIEbDQWRobmuVmtuyEfBwIncnFQtUQV+fCmnfc6/TX3oM+TKPq6wVjWRXM4uxKw10ul
 2llC2asojWqxnuhRx4ixdNhg641Gsrrj1kcbv0DzLPrKYcZfdZS6txz2blPhqkhgCBreOAGrf2
 I6na0G+9fu0I1Khrg9dFpQag
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:34 -0800
IronPort-SDR: AcczeqZZEo03vX9756H6qTsbPoG3QSUh2nWNfMfqZ8kKzybnc+Zwp2BApQFTRADGRhruBFBM0r
 AIEljy1oE1JviZp98m/I4N7DnjJ3ugvFe84AZvIoijLVnIO/fhoOFGptZ5su7hnw2/HO4OGZYk
 ME81HakcpF+ZDmD/hQrLTvh9CHPvkoHnY/o3PWWxtyID0RDFCsXsnc7xtvDKJQMw4j6ocpWDeV
 nPGjoIydZ2yXDMI0CilLpbEya17fGvgLwMe4Av0DBioG0QGF6akaR3neVpa5LifDZ/lYtX4tVT
 WnQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:20:06 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 20/28] btrfs: avoid async checksum on HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:27 +0900
Message-Id: <20191204081735.852438-21-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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

