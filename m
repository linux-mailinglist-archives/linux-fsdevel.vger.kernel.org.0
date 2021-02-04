Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91F430F078
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhBDKYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:24:02 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54215 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbhBDKYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434239; x=1643970239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AfKxy3V5fRCeGWEijtRKvUM90jHEdUIpacN0TtVCq10=;
  b=IS2Q0O92ZVvbX4u+cg837SSL/siHNdy/rOQoABZMpgHTe1C5hpCD5nRF
   0r1jamAWWYpsapfnTVbMXUZMuUe3r/dZZlg3Eg/+BVyylUB2sEFFrKHHc
   wNhH8SYsL5y8oWbUZrhzE6BU1zoTqEG8uAbt4Lcd0qjCMuloGvcwNCISD
   pgV8zVWN+6AyzUzFZThtMQijpTVPZxLFmTYXzchdaum4wCsB066u6Lwef
   5XZHxhCWVZq/Avabr6xYczV9ZhYSCluU1QsLvgIaKIkBdXgXU+Wdr5+KR
   3g7ErLv7HZlTbqo0lBKBwAYSFN06TXrtRGul2gEttysbzVvYzKlOPJAdu
   g==;
IronPort-SDR: Uzk/DZyNORdrXN4Swl3d8QmqDZObenacR0AhbIQYyAleSDycRHXwHp6bQWs351qAYVAY6pBgR4
 zy8aPYWj54yHeb4B3CzowDdQV6tk4jv3ogVR1KC4kgTopBI6I2zoVIgGKQIVIba48BI8QNW4cm
 Ho1MPRTdTz92PLMNftdopj+MVhH5GOoeX7cE4bAUii9R2bQsScaI3A2KItHJ4Zc3PbVEhjtJo5
 ZeU9jD7J1wGueojWYtch7aeCQxXuVVKCoSmaCwPcqpGN/2Zxyv1YIMyyzAA0izX3Nn4dYremuh
 kRU=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107939"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:22:53 +0800
IronPort-SDR: 8b3XuRIbOZ8DASrXA5NChhJejJQA6T3bLwdHKcT6onM/iGGofGFKhH+fAPp9gubGSDiv2wPuJW
 yrB+UzHd+u7a0HDNihZtOdM9ImZhI8PXKWZYCBek0FHSInatYob/cg2aX6fjH5NjyH2xL4qaHB
 syzchtv1shimWuWWhoLfOazTrNUPp56WITyzdmYy30h0sQXSuDhOWZNyNCi3pDmTnsUM2MOC0M
 CSrGslRuzgdAKdtxerPUeUsgMWYJLg9AH30tOZDcI6x+GeSgrS2QyQt6jSEu+0baca8X6i38pT
 po5K69W5Cim7RTEJ9BSBkHjd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:04:57 -0800
IronPort-SDR: DFp4eYRRuzaQDbC8K661Um6R9JMkILp9L+Vhy8jvcKX8kNNg8xb2jr25x9XkL63JfK4DjGwMmd
 SGDjcdfNlV14s0sNYwL+6aUrrIg0DqldGeXl0ZfJ5bhIWElAA8xOyzm9z9SOjfdAXBqh8O+FnE
 4B7qAmIeWxXxgNPp7RZSTT8hyPadom4W4XZ457qkzhieFcHb1nsiBcXUwrBugR/PK9lMFpEoSy
 JVGSDeYyYSASGJeu28yyoOLMxdXW7voGkjiowQ+fsH+DVnTNtAC00ZGPTOtNIjF4S8m1KlIvPt
 gQE=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:22:53 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v15 00/42] btrfs: zoned block device support
Date:   Thu,  4 Feb 2021 19:21:39 +0900
Message-Id: <cover.1612433345.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series adds zoned block device support to btrfs. Some of the patches
in the previous series are already merged as preparation patches.

This series and related changes to userland tools are also available on
github.

Kernel   https://github.com/naota/linux/tree/btrfs-zoned-v15
Userland https://github.com/naota/btrfs-progs/tree/btrfs-zoned
xfstests https://github.com/naota/fstests/tree/btrfs-zoned

Userland tool depends on patched util-linux (libblkid and wipefs) to handle
log-structured superblock. To ease the testing, pre-compiled static linked
userland tools are available here:
https://wdc.app.box.com/s/fnhqsb3otrvgkstq66o6bvdw6tk525kp

Followup work will address several areas that can be improved.

- Splitting an ordered extent: as we need to enforce the rule one BIO ==
  one ordered extent, the BIO submission path could be improved to not
  require splitting ordered extents, but rather, to create ordered extents
  that can be processed with a single BIO.
- Redirtying freed tree blocks: switch to keeping the blocks dirty
- Dedicated tree-log block group: We need a tree-log for zoned device for
  performance reasons. Dbench (32 clients) is 85% slower with "-o
  notreelog".  However, we need to separate tree-log block group from other
  metadata space_info to avoid premature ENOSPC problem
- Relocation: Use normal write command for relocation. Also, relocated
  device extents must be reset and they should be discarded on regular
  btrfs too.
- Support for zone capacity smaller than zone size (NVMe ZNS devices)
- Support device open and active zones limits (NVMe ZNS devices)

Also, we are leaving a fix for "btrfs: serialize log transaction on zoned
filesystem" for later. Filipe pointed out that fsync() on zoned filesystem
fallback to a full transaction commit even without concurrency, leading to
performance degradation. There is a fix for this issue itself. However, the
fix revealed other failures in fsync() path. Current code is slower but
working.  So, we leave this performance fix for later.

Changes from v14(+ fixed in for-next)
  - Fix commit log, messages and comment styles (David)
  - Added some comments to code
  - Do not always call inode_need_compress() (patch 29)
  - Fix double unlock in mark_block_group_to_copy() (patch 33)
  - Do not limit parallelism for non-zoned FS (patch 41)

btrfs-progs and xfstests series will follow.

This version of ZONED btrfs switched from normal write command to zone
append write command. You do not need to specify LBA (at the write pointer)
to write for zone append write command. Instead, you only select a zone to
write with its start LBA. Then the device (NVMe ZNS), or the emulation of
zone append command in the sd driver in the case of SAS or SATA HDDs,
automatically writes the data at the write pointer position and return the
written LBA as a command reply.

The benefit of using the zone append write command is that write command
issuing order does not matter. So, we can eliminate block group lock and
utilize asynchronous checksum, which can reorder the IOs.

Eliminating the lock improves performance. In particular, on a workload
with massive competing to the same zone [1], we observed 36% performance
improvement compared to normal write.

[1] Fio running 16 jobs with 4KB random writes for 5 minutes

However, there are some limitations. We cannot use the non-SINGLE profile.
Supporting non-SINGLE profile with zone append writing is not trivial. For
example, in the DUP profile, we send a zone append writing IO to two zones
on a device. The device reply with written LBAs for the IOs. If the offsets
of the returned addresses from the beginning of the zone are different,
then it results in different logical addresses.

For the same reason, we cannot issue multiple IOs for one ordered extent.
Thus, the size of an ordered extent is limited under max_zone_append_size.
This limitation will cause fragmentation and increased usage of metadata.
In the future, we can add optimization to merge ordered extents after
end_bio.

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

The zone of a chunk is reset to allow reuse of the zone only when the
block group is being freed, that is, when all the chunks of the block
group are unused.

For btrfs volumes composed of multiple zoned disks, a restriction is
added to ensure that all disks have the same zone size. This
restriction matches the existing constraint that all chunks in a block
group must have the same size.

* Enabling tree-log

The tree-log feature does not work on ZONED mode as is. Blocks for a
tree-log tree are allocated mixed with other metadata blocks, and btrfs
writes and syncs the tree-log blocks to devices at the time of fsync(),
which is different timing than a global transaction commit. As a result,
both writing tree-log blocks and writing other metadata blocks become
non-sequential writes which ZONED mode must avoid.

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
circular buffer to write updated superblocks. Once the first zone is filled
up, start writing into the second zone. The first zone will be reset once
both zones are filled. We can determine the postion of the latest
superblock by reading the write pointer information from a device.

* Patch series organization

Patches 1 and 2 are preparing patches for block and iomap layer.

Patches 3 to 7 are fixes for previous patches or preparing for the latter
patches.

Patch 8 implements emulated zoned mode for non-zoned devices.

Patches 9 and 10 tweak the device extent allocation for ZONED mode and add
verification to check if a device extent is properly aligned to zones.

Patches 11 to 14 implements sequential block allocator for ZONED mode.

Patches 15 and 16 tweak some btrfs features work with emulated ZONED mode.
These include re-dirtying (and pinning) of once-freed metadata blocks to
prevent write holes, and advancing the allocation offset for tree-log node
blocks.

Patches 17 and later are for real zoned devices.

Patch 17 implement a zone reset for unused block groups.

Patches 18 to 31 implement the writing path for several types of IO
(non-compressed data, direct IO, and metadata). These include re-dirtying
once-freed metadata blocks to prevent write holes.

Patches 32 to 41 tweak some btrfs features work with ZONED mode. These
include device-replace, relocation, repairing IO error, and tree-log.

Patch 42 adds the ZONED feature to the list of supported features.

* Patch testing note

** Zone-aware util-linux

Since the log-structured superblock feature changed the location of
superblock magic, the current util-linux (libblkid) cannot detect ZONED
btrfs anymore. You need to apply a to-be posted patch to util-linux to make
it "zone aware".

** Testing device

You need devices with zone append writing command support to run ZONED
btrfs.

Other than real devices, null_blk supports zone append write command. You
can use memory backed null_blk to run the test on it. Following script
creates 12800 MB /dev/nullb0.

    sysfs=/sys/kernel/config/nullb/nullb0
    size=12800 # MB
    
    # drop nullb0
    if [[ -d $sysfs ]]; then
            echo 0 > "${sysfs}"/power
            rmdir $sysfs
    fi
    lsmod | grep -q null_blk && rmmod null_blk
    modprobe null_blk nr_devices=0
    
    mkdir "${sysfs}"
    
    echo "${size}" > "${sysfs}"/size
    echo 1 > "${sysfs}"/zoned
    echo 0 > "${sysfs}"/zone_nr_conv
    echo 1 > "${sysfs}"/memory_backed
    
    echo 1 > "${sysfs}"/power
    udevadm settle

Zoned SCSI devices such as SMR HDDs or scsi_debug also support the zone
append command as an emulated command within the SCSI sd driver. This
emulation is completely transparent to the user and provides the same
semantic as a NVMe ZNS native drive support.

Also, there is a qemu patch available to enable NVMe ZNS device.

** xfstests

We ran xfstests on ZONED btrfs, and, if we omit some cases that are known
to fail currently, all test cases pass.

Cases that can be ignored:
1) failing also with the regular btrfs on regular devices,
2) trying to test fallocate feature without testing with
   "_require_xfs_io_command "falloc"",
3) trying to test incompatible features for ZONED btrfs (e.g. RAID5/6)
4) trying to use incompatible setup for ZONED btrfs (e.g. dm-linear not
   aligned to zone boundary, swap)
5) trying to create a file system with too small size, (we require at least
   9 zones to initiate a ZONED btrfs)
6) dropping original MKFS_OPTIONS ("-O zoned"), so it cannot create ZONED
   btrfs (btrfs/003)
7) having ENOSPC which incurred by larger metadata block group size

I will send a patch series for xfstests to handle these cases (2-6)
properly.

Patched xfstests is available here:

https://github.com/naota/fstests/tree/btrfs-zoned

Also, you need to apply the following patch if you run xfstests with
tcmu devices. xfstests btrfs/003 failed to "_devmgt_add" after
"_devmgt_remove" without this patch.

https://marc.info/?l=linux-scsi&m=156498625421698&w=2

v14 https://lore.kernel.org/linux-btrfs/SN4PR0401MB359814032CDF9889ED2DA7FA9BB89@SN4PR0401MB3598.namprd04.prod.outlook.com/T/
v13 https://lore.kernel.org/linux-btrfs/cover.1611295439.git.naohiro.aota@wdc.com/T/
v12 https://lore.kernel.org/linux-btrfs/cover.1610693036.git.naohiro.aota@wdc.com/T/
v11 https://lore.kernel.org/linux-btrfs/SN4PR0401MB35989E15509A0D36CBC35B109BAA0@SN4PR0401MB3598.namprd04.prod.outlook.com/T/#t
v10 https://lore.kernel.org/linux-btrfs/cover.1605007036.git.naohiro.aota@wdc.com/
v9 https://lore.kernel.org/linux-btrfs/cover.1604065156.git.naohiro.aota@wdc.com/
v8 https://lore.kernel.org/linux-btrfs/cover.1601572459.git.naohiro.aota@wdc.com/
v7 https://lore.kernel.org/linux-btrfs/20200911123259.3782926-1-naohiro.aota@wdc.com/
v6 https://lore.kernel.org/linux-btrfs/20191213040915.3502922-1-naohiro.aota@wdc.com/
v5 https://lore.kernel.org/linux-btrfs/20191204082513.857320-1-naohiro.aota@wdc.com/
v4 https://lwn.net/Articles/797061/
v3 https://lore.kernel.org/linux-btrfs/20190808093038.4163421-1-naohiro.aota@wdc.com/
v2 https://lore.kernel.org/linux-btrfs/20190607131025.31996-1-naohiro.aota@wdc.com/
v1 https://lore.kernel.org/linux-btrfs/20180809180450.5091-1-naota@elisp.net/

Changelog
v13
  - Rebased on the latest misc-next
    - Fix conflicts
  - Bug fix
    - Fix use-after-free in read_one_block_group() (Patch 05)
    - Set ffe_ctl->max_extent_size and total_free_size properly (Patch 14)
    - Add check if a bio spans across ordered extents (Patch 23)
  - Add comment.
v12
 - Addressed the review comments
   - Add @return to btrfs_bio_add_page()
   - Load and pass struct btrfs_block_group_item* to read_one_block_group
   - Remove lock contention from transaction log serialisation
   - Introduce btrfs_clear_treelog_bg() helper
   - Do not eat errored return value in calculate_alloc_pointer()
   - Handle errors from btrfs_add_ordered_extent() in clone_ordered_extent()
   - Use btrfs_is_zoned in btrfs_ioctl_fitrim()
   - Code style and commit message fix
 - Use the same SB locations as regular btrfs if the device is non-zoned.
 - Remove "force_zoned" flag since it's no longer necessary by delaying the
   load of zone info.
 - Added comments.
v11
  - Added emulated zoned mode support.
    - Change superblock (SB) location on conventional zones to unify the
      location of primary SB on regular btrfs and emulated zoned btrfs.
    - Move zone info loading later to open_ctre() stage to determine
      emulated zone size from the size of device extents.
  - Set REQ_OP_ZONE_APPEND only if the block group is on a sequential zone.
  - Disallow fitrim on zoned mode for now.
  - Mark fully zone_unusable block group as unused, so that it can be
    reclaimed soon.
  - Replace: do not issue zero out on conventional zones.
  - Add treelog_bg_lock's lock order description.
  - Open code btrfs_align_offset_to_zone() and
    dev_extent_search_start_zoned() (Anand).

  - Bug fix:
    - Re-check pending extent if device extent hole is changed by
      dev_extent_hole_check_zoned() 
    - Do not load allocation pointer for new block group on conventional
      zones to avoid deadlock.
v10
  - Added emulated zoned mode support.
    - Change superblock (SB) location on conventional zones to unify the
      location of primary SB on regular btrfs and emulated zoned btrfs.
    - Move zone info loading later to open_ctre() stage to determine
      emulated zone size from the size of device extents.
  - Set REQ_OP_ZONE_APPEND only if the block group is on a sequential zone.
  - Disallow fitrim on zoned mode for now.
  - Mark fully zone_unusable block group as unused, so that it can be
    reclaimed soon.
  - Replace: do not issue zero out on conventional zones.
  - Add treelog_bg_lock's lock order description.
  - Open code btrfs_align_offset_to_zone() and
    dev_extent_search_start_zoned() (Anand).

  - Bug fix:
    - Re-check pending extent if device extent hole is changed by
      dev_extent_hole_check_zoned() 
    - Do not load allocation pointer for new block group on conventional
      zones to avoid deadlock.

v9
 - Direct-IO path now follow several hardware restrictions (other than
   max_zone_append_size) by using ZONE_APPEND support of iomap
 - introduces union of fs_info->zone_size and fs_info->zoned [Johannes]
   - and use btrfs_is_zoned(fs_info) in place of btrfs_fs_incompat(fs_info, ZONED)
 - print if zoned is enabled or not when printing module info [Johannes]
 - drop patch of disabling inode_cache on ZONED
 - moved for_teelog flag to a proper location [Johannes]
 - Code style fixes [Johannes]
 - Add comment about adding physical layer things to ordered extent
   structure
 - Pass file_offset explicitly to extract_ordered_extent() instead of
   determining it from bio
 - Bug fixes
   - write out fsync region so that the logical address of ordered extents
     and checksums are properly finalized
   - free zone_info at umount time
   - fix superblock log handling when entering zones[1] in the first time
   - fixes double free of log-tree roots [Johannes] 
   - Drop erroneous ASSERT in do_allocation_zoned()
v8
 - Use bio_add_hw_page() to build up bio to honor hardware restrictions
   - add bio_add_zone_append_page() as a wrapper of the function
 - Split file extent on submitting bio
   - If bio_add_zone_append_page() fails, split the file extent and send
     out bio
   - so, we can ensure one bio == one file extent
 - Fix build bot issues
 - Rebased on misc-next
v7:
 - Use zone append write command instead of normal write command
   - Bio issuing order does not matter
   - No need to use lock anymore
   - Can use asynchronous checksum
 - Removed RAID support for now
 - Rename HMZONED to ZONED
 - Split some patches
 - Rebased on kdave/for-5.9-rc3 + iomap direct IO
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

Johannes Thumshirn (7):
  block: add bio_add_zone_append_page
  btrfs: release path before calling to btrfs_load_block_group_zone_info
  btrfs: zoned: do not load fs_info::zoned from incompat flag
  btrfs: zoned: allow zoned filesystems on non-zoned block devices
  btrfs: zoned: check if bio spans across an ordered extent
  btrfs: zoned: cache if block-group is on a sequential zone
  btrfs: save irq flags when looking up an ordered extent

Naohiro Aota (35):
  iomap: support REQ_OP_ZONE_APPEND
  btrfs: zoned: defer loading zone info after opening trees
  btrfs: zoned: use regular super block location on zone emulation
  btrfs: zoned: disallow fitrim on zoned filesystems
  btrfs: zoned: implement zoned chunk allocator
  btrfs: zoned: verify device extent is aligned to zone
  btrfs: zoned: load zone's allocation offset
  btrfs: zoned: calculate allocation offset for conventional zones
  btrfs: zoned: track unusable bytes for zones
  btrfs: zoned: implement sequential extent allocation
  btrfs: zoned: redirty released extent buffers
  btrfs: zoned: advance allocation pointer after tree log node
  btrfs: zoned: reset zones of unused block groups
  btrfs: factor out helper adding a page to bio
  btrfs: zoned: use bio_add_zone_append_page
  btrfs: zoned: handle REQ_OP_ZONE_APPEND as writing
  btrfs: zoned: split ordered extent when bio is sent
  btrfs: extend btrfs_rmap_block for specifying a device
  btrfs: zoned: use ZONE_APPEND write for zoned btrfs
  btrfs: zoned: enable zone append writing for direct IO
  btrfs: zoned: introduce dedicated data write path for zoned
    filesystems
  btrfs: zoned: serialize metadata IO
  btrfs: zoned: wait for existing extents before truncating
  btrfs: zoned: do not use async metadata checksum on zoned filesystems
  btrfs: zoned: mark block groups to copy for device-replace
  btrfs: zoned: implement cloning for zoned device-replace
  btrfs: zoned: implement copying for zoned device-replace
  btrfs: zoned: support dev-replace in zoned filesystems
  btrfs: zoned: enable relocation on a zoned filesystem
  btrfs: zoned: relocate block group to repair IO failure in zoned
    filesystems
  btrfs: split alloc_log_tree()
  btrfs: zoned: extend zoned allocator to use dedicated tree-log block
    group
  btrfs: zoned: serialize log transaction on zoned filesystems
  btrfs: zoned: reorder log node allocation on zoned filesystem
  btrfs: zoned: enable to mount ZONED incompat flag

 block/bio.c                       |  33 ++
 fs/btrfs/block-group.c            | 134 +++--
 fs/btrfs/block-group.h            |  21 +-
 fs/btrfs/ctree.h                  |   8 +-
 fs/btrfs/dev-replace.c            | 184 +++++++
 fs/btrfs/dev-replace.h            |   3 +
 fs/btrfs/disk-io.c                |  66 ++-
 fs/btrfs/disk-io.h                |   2 +
 fs/btrfs/extent-tree.c            | 230 +++++++-
 fs/btrfs/extent_io.c              | 139 ++++-
 fs/btrfs/extent_io.h              |   2 +
 fs/btrfs/file.c                   |   6 +-
 fs/btrfs/free-space-cache.c       |  87 +++
 fs/btrfs/free-space-cache.h       |   2 +
 fs/btrfs/inode.c                  | 197 ++++++-
 fs/btrfs/ioctl.c                  |   8 +
 fs/btrfs/ordered-data.c           |  86 ++-
 fs/btrfs/ordered-data.h           |  10 +
 fs/btrfs/relocation.c             |  34 +-
 fs/btrfs/scrub.c                  | 143 +++++
 fs/btrfs/space-info.c             |  13 +-
 fs/btrfs/space-info.h             |   4 +-
 fs/btrfs/sysfs.c                  |   2 +
 fs/btrfs/tests/extent-map-tests.c |   2 +-
 fs/btrfs/transaction.c            |  10 +
 fs/btrfs/transaction.h            |   3 +
 fs/btrfs/tree-log.c               |  62 ++-
 fs/btrfs/volumes.c                | 314 ++++++++++-
 fs/btrfs/volumes.h                |   3 +
 fs/btrfs/zoned.c                  | 874 +++++++++++++++++++++++++++++-
 fs/btrfs/zoned.h                  | 157 +++++-
 fs/iomap/direct-io.c              |  43 +-
 include/linux/bio.h               |   2 +
 include/linux/iomap.h             |   1 +
 34 files changed, 2716 insertions(+), 169 deletions(-)

-- 
2.30.0

