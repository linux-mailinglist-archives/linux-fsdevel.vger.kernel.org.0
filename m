Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44512191437
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgCXPZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:25:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39883 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbgCXPZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585063502; x=1616599502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xaCtiHyqyRbO1ofbhK0zFUtuBTCIQCZrtTlzQ5zfCwY=;
  b=p5InG0II7MBkIq/4FEBDbjz+OkNrhvNYQ6tgWmMmQJerQINSVQhpNIkt
   pg7+VFvO+kaCtWvuD/3j536T4UUoI1Afi2vineUe6y4DBNWb+HsPueDvA
   ZINUzMYdTeL3U4UiX2Pd2Ivf129LIV34HOzWN20yXoaw7k00/eZowxyOt
   vetbR6QfEGTnbjvk/MpSeQGqfTpm6N3ND6b7RggMAL6Ay5diRELh0LDAv
   wZPYPOL4apg0rtUl340wHbntXaEpKQ8mAYzZIf6vMpdcRHSUOXTqKmDom
   Bcd9ZKYhddfgg0nosqVqR+j4ZlcOWo3zc4jQU16dSpBS5E+NfGe7FqC5L
   Q==;
IronPort-SDR: 6KSIteRFVGljOMXGfHQuMoBTYp5hCQPFdsvhX5lzWtNh7mrzPKS1J+AtwPQtpOAqTeBDDGWp5j
 /rE7jEy1Wp6mqF+O6tGOHNtk7mZg1LC09kvaPiA/D5orzHKi2uj53gU9qSRpGVmy+cLihBVLZ0
 yjOAAM3t49RelBrk7iOlOsxoS3CnbzTGguZ80FJZnfucNvEEwd0F9lOwfSupa2haG1llsHzuC8
 2WvftM1hQnmY+KiMmMiw36/o/eJecadrLQrDcSTC0aUonzEv8vAeKhiM0TQutuqWof2iSDU0MV
 yqc=
X-IronPort-AV: E=Sophos;i="5.72,300,1580745600"; 
   d="scan'208";a="133371550"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 23:25:02 +0800
IronPort-SDR: PmIhIju7mhB93u0Tf71Lw/OKvE/rLqrbqZfALbHAbn2mxmz4yAOsiiYrHqF7EVMcpnBVQ7TvOq
 Hoj9PlorGq8mvdVLrCLeO1+OkpRmC4jLx66WFBxA0cTlLpS4LdJO0KO8JMf8ruxv2s/h10tEAE
 CwFU9LHQH/D9c64gWcFzG2BK3yjwRWMe3WR217U85udiTJ5BjSHukRpWGYj2YvwFrBO1C/QgyP
 4J1srDgPwN3eU7Y+BdPJ6z4TlNatnLPEL4z84hR8bhiUD5+etQwK4V9uZpRxI9p10zwhz4wGCp
 32dVA2W4ZE2+JeqvHCxDzPxc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:16:41 -0700
IronPort-SDR: Fj32O1Z20k2UD58hwSuKR+Tvq0z8tJyxidYIqhthiJJV1FWoh6N7I1bdtCND+82AmdnfJCp0iY
 yEa50Qltof6QI43JPOmw9jljrLRfG+xcdyTOStegBzg86pSx/cYAhLOydKiHJc5lgXauoKfsUR
 ch0MPv8zp6SFOcxsRuFum4YNAG2dgHmF6TFStWXWVQD0MN0tbRRhvABEg8xMuSHMTDCVjETaRx
 RmaIHyfvxLeVjKcF0NwBrTqPl87QBxc5QMM35gHaP4OX5qsDEHjccUSJ7ohUVUwyy4LW6LMsQw
 +8U=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 08:25:00 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 00/11] Introduce Zone Append for writing to zoned block devices
Date:   Wed, 25 Mar 2020 00:24:43 +0900
Message-Id: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
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
direct I/Os, which also needed changes in iomap.

The series is based on Jens' for-next branch.

Changes since v1:
- Too much to mention, treat as a completely new series.

Damien Le Moal (3):
  block: Introduce zone write pointer offset caching
  null_blk: Cleanup zoned device initialization
  null_blk: Support REQ_OP_ZONE_APPEND

Johannes Thumshirn (7):
  block: factor out requeue handling from dispatch code
  block: provide fallbacks for blk_queue_zone_is_seq and
    blk_queue_zone_no
  block: introduce blk_req_zone_write_trylock
  scsi: sd_zbc: factor out sanity checks for zoned commands
  scsi: sd_zbc: emulate ZONE_APPEND commands
  iomap: Add support for zone append writes
  zonefs: use zone-append for sequential zones

Keith Busch (1):
  block: Introduce REQ_OP_ZONE_APPEND

 block/bio.c                    |  72 ++++++-
 block/blk-core.c               |  52 +++++
 block/blk-map.c                |   2 +-
 block/blk-mq.c                 |  54 ++++-
 block/blk-settings.c           |  19 ++
 block/blk-sysfs.c              |  15 +-
 block/blk-zoned.c              |  83 +++++++-
 block/blk.h                    |   4 +-
 drivers/block/null_blk.h       |  14 +-
 drivers/block/null_blk_main.c  |  35 ++--
 drivers/block/null_blk_zoned.c |  51 ++++-
 drivers/scsi/scsi_lib.c        |   1 +
 drivers/scsi/sd.c              |  28 ++-
 drivers/scsi/sd.h              |  36 +++-
 drivers/scsi/sd_zbc.c          | 352 +++++++++++++++++++++++++++++++--
 fs/iomap/direct-io.c           |  80 ++++++--
 fs/zonefs/super.c              |  15 +-
 include/linux/bio.h            |  22 +--
 include/linux/blk_types.h      |  14 ++
 include/linux/blkdev.h         |  42 +++-
 include/linux/fs.h             |   1 +
 include/linux/iomap.h          |  22 +--
 22 files changed, 881 insertions(+), 133 deletions(-)

-- 
2.24.1

