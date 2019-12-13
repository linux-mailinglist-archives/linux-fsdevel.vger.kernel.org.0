Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9823A11DCC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfLMEKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:10:38 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11856 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfLMEKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210237; x=1607746237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2uDN76Qs/oVvAcJQ7y4zOTlotzzFJz5XpK3hvaHVow8=;
  b=jSrObbL2GsDkBGeSD8uBPRaEdIMXpWKCCmDRPuNp5HHY5LZNwZUt4i0t
   VXJ32AlATAvsvM7alF8AX76fvzckPd89QdYOyihnJPMUPPmnZSGCjwRWK
   AIPnbSGbGlV+o6Vst3ePk5rwFnuCUhlF5/SyPPjCis5ijObD47DPc8eS7
   2Kgl6xQNkQcoWCvqw9Lu2VhearnCoif+wvzp9EWL/lCG6ATA0XBQrCea/
   JuOJe2qG/and5+p3hZ510itmgFf0cdM7Tp7arNrk4TjJ98Flmc1cK3mDc
   n6Q+a7Gjt2VaLh9bchq/yw8Lkb2b7XzFUJ+2a95fjqlGip/zPLdyVoMz1
   g==;
IronPort-SDR: UDP/yFeLZnMu8USPV4JcunqDjsGDbqDp8QkHnJqfSM1Q/A/QbS7owXtzas0DgUDvZ0dtdeg8Xd
 sZ2uUHG8JcHS77bZbsm58RP/aSmpZXXaIIJMEdioVJ/YPR2FVIlJnJOGbjfk2RYt+K/XBWDp7d
 sGhWLk7peJnVi0LZjDz7F/Objz2MmYlYUYD3FQNHvf3HOI64rzzbgbriRuxHYeqooTTZVzQcWi
 xZK3zXplximPgEi9uQQWusSHe7Rv3Jd0y7VWpidJFNoLZ3il9ZgJk0jUVH+OQ/gabcNdlxPH6F
 j+Q=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860091"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:10:37 +0800
IronPort-SDR: 9lClh/QSKYGdn7fodU0XufcggyjbsMq05NQEpcfr6REgPdd7tTbvYLzbYOnuJC5NsBI+Z3CjlB
 yYSj0K1ctOfLoB6CziKMYXoJlI1mfv9dxj9zyr1AF+OPe+WeXz5I2ORdCyElYXkUULJF55djH0
 oMAsQSci4t4VtqoZ5doak8pz+AD9PNYNV+7/X6TLR5j5k0fFfTSZ2qihjfh6Lf5oWCFAQOgQTW
 s4xtqmwpLm7uJUAIIqvxQqg/iriEPwfWHt7LWSmtiCROgU2zDzPELrSty0H7iS48KdwCEKeq01
 rwBSADReD3KC/H0VYPVWQ36d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:08 -0800
IronPort-SDR: s8j8DhbtvqOGyEwkZ0n9aASS5A0s9+UCD5OCWCwi7VLZYeTK4TfpzGPhl8YoxS7kWARNqZxRO/
 DF5M8thhN1uTqhiBKh26878OMminNw072ETlIGifppMXOC4ATimUgAgPwpypqE5DQw0q6l/yTk
 GOBauCpzgRkLXqKsWZiVtXL/OejORsJb600oksinxA8TwQ3QiJxS+C2qutCJ4BYiLrYcOLJly+
 KhUnGz13m4Cqvlr6JAprXriiobL1kJmZwDZ49qUOI/lyI7e7yAxPDlUgXPGrfAnU9bGKqjUT2N
 paU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:10:34 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 00/28] btrfs: zoned block device support
Date:   Fri, 13 Dec 2019 13:08:47 +0900
Message-Id: <20191213040915.3502922-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series adds zoned block device support to btrfs.

Changes:
 - Changed -EINVAL to -EOPNOTSUPP to reject incompatible features
   within HMZONED mode (David)
 - Use bitmap helpers (Johannes)
 - Fix calculation of a string length
 - Code cleanup

Userland series is unchaged with the last version:
https://lore.kernel.org/linux-btrfs/20191204082513.857320-1-naohiro.aota@wdc.com/T/

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

* Serialization of write IOs

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

* Enabling tree-log

The tree-log feature does not work on HMZONED mode as is. Blocks for a
tree-log tree are allocated mixed with other metadata blocks, and btrfs
writes and syncs the tree-log blocks to devices at the time of fsync(),
which is different timing than a global transaction commit. As a result,
both writing tree-log blocks and writing other metadata blocks become
non-sequential writes which HMZONED mode must avoid.

This series introduces a dedicated block group for tree-log blocks to
create two metadata writing streams, one for tree-log blocks and the
other for metadata blocks. As a result, each write stream can now be
written to devices separately and sequentially.

* Log-structured superblock

Superblock (and its copies) is the only data structure in btrfs which
has a fixed location on a device. Since we cannot overwrite in a
sequential write required zone, we cannot place superblock in the
zone.

This series implements superblock log writing. It uses two zones as a
circular buffer to write updated superblocks. Once the first zone is
filled up, start writing into the second zone and reset the first
one. We can determine the postion of the latest superblock by reading
the write pointer information from a device.

* Patch series organization

Patch 1 introduces the HMZONED incompatible feature flag to indicate that
the btrfs volume was formatted for use on zoned block devices.

Patches 2 and 3 implement functions to gather information on the zones of
the device (zones type and write pointer position).

Patches 4 to 7 disable features which are not compatible with the
sequential write constraints of zoned block devices. These includes
RAID5/6, space_cache, NODATACOW, and fallocate.

Patch 8 implements the log-structured superblock writing.

Patches 9 and 10 tweak the extent buffer allocation for HMZONED mode
to implement sequential block allocation in block groups and chunks.

Patch 11 and 12 handles the case when write pointers of devices which
compose e.g., RAID1 block group devices, are a mismatch.

Patch 13 implement a zone reset for unused block groups.

Patches 14 to 20 implement the serialization of allocation and submit_bio
for several types of IO (non-compressed data, compressed data, direct IO,
and metadata). These include re-dirtying once-freed metadata blocks to
prevent write holes.

Patch 21 and 22 disable features which are not compatible with the
serialization to prevent deadlocks. These include MIXED_BG and
INODE_MAP_CACHE.

Patches 23 to 27 tweak some btrfs features work with HMZONED mode. These
include device-replace, relocation, repairing IO error, and tree-log.

Finally, patch 28 adds the HMZONED feature to the list of supported
features.

* Patch testing note

This series is based on kdave/for-5.5.

** Zone-aware util-linux

Since the log-structured superblock feature changed the location of
superblock magic, the current util-linux (libblkid) cannot detect
HMZONED btrfs anymore. You need to apply a to-be posted patch to
util-linux to make it "zone aware".

** Testing device

You can use tcmu-runer [1] to create an emulated zoned device backed
by a regular file. Here is a setup how-to:
http://zonedstorage.io/projects/tcmu-runner/#compilation-and-installation

[1] https://github.com/open-iscsi/tcmu-runner

You can also attach SMR disks on a host machine to a guest VM. Here is
a guide:
http://zonedstorage.io/projects/qemu/

** xfstests

We ran xfstests on HMZONED btrfs, and, if we omit some cases that are
known to fail currently, all test cases pass.

Cases that can be ignored:
1) failing also with the regular btrfs on regular devices,
2) trying to test fallocate feature without testing with
   "_require_xfs_io_command "falloc"",
3) trying to test incompatible features for HMZONED btrfs (e.g. RAID5/6)
4) trying to use incompatible setup for HMZONED btrfs (e.g. dm-linear
   not aligned to zone boundary, swap)
5) trying to create a file system with too small size, (we require at
   least 9 zones to initiate a HMZONED btrfs)
6) dropping original MKFS_OPTIONS ("-O hmzoned"), so it cannot create
   HMZONED btrfs (btrfs/003)
7) having ENOSPC which incurred by larger metadata block group size [2]

I will send a patch series for xfstests to handle these cases (2-6)
properly.

[2] For example, generic/275 try to fill a file system and see the
    ENOSPC behaviors. It creates 2GB (= 8 zones * 256 MB/zone) file
    system and tries to fill the FS using the "df"'s block
    count. Since we use 5 zones (1 for a superblock, 2 * 2 for
    meta/system dup), we cannot fill the FS over 51%. And the test
    fails telling us "could not sufficiently fill filesystem."

Also, you need to apply the following patch if you run xfstests with
tcmu devices. xfstests btrfs/003 failed to "_devmgt_add" after
"_devmgt_remove" without this patch.

https://marc.info/?l=linux-scsi&m=156498625421698&w=2

v4 https://lwn.net/Articles/797061/
v3 https://lore.kernel.org/linux-btrfs/20190808093038.4163421-1-naohiro.aota@wdc.com/
v2 https://lore.kernel.org/linux-btrfs/20190607131025.31996-1-naohiro.aota@wdc.com/
v1 https://lore.kernel.org/linux-btrfs/20180809180450.5091-1-naota@elisp.net/

Changelog
v6:
 - Use bitmap helpers (Johannes)
 - Code cleanup (Johannes)
 - Rebased on kdave/for-5.5
 - Enable the tree-log feature.
 - Treat conventional zones as sequential zones, so we can now allow
   mixed allocation of conventional zone and sequential write required
   zone to construct a block group.
 - Implement log-structured superblock
   - No need for one conventional zone at the beginning of a device.
 - Fix deadlock of direct IO writing
 - Fix building with !CONFIG_BLK_DEV_ZONED (Johannes)
 - Fix leak of zone_info (Johannes)
v5:
 - Rebased on kdave/for-5.5
 - Enable the tree-log feature.
 - Treat conventional zones as sequential zones, so we can now allow
   mixed allocation of conventional zone and sequential write required
   zone to construct a block group.
 - Implement log-structured superblock
   - No need for one conventional zone at the beginning of a device.
 - Fix deadlock of direct IO writing
 - Fix building with !CONFIG_BLK_DEV_ZONED (Johannes)
 - Fix leak of zone_info (Johannes)
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

Naohiro Aota (28):
  btrfs: introduce HMZONED feature flag
  btrfs: Get zone information of zoned block devices
  btrfs: Check and enable HMZONED mode
  btrfs: disallow RAID5/6 in HMZONED mode
  btrfs: disallow space_cache in HMZONED mode
  btrfs: disallow NODATACOW in HMZONED mode
  btrfs: disable fallocate in HMZONED mode
  btrfs: implement log-structured superblock for HMZONED mode
  btrfs: align device extent allocation to zone boundary
  btrfs: do sequential extent allocation in HMZONED mode
  btrfs: make unmirroed BGs readonly only if we have at least one
    writable BG
  btrfs: ensure metadata space available on/after degraded mount in
    HMZONED
  btrfs: reset zones of unused block groups
  btrfs: redirty released extent buffers in HMZONED mode
  btrfs: serialize data allocation and submit IOs
  btrfs: implement atomic compressed IO submission
  btrfs: support direct write IO in HMZONED
  btrfs: serialize meta IOs on HMZONED mode
  btrfs: wait existing extents before truncating
  btrfs: avoid async checksum on HMZONED mode
  btrfs: disallow mixed-bg in HMZONED mode
  btrfs: disallow inode_cache in HMZONED mode
  btrfs: support dev-replace in HMZONED mode
  btrfs: enable relocation in HMZONED mode
  btrfs: relocate block group to repair IO failure in HMZONED
  btrfs: split alloc_log_tree()
  btrfs: enable tree-log on HMZONED mode
  btrfs: enable to mount HMZONED incompat flag

 fs/btrfs/Makefile           |    1 +
 fs/btrfs/block-group.c      |  124 +++-
 fs/btrfs/block-group.h      |   15 +
 fs/btrfs/ctree.h            |   10 +-
 fs/btrfs/dev-replace.c      |  186 +++++
 fs/btrfs/dev-replace.h      |    3 +
 fs/btrfs/disk-io.c          |   74 +-
 fs/btrfs/disk-io.h          |    2 +
 fs/btrfs/extent-tree.c      |  194 ++++-
 fs/btrfs/extent_io.c        |   33 +-
 fs/btrfs/extent_io.h        |    2 +
 fs/btrfs/file.c             |    4 +
 fs/btrfs/free-space-cache.c |   38 +
 fs/btrfs/free-space-cache.h |    2 +
 fs/btrfs/hmzoned.c          | 1329 +++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h          |  300 ++++++++
 fs/btrfs/inode.c            |  107 ++-
 fs/btrfs/ioctl.c            |    3 +
 fs/btrfs/relocation.c       |   39 +-
 fs/btrfs/scrub.c            |  148 +++-
 fs/btrfs/space-info.c       |   13 +-
 fs/btrfs/space-info.h       |    4 +-
 fs/btrfs/super.c            |   12 +-
 fs/btrfs/sysfs.c            |    4 +
 fs/btrfs/transaction.c      |   10 +
 fs/btrfs/transaction.h      |    3 +
 fs/btrfs/tree-log.c         |   49 +-
 fs/btrfs/volumes.c          |  226 +++++-
 fs/btrfs/volumes.h          |    5 +
 include/uapi/linux/btrfs.h  |    1 +
 30 files changed, 2858 insertions(+), 83 deletions(-)
 create mode 100644 fs/btrfs/hmzoned.c
 create mode 100644 fs/btrfs/hmzoned.h

-- 
2.24.0

