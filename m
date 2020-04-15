Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291A61A97F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408261AbgDOJHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:07:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19511 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393850AbgDOJFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586941525; x=1618477525;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tV5+FI/nWmuJ8QKVHPii1dGIvjypo14JmyE9F4kEeO8=;
  b=hBVEQJqe6cF1DeQwbGE/XTMWlNakggaXmfkMMlYcz/4x5mJU+d0g95Vz
   f9MIWIIiUtP1luGv/jIFvI+6L7X5yG1RQSZUzQqhvV3d4ptf2wshulrqn
   9+1uHo+VKOPmzyDWRAptdJN9JBHoPG2lmFTmvaWTGO1Z7goDk0T64TB/X
   FyXROEg0wxS7UcuTrlUe4mwwJW9gZ4+sY+OOnV1yE8g9zd+L+6Ol9Q2EG
   4g3Pv2FvTiEMAbo+aPqEclm+7dOKnyrVD2Smv3W7xcCruPWLdVImIAfIK
   VCmh7tNOFtfxhLpbT3wz+eyM5SWkvwYB3yF3ARKHAYo6mzdiOB2wLGePF
   g==;
IronPort-SDR: qYVXCo5FWRgflf6RW1B/+/p+szRcmfS64iuo3btO+n45aj+rXbvGyQYN8+nwm6oKuNXIwy0zR6
 sIIOpxyNLvb6IXPOKrtxjzglD1fmkl6OVxAXm9vM4ale9dQqXw9Ky31dRjAIMWcQAUlMM4Bj+T
 BsrRvTi/Fb7OoXtSiJtLB/fa7DHeHN5v7C3usUhSFKev01moGL79GgmUk5HR6HNvY7UPtMiZ7y
 vwiiOJHQVWSFPvyXH/w76Y+LLEm+Uop2zwxmDxjplEwhjRwkJ8E+XEq5le5/pAKuCk+0lgYkWd
 LU8=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; 
   d="scan'208";a="136802964"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:05:23 +0800
IronPort-SDR: PjldsnGKaw1BRo9i2ltXXGj6sE/mhFa20EyDOKiY55f2TwBWCCI5DXLIDXQHYFJl8F/dWlDmhl
 5lwIUx+kjO40JoEeUyrmeJw90ODJ/abife7UK1/VFKfBR/rTeyEVkeWYjv/uv3pl92t/F2mcn9
 4Da9IWknM79MmbcjOhz5qJndNfwhUdZjeEpZm/kpF0E0xJa4///vDtB3HTLbB701mbAkSWYPCh
 BAuNuinXksNm/FCrALTUfekxxpfaSdEbhXnlHhiM9NTfFSMLxzexvnOLcG6nd94A/ceHKx2F68
 HVN9ncyiOi5d0YbXYLkCadP/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:56:24 -0700
IronPort-SDR: L0GDHwqtqtCkJ2tGecHkstjXZ1LCSPSVvPdym8zdmKPZqAAIz2E2BNKwYMWMWU5Ua85KRUfzl+
 G29fydanA2ICZJoqWMmFp1XPQuAIlBTnNmaBlicz6SgL8gZHFl7ZHiyABMhh1oM/bnM3X4o3o9
 OcltSqh+fLb4b+v15a8qXg6z2e9hYpom5OXoQ5ljo1neDxlCkiCNHWCFBIj9QBCTSsgCGcOmQP
 GQya3a5UTKTWX2TBD2Y6M8EVCKvfmVEwOhdQvuenFJR3HjFjF8vBcx8mzQMf4EHqmDXSQ21nG9
 ruo=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Apr 2020 02:05:21 -0700
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
Subject: [PATCH v6 00/11] Introduce Zone Append for writing to zoned block devices
Date:   Wed, 15 Apr 2020 18:05:02 +0900
Message-Id: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
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

The series is based on v5.7-rc1 , but it should be trivial to re-base onto
Jens' for-next branch once it re-opened.

As Christoph asked for a branch I pushed it to a git repo at:
git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git zone-append.v6
https://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git/log/?h=zone-append.v6

Changes to v5:
- Added patch to fix the memleak on failed scsi command setup
- Added prep patch from Christoph for bio_add_hw_page
- Added Christoph's suggestions for adding append pages to bios
- Fixed compile warning with !CONFIG_BLK_DEV_ZONED
- Damien re-worked revalidate zone
- Added Christoph's suggestions for rescanning write pointers to update cache

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

Christoph Hellwig (1):
  block: rename __bio_add_pc_page to bio_add_hw_page

Damien Le Moal (2):
  block: Modify revalidate zones
  null_blk: Support REQ_OP_ZONE_APPEND

Johannes Thumshirn (7):
  scsi: free sgtables in case command setup fails
  block: provide fallbacks for blk_queue_zone_is_seq and
    blk_queue_zone_no
  block: introduce blk_req_zone_write_trylock
  scsi: sd_zbc: factor out sanity checks for zoned commands
  scsi: sd_zbc: emulate ZONE_APPEND commands
  block: export bio_release_pages and bio_iov_iter_get_pages
  zonefs: use REQ_OP_ZONE_APPEND for sync DIO

Keith Busch (1):
  block: Introduce REQ_OP_ZONE_APPEND

 block/bio.c                    | 127 +++++++++---
 block/blk-core.c               |  52 +++++
 block/blk-map.c                |   5 +-
 block/blk-mq.c                 |  27 +++
 block/blk-settings.c           |  23 +++
 block/blk-sysfs.c              |  13 ++
 block/blk-zoned.c              |  22 +-
 block/blk.h                    |   4 +-
 drivers/block/null_blk_zoned.c |  39 +++-
 drivers/scsi/scsi_lib.c        |  17 +-
 drivers/scsi/sd.c              |  24 ++-
 drivers/scsi/sd.h              |  43 +++-
 drivers/scsi/sd_zbc.c          | 359 +++++++++++++++++++++++++++++++--
 fs/zonefs/super.c              |  80 +++++++-
 include/linux/blk_types.h      |  14 ++
 include/linux/blkdev.h         |  25 ++-
 16 files changed, 783 insertions(+), 91 deletions(-)

-- 
2.24.1

