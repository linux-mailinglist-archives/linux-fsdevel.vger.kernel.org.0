Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D73A195B93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgC0QuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 12:50:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2564 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgC0QuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585327818; x=1616863818;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oVftKbwfnWY4xe1eo0bpwRwBmp1J09p+gkHG1l+XKYA=;
  b=ErzSBswDNKkrxoO4iecb1mRMP6fKV/FyElh63sCNWcc2AJG7P09as45x
   TV8TsAs9+yOmpng3w/yCRY44lHyNQdV8HZmnB/gKxPOYuZMpXFEDZZIXQ
   n4AWY4xxKnSNPvQMW1PgXqKpKMXQs+hIJOtIyvUo4Zk9mhK+TC+IqQ/BZ
   ZxxflytPIIlIxFhd+wfM68CFbTxTc6TxhUKjojGNJM4aevXoOo4dgnWz2
   I8ujQq16UfKUgvhVAE332IguOD9OudChcUsS613IfDxWYfEt6FQ1mC670
   Uw6A9KKAmMJ1+oiJ8M9+2Kv/iC5kDBoE05BTwJS8oukdQuId0GIrxI8TA
   A==;
IronPort-SDR: iLrtkVQphOYLb/b4mySNdoqgKC1d8dRLRKoXcPK0LAqt1m9U26VBKv7cXVdJARaeBsRfURjoxu
 AvLLD0naEeRAle6eNj1Xtl5UZ4BcqlWGeSfCAesr8khSP/OwEmDm3aLFL0ofRRwoy8aS+L2TiH
 clq4CfoIz0CpxbsblSCb7yeXegdJJFvkDBqsPihqhnryDMOWUKUmAmHU8NDGpthq0qPO35uvK8
 wYQBToai8hefpXm1Fwp7VF4O1AU0jam8x1Uuy1y8btTv3+ptdj8Prcob35DSYUypDrTmhC1Vi9
 KA4=
X-IronPort-AV: E=Sophos;i="5.72,313,1580745600"; 
   d="scan'208";a="242210429"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 00:50:17 +0800
IronPort-SDR: pHMRElGYoE+EyGfEl1NKDyzsPWRwPB9M4NP/VR9m2ZAQFwYRBGa55PT+xSGgP8kwMlLItPzeLX
 dOSbjTKYRJuqk89F7TjZAOGIdEI1P7koYHlVJ+NqWrv9vDEaHz+d/3A676DksI778lqQP9/r/j
 OupQMbYjD6B2fFMQoEj7mRXRokgiXIpPdrGTRx7azchfJVxxq8HQiSPh1C1t7DDFGm459ktFim
 A0UNxvDhUGiUkFen5HzA3rEQ46WOyrVVbUA+Z9fCKUo+/ek4R14OuAMAXGfVZLmuHh0DBvt/XO
 4gHmZp+R0pBfLSC58CdwkP/q
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 09:41:51 -0700
IronPort-SDR: UNR1/lS7I37Z4IVey3UuPUL58K4ZEXjy+aXG+HsnSoPLpVzB2HinMLDFDHofH9xyxeTjRDK1i4
 Aw+G7rol0KyTVgW5VjrYiUwdFgi+8QctcXlWPb9JkjhIsa9xysavsRxNZO8Zh5HMsRS0TqWQPT
 6YNwkbaFRM57z+fuZP/yyHD6KlGf2BlZRVoaIhCI8jkqCllH1DOgXjR4BE1of7aEw2tVaGHCK1
 yT3SyI513XnHjPHFOA8TSep1WMyeF0sK1SkWB6naroYkrmRjvMeTI9gBnibJ5X+S6YlbKFSejL
 8Mo=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Mar 2020 09:50:16 -0700
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
Subject: [PATCH v3 00/10] Introduce Zone Append for writing to zoned block devices
Date:   Sat, 28 Mar 2020 01:50:02 +0900
Message-Id: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
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
direct I/Os.

The series is based on Jens' for-next branch, with HEAD == 1385d15e8a0d
("libata: remove references to ATA_DEBUG")

Changes since v2:
- Remove iomap implementation and directly issue zone-appends from within
  zonefs (Christoph)
- Drop already merged patch
- Rebase onto new for-next branch

Changes since v1:
- Too much to mention, treat as a completely new series.

Damien Le Moal (3):
  block: Introduce zone write pointer offset caching
  null_blk: Cleanup zoned device initialization
  null_blk: Support REQ_OP_ZONE_APPEND

Johannes Thumshirn (6):
  block: provide fallbacks for blk_queue_zone_is_seq and
    blk_queue_zone_no
  block: introduce blk_req_zone_write_trylock
  scsi: sd_zbc: factor out sanity checks for zoned commands
  scsi: sd_zbc: emulate ZONE_APPEND commands
  block: export bio_release_pages and bio_iov_iter_get_pages
  zonefs: use REQ_OP_ZONE_APPEND for sync DIO

Keith Busch (1):
  block: Introduce REQ_OP_ZONE_APPEND

 block/bio.c                    |  74 ++++++-
 block/blk-core.c               |  52 +++++
 block/blk-map.c                |   2 +-
 block/blk-mq.c                 |  27 +++
 block/blk-settings.c           |  19 ++
 block/blk-sysfs.c              |  15 +-
 block/blk-zoned.c              |  93 ++++++++-
 block/blk.h                    |   4 +-
 drivers/block/null_blk.h       |  14 +-
 drivers/block/null_blk_main.c  |  35 ++--
 drivers/block/null_blk_zoned.c |  51 ++++-
 drivers/scsi/scsi_lib.c        |   1 +
 drivers/scsi/sd.c              |  28 ++-
 drivers/scsi/sd.h              |  36 +++-
 drivers/scsi/sd_zbc.c          | 352 +++++++++++++++++++++++++++++++--
 fs/zonefs/super.c              |  92 ++++++++-
 include/linux/bio.h            |  22 +--
 include/linux/blk_types.h      |  14 ++
 include/linux/blkdev.h         |  42 +++-
 19 files changed, 877 insertions(+), 96 deletions(-)

-- 
2.24.1

