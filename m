Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E676D2E051C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgLVDzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:55:13 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46487 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLVDzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609312; x=1640145312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QHop2SNGXgOREr2Aczdit1N1Gf0FQv5Ys9s3ZFZ8P9k=;
  b=XWqERA7o/Ux9f+O4+ZRfUSg+h+qOrGRv13HMYdSXHj6j2UJO7n9yjt0g
   ghB9f8ki680BxY5p0UDKYwmrB4rxAdfum4U4a6lXEkusY8xJQ6SegV7Ye
   pBBFyCvNVKR+MgJu2Sj3F5sBtQEPRVSFpLbX0nUt2w+nrSTou1mCk2hZc
   BkIKpOp7ugnkSpL1/Q0337osOlqH1Z5oA92icxyvdIsMwLa8cftVofXs2
   LuPTQ3S4Dw9jDmV6m1P75EL6IJB9HqJkYI96EYUNaoJfwR+VqXtWvPfg7
   CXIfEiBQ+mAIEJF27fwAmflcwYxGfKxdZHhIclYEfck38ZNQ70S0+n7S2
   g==;
IronPort-SDR: mU+rUmBvHvTbrKQxl7Jqjh0NIHMdrcgXEgcII7UO+c1NS8pBFj12j6JYDjhsK0uw+jcPcke2M1
 3Z/fuqvL8pVqAP16TTg+P0fyXP8+9rKzrI4rMDDBtwnZGnv/Pj6sp+w6K/JEgW2hAzcnPHMZCL
 ddq7TRALXqovp4kkgeFafNzZmfoAeHc9SKRuZJ537jHT89Nf/uK+puTtABGlI6/Wpby+/5iAJG
 LwkuG9VSLUyjIcWdW+D1FadHAvOZMf63eaJ6vvTO/PKBz+28dRew8xgm5/AKy1GCKasPyG/dZb
 3ro=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193843"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:12 +0800
IronPort-SDR: g36KfR1DANNGf4ayVaNvekk20hS8GFDOfpmKNJ9B1iG0vjSrXsOZn7azCkf1EyNotqOrAR/46i
 05FoB2makSHxOENZsfNE4f06ybFb7usDJP+THEROJh35MK05FzUT2JFcxZpIQ3Kz1uB20V15e9
 1ponRdjwheVffYq9njNyDk9w0s/xx1JducLtzQTvsF6glgujrh/RxeMB+zXo38Z4b4Yl+t3htT
 jRyvaR909Tp0pnZkvvLtTCyA9BYifCMP5m9p7VA45V0IcIJ4j7k0rcTg8psO8PkJ1qWSDWPh8f
 HAIAkDmuVS10RefAo9Z779jo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:24 -0800
IronPort-SDR: FHvKbuAzj7LeplJ/orqO5iXiwCa0tTX8wVI2tzVuXKQwJ2SadnosVNijtDyEpoHcCSsjACLv4K
 AgFqzGEbe+XFMR0PIpu+ocDgh/sv6UIlO7dpxD+tWt1IF1cN6M3/PIqJuiJ2dyKR7SkxAdUe8Z
 BrQCX2Fp+hq5qB/ePdErqoWs28OYWX4W3kxGPdyF9qWnQKJD5YfoIE5TXnaFI/XkU2DcGlru90
 eTXEngfxKSKy4HJtPx2xW3CSuBlW0DCpQiiyjBCWbHRsuVvvX/frdBZvBvLbMk3KXKmqxs6KJN
 tNw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:12 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v11 30/40] btrfs: avoid async metadata checksum on ZONED mode
Date:   Tue, 22 Dec 2020 12:49:23 +0900
Message-Id: <57bf58857026225f3e3500003b489075e9c8dda1.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In ZONED, btrfs uses per-FS zoned_meta_io_lock to serialize the metadata
write IOs.

Even with these serialization, write bios sent from btree_write_cache_pages
can be reordered by async checksum workers as these workers are per CPU and
not per zone.

To preserve write BIO ordering, we can disable async metadata checksum on
ZONED.  This does not result in lower performance with HDDs as a single CPU
core is fast enough to do checksum for a single zone write stream with the
maximum possible bandwidth of the device. If multiple zones are being
written simultaneously, HDD seek overhead lowers the achievable maximum
bandwidth, resulting again in a per zone checksum serialization not
affecting performance.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1f0523a796b4..efcf1a343732 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -814,6 +814,8 @@ static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
 static int check_async_write(struct btrfs_fs_info *fs_info,
 			     struct btrfs_inode *bi)
 {
+	if (btrfs_is_zoned(fs_info))
+		return 0;
 	if (atomic_read(&bi->sync_writers))
 		return 0;
 	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
-- 
2.27.0

