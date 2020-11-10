Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB6B2AD514
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbgKJL33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:29 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12022 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731588AbgKJL3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007750; x=1636543750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wZjvAc327/RtuGLWgNBK72YschgrDw5lTDO/jaWYdfI=;
  b=Y24ENbTHjSRcm7/0vxgFJe7Udy0zEruArZWF4pInaDZ4mR2K4gJm9vc0
   zor2AvxDlS5mslKXtMGxLblzNzqE41TpPJiZJJGWiDwFDDsPrIGMyIRC4
   7Se6f0fqN6gojWqbcl1FjTHQQHo0pakZbPtpqJWLieA+4UcqxQpCkcCkt
   2fL/ek+gpr3oVOJiqzgmxGL8r8vMl217rVksN3KytStKBKZOIWsOSjTzF
   MBuqpg0PGOnVtRggzIrbPUX/8+C54HojY9UriPB5suMMyt+v9NpotLkMl
   P+2ipzWoIHQszui9S248nktZpGIhWqh1ADMSYsXyFARP3bratPVSot/PX
   g==;
IronPort-SDR: wZNpQv4ixTjLkS1zU7nOIwtbJr12NvBKUos6QuUtddVRQIsoAOg/Wy4OhJZt3JSo/YnfyhbmFa
 OoMAgJ0/XyxicSlzHjTFBjM8OuV8rL4zZoCGSSykYy+XC7kjRq3iNELnLZWSryVeEA+jPeQxuk
 TynOZDZODk+QKLtkVy1J4qnTo/Z3fiZ0v6juG4to1mXJF7bGEttAfizbmv6N7yWcJOIBl2QjHg
 AQfbIK/hNEJlpshEXkqpYJwbanO4oq2R4Lipxgyi9lHzXkNC51Xn4a4tf+NX8FLTnSGyMLX1E7
 ok8=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376640"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:54 +0800
IronPort-SDR: s9JcY7SGNh/ebHR0UVpZ4MjeXpBF2GYPsv5obAYQMfpVktUMi87h9h2PMVQ2iqe7KUYkrGzi4i
 xNCZRGHUcIjdHQuN+mwM5AOpQpXdoFUkbk2qQxtakyrhihQtz3Aib8dkuzs1ZX8787N4dzpH9d
 pBimBhtrJ05kYI5O3WlQjqRWewf3yh2zvdZZuPlijQe3eW6VOYXOlJpQZSZHKvi5/kMSZncPvy
 zaQyJhEz8F+4xB1EDHomcZbCm9KrByQffWpwcdI7H4nPWiB+LIy4yyQRWoXl5lL1tL+/wUZSEE
 1R3u39JVtyuXhRMtSY3zJ9Kj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:55 -0800
IronPort-SDR: 6kdp1V+9FmFFPT0pjavFEQq1SR7ggm96q6rlz5AnlI1bmr3PphbwiyhAWAgzn3VMrEsbpJsXmQ
 V9AOJy1djzorbLxSotSnEew1Mha0z6uSvzMincc3ZbuC8/kGAp9Vf9u2mN1j/dSTwLkPx1AyIM
 f5LkWX0/Cu/NXFmcGHa/i7YqqQ+w0ea1AIOvE09nqHMg+mNg0lFT3aal2chyIq1aGtZKu/7EL5
 cwBtizP88C30EjJNd0Wabt4SViCYsHEqnNvXlfM8hINFKZOrx3uoOjXseorhTlGRxFgcIHvvzv
 mJQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:53 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 30/41] btrfs: avoid async metadata checksum on ZONED mode
Date:   Tue, 10 Nov 2020 20:26:33 +0900
Message-Id: <88b50c919c7ee1e85c97430a9d53b68610c32fa8.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
index 66f90ebfc01f..9490dbbbdb2a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -813,6 +813,8 @@ static blk_status_t btree_submit_bio_start(void *private_data, struct bio *bio,
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

