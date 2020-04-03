Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4BE19D4BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 12:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgDCKM6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 06:12:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56713 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585908778; x=1617444778;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5B7jfCFPvDXPf+LfQjYPXOsdoLoYkoGO0uh33NtAmwo=;
  b=N0Erfb1rwaWqWRsmOEDjQkFERw87i0+7nlRvviV2+2Y9+OofAqMxwWcU
   FH1V5o6sWCSlchzh84ALUSYNZbkgDnt1MGjNrF8Pbwxc+FRG4a7OyBbej
   QbX5FtQG+MdGTzTGf5E7f2wGfAp8hBuKf1lfbgH7AqniKifvRh8v4l5v9
   bBTXNSK2OG5n9rLXB8PgQ/OeBd7yI9Ky5yv+ZEP4igcZZkxQ91qelNFrX
   Nbg8ZO1CNkI9tbdCH9jKV3XsC/fT08KGOiGxC+fP6NnN6CgLxiQCWMLBb
   Pz72HQRJDFos8xuWXxYBOt6ttOS4cgU8rd/rdEN0Q6wWYMrUkRAcMvn7s
   g==;
IronPort-SDR: MmcKRb3yB3LFHAsNzC/eYLNi3Q0KikBKBDC9IvGMr/2FBV8TGUgk2IL46TEjVJWPOzn1Z0N5VW
 t3Wv9R29xaeaQnybaemneoEwGBGCUHFKdQlwoikyOACwPCzblusDNiKputYfMKMC1jwrfsAfQm
 ASGBK1Wn5TzM4o0U8MuJaqAE5yKYB/B0qFjF1VLwkoGBphgZyiEBo8BlpFuyjM/ik11lug3v5t
 veyw0hM2XQjRi39g9BMFl0ChycFbSanuD95IeljumBxGpe/lEre2iMWhuCfWpoFg0gpCs1Vsf6
 CJY=
X-IronPort-AV: E=Sophos;i="5.72,339,1580745600"; 
   d="scan'208";a="135955981"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2020 18:12:58 +0800
IronPort-SDR: DyJ+tVstZnZl1wJjVnJTzSobQBP1ToOq75QKJXdetwBXvBvl9TI9Fw7iNhCMDTCki0+++K9Gc9
 BFUBBu7du8VDIj4QlWV7Qhm+iBQOl2Rb9uJhC3Lku23wrXoe7Z4OX2fuq851y+YDj7If9YZ8Gx
 fAUcvhVJKbLLw5EG8DTLIA1xSbN323kTt0Wv3d+rtN4gl6iA56fk5Rym7xsegj9gUnpIm+tLDD
 I5GKNrvldQZGl+FEDQ6Qd4CDeyc9P7nhYRq4ICqkASibgEd2JCr1uYK8mXEj5qOJUKlQhi41i/
 M1h5pFcfzGKVo/7i8y5nz1gD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 03:03:47 -0700
IronPort-SDR: yTmEhCR+KpXfEUKVLJEJWrVNAmiKzQT7DYsysW31rLlvTvirQhQxKrc1zVZ94zEf0vNfpWGn8+
 bugjiCIVT5ECb74jx/Xld0pF9PSf6O8X43fD89CKjLwR06XNbSJM7uAup/onpdbj4MNa22ZgO8
 jDOdLaDBl7lLu1lYNFXZ6NK0w7E7uzkE570G5w3QJGV+8HZqIHVFMJLfhg5qR6WzMHb+uYNknj
 0/G1VdH3yI8LJCLvtpjuYy2tTa+wVjxb96kHazlfe6be7LnhnRLBQoYu+Ykuh2zT4366cMvwG7
 /2o=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Apr 2020 03:12:55 -0700
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
Subject: [PATCH v4 00/10] Introduce Zone Append for writing to zoned block devices
Date:   Fri,  3 Apr 2020 19:12:40 +0900
Message-Id: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
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

Damien Le Moal (2):
  block: Modify revalidate zones
  null_blk: Support REQ_OP_ZONE_APPEND

Johannes Thumshirn (7):
  block: provide fallbacks for blk_queue_zone_is_seq and
    blk_queue_zone_no
  block: introduce blk_req_zone_write_trylock
  scsi: sd_zbc: factor out sanity checks for zoned commands
  scsi: export scsi_mq_uninit_cmnd
  scsi: sd_zbc: emulate ZONE_APPEND commands
  block: export bio_release_pages and bio_iov_iter_get_pages
  zonefs: use REQ_OP_ZONE_APPEND for sync DIO

Keith Busch (1):
  block: Introduce REQ_OP_ZONE_APPEND

 block/bio.c                    |  59 ++++-
 block/blk-core.c               |  52 +++++
 block/blk-mq.c                 |  27 +++
 block/blk-settings.c           |  23 ++
 block/blk-sysfs.c              |  13 ++
 block/blk-zoned.c              |  52 ++++-
 drivers/block/null_blk_zoned.c |  39 +++-
 drivers/scsi/scsi_lib.c        |  10 +-
 drivers/scsi/sd.c              |  26 ++-
 drivers/scsi/sd.h              |  38 +++-
 drivers/scsi/sd_zbc.c          | 403 +++++++++++++++++++++++++++++++--
 fs/zonefs/super.c              |  80 ++++++-
 include/linux/blk_types.h      |  14 ++
 include/linux/blkdev.h         |  33 ++-
 include/scsi/scsi_cmnd.h       |   1 +
 15 files changed, 809 insertions(+), 61 deletions(-)

-- 
2.24.1

