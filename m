Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD3C11DCED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbfLMELR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:17 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11924 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731971AbfLMELR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210277; x=1607746277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fQova5fCa+QqHXMFjuyqIKWvJWmoO6qkos/hzGf3o5o=;
  b=qh0jhjKHeb8RYe8SmIhACutAxSGXV0ZiTw9ZO9ECho5Z5+4MIyFKa85I
   YRQrrQZsnkcuN0v5zqTVqtAZc0bmMVKm+ZNvwFurR0HGoe8K6O3IL59lQ
   ipG+z8ZF8H9+WsMjIeduN5PCyrBPkPrKzm8dAlutTPyp2r6uPHY6AT8JO
   3erD2KkamMNNDF7SUJKr+3R4p90CR/euH5/NnAM/3p2fCE5ZfdHcSNY4p
   VZVM8ckURBDkrasDmqfOua3nLkX7rSNoqqnV2MaJ9bQJ815iK5EupfWH9
   f4JFf1+3KUvukRULa9rjsoeS+fbnd3GLLauMHJEdQpUp1mNj2/Pc+3DB+
   w==;
IronPort-SDR: ThUhEaG50kX/ds2LUXzpvL4DRimjUhgca7el/DFogAv0mLaruBKn+1/2yfAPc2zi5ux7En25+w
 6wVKQMzqF2SCUNBoV/XFj81hoWl2umZDR6UVPF0AzZmjD1vDYYerycUvxnipmKUcUyQnL7dSK8
 zQ74j5IW0Yu+3M8P3zRsgLweujqIVTWIEH8O5q6rwqdCgzSnmYuBDOumawMssKJMDd93xLN5yZ
 zAZ8eguWJme/ke4aSfbAVomziNldQqxBZS6sEZuaVwMaBR2J6Yhgi83z3WXJv5NsWBvr7IqvS2
 D60=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860146"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:17 +0800
IronPort-SDR: xCP7X9kFCtLqOsBIwe85z8OhsKmo/pqJJ6URQtJqHVgfglyGv/2A/EAZhnQ0kfJ/vkSGPGaHyp
 gS3Xc4sv0daqti9hO3qAzcZ1RgaDWfzAsn/sDoXbhBj5mVOIVAQGW+giNE0tpP9ucTJiL4ITNO
 ZUrC51R577QBfQ070PhoCLpmHhaf6Zrcwh+Gd+YIM0KfFQJ3T+PyAU3Qcrket/A+ekvZ1uNMss
 njj0L0SRlDXx8/emjvaYJa+kwRC0xiG6FLMUVI5Ur3cklyOIIEFogB1i6cFriVbsQQ19fIZBYt
 wACApE8KJ6o0hNsfI/pLtNJH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:48 -0800
IronPort-SDR: rnRhJ4NoLFXX3L7L5JERYqxmfnaMjGqDTM+1XzJ+7cT8hyxMqLcFqmphHcHul1XmMyHE9thNF7
 iPCd+O/ikwQrn7gN2ZNaQEIXBgrGtmymUghfHceOO29Z+qqCjQMbqTLzyxbXHNc53t5bCVJGKH
 uRWAdR22sbFgO+uNRNi/Qifs7NmyDLGddLZ09KY19JjP4spk72svQ97J1SzJThiztZCGuIxGWG
 jpYO7f9Zr4Ofm+q80o3aBwuzZdCkDlYWn2yIpZ8kwNlp0u9C5nOghNe9Qs9SPO6mtWL3N1CydL
 Zs4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:14 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 17/28] btrfs: support direct write IO in HMZONED
Date:   Fri, 13 Dec 2019 13:09:04 +0900
Message-Id: <20191213040915.3502922-18-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
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

