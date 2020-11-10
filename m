Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C0C2AD830
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 15:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgKJOAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 09:00:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47944 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgKJOAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:00:47 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AADxtHo132490;
        Tue, 10 Nov 2020 14:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AulPiQ75gF9vRqfk14r+6otfi/iKuZHcgt0FfTiOWlA=;
 b=Nbt1YZjYYt/T84/bZEZQWicxLEc7WtuaUmwszjwni0BWtJqOenK4dkMs8QJhqaAW/SiG
 HjECofaWglThcGOCkVreTLUqUtrFQ9xjNGwBAQHsTMbNhJqMvD+1O9Dc3MQrma7RcnF0
 flR49VtxplBcaRJNWiERUMNEwO5WoS2/pvvnvuVxxrXYNnhDFpZfU91SBTVx9gdfA4mQ
 uq+04T20tBQlW078dIKIfW7tyGzW6laKTTwjTGpNand4vUkCD8CgE4Qv0C81UB0984kI
 2IT8lg/Xe9L877ZiheXjebE+LS648YZqjh0W2AZ5OcEksdCK3hOPBT9dHN/XzAX7gdge Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34nh3autaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 14:00:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AADt5BN074376;
        Tue, 10 Nov 2020 14:00:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34qgp6tdrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 14:00:25 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AAE0JYT018187;
        Tue, 10 Nov 2020 14:00:21 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 06:00:19 -0800
Subject: Re: [PATCH v10 00/41] btrfs: zoned block device support
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1a58611e-3116-57e1-3462-bb1888416d67@oracle.com>
Date:   Tue, 10 Nov 2020 22:00:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=1
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100100
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/11/20 7:26 pm, Naohiro Aota wrote:
> This series adds zoned block device support to btrfs.
> 
> This series is also available on github.
> Kernel   https://github.com/naota/linux/tree/btrfs-zoned-v10

  This branch is not reachable. Should it be

     https://github.com/naota/linux/tree/btrfs-zoned-for-v10 ?

  But the commits in this branch are at a pre-fixups stage.

Thanks, Anand


> Userland https://github.com/naota/btrfs-progs/tree/btrfs-zoned
> xfstests https://github.com/naota/fstests/tree/btrfs-zoned

> 
> Userland tool depends on patched util-linux (libblkid and wipefs) to handle
> log-structured superblock. To ease the testing, pre-compiled static linked
> userland tools are available here:
> https://wdc.app.box.com/s/fnhqsb3otrvgkstq66o6bvdw6tk525kp
> 
> This v10 still leaves the following issues left for later fix. But, the
> first part of the series should be good shape to be merged.
> - Bio submission path & splitting an ordered extent
> - Redirtying freed tree blocks
>    - Switch to keeping it dirty
>      - Not working correctly for now
> - Dedicated tree-log block group
>    - We need tree-log for zoned device
>      - Dbench (32 clients) is 85% slower with "-o notreelog"
>    - Need to separate tree-log block group from other metadata space_info
> - Relocation
>    - Use normal write command for relocation
>    - Relocated device extents must be reset
>      - It should be discarded on regular btrfs too though
> 
> Changes from v9:
>    - Extract iomap_dio_bio_opflags() to set the proper bi_opf flag
>    - write pointer emulation
>      - Rewrite using btrfs_previous_extent_item()
>      - Convert ASSERT() to runtime check
>    - Exclude regular superblock positions
>    - Fix an error on writing to conventional zones
>    - Take the transaction lock in mark_block_group_to_copy()
>    - Rename 'hmzoned_devices' to 'zoned_devices' in btrfs_check_zoned_mode()
>    - Add do_discard_extent() helper
>    - Move zoned check into fetch_cluster_info()
>    - Drop setting bdev to bio in btrfs_bio_add_page() (will fix later once
>      we support multiple devices)
>    - Subtract bytes_zone_unusable properly when removing a block group
>    - Add "struct block_device *bdev" directly to btrfs_rmap_block()
>    - Rename btrfs_zone_align to btrfs_align_offset_to_zone
>    - Add comment to use pr_info in place of btrfs_info
>    - Add comment for superblock log zones
>    - Fix coding style
>    - Fix typos
> 
> btrfs-progs and xfstests series will follow.
> 
> This version of ZONED btrfs switched from normal write command to zone
> append write command. You do not need to specify LBA (at the write pointer)
> to write for zone append write command. Instead, you only select a zone to
> write with its start LBA. Then the device (NVMe ZNS), or the emulation of
> zone append command in the sd driver in the case of SAS or SATA HDDs,
> automatically writes the data at the write pointer position and return the
> written LBA as a command reply.
> 
> The benefit of using the zone append write command is that write command
> issuing order does not matter. So, we can eliminate block group lock and
> utilize asynchronous checksum, which can reorder the IOs.
> 
> Eliminating the lock improves performance. In particular, on a workload
> with massive competing to the same zone [1], we observed 36% performance
> improvement compared to normal write.
> 
> [1] Fio running 16 jobs with 4KB random writes for 5 minutes
> 
> However, there are some limitations. We cannot use the non-SINGLE profile.
> Supporting non-SINGLE profile with zone append writing is not trivial. For
> example, in the DUP profile, we send a zone append writing IO to two zones
> on a device. The device reply with written LBAs for the IOs. If the offsets
> of the returned addresses from the beginning of the zone are different,
> then it results in different logical addresses.
> 
> For the same reason, we cannot issue multiple IOs for one ordered extent.
> Thus, the size of an ordered extent is limited under max_zone_append_size.
> This limitation will cause fragmentation and increased usage of metadata.
> In the future, we can add optimization to merge ordered extents after
> end_bio.
> 
> * Patch series description
> 
> A zoned block device consists of a number of zones. Zones are either
> conventional and accepting random writes or sequential and requiring
> that writes be issued in LBA order from each zone write pointer
> position. This patch series ensures that the sequential write
> constraint of sequential zones is respected while fundamentally not
> changing BtrFS block and I/O management for block stored in
> conventional zones.
> 
> To achieve this, the default chunk size of btrfs is changed on zoned
> block devices so that chunks are always aligned to a zone. Allocation
> of blocks within a chunk is changed so that the allocation is always
> sequential from the beginning of the chunks. To do so, an allocation
> pointer is added to block groups and used as the allocation hint.  The
> allocation changes also ensure that blocks freed below the allocation
> pointer are ignored, resulting in sequential block allocation
> regardless of the chunk usage.
> 
> The zone of a chunk is reset to allow reuse of the zone only when the
> block group is being freed, that is, when all the chunks of the block
> group are unused.
> 
> For btrfs volumes composed of multiple zoned disks, a restriction is
> added to ensure that all disks have the same zone size. This
> restriction matches the existing constraint that all chunks in a block
> group must have the same size.
> 
> * Enabling tree-log
> 
> The tree-log feature does not work on ZONED mode as is. Blocks for a
> tree-log tree are allocated mixed with other metadata blocks, and btrfs
> writes and syncs the tree-log blocks to devices at the time of fsync(),
> which is different timing than a global transaction commit. As a result,
> both writing tree-log blocks and writing other metadata blocks become
> non-sequential writes which ZONED mode must avoid.
> 
> This series introduces a dedicated block group for tree-log blocks to
> create two metadata writing streams, one for tree-log blocks and the
> other for metadata blocks. As a result, each write stream can now be
> written to devices separately and sequentially.
> 
> * Log-structured superblock
> 
> Superblock (and its copies) is the only data structure in btrfs which
> has a fixed location on a device. Since we cannot overwrite in a
> sequential write required zone, we cannot place superblock in the
> zone.
> 
> This series implements superblock log writing. It uses two zones as a
> circular buffer to write updated superblocks. Once the first zone is filled
> up, start writing into the second zone. The first zone will be reset once
> both zones are filled. We can determine the postion of the latest
> superblock by reading the write pointer information from a device.
> 
> * Patch series organization
> 
> Patches 1 and 2 are preparing patches for block and iomap layer.
> 
> Patch 3 introduces the ZONED incompatible feature flag to indicate that the
> btrfs volume was formatted for use on zoned block devices.
> 
> Patches 4 to 6 implement functions to gather information on the zones of
> the device (zones type, write pointer position, and max_zone_append_size).
> 
> Patches 7 to 10 disable features which are not compatible with the
> sequential write constraints of zoned block devices. These includes
> space_cache, NODATACOW, fallocate, and MIXED_BG.
> 
> Patch 11 implements the log-structured superblock writing.
> 
> Patches 12 and 13 tweak the device extent allocation for ZONED mode and add
> verification to check if a device extent is properly aligned to zones.
> 
> Patches 14 to 17 implements sequential block allocator for ZONED mode.
> 
> Patch 18 implement a zone reset for unused block groups.
> 
> Patches 19 to 30 implement the writing path for several types of IO
> (non-compressed data, direct IO, and metadata). These include re-dirtying
> once-freed metadata blocks to prevent write holes.
> 
> Patches 31 to 40 tweak some btrfs features work with ZONED mode. These
> include device-replace, relocation, repairing IO error, and tree-log.
> 
> Finally, patch 41 adds the ZONED feature to the list of supported features.
> 
> * Patch testing note
> 
> ** Zone-aware util-linux
> 
> Since the log-structured superblock feature changed the location of
> superblock magic, the current util-linux (libblkid) cannot detect ZONED
> btrfs anymore. You need to apply a to-be posted patch to util-linux to make
> it "zone aware".
> 
> ** Testing device
> 
> You need devices with zone append writing command support to run ZONED
> btrfs.
> 
> Other than real devices, null_blk supports zone append write command. You
> can use memory backed null_blk to run the test on it. Following script
> creates 12800 MB /dev/nullb0.
> 
>      sysfs=/sys/kernel/config/nullb/nullb0
>      size=12800 # MB
>      
>      # drop nullb0
>      if [[ -d $sysfs ]]; then
>              echo 0 > "${sysfs}"/power
>              rmdir $sysfs
>      fi
>      lsmod | grep -q null_blk && rmmod null_blk
>      modprobe null_blk nr_devices=0
>      
>      mkdir "${sysfs}"
>      
>      echo "${size}" > "${sysfs}"/size
>      echo 1 > "${sysfs}"/zoned
>      echo 0 > "${sysfs}"/zone_nr_conv
>      echo 1 > "${sysfs}"/memory_backed
>      
>      echo 1 > "${sysfs}"/power
>      udevadm settle
> 
> Zoned SCSI devices such as SMR HDDs or scsi_debug also support the zone
> append command as an emulated command within the SCSI sd driver. This
> emulation is completely transparent to the user and provides the same
> semantic as a NVMe ZNS native drive support.
> 
> Also, there is a qemu patch available to enable NVMe ZNS device.
> 
> ** xfstests
> 
> We ran xfstests on ZONED btrfs, and, if we omit some cases that are known
> to fail currently, all test cases pass.
> 
> Cases that can be ignored:
> 1) failing also with the regular btrfs on regular devices,
> 2) trying to test fallocate feature without testing with
>     "_require_xfs_io_command "falloc"",
> 3) trying to test incompatible features for ZONED btrfs (e.g. RAID5/6)
> 4) trying to use incompatible setup for ZONED btrfs (e.g. dm-linear not
>     aligned to zone boundary, swap)
> 5) trying to create a file system with too small size, (we require at least
>     9 zones to initiate a ZONED btrfs)
> 6) dropping original MKFS_OPTIONS ("-O zoned"), so it cannot create ZONED
>     btrfs (btrfs/003)
> 7) having ENOSPC which incurred by larger metadata block group size
> 
> I will send a patch series for xfstests to handle these cases (2-6)
> properly.
> 
> Patched xfstests is available here:
> 
> https://github.com/naota/fstests/tree/btrfs-zoned
> 
> Also, you need to apply the following patch if you run xfstests with
> tcmu devices. xfstests btrfs/003 failed to "_devmgt_add" after
> "_devmgt_remove" without this patch.
> 
> https://marc.info/?l=linux-scsi&m=156498625421698&w=2
> 
> v9 https://lore.kernel.org/linux-btrfs/cover.1604065156.git.naohiro.aota@wdc.com/
> v8 https://lore.kernel.org/linux-btrfs/cover.1601572459.git.naohiro.aota@wdc.com/
> v7 https://lore.kernel.org/linux-btrfs/20200911123259.3782926-1-naohiro.aota@wdc.com/
> v6 https://lore.kernel.org/linux-btrfs/20191213040915.3502922-1-naohiro.aota@wdc.com/
> v5 https://lore.kernel.org/linux-btrfs/20191204082513.857320-1-naohiro.aota@wdc.com/
> v4 https://lwn.net/Articles/797061/
> v3 https://lore.kernel.org/linux-btrfs/20190808093038.4163421-1-naohiro.aota@wdc.com/
> v2 https://lore.kernel.org/linux-btrfs/20190607131025.31996-1-naohiro.aota@wdc.com/
> v1 https://lore.kernel.org/linux-btrfs/20180809180450.5091-1-naota@elisp.net/
> 
> Changelog
> v9
>   - Direct-IO path now follow several hardware restrictions (other than
>     max_zone_append_size) by using ZONE_APPEND support of iomap
>   - introduces union of fs_info->zone_size and fs_info->zoned [Johannes]
>     - and use btrfs_is_zoned(fs_info) in place of btrfs_fs_incompat(fs_info, ZONED)
>   - print if zoned is enabled or not when printing module info [Johannes]
>   - drop patch of disabling inode_cache on ZONED
>   - moved for_teelog flag to a proper location [Johannes]
>   - Code style fixes [Johannes]
>   - Add comment about adding physical layer things to ordered extent
>     structure
>   - Pass file_offset explicitly to extract_ordered_extent() instead of
>     determining it from bio
>   - Bug fixes
>     - write out fsync region so that the logical address of ordered extents
>       and checksums are properly finalized
>     - free zone_info at umount time
>     - fix superblock log handling when entering zones[1] in the first time
>     - fixes double free of log-tree roots [Johannes]
>     - Drop erroneous ASSERT in do_allocation_zoned()
> v8
>   - Use bio_add_hw_page() to build up bio to honor hardware restrictions
>     - add bio_add_zone_append_page() as a wrapper of the function
>   - Split file extent on submitting bio
>     - If bio_add_zone_append_page() fails, split the file extent and send
>       out bio
>     - so, we can ensure one bio == one file extent
>   - Fix build bot issues
>   - Rebased on misc-next
> v7:
>   - Use zone append write command instead of normal write command
>     - Bio issuing order does not matter
>     - No need to use lock anymore
>     - Can use asynchronous checksum
>   - Removed RAID support for now
>   - Rename HMZONED to ZONED
>   - Split some patches
>   - Rebased on kdave/for-5.9-rc3 + iomap direct IO
> v6:
>   - Use bitmap helpers (Johannes)
>   - Code cleanup (Johannes)
>   - Rebased on kdave/for-5.5
>   - Enable the tree-log feature.
>   - Treat conventional zones as sequential zones, so we can now allow
>     mixed allocation of conventional zone and sequential write required
>     zone to construct a block group.
>   - Implement log-structured superblock
>     - No need for one conventional zone at the beginning of a device.
>   - Fix deadlock of direct IO writing
>   - Fix building with !CONFIG_BLK_DEV_ZONED (Johannes)
>   - Fix leak of zone_info (Johannes)
> v5:
>   - Rebased on kdave/for-5.5
>   - Enable the tree-log feature.
>   - Treat conventional zones as sequential zones, so we can now allow
>     mixed allocation of conventional zone and sequential write required
>     zone to construct a block group.
>   - Implement log-structured superblock
>     - No need for one conventional zone at the beginning of a device.
>   - Fix deadlock of direct IO writing
>   - Fix building with !CONFIG_BLK_DEV_ZONED (Johannes)
>   - Fix leak of zone_info (Johannes)
> v4:
>   - Move memory allcation of zone informattion out of
>     btrfs_get_dev_zones() (Anand)
>   - Add disabled features table in commit log (Anand)
>   - Ensure "max_chunk_size >= devs_min * data_stripes * zone_size"
> v3:
>   - Serialize allocation and submit_bio instead of bio buffering in
>     btrfs_map_bio().
>   -- Disable async checksum/submit in HMZONED mode
>   - Introduce helper functions and hmzoned.c/h (Josef, David)
>   - Add support for repairing IO failure
>   - Add support for NOCOW direct IO write (Josef)
>   - Disable preallocation entirely
>   -- Disable INODE_MAP_CACHE
>   -- relocation is reworked not to rely on preallocation in HMZONED mode
>   - Disable NODATACOW
>   -Disable MIXED_BG
>   - Device extent that cover super block position is banned (David)
> v2:
>   - Add support for dev-replace
>   -- To support dev-replace, moved submit_buffer one layer up. It now
>      handles bio instead of btrfs_bio.
>   -- Mark unmirrored Block Group readonly only when there are writable
>      mirrored BGs. Necessary to handle degraded RAID.
>   - Expire worker use vanilla delayed_work instead of btrfs's async-thread
>   - Device extent allocator now ensure that region is on the same zone type.
>   - Add delayed allocation shrinking.
>   - Rename btrfs_drop_dev_zonetypes() to btrfs_destroy_dev_zonetypes
>   - Fix
>   -- Use SECTOR_SHIFT (Nikolay)
>   -- Use btrfs_err (Nikolay)
> 
> 
> Johannes Thumshirn (1):
>    block: add bio_add_zone_append_page
> 
> Naohiro Aota (40):
>    iomap: support REQ_OP_ZONE_APPEND
>    btrfs: introduce ZONED feature flag
>    btrfs: get zone information of zoned block devices
>    btrfs: check and enable ZONED mode
>    btrfs: introduce max_zone_append_size
>    btrfs: disallow space_cache in ZONED mode
>    btrfs: disallow NODATACOW in ZONED mode
>    btrfs: disable fallocate in ZONED mode
>    btrfs: disallow mixed-bg in ZONED mode
>    btrfs: implement log-structured superblock for ZONED mode
>    btrfs: implement zoned chunk allocator
>    btrfs: verify device extent is aligned to zone
>    btrfs: load zone's alloction offset
>    btrfs: emulate write pointer for conventional zones
>    btrfs: track unusable bytes for zones
>    btrfs: do sequential extent allocation in ZONED mode
>    btrfs: reset zones of unused block groups
>    btrfs: redirty released extent buffers in ZONED mode
>    btrfs: extract page adding function
>    btrfs: use bio_add_zone_append_page for zoned btrfs
>    btrfs: handle REQ_OP_ZONE_APPEND as writing
>    btrfs: split ordered extent when bio is sent
>    btrfs: extend btrfs_rmap_block for specifying a device
>    btrfs: use ZONE_APPEND write for ZONED btrfs
>    btrfs: enable zone append writing for direct IO
>    btrfs: introduce dedicated data write path for ZONED mode
>    btrfs: serialize meta IOs on ZONED mode
>    btrfs: wait existing extents before truncating
>    btrfs: avoid async metadata checksum on ZONED mode
>    btrfs: mark block groups to copy for device-replace
>    btrfs: implement cloning for ZONED device-replace
>    btrfs: implement copying for ZONED device-replace
>    btrfs: support dev-replace in ZONED mode
>    btrfs: enable relocation in ZONED mode
>    btrfs: relocate block group to repair IO failure in ZONED
>    btrfs: split alloc_log_tree()
>    btrfs: extend zoned allocator to use dedicated tree-log block group
>    btrfs: serialize log transaction on ZONED mode
>    btrfs: reorder log node allocation
>    btrfs: enable to mount ZONED incompat flag
> 
>   block/bio.c                       |   38 +
>   fs/btrfs/Makefile                 |    1 +
>   fs/btrfs/block-group.c            |   84 +-
>   fs/btrfs/block-group.h            |   18 +-
>   fs/btrfs/ctree.h                  |   20 +-
>   fs/btrfs/dev-replace.c            |  195 +++++
>   fs/btrfs/dev-replace.h            |    3 +
>   fs/btrfs/disk-io.c                |   93 ++-
>   fs/btrfs/disk-io.h                |    2 +
>   fs/btrfs/extent-tree.c            |  218 ++++-
>   fs/btrfs/extent_io.c              |  130 ++-
>   fs/btrfs/extent_io.h              |    2 +
>   fs/btrfs/file.c                   |    6 +-
>   fs/btrfs/free-space-cache.c       |   58 ++
>   fs/btrfs/free-space-cache.h       |    2 +
>   fs/btrfs/inode.c                  |  164 +++-
>   fs/btrfs/ioctl.c                  |   13 +
>   fs/btrfs/ordered-data.c           |   79 ++
>   fs/btrfs/ordered-data.h           |   10 +
>   fs/btrfs/relocation.c             |   35 +-
>   fs/btrfs/scrub.c                  |  145 ++++
>   fs/btrfs/space-info.c             |   13 +-
>   fs/btrfs/space-info.h             |    4 +-
>   fs/btrfs/super.c                  |   19 +-
>   fs/btrfs/sysfs.c                  |    4 +
>   fs/btrfs/tests/extent-map-tests.c |    2 +-
>   fs/btrfs/transaction.c            |   10 +
>   fs/btrfs/transaction.h            |    3 +
>   fs/btrfs/tree-log.c               |   52 +-
>   fs/btrfs/volumes.c                |  322 +++++++-
>   fs/btrfs/volumes.h                |    7 +
>   fs/btrfs/zoned.c                  | 1272 +++++++++++++++++++++++++++++
>   fs/btrfs/zoned.h                  |  295 +++++++
>   fs/iomap/direct-io.c              |   41 +-
>   include/linux/bio.h               |    2 +
>   include/linux/iomap.h             |    1 +
>   include/uapi/linux/btrfs.h        |    1 +
>   37 files changed, 3246 insertions(+), 118 deletions(-)
>   create mode 100644 fs/btrfs/zoned.c
>   create mode 100644 fs/btrfs/zoned.h
> 

