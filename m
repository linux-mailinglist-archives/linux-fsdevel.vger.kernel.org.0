Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C570C85E4C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbfHHJbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59627 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbfHHJbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256673; x=1596792673;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YYtFVC0rOrq5aFmD44b9ZTuE7xBwHLYPSvkZMJZk/Z4=;
  b=lmNsPWDeabqkFtL7TrB/KKXMHOaGA+QS9s1ALRFEHpBKeA0N2lSKxl0A
   h2muPVaulsVsOIHqhtbYTxSxrCipyxzmPAaEXDEl5bfQPjm85Z9RZ0DUg
   b0RTdSER8XlwH6QQ2VdaSOwUY52nUvbav5qQyP+AKYNzYmZT0GBFz3taF
   JDiCL0EzgFvX2JdWaoypeMZav1FuK+Mzw5RqRaiiflYpaa4+LaI3Vwb78
   gsQpGZMe4pn7H13qi02fInj3mVN5JJqVbSd2r3oCMyFrXdLTEm8Hrdl6P
   NodN/BEoJuaag6MGRxtH41kyuLcPqLtC2iwLU37Gnaf+o+WCXqGup7RwS
   Q==;
IronPort-SDR: KSwcmAv4XgZiuQ4855y5n6fEkQERDfpbo7OTOZRS/P+TPaUZOrhLR0aSBYfRYJQiVl9LkBJ0Zs
 KlUPcmQ8DjKSB6W7kEQdgxdJ161RsfdLONX7GSjXFeWJh2JuwyVh/mcF3jf6+airA7S0W4zlFO
 jH3hY09Bv0NHbn/zth2Ec8rAI0gns/YApNxGwAn761IeLBmXGBm5pEi6IJX14ak3JqODW+KeMt
 LZNBcJCQV3HCum2QXzweUCf7k1DHGGXorOMjXObpubwajRDlc6EGC9URZDp08hMa/aKswni6bV
 1fw=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363282"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:12 +0800
IronPort-SDR: C3FomeBFrGJUnLkUSmoY11Z8IBJk7eD6hyD0XEHyGv6wYQ0+7a45qkTrTtfGcBO021QaL0580w
 C4GJl7QRIci6Qa37lDir7QKIP+vWb0TDCnRxaAjmFoq4TZVC1Mei3l44jN6cu/UyGpntJAL2/M
 l4eE2ugmeYQvSwC5TQbrdBpRnustD7H8jUL8Wa+i1TMubFIqL/NOpCoE//Y9UW4ydccmlcHMO3
 iW76l/on/YPqe3PVP52jvxd1UuBzfD35flgggmMmk8TeoiJlVlAZ8SvFclGNdCavA0ATT/yiPb
 r7exID3e76ZOKXWH6C9ys4mC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:28:56 -0700
IronPort-SDR: FyJ3JS+xd6u6x0kRBi+UzCTdS/ideGJUTU0EGtPQIWrNJf4PGXkGAipB5Z7CS7OrknrvJnb0Lx
 FbGBL7ccX8Y43eXmPHLOhK7fs/uZNhU3DM5ACsIQJH5k4+tWxLLSiS+da3olxp4rp5X4NLiyA4
 NmR92dzNz26KDyA1hg4zvnu4CX/OnmvD3Xv7GlSXiJsCMfcHmbHEuJX2HCtJZSiIHEzGumHtVK
 BcXbRoAMTfNIV2TuueCE06W4rA+NAkbwxxOIxt4m7Jo1CjcXeWzCHn6eML+UXAo01if3GeHslr
 Y98=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:11 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 00/27] btrfs zoned block device support
Date:   Thu,  8 Aug 2019 18:30:11 +0900
Message-Id: <20190808093038.4163421-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series adds zoned block device support to btrfs.

* Summary of changes from v2

The most significant change from v2 is the serialization of sequential
block allocation and submit_bio using per block group mutex instead of
waiting and sorting BIOs in a buffer. This per block group mutex now
locked before allocation and released after all BIOs submission
finishes. The same method is used for both data and metadata IOs.

By using a mutex instead of a submit buffer, we must disable
EXTENT_PREALLOC entirely in HMZONED mode to prevent deadlocks. As a
result, INODE_MAP_CACHE and MIXED_BG are disabled in HMZONED mode, and
relocation inode is reworked to use btrfs_wait_ordered_range() after
each relocation instead of relying on preallocated file region.

Furthermore, asynchronous checksum is disabled in and inline with the
serialized block allocation and BIO submission. This allows preserving
sequential write IO order without introducing any new functionality
such as submit buffers. Async submit will be removed once we merge
cgroup writeback support patch series.

* Patch series description

A zoned block device consists of a number of zones. Zones are either
conventional and accepting random writes or sequential and requiring
that writes be issued in LBA order from each zone write pointer
position. This patch series ensures that the sequential write
constraint of sequential zones is respected while fundamentally not
changing BtrFS block and I/O management for block stored in
conventional zones.

To achieve this, the default chunk size of btrfs is changed on zoned
block devices so that chunks are always aligned to a zone. Allocation
of blocks within a chunk is changed so that the allocation is always
sequential from the beginning of the chunks. To do so, an allocation
pointer is added to block groups and used as the allocation hint.  The
allocation changes also ensure that blocks freed below the allocation
pointer are ignored, resulting in sequential block allocation
regardless of the chunk usage.

While the introduction of the allocation pointer ensures that blocks
will be allocated sequentially, I/Os to write out newly allocated
blocks may be issued out of order, causing errors when writing to
sequential zones.  To preserve the ordering, this patch series adds
some mutexes around allocation and submit_bio and serialize
them. Also, this series disable async checksum and submit to avoid
mixing the BIOs.

The zone of a chunk is reset to allow reuse of the zone only when the
block group is being freed, that is, when all the chunks of the block
group are unused.

For btrfs volumes composed of multiple zoned disks, a restriction is
added to ensure that all disks have the same zone size. This
restriction matches the existing constraint that all chunks in a block
group must have the same size.

* Patch series organization

Patch 1 introduces the HMZONED incompatible feature flag to indicate
that the btrfs volume was formatted for use on zoned block devices.

Patches 2 and 3 implement functions to gather information on the zones
of the device (zones type and write pointer position).

Patches 4 to 8 disable features which are not compatible with the
sequential write constraints of zoned block devices. These includes
RAID5/6, space_cache, NODATACOW, TREE_LOG, and fallocate.

Patches 9 and 10 tweak the extent buffer allocation for HMZONED mode
to implement sequential block allocation in block groups and chunks.

Patch 11 and 12 handles the case when write pointers of devices which
compose e.g., RAID1 block group devices, are a mismatch.

Patch 13 implement a zone reset for unused block groups.

Patch 14 restrict the possible locations of super blocks to conventional
zones to preserve the existing update in-place mechanism for the super
blocks.

Patches 15 to 21 implement the serialization of allocation and
submit_bio for several types of IO (non-compressed data, compressed
data, direct IO, and metadata). These include re-dirtying once-freed
metadata blocks to prevent write holes.

Patch 22 and 23 disable features which are not compatible with the
serialization to prevent deadlocks. These include MIXED_BG and
INODE_MAP_CACHE.

Patches 24 to 26 tweak some btrfs features work with HMZONED
mode. These include device-replace, relocation, and repairing IO
error.

Finally, patch 27 adds the HMZONED feature to the list of supported
features.

* Patch testing note

This series is based on kdave/for-5.3-rc2.

Also, you need to cherry-pick the following commits to disable write
plugging with that branch. As described in commit b49773e7bcf3
("block: Disable write plugging for zoned block devices"), without
these commits, write plugging can reorder BIOs submitted from multiple
contexts, e.g., multiple extent_write_cached_pages().

0c8cf8c2a553 ("block: initialize the write priority in blk_rq_bio_prep")
f924cddebc90 ("block: remove blk_init_request_from_bio")
14ccb66b3f58 ("block: remove the bi_phys_segments field in struct bio")
c05f42206f4d ("blk-mq: remove blk_mq_put_ctx()")
970d168de636 ("blk-mq: simplify blk_mq_make_request()")
b49773e7bcf3 ("block: Disable write plugging for zoned block devices")

Furthermore, you need to apply the following patch if you run xfstests
with tcmu-loop disks. xfstests btrfs/003 failed to "_devmgt_add" after
"_devmgt_remove" without this patch.

https://marc.info/?l=linux-scsi&m=156498625421698&w=2

You can use tcmu-runer [1] to create an emulated zoned device backed
by a regular file. Here is a setup how-to:
http://zonedstorage.io/projects/tcmu-runner/#compilation-and-installation
                                                                                                                                                                                              
[1] https://github.com/open-iscsi/tcmu-runner

v2 https://lore.kernel.org/linux-btrfs/20190607131025.31996-1-naohiro.aota@wdc.com/
v1 https://lore.kernel.org/linux-btrfs/20180809180450.5091-1-naota@elisp.net/

Changelog
v3:
 - Serialize allocation and submit_bio instead of bio buffering in btrfs_map_bio().
 -- Disable async checksum/submit in HMZONED mode
 - Introduce helper functions and hmzoned.c/h (Josef, David)
 - Add support for repairing IO failure
 - Add support for NOCOW direct IO write (Josef)
 - Disable preallocation entirely
 -- Disable INODE_MAP_CACHE
 -- relocation is reworked not to rely on preallocation in HMZONED mode
 - Disable NODATACOW
 -Disable MIXED_BG
 - Device extent that cover super block position is banned (David)
v2:
 - Add support for dev-replace
 -- To support dev-replace, moved submit_buffer one layer up. It now
    handles bio instead of btrfs_bio.
 -- Mark unmirrored Block Group readonly only when there are writable
    mirrored BGs. Necessary to handle degraded RAID.
 - Expire worker use vanilla delayed_work instead of btrfs's async-thread
 - Device extent allocator now ensure that region is on the same zone type.
 - Add delayed allocation shrinking.
 - Rename btrfs_drop_dev_zonetypes() to btrfs_destroy_dev_zonetypes
 - Fix
 -- Use SECTOR_SHIFT (Nikolay)
 -- Use btrfs_err (Nikolay)

Naohiro Aota (27):
  btrfs: introduce HMZONED feature flag
  btrfs: Get zone information of zoned block devices
  btrfs: Check and enable HMZONED mode
  btrfs: disallow RAID5/6 in HMZONED mode
  btrfs: disallow space_cache in HMZONED mode
  btrfs: disallow NODATACOW in HMZONED mode
  btrfs: disable tree-log in HMZONED mode
  btrfs: disable fallocate in HMZONED mode
  btrfs: align device extent allocation to zone boundary
  btrfs: do sequential extent allocation in HMZONED mode
  btrfs: make unmirroed BGs readonly only if we have at least one
    writable BG
  btrfs: ensure metadata space available on/after degraded mount in
    HMZONED
  btrfs: reset zones of unused block groups
  btrfs: limit super block locations in HMZONED mode
  btrfs: redirty released extent buffers in sequential BGs
  btrfs: serialize data allocation and submit IOs
  btrfs: implement atomic compressed IO submission
  btrfs: support direct write IO in HMZONED
  btrfs: serialize meta IOs on HMZONED mode
  btrfs: wait existing extents before truncating
  btrfs: avoid async checksum/submit on HMZONED mode
  btrfs: disallow mixed-bg in HMZONED mode
  btrfs: disallow inode_cache in HMZONED mode
  btrfs: support dev-replace in HMZONED mode
  btrfs: enable relocation in HMZONED mode
  btrfs: relocate block group to repair IO failure in HMZONED
  btrfs: enable to mount HMZONED incompat flag

 fs/btrfs/Makefile           |   2 +-
 fs/btrfs/compression.c      |   5 +-
 fs/btrfs/ctree.h            |  37 +-
 fs/btrfs/dev-replace.c      | 155 +++++++
 fs/btrfs/dev-replace.h      |   3 +
 fs/btrfs/disk-io.c          |  29 ++
 fs/btrfs/extent-tree.c      | 277 +++++++++++--
 fs/btrfs/extent_io.c        |  22 +-
 fs/btrfs/extent_io.h        |   2 +
 fs/btrfs/file.c             |   4 +
 fs/btrfs/free-space-cache.c |  35 ++
 fs/btrfs/free-space-cache.h |   5 +
 fs/btrfs/hmzoned.c          | 785 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h          | 198 +++++++++
 fs/btrfs/inode.c            |  88 +++-
 fs/btrfs/ioctl.c            |   3 +
 fs/btrfs/relocation.c       |  39 +-
 fs/btrfs/scrub.c            |  89 +++-
 fs/btrfs/space-info.c       |  13 +-
 fs/btrfs/space-info.h       |   4 +-
 fs/btrfs/super.c            |   7 +
 fs/btrfs/sysfs.c            |   4 +
 fs/btrfs/transaction.c      |  10 +
 fs/btrfs/transaction.h      |   3 +
 fs/btrfs/volumes.c          | 207 +++++++++-
 fs/btrfs/volumes.h          |   5 +
 include/uapi/linux/btrfs.h  |   1 +
 27 files changed, 1980 insertions(+), 52 deletions(-)
 create mode 100644 fs/btrfs/hmzoned.c
 create mode 100644 fs/btrfs/hmzoned.h

-- 
2.22.0

