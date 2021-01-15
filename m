Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6A2F7355
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbhAOHAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 02:00:11 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41752 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbhAOHAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610694010; x=1642230010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QHop2SNGXgOREr2Aczdit1N1Gf0FQv5Ys9s3ZFZ8P9k=;
  b=gw9E7Fin4a/zt6vPSulobsJtntdAtoQ9IcTPRCEDjzRD6V2LP0h31oBe
   DPNs4n65geK35fxNerTGQYyZFJSH748u6apSgUSpmANhWNuKGupT4H9LA
   41oPAqEAAvXa1BJBIfUUbVaP7dApjTISxGJRv+OdOnaJCfp2bw0kv64CS
   fN3kQgpK3oVm0De5kj8eaCQjjqQmJ57gkAO4mtZxy5gPZAygHgRCuv4AA
   0Ja8tSuqp+HU4NHPhf3xxHkHPMgYEsPscFGH5IVJ8KryOj68vZQwFtr07
   sj7zFb7ri7vC7kjOTT2AlXskAX6Pf/FA3qxju20MrSAq4f8r5U5FTOpay
   g==;
IronPort-SDR: ocETKv8Lz3Zgp6jU+1fVMin25p7jYI41oHjA1iS8rw6Gh7X9RP9Zj5IbnYSIoX6uNxf9v2D8po
 gQU2QMDWMvbJOuMMy9lYua21oQraQGK0yrmOPo8llDdwMKMq6MsLnUmySsoFTi5vZgUJSWup2/
 lrn1pWYo90nK21k213PuS3rXTLW+uu+JkyOlOg1AV3MDElWggtAbPl4Bxb882D7jgfKIQXMfoo
 dvQwrbX8LNdnIyGCJM1t7qQeZNJpV65Lc3TrWSV2qJNtieAWCUqyF1yZM7F/Ptjez/Y86Q9kCF
 Ps4=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928296"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:56:07 +0800
IronPort-SDR: GuA0mcvRW1hy6LsKwR43c72fZxzTJ5b6kbuqdgnp6XFrJ1SDYZO/58/XBANdhAe+ID3SrRT4ip
 0ya4jZJWUpM4C8H521AN2pH8aG57thU+rmGj4lkm1Yf6ty2cUrMdm8CU/1WQAonE0azAyU5nS/
 8tnlaYMQPIf24y511QJ1pBwHjxR4VH7ehW0O+H5mXiryRCQ0vxbCzC6vEuw4ODUbpQQxqUF9Jp
 yXxwfW7zoZvUMpatiC8gMqK+URKdSMohEPkXiPIwG9KEeESeuyG1iCIPqiMKhRdu5BPlpb9Qw0
 GehFVsVaqyH/Com0a2bzfM1+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:49 -0800
IronPort-SDR: rPEz92gahBtHKl1cfIesRXVke2lxSO9kEMwv038FQ5qAcJBKfTDJSpPnt2dYJrQnZIFs9z11pM
 XrwMN8VRrTCS9EfBWYK6rYAMMuatL96tQKjXZyXpZNxFAMSg6e1MDZ9PFRL4w91KMB+cOHbId6
 aMG492ZDIbliSXXqOV8VGczE/hs1OPlBit7RzLVDle00D6CKADse996kXcNv/SN0q/g4bSQOKm
 YoAcIi2tPfhY1hiT6zuC3UxQGmjnAkMT7FA/Wl72z501u6WsqGz7sJNkCwg2fgyuIxLAs17GKI
 Ldk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:56:06 -0800
Received: (nullmailer pid 1916482 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 31/41] btrfs: avoid async metadata checksum on ZONED mode
Date:   Fri, 15 Jan 2021 15:53:35 +0900
Message-Id: <ab23c072a04eef6440541075aa0044e972d1f959.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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

