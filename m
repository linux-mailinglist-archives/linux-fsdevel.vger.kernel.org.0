Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E5F2F734D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbhAOG7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:59:37 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41647 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbhAOG7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693976; x=1642229976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x0qh581EhEV9VljJVg6uXrojD8Nw39aN75ASM6rP5PU=;
  b=mSkvjN1gKoyAS2/BAjQ+NSmwaqhg5yPKc7O9V+mhb6BBx4qSAd0NiIbk
   +U59OeGwxtJgbuoBlfm2WkoxIFepZaESGlNryKOGACgGufmacIZWW1oKC
   9/pHFdoAbnUENAVJ9LbHp4nH/V40slRh8HImsopwNynBgSpY161yGem0y
   lKZQPv5lgq6aJJ4dEv6WEXnVj/a5pldfFGJujaikfudiGFXIAKR+xVFWm
   KG3fNRGm4+iCEPQXxxj2jqZVspc3fzQh2ncFHd3yvbtxOwypp+xB/vKkG
   5fBjLcUA+Z45prWzn1/Pc94xzIDN3pbV9xXK02rogGzSdMQoT9IJWffvb
   Q==;
IronPort-SDR: USn2lDRyIUZ1P039pcafPaQU2vcx4zNxUnEtj/KmxGHqrECLsbwhpHxV7JJNd8AIVDFWgzaTY8
 FZ/mUHNg8NykWA+eQWFDUsQsngjFYWLfvr/7HhsILprGX9IQH39ncrvC3Nr52wZLimVabxOlAp
 9dv3Vgv1g2QjMoP+sDGcGIhrIhLioDxoIeXgi5IkJ6FGemb13xSi1pAP1+WTScwsF3H/nJiVBs
 cfW5eX05Q/2t9r95VldvngB7JGy1DefVbNBLN7D1xAMQw9ffrlExfwMFhmq67mFHGgeufWoBF2
 Fc8=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928284"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:59 +0800
IronPort-SDR: 2w43JGyLMiEDdH5WVYAXTYkzPlwcTpE5Zd3hw8uo5TJ0Vf9VixGWuAjEdegf9yEnqOdz4ymDpx
 QeE6JmfrYOcnhyrKtd5eqhbVjbQ+NohCVQamgm1K6BPtbNjbACvzBwiRXc2rVTIpvS6gK2M5SF
 5R2NcHmjbXRHEt/oCAiZcdpCgq8sQxuefkAXKmgi3x7h1PuMYjLI8K523xt5NZ5qjECEM8dUzN
 PvA0i5R3WN+ZvJM9ZjFq5ZrA+c5pMO5yoQ9bTNJYDCO0kbK5q4H+MTlHBD7Qgwe/EzN/YyVRl2
 mO/IMCvdCpxntDhO6b/1MNOj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:41 -0800
IronPort-SDR: WAcpIRnSv+pgoqsgM3zM18sV8pkMh8UJ1EC0XefWCKYFjBZW9JcIN6XWxAoTNFITOf7wWFs3Q2
 4qtR1aAe1b/HFJSXjHh8UF1lej+jEhBF+w5CNJAMLGP5cwf6IpInGynCl+vY8dZjjp1HgJK6Bj
 YpPU5mdFYHsJ4Re4zSinwRAZ+C0Oa5Uq3/EkdDrMrAe2/b+iW/SnkFysVpsVid9wgFS6xgk3wQ
 35vDRD3ECG78fc0gQjEvB5iwob5OTgYSaIuuJoECt1ITZgnJ04v+Fj6TsH20UqLwsMNGX5i5tN
 TkM=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:58 -0800
Received: (nullmailer pid 1916474 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 27/41] btrfs: enable zone append writing for direct IO
Date:   Fri, 15 Jan 2021 15:53:31 +0900
Message-Id: <c6abc208a165c38a69d1159445b90918690957d6.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Likewise to buffered IO, enable zone append writing for direct IO when its
used on a zoned block device.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6b5f273a0d83..4f0915346c9d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7708,6 +7708,9 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->bdev = fs_info->fs_devices->latest_bdev;
 	iomap->length = len;
 
+	if (write && btrfs_use_zone_append(BTRFS_I(inode), em))
+		iomap->flags |= IOMAP_F_ZONE_APPEND;
+
 	free_extent_map(em);
 
 	return 0;
@@ -7936,6 +7939,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	if (err)
 		dip->dio_bio->bi_status = err;
 
+	btrfs_record_physical_zoned(dip->inode, dip->logical_offset, bio);
+
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
 }
@@ -8088,6 +8093,18 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		bio->bi_end_io = btrfs_end_dio_bio;
 		btrfs_io_bio(bio)->logical = file_offset;
 
+		WARN_ON_ONCE(write && btrfs_is_zoned(fs_info) &&
+			     fs_info->max_zone_append_size &&
+			     bio_op(bio) != REQ_OP_ZONE_APPEND);
+
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			ret = extract_ordered_extent(inode, bio, file_offset);
+			if (ret) {
+				bio_put(bio);
+				goto out_err;
+			}
+		}
+
 		ASSERT(submit_len >= clone_len);
 		submit_len -= clone_len;
 
-- 
2.27.0

