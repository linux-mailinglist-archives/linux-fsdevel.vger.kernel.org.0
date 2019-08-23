Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F83E9ACA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404054AbfHWKLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:13 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47762 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403955AbfHWKLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555072; x=1598091072;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=johZ3eEmJ7Y/r5f5FRznclycBRDrptdIfjF4T4dC6Wo=;
  b=MLiELV07c89x1kezqUsecsM5YA34kKhQ1vfSJefItqa32PuLaT6zSQNe
   6cZllDmMOFDY92KK5Wg0ZL2clCTT5amOp7e5QL5yaeSnRdhCSYy7s30Z3
   q2WrjPeK+/BAq3kwq9BOzuvGRCi1AnSwxhzKVoKMimLn03KktPDP6uZ13
   e8t9sNLu3W4Zbrx40MRWF+rZhx9EXS/0mySv4KiANrsem9dF8Lim75Srw
   I5OVJpDyfaaYbzv2eY+wPF+GOAjr2uRj5FG6hMKjysOBFtSDB90fB+dSK
   2zBJoMkP+HNdkCg8pjo1OcXobHpuneF5pbK6pxawaXefUXVcWrdFAx1Xa
   Q==;
IronPort-SDR: Qv4P9sC5k3TtIH9bDIZcBFrMkmFVpZOqxvWK9eJsbcVQs9bW/RpMkjZXRLDFG/H0cdBtZWzCi/
 68m5u3TV9ANra6/bwZUnhlTe2bZJl6nRbvG3cBTmevbZ1y7IiK10KpPWvSIw2lj2/CUkDWvDnI
 FFas593EyUFe/3zZdn9dCDOiE80XuyNTrWZT5A6inzq+N7HcekvLncDYotOvNESjX8cjgQEXQj
 MhOv6CklHN/gMEABWMF5aQMvf9qQ23FuVtAdjwgBErdsJXH28XmZ7w9ldFHbwDMfQpxLs4nNIf
 mm8=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096227"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:10 +0800
IronPort-SDR: cLE20ZULspzFZCu9I0F9BvIg8tbZ8A9c5cUHL0+CRYs+VfMRUJaaztocesy3a0UN77M3ExUOg9
 B4zunWnD+BiI1X57vgU9k3N+Ur2b4ie1FcNHeXeZ6/22u7WSYjY+XlIoYBf3xXKxrlkzzdOLRY
 7DjPEPsy652bP1OTzZjT65kNy2dTeqa+uCMaFpftg14RUat1mILAZKFZLMo++/Ae8XmyGf/CuU
 Fw98nvB9SSGH9Zb/ro8u6pKeWPBB0UTvEU7dpxTT60CcEdNhyzC6VDRFwmCjaIAnDqlLh08BnX
 hH+jB0YEFEqJjwzOxlEEITX4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:28 -0700
IronPort-SDR: oVbyAQih1lrni9oQaY1JxmQ9SwuEquPyN68og0ucE+8TvlNFoh0BPunK1X21uTHA/RkREXztqD
 1AcEBkGSOGF2iKNgkGDYmULsavd2KochEhmwE+e0tIUxD7ce/whqwjq683SuHBObAbxXWEZGdf
 /YuvfTdWCCQPEHW6M2C+htsTZdXPMrHL3ekQxbOFYzo44AMlGP/CesQhuTpMFFBdqoDdvSaP2t
 XN9IVtuY3T+xy4SzBVwdpzExuGrB0U+9YZzLOesDqFo817S9dr69voVaUOIYkb0efNZgpRMxrq
 n+0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 00/27] btrfs zoned block device support
Date:   Fri, 23 Aug 2019 19:10:09 +0900
Message-Id: <20190823101036.796932-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series adds zoned block device support to btrfs.

This v4 is slightly fixed version of v3:

Changes:
 - Move memory allcation of zone informattion out of
   btrfs_get_dev_zones() (Anand)
 - Add disabled features table in commit log (Anand)
 - Ensure "max_chunk_size >= devs_min * data_stripes * zone_size"

Userland series (unchanged):
https://lore.kernel.org/linux-btrfs/20190820045258.1571640-1-naohiro.aota@wdc.com/T/

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

v3 https://lore.kernel.org/linux-btrfs/20190808093038.4163421-1-naohiro.aota@wdc.com/
v2 https://lore.kernel.org/linux-btrfs/20190607131025.31996-1-naohiro.aota@wdc.com/
v1 https://lore.kernel.org/linux-btrfs/20180809180450.5091-1-naota@elisp.net/

Changelog
v4:
 - Move memory allcation of zone informattion out of
   btrfs_get_dev_zones() (Anand)
 - Add disabled features table in commit log (Anand)
 - Ensure "max_chunk_size >= devs_min * data_stripes * zone_size"
v3:
 - Serialize allocation and submit_bio instead of bio buffering in
   btrfs_map_bio().
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
 fs/btrfs/super.c            |  15 +-
 fs/btrfs/sysfs.c            |   4 +
 fs/btrfs/transaction.c      |  10 +
 fs/btrfs/transaction.h      |   3 +
 fs/btrfs/volumes.c          | 212 +++++++++-
 fs/btrfs/volumes.h          |   5 +
 include/uapi/linux/btrfs.h  |   1 +
 27 files changed, 1991 insertions(+), 54 deletions(-)
 create mode 100644 fs/btrfs/hmzoned.c
 create mode 100644 fs/btrfs/hmzoned.h

-- 
2.23.0

