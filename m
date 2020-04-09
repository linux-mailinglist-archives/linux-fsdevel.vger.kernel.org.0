Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E394A1A384E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgDIQx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 12:53:57 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24703 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgDIQx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586451237; x=1617987237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vKMbOE74U0yXpznagN3aQgu7Jq3BgngCSfrecQ7Pe6Y=;
  b=Foz8v5zzdiqVRkA8dHvz4yFcsjM9JooAQilEEELSn7FWyUt4UyWXua3q
   z15fdr2S9wW5z4w9zaUT6bNmNtn37Brb5pvUFjx2DR9JWT2Ccr8BjOULH
   mit9MArPilZzisGN9Br9ElVxjtnkn8cIWSdyAjD4+26Qhro8n5SXOwH8a
   RfHG5lbBRHKIdoq5Rq40PTjRelpBHCm7YMJIaFOZu+YOlnUU2TzMsRQmd
   LjfIrq0dovSy43M7TNWBYkXotb1NAj4AkZdX9jkEXMcGBiM1ywhoSK1Ty
   45DNSMK4y39GyUop9Qh6GCIGo7RKqq8sONkraZ5S1DcHtjM0Op5Wlpva4
   A==;
IronPort-SDR: YNbc1qzVcCgJxFI5nt9wsA69BWozYfTEezXq1/WskA48ohQGzVuQiZiKxnAAm6PnR5ul/QeglZ
 aeJeP5rJ4WQQtGsYfXLiXK6N639Anb7OMoUwcKUxGPY0WfrYxbVyMA1yJILE2KDZzjDf9esJlu
 yEhm75ihNILm3oJK0YHGHAq+adUZ6I6DdEYfW8NHj0v2vD800d09m50WKnIejaq3EGMdinw0y0
 QwBm4A8TsiLoXBC2OoKFocxae1NljqORGDpgCaH4Bt1IXdNYv7oqwLdDJ8ppY01oMBy970rl7e
 Y8s=
X-IronPort-AV: E=Sophos;i="5.72,363,1580745600"; 
   d="scan'208";a="136423675"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 00:53:57 +0800
IronPort-SDR: KHzCv9llha0W0zYcAL6LYBFvdxRXV31tXDKxYC+Q1vaQZXjok2i9b+gt9O6wscHzbNoKL17QFj
 Lrg4RsfXGtQbbkmTl5Tr6nXMmX+C9HwPIWPGPVw2VfFWuILs5oByS0eINQr/CUBoDMKRTQubJB
 IeCcV6DSzHB+7Vrcjn9equ8JZ4/q4vdnpWCAOIce57IPStFgn7mJssny2EdPsKb5py6FyDoG9p
 1ClWoFSyJxIGz7BVjD7JAsr2Qlfwfp3DC6tuHjDNBKrp0NgkHYXIF/WxtrVWa4iDCMZYIaOEXw
 3h1aZui254VnOglV3i70Vh3N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 09:44:35 -0700
IronPort-SDR: XciXq+t+yIOOeKM7TrCEcJhA5hgDjPNLPB4Ajw7XVZrAPPmncPakCDqRTgEDw9He679g5A+eJe
 hLs4WvRSf66sdwFsFYIB7KMEQEDx9mKpuX9gf1BGb3i1L8d5mdfDQANUiSocV3FZffebLUF6EP
 WRYE92ait4kxB0xtm1Fh03Ee48EveH4ndqIxR4YBGRUq8hTYewBbBPT9fEV5iePX1/eBGX/QJJ
 xwD7WsSIg62fSSTyHxmngsIBUWIc7XPOYLsNLZxCkSxURLvO3SZ9gnVI06VitKSvimMF2/UDdM
 +Lg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2020 09:53:55 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 00/10] Introduce Zone Append for writing to zoned block devices
Date:   Fri, 10 Apr 2020 01:53:42 +0900
Message-Id: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The upcoming NVMe ZNS Specification will define a new type of write
command for zoned block devices, zone append.

When when writing to a zoned block device using zone append, the start
sector of the write is pointing at the start LBA of the zone to write to.
Upon completion the block device will respond with the position the data
has been placed in the zone. This from a high level perspective can be
seen like a file system's block allocator, where the user writes to a
file and the file-system takes care of the data placement on the device.

In order to fully exploit the new zone append command in file-systems and
other interfaces above the block layer, we choose to emulate zone append
in SCSI and null_blk. This way we can have a single write path for both
file-systems and other interfaces above the block-layer, like io_uring on
zoned block devices, without having to care too much about the underlying
characteristics of the device itself.

The emulation works by providing a cache of each zone's write pointer, so
zone append issued to the disk can be translated to a write with a
starting LBA of the write pointer. This LBA is used as input zone number
for the write pointer lookup in the zone write pointer offset cache and
the cached offset is then added to the LBA to get the actual position to
write the data. In SCSI we then turn the REQ_OP_ZONE_APPEND request into a
WRITE(16) command. Upon successful completion of the WRITE(16), the cache
will be updated to the new write pointer location and the written sector
will be noted in the request. On error the cache entry will be marked as
invalid and on the next write an update of the write pointer will be
scheduled, before issuing the actual write.

In order to reduce memory consumption, the only cached item is the offset
of the write pointer from the start of the zone, everything else can be
calculated. On an example drive with 52156 zones, the additional memory
consumption of the cache is thus 52156 * 4 = 208624 Bytes or 51 4k Byte
pages. The performance impact is neglectable for a spinning drive.

For null_blk the emulation is way simpler, as null_blk's zoned block
device emulation support already caches the write pointer position, so we
only need to report the position back to the upper layers. Additional
caching is not needed here.

Furthermore we have converted zonefs to run use ZONE_APPEND for synchronous
direct I/Os. Asynchronous I/O still uses the normal path via iomap.

The series is based on v5.6 final, but it should be trivial to re-base onto
Jens' for-next branch once it re-opened.

As Christoph asked for a branch I pushed it to a git repo at:
git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git zone-append.v5
https://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git/log/?h=zone-append.v5

Changes to v4:
- Added page merging for zone-append bios (Christoph)
- Removed different locking schmes for zone management operations (Christoph)
- Changed wp_ofst assignment from blk_revalidate_zones (Christoph)
- Smaller nitpicks (Christoph)
- Documented my changes to Keith's patch so it's clear where I messed up so he
  doesn't get blamed
- Added Damien as a Co-developer to the sd emulation patch as he wrote as much
  code for it as I did (if not more)

Changes since v3:
- Remove impact of zone-append from bio_full() and bio_add_page()
  fast-path (Christoph)
- All of the zone write pointer offset caching is handled in SCSI now
  (Christoph) 
- Drop null_blk pathces that damien sent separately (Christoph)
- Use EXPORT_SYMBOL_GPL for new exports (Christoph)	

Changes since v2:
- Remove iomap implementation and directly issue zone-appends from within
  zonefs (Christoph)
- Drop already merged patch
- Rebase onto new for-next branch

Changes since v1:
- Too much to mention, treat as a completely new series.
  block: Modify revalidate zones
  null_blk: Support REQ_OP_ZONE_APPEND

Johannes Thumshirn (7):
  block: provide fallbacks for blk_queue_zone_is_seq and
    blk_queue_zone_no
  block: introduce blk_req_zone_write_trylock
  scsi: sd_zbc: factor out sanity checks for zoned commands
  scsi: export scsi_mq_free_sgtables
  scsi: sd_zbc: emulate ZONE_APPEND commands
  block: export bio_release_pages and bio_iov_iter_get_pages
  zonefs: use REQ_OP_ZONE_APPEND for sync DIO

Keith Busch (1):
  block: Introduce REQ_OP_ZONE_APPEND

 block/bio.c                    |  72 ++++++-
 block/blk-core.c               |  52 +++++
 block/blk-mq.c                 |  27 +++
 block/blk-settings.c           |  23 ++
 block/blk-sysfs.c              |  13 ++
 block/blk-zoned.c              |  33 ++-
 drivers/block/null_blk_zoned.c |  39 +++-
 drivers/scsi/scsi_lib.c        |   8 +-
 drivers/scsi/sd.c              |  26 ++-
 drivers/scsi/sd.h              |  40 +++-
 drivers/scsi/sd_zbc.c          | 380 +++++++++++++++++++++++++++++++--
 fs/zonefs/super.c              |  80 ++++++-
 include/linux/blk_types.h      |  14 ++
 include/linux/blkdev.h         |  32 ++-
 include/scsi/scsi_cmnd.h       |   1 +
 15 files changed, 783 insertions(+), 57 deletions(-)

-- 
2.24.1

