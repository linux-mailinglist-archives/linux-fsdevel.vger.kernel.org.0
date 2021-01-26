Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F6304981
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbhAZF1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:27:44 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33029 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbhAZC1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628028; x=1643164028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=09odFvQwvyu+EcfMH86F9FVtivIIyZH4xXzfo/FZIcc=;
  b=lWpLrB/YRcq52zi1nT88XudDZLiNTZ25tHn8pvhr54QCiicGhMjm349l
   lsZ/7HdIoVm54cEnbJ27UIdmeLfNRSbtUrrZY7SiERTbwI2xI/zVQamJk
   Aw8BF8vP6l4dt5r4Ej7ZjhKFkwFC8vS+bc/qK55J354Fb3Ia6fUCNbDyd
   CTyaqqMxk4cvJaREMPs6tZixjwNA1f/m0o5bb9pytyxNYFbYCBnNkZygJ
   oJH4WTsDFZ/aLH1y5ruBC/0qOyHKcvTiglyP7sdMJmKSqaMfMe0Fx0Kzx
   QdbiHXBF4Zci0XG+0/dUVnOJPiGQ4lyT70QynJ72vxvDqTxCQLJfj5khK
   g==;
IronPort-SDR: LTuJ3ScOMJRxDF+8n/R3knOcqUJu5Bggrjkrn2hBpRqDPxKTcP06hLz8HJoa0oYYaQkqAP4vE4
 Dx4nD0Or7twlItvDwrwqNWz+q1oRNTgeWaWI0zWRWZeRgG1KBi86h3AdpT3Ro2n7z7nT5HXInj
 j61B4zk4mVzTcK4Hkfah46h3yfwip8nFRH0gYcFQeXrzNPWMW2F244DhZ4NkSqq94n/jna6VgH
 OxtCBOoRSR8fHDoeDX9C1TP50YFrcFQE7TCEGXPjX1jAeuxKJooEWXnBOed3pikz03a21Vk3O0
 ks4=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483495"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:25:59 +0800
IronPort-SDR: R62tbtvzwR2wwPldLLTzsjedWMb1nZeVzxiCX3nN0Uuz+gdFzaMy/kecSrtd379uWFEvNmqgnc
 qSUVaFapfcUucVapm7aESv/XuaJH/QLCJkNRR2+5gdpf42eu/g0oID/pRDC/6IoD7ziuiwtIrr
 GgvjSzZ+kq0+YcQts/ymQ644B/BlqBQ2tmTvXR703vB2BgmmbNpsyMAIaiu129Qj7gQUzeu3Be
 MvZnfvX9IaAqW2r6DYXcbQFkGOqK+XZdnmCDvXJY0VDInDj9qR+x/Lr3GRjY/TK3WyELRxUZnn
 NYXeW13BLx200Fbjg5fXz3ku
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:25 -0800
IronPort-SDR: xFRfyKvti1GnbNxh2ow0G5YKY0dgtwrZrsREBfcNj77ePrvqIS/8An5TbCO4pTKi4F/9ugCnSc
 wb47TBOodGnBQcZsxE811dCWnAb4U3i/nEJrz+JouP/i0trE5OGFUUF0a6Uq/73xWVnAynGcKa
 0GJt/a1/skCsO0dscX7e5Oep+ja5Tz/EwK0anOKQ1Zv3MZckPMVMWHu57o9YvPa3Auy0VEx464
 2/6GMk5JaTZ5auBo6LKMfRTZsFUfrKsxs3KFDl+j39THvQTgvWHNN3nM0veGfCTsn0lqnAWrs6
 lSg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:25:57 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v14 00/42] btrfs: zoned block device support
Date:   Tue, 26 Jan 2021 11:24:38 +0900
Message-Id: <cover.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series adds zoned block device support to btrfs. Some of the patches
in the previous series are already merged as preparation patches.

This series is also available on github.
Kernel   https://github.com/naota/linux/tree/btrfs-zoned-v14
Userland https://github.com/naota/btrfs-progs/tree/btrfs-zoned
xfstests https://github.com/naota/fstests/tree/btrfs-zoned

Userland tool depends on patched util-linux (libblkid and wipefs) to handle
log-structured superblock. To ease the testing, pre-compiled static linked
userland tools are available here:
https://wdc.app.box.com/s/fnhqsb3otrvgkstq66o6bvdw6tk525kp

v11 restructured the series so that it starts with the minimum patches to
run emulated zoned mode on regular devices (chunk/extent allocator,
allocation pointer handling, pinning of freed extents (re-dirtying released
extent)).

This series still leaves the following issues left for later fix.
- Bio submission path & splitting an ordered extent
- Redirtying freed tree blocks
  - Switch to keeping it dirty
    - Not working correctly for now
- Dedicated tree-log block group
  - We need tree-log for zoned device
    - Dbench (32 clients) is 85% slower with "-o notreelog"
  - Need to separate tree-log block group from other metadata space_info
- Relocation
  - Use normal write command for relocation
  - Relocated device extents must be reset
    - It should be discarded on regular btrfs too though
- Support for zone capacity

Changes from v14
  - Rebased on lated misc-next
  - Account zone_unusable as readonly when a BG is readonly (patch 13)
  - Do not eat errno (patch 12)
  - Drop useless WARN (patch 22)

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

Patch 17 adds the ZONED feature to the list of supported features. So, at
this point, emulated ZONED mode works on non-zoned device.

Patches 18 and later are for real zoned devices.

Patch 18 implement a zone reset for unused block groups.

Patches 19 to 32 implement the writing path for several types of IO
(non-compressed data, direct IO, and metadata). These include re-dirtying
once-freed metadata blocks to prevent write holes.

Patches 33 to 42 tweak some btrfs features work with ZONED mode. These
include device-replace, relocation, repairing IO error, and tree-log.

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

v12 https://lore.kernel.org/linux-btrfs/cover.1610693036.git.naohiro.aota@wdc.com/T/#t
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
  btrfs: release path before calling into
    btrfs_load_block_group_zone_info
  btrfs: do not load fs_info->zoned from incompat flag
  btrfs: allow zoned mode on non-zoned block devices
  btrfs: check if bio spans across an ordered extent
  btrfs: cache if block-group is on a sequential zone
  btrfs: save irq flags when looking up an ordered extent

Naohiro Aota (35):
  iomap: support REQ_OP_ZONE_APPEND
  btrfs: defer loading zone info after opening trees
  btrfs: use regular SB location on emulated zoned mode
  btrfs: disallow fitrim in ZONED mode
  btrfs: implement zoned chunk allocator
  btrfs: verify device extent is aligned to zone
  btrfs: load zone's allocation offset
  btrfs: calculate allocation offset for conventional zones
  btrfs: track unusable bytes for zones
  btrfs: do sequential extent allocation in ZONED mode
  btrfs: redirty released extent buffers in ZONED mode
  btrfs: advance allocation pointer after tree log node
  btrfs: enable to mount ZONED incompat flag
  btrfs: reset zones of unused block groups
  btrfs: extract page adding function
  btrfs: use bio_add_zone_append_page for zoned btrfs
  btrfs: handle REQ_OP_ZONE_APPEND as writing
  btrfs: split ordered extent when bio is sent
  btrfs: extend btrfs_rmap_block for specifying a device
  btrfs: use ZONE_APPEND write for ZONED btrfs
  btrfs: enable zone append writing for direct IO
  btrfs: introduce dedicated data write path for ZONED mode
  btrfs: serialize meta IOs on ZONED mode
  btrfs: wait existing extents before truncating
  btrfs: avoid async metadata checksum on ZONED mode
  btrfs: mark block groups to copy for device-replace
  btrfs: implement cloning for ZONED device-replace
  btrfs: implement copying for ZONED device-replace
  btrfs: support dev-replace in ZONED mode
  btrfs: enable relocation in ZONED mode
  btrfs: relocate block group to repair IO failure in ZONED
  btrfs: split alloc_log_tree()
  btrfs: extend zoned allocator to use dedicated tree-log block group
  btrfs: serialize log transaction on ZONED mode
  btrfs: reorder log node allocation

 block/bio.c                       |  33 ++
 fs/btrfs/block-group.c            | 137 +++--
 fs/btrfs/block-group.h            |  20 +-
 fs/btrfs/ctree.h                  |   8 +-
 fs/btrfs/dev-replace.c            | 182 ++++++
 fs/btrfs/dev-replace.h            |   3 +
 fs/btrfs/disk-io.c                |  57 +-
 fs/btrfs/disk-io.h                |   2 +
 fs/btrfs/extent-tree.c            | 232 +++++++-
 fs/btrfs/extent_io.c              | 138 ++++-
 fs/btrfs/extent_io.h              |   2 +
 fs/btrfs/file.c                   |   6 +-
 fs/btrfs/free-space-cache.c       |  87 +++
 fs/btrfs/free-space-cache.h       |   2 +
 fs/btrfs/inode.c                  | 200 ++++++-
 fs/btrfs/ioctl.c                  |   8 +
 fs/btrfs/ordered-data.c           |  93 +++-
 fs/btrfs/ordered-data.h           |  10 +
 fs/btrfs/relocation.c             |  34 +-
 fs/btrfs/scrub.c                  | 145 +++++
 fs/btrfs/space-info.c             |  13 +-
 fs/btrfs/space-info.h             |   4 +-
 fs/btrfs/sysfs.c                  |   2 +
 fs/btrfs/tests/extent-map-tests.c |   2 +-
 fs/btrfs/transaction.c            |  10 +
 fs/btrfs/transaction.h            |   3 +
 fs/btrfs/tree-log.c               |  59 +-
 fs/btrfs/volumes.c                | 314 ++++++++++-
 fs/btrfs/volumes.h                |   3 +
 fs/btrfs/zoned.c                  | 882 +++++++++++++++++++++++++++++-
 fs/btrfs/zoned.h                  | 159 +++++-
 fs/iomap/direct-io.c              |  43 +-
 include/linux/bio.h               |   2 +
 include/linux/iomap.h             |   1 +
 34 files changed, 2728 insertions(+), 168 deletions(-)

-- 
2.27.0

