Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93C2112474
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfLDIUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:20:03 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfLDIUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447602; x=1606983602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fQova5fCa+QqHXMFjuyqIKWvJWmoO6qkos/hzGf3o5o=;
  b=ApLqcywEDS9U6KVTmu9khC7jBaBbrvcqc92Ox3O+izABcGv2LLAfQLHW
   TRbk2om/kpMUYTUADcuXOPfw8FTWnHVM62UkydifBKw0d/kkoiUpSIFl4
   ufeGk9lYJGErEx43MM4hztplum8pBYKdkLIQWPD34rxLX2ZenPjhklodx
   oHNAaTT9xjuOzCnzT31ZZ38ycgu2blSPeomjS32yDcWxZqDjBvWrmmxTW
   7tBabot/6XuDWzwlLwmrrE8HzVJdWlUuQfcRKrfa4gypiI5apbmgf5J78
   moyovRXekvG4d7zkRJpRp4kzj4vsZ2trMpzXP5bgq0zd8F8lsuO1ethFM
   g==;
IronPort-SDR: SGagtC+HhGAQz6Dajnczk3XWpM1yt2cvMHiivQuBJeFCnfLEL3OZHPQkBh3xlEGO39Wf+ChFOJ
 QulOqV6sNEg27zBjivQOGA1SfDct9/ZDgltGHKRkU0603cWec3EpWyPAei90lpcuza/PyMiKo2
 bPdOoK/wMpMwbhLnlIXavQwh4A0ly8Usd2VAlZHH88SN7j4Mbu9K5QR7LMWn52V9S3TBE2B2Af
 sK+zWbM49P8z4vgRD0YqEKVtkMGDgmjDVOcMXb7LrN1/aSumWasKww0DUi3UV+2MnbTcFWaLkX
 OuQ=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355095"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:20:02 +0800
IronPort-SDR: 8vGOsrbZbrkzpIuHXp67OxFdgCXwbWHmkn2gc0a8qxP2diiAi8CwTVgRYIN7R2YxfiTwNKezw5
 kTB7utmJdgmE2Hqpo6LjwSowazB8ogcc+X5CfIyGS5hccKpjJgrpiAgVepJ1HzGEfDfI7DMjNV
 GjOI0WWhUlgDcaxHNuexz43P294YENWxSUUyhEV7PyDEXQz4HLf5xGbHjg36fD9/Y9jvusC4m1
 4HuJIilrR9xXb8F7jzqU0WQHHvYi+WDn+mQZGQIQtmVbq1EXfFjqeyVQtHmg/3yOTLTOCV23RQ
 DdYf4wRT0MryZpiB5AJVuZAE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:27 -0800
IronPort-SDR: 4J396UrE7jBEbzgc5Gr8/NsLrROGqFVn2R10gVdvWHd4KRu8eqGdl2P9vGh0wHGREohIGDN6Ah
 8JcAoDKqzqELIM9iBOa6cmjI5f9cKwQAtfXMJc4EDQ2eC4StTESQpaINcx0jMiLwSpGuoiESaZ
 9WjxQRXarBR84xAN8CrBtvl0MisRtC0zDR0F4iop5/zsIDKYwL/Lm6c+kls+fbO3ozXB6JsCL/
 0GmAcQzH6z+QH2D/kmRRP/tFGLKR6UEphbTm/PJxDQQPn5seWVe7qppiyFbxMjtXJwToaEXBht
 6pc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:59 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 17/28] btrfs: support direct write IO in HMZONED
Date:   Wed,  4 Dec 2019 17:17:24 +0900
Message-Id: <20191204081735.852438-18-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As same as with other IO submission, we must unlock a block group for the
next allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e09089e24a8f..44658590c6e8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -60,6 +60,7 @@ struct btrfs_dio_data {
 	u64 reserve;
 	u64 unsubmitted_oe_range_start;
 	u64 unsubmitted_oe_range_end;
+	u64 alloc_end;
 	int overwrite;
 };
 
@@ -7787,6 +7788,12 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		}
 	}
 
+	if (dio_data->alloc_end) {
+		btrfs_hmzoned_data_io_unlock_logical(fs_info,
+						     dio_data->alloc_end - 1);
+		dio_data->alloc_end = 0;
+	}
+
 	/* this will cow the extent */
 	len = bh_result->b_size;
 	free_extent_map(em);
@@ -7818,6 +7825,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	WARN_ON(dio_data->reserve < len);
 	dio_data->reserve -= len;
 	dio_data->unsubmitted_oe_range_end = start + len;
+	dio_data->alloc_end = em->block_start + (start - em->start) + len;
 	current->journal_info = dio_data;
 out:
 	return ret;
@@ -8585,6 +8593,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	struct btrfs_io_bio *io_bio;
 	bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
 	int ret = 0;
+	u64 disk_bytenr, len;
 
 	bio = btrfs_bio_clone(dio_bio);
 
@@ -8628,7 +8637,18 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 			dio_data->unsubmitted_oe_range_end;
 	}
 
+	disk_bytenr = dip->disk_bytenr;
+	len = dip->bytes;
 	ret = btrfs_submit_direct_hook(dip);
+	if (write) {
+		struct btrfs_dio_data *dio_data = current->journal_info;
+
+		if (disk_bytenr + len == dio_data->alloc_end) {
+			btrfs_hmzoned_data_io_unlock_logical(
+				btrfs_sb(inode->i_sb), disk_bytenr);
+			dio_data->alloc_end = 0;
+		}
+	}
 	if (!ret)
 		return;
 
@@ -8804,6 +8824,11 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			btrfs_delalloc_release_space(inode, data_reserved,
 					offset, count - (size_t)ret, true);
 		btrfs_delalloc_release_extents(BTRFS_I(inode), count);
+		if (dio_data.alloc_end) {
+			pr_info("unlock final direct %llu", dio_data.alloc_end);
+			btrfs_hmzoned_data_io_unlock_logical(
+				fs_info, dio_data.alloc_end - 1);
+		}
 	}
 out:
 	if (wakeup)
-- 
2.24.0

