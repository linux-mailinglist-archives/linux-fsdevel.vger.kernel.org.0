Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D98A72C5D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbjFLN0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFLN0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:26:15 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848139E;
        Mon, 12 Jun 2023 06:26:13 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 0EF8C424CE;
        Mon, 12 Jun 2023 09:26:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1686576371;
        bh=0fBXF242TlnlWWnUpbHtMjtG1I01VWvHHxTIoR6WCiw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=gokkRUxmuspzQsLHgOEmq4Q29gq7pNrJRIEDnyeYO44Qx0TRWB3hMAWWonuXC1NKk
         DS5qCs6fdy8Rp7cdims+uqJCJOgr8sEdTzUbysMCODMo5hOfxcL86j/Q/zLPgW5Qvv
         kX7tOU/OMJwP5ax8RweZktXKTmq6nIzlEmutzVUl6e7HzxxzgtErJAlGtbewjNdbsI
         0OiESzYijQulRudwDR+ygvC5jM06XsevsUkYb0ITUHPU4d8V5eTH7xV3mlswbQBync
         +7So8UtQ1WtPdY77R2um13804xjFrduXTy44fLgP1UH3q7bwVmPM/V/mKec/pVUF9r
         4NxRYJ+zyX8Eg==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Jun 2023 15:26:03 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <dchinner@redhat.com>, <willy@infradead.org>, <dlemoal@kernel.org>,
        <linux@weissschuh.net>, <jack@suse.cz>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sergei.shtepa@veeam.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v5 03/11] documentation: Block Devices Snapshots Module
Date:   Mon, 12 Jun 2023 15:21:29 +0200
Message-ID: <20230612132137.10362-4-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230612132137.10362-1-sergei.shtepa@veeam.com>
References: <20230612132137.10362-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29240315546D776B
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The document contains:
* Describes the purpose of the mechanism
* Description of features
* Description of algorithms
* Recommendations about using the module from the user-space side
* Reference to module interface description

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 Documentation/block/blksnap.rst | 345 ++++++++++++++++++++++++++++++++
 Documentation/block/index.rst   |   1 +
 MAINTAINERS                     |   6 +
 3 files changed, 352 insertions(+)
 create mode 100644 Documentation/block/blksnap.rst

diff --git a/Documentation/block/blksnap.rst b/Documentation/block/blksnap.rst
new file mode 100644
index 000000000000..eb20d466d1ca
--- /dev/null
+++ b/Documentation/block/blksnap.rst
@@ -0,0 +1,345 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+Block Devices Snapshots Module (blksnap)
+========================================
+
+Introduction
+============
+
+At first glance, there is no novelty in the idea of creating snapshots for
+block devices. The Linux kernel already has mechanisms for creating snapshots.
+Device Mapper includes dm-snap, which allows to create snapshots of block
+devices. BTRFS supports snapshots at the file system level. However, both
+of these options have flaws that do not allow to use them as a universal
+tool for creating backups.
+
+The main properties that a backup tool should have are:
+
+- Simplicity and versatility of use
+- Reliability
+- Minimal consumption of system resources during backup
+- Minimal time required for recovery or replication of the entire system
+
+Taking above properties into account, blksnap module features:
+
+- Change tracker
+- Snapshots at the block device level
+- Dynamic allocation of space for storing differences
+- Snapshot overflow resistance
+- Coherent snapshot of multiple block devices
+
+Features
+========
+
+Change tracker
+--------------
+
+The change tracker allows to determine which blocks were changed during the
+time between the last snapshot created and any of the previous snapshots.
+With a map of changes, it is enough to copy only the changed blocks, and no
+need to reread the entire block device completely. The change tracker allows
+to implement the logic of both incremental and differential backups.
+Incremental backup is critical for large file repositories whose size can be
+hundreds of terabytes and whose full backup time can take more than a day.
+On such servers, the use of backup tools without a change tracker becomes
+practically impossible.
+
+Snapshot at the block device level
+----------------------------------
+
+A snapshot at the block device level allows to simplify the backup algorithm
+and reduce consumption of system resources. It also allows to perform linear
+reading of disk space directly, which allows to achieve maximum reading speed
+with minimal use of processor time. At the same time, the versatility of
+creating snapshots for any block device is achieved, regardless of the file
+system located on it. The exceptions are BTRFS, ZFS and cluster file systems.
+
+Dynamic allocation of storage space for differences
+---------------------------------------------------
+
+To store differences, the module does not require a pre-reserved block
+device range. A range of sectors can be allocated on any block device
+immediately before creating a snapshot in individual files on the file
+system. In addition, the size of the difference storage can be increased
+after the snapshot is created by adding new sector ranges on block devices.
+Sector ranges can be allocated on any block devices of the system, including
+those on which the snapshot was created. A shared difference storage for
+all images of snapshot block devices allows to optimize the use of disk space.
+
+Snapshot overflow resistance
+----------------------------
+
+To create images of snapshots of block devices, the module stores blocks
+of the original block device that have been changed since the snapshot
+was taken. To do this, the module handles write requests and reads blocks
+that need to be overwritten. This algorithm guarantees safety of the data
+of the original block device in the event of an overflow of the snapshot,
+and even in the case of unpredictable critical errors. If a problem occurs
+during backup, the difference storage is released, the snapshot is closed,
+no backup is created, but the server continues to work.
+
+Coherent snapshot of multiple block devices
+-------------------------------------------
+
+A snapshot is created simultaneously for all block devices for which a backup
+is being created, ensuring their coherent state.
+
+
+Algorithms
+==========
+
+Overview
+--------
+
+The blksnap module is a block-level filter. It handles all write I/O units.
+The filter is attached to the block device when the snapshot is created
+for the first time. The change tracker marks all overwritten blocks.
+Information about the history of changes on the block device is available
+while holding the snapshot. The module reads the blocks that need to be
+overwritten and stores them in the difference storage. When reading from
+a snapshot image, reading is performed either from the original device or
+from the difference storage.
+
+Change tracking
+---------------
+
+A change tracker map is created for each block device. One byte
+of this map corresponds to one block. The block size is set by the
+``tracking_block_minimum_shift`` and ``tracking_block_maximum_count``
+module parameters. The ``tracking_block_minimum_shift`` parameter limits
+the minimum block size for tracking, while ``tracking_block_maximum_count``
+defines the maximum allowed number of blocks. The size of the change tracker
+block is determined depending on the size of the block device when adding
+a tracking device, that is, when the snapshot is taken for the first time.
+The block size must be a power of two. The ``tracking_block_maximum_shift``
+module parameter allows to limit the maximum block size for tracking. If the
+block size reaches the allowable limit, the number of blocks will exceed the
+``tracking_block_maximum_count`` parameter.
+
+The byte of the change map stores a number from 0 to 255. This is the
+snapshot number, since the creation of which there have been changes in
+the block. Each time a snapshot is created, the number of the current
+snapshot is increased by one. This number is written to the cell of the
+change map when writing to the block. Thus, knowing the number of one of
+the previous snapshots and the number of the last snapshot, one can determine
+from the change map which blocks have been changed. When the number of the
+current change reaches the maximum allowed value for the map of 255, at the
+time when the next snapshot is created, the map of changes is reset to zero,
+and the number of the current snapshot is assigned the value 1. The change
+tracker is reset, and a new UUID is generated - a unique identifier of the
+snapshot generation. The snapshot generation identifier allows to identify
+that a change tracking reset has been performed.
+
+The change map has two copies. One copy is active, it tracks the current
+changes on the block device. The second copy is available for reading
+while the snapshot is being held, and contains the history up to the moment
+the snapshot is taken. Copies are synchronized at the moment of snapshot
+creation. After the snapshot is released, a second copy of the map is not
+needed, but it is not released, so as not to allocate memory for it again
+the next time the snapshot is created.
+
+Copy on write
+-------------
+
+Data is copied in blocks, or rather in chunks. The term "chunk" is used to
+avoid confusion with change tracker blocks and I/O blocks. In addition,
+the "chunk" in the blksnap module means about the same as the "chunk" in
+the dm-snap module.
+
+The size of the chunk is determined by the ``chunk_minimum_shift`` and
+``chunk_maximum_count`` module parameters. The ``chunk_minimum_shift``
+parameter limits the minimum size of the chunk, while ``chunk_maximum_count``
+defines the maximum allowed number of chunks. The size of the chunk is
+determined depending on the size of the block device at the time of taking the
+snapshot. The size of the chunk must be a power of two. The module parameter
+``chunk_maximum_shift`` allows to limit the maximum chunk size. If the chunk
+size reaches the allowable limit, the number of chunks will exceed the
+``chunk_maximum_count`` parameter.
+
+One chunk is described by the ``struct chunk`` structure. An array of structures
+is created for each block device. The structure contains all the necessary
+information to copy the chunks data from the original block device to the
+difference storage. This information allows to describe the snapshot image.
+A semaphore is located in the structure, which allows synchronization of threads
+accessing the chunk.
+
+The block level has a feature. If a read I/O unit was sent, and a write I/O
+unit was sent after it, then a write can be performed first, and only then
+a read. Therefore, the copy-on-write algorithm is executed synchronously.
+If a write request is handled, the execution of this I/O unit will be
+delayed until the overwritten chunks are copied to the difference storage.
+But if, when handling a write I/O unit, it turns out that the recorded range
+of sectors has already been copied to the difference storage, then the I/O
+unit is simply passed.
+
+This algorithm allows to efficiently perform backups of systems that run
+Round Robin Database. Such databases can be overwritten several times during
+the system backup. Of course, the value of a backup of the RRD monitoring
+system data can be questioned. However, it is often a task to make a backup
+of the entire enterprise infrastructure in order to restore or replicate it
+entirely in case of problems.
+
+There is also a flaw in the algorithm. When overwriting at least one sector,
+an entire chunk is copied. Thus, a situation of rapid filling of the difference
+storage when writing data to a block device in small portions in random order
+is possible. This situation is possible in case of strong fragmentation of
+data on the file system. But it must be borne in mind that with such data
+fragmentation, performance of systems usually degrades greatly. So, this
+problem does not occur on real servers, although it can easily be created
+by artificial tests.
+
+Difference storage
+------------------
+
+The difference storage is a pool of disk space areas, and it is shared with
+all block devices in the snapshot. Therefore, there is no need to divide
+the difference storage area between block devices, and the difference storage
+itself can be located on different block devices.
+
+There is no need to allocate a large disk space immediately before creating
+a snapshot. Even while the snapshot is being held, the difference storage
+can be expanded. It is enough to have free space on the file system.
+
+Areas of disk space can be allocated on the file system using fallocate(),
+and the file location can be requested using Fiemap Ioctl or Fibmap Ioctl.
+Unfortunately, not all file systems support these mechanisms, but the most
+common XFS, EXT4 and BTRFS file systems support it. BTRFS requires additional
+conversion of virtual offsets to physical ones.
+
+While holding the snapshot, the user process can poll the status of the module.
+When free space in the difference storage is reduced to a threshold value, the
+module generates an event about it. The user process can prepare a new area
+and pass it to the module to expand the difference storage. The threshold
+value is determined as half of the value of the ``diff_storage_minimum``
+module parameter.
+
+If free space in the difference storage runs out, an event is generated about
+the overflow of the snapshot. Such a snapshot is considered corrupted, and
+read I/O units to snapshot images will be terminated with an error code.
+The difference storage stores outdated data required for snapshot images,
+so when the snapshot is overflowed, the backup process is interrupted,
+but the system maintains its operability without data loss.
+
+Performing I/O for a snapshot image
+-----------------------------------
+
+To read snapshot data, when taking a snapshot, block devices of snapshot images
+are created. The snapshot image block devices support the write operation.
+This allows to perform additional data preparation on the file system before
+creating a backup.
+
+To process the I/O unit, clones of the I/O unit are created, which redirect
+the I/O unit either to the original block device or to the difference storage.
+When processing of cloned I/O units is completed, the original I/O unit is
+marked as completed too.
+
+An I/O unit can be partially processed without accessing to block devices if
+the I/O unit refers to a chunk that is in the queue for storing to the
+difference storage. In this case, the data is read or written in a buffer in
+memory.
+
+If, when processing the write I/O unit, it turns out that the data of the
+referred chunk has not yet been stored to the difference storage or has not
+even been read from the original device, then an I/O unit to read data from the
+original device is initiated beforehand. After the reading from original device
+is performed, their data from the I/O unit is partially overwritten directly in
+the buffer of the chunk in memory, and the chunk is scheduled to be saved to the
+difference storage.
+
+How to use
+==========
+
+Depending on the needs and the selected license, you can choose different
+options for managing the module:
+
+- Using ioctl directly
+- Using a static C++ library
+- Using the blksnap console tool
+
+Using a BLKFILTER_CTL for block device
+--------------------------------------
+
+BLKFILTER_CTL allows to send a filter-specific command to the filter on block
+device and get the result of its execution. The module provides the
+``include/uapi/blksnap.h`` header file with a description of the commands and
+their data structures.
+
+1. ``blkfilter_ctl_blksnap_cbtinfo`` allows to get information from the
+   change tracker.
+2. ``blkfilter_ctl_blksnap_cbtmap`` reads the change tracker table. If a write
+   operation was performed for the snapshot, then the change tracker takes this
+   into account. Therefore, it is necessary to receive tracker data after write
+   operations have been completed.
+3. ``blkfilter_ctl_blksnap_cbtdirty`` mark blocks as changed in the change
+   tracker table. This is necessary if post-processing is performed after the
+   backup is created, which changes the backup blocks.
+4. ``blkfilter_ctl_blksnap_snapshotadd`` adds a block device to the snapshot.
+5. ``blkfilter_ctl_blksnap_snapshotinfo`` allows to get the name of the snapshot
+   image block device and the presence of an error.
+
+Using ioctl
+-----------
+
+Using a BLKFILTER_CTL ioctl does not allow to fully implement the management of
+the blksnap module. A control file ``blksnap-control`` is created to manage
+snapshots. The control commands are also described in the file
+``include/uapi/blksnap.h``.
+
+1. ``blksnap_ioctl_version`` get the version number.
+2. ``blk_snap_ioctl_snapshot_create`` initiates the snapshot creation process.
+3. ``blk_snap_ioctl_snapshot_append_storage`` add the range of blocks to
+   difference storage.
+4. ``blk_snap_ioctl_snapshot_take`` creates block devices of block device
+   snapshot images.
+5. ``blk_snap_ioctl_snapshot_collect`` collect all created snapshots.
+6. ``blk_snap_ioctl_snapshot_wait_event`` allows to track the status of
+   snapshots and receive events about the requirement to expand the difference
+   storage or about snapshot overflow.
+7. ``blk_snap_ioctl_snapshot_destroy`` releases the snapshot.
+
+Static C++ library
+------------------
+
+The [#userspace_libs]_ library was created primarily to simplify creation of
+tests in C++, and it is also a good example of using the module interface.
+When creating applications, direct use of control calls is preferable.
+However, the library can be used in an application with a GPL-2+ license,
+or a library with an LGPL-2+ license can be created, with which even a
+proprietary application can be dynamically linked.
+
+blksnap console tool
+--------------------
+
+The blksnap [#userspace_tools]_ console tool allows to control the module from
+the command line. The tool contains detailed built-in help. To get list of
+commands with usage description, see ``blksnap --help`` command. The ``blksnap
+<command name> --help`` command allows to get detailed information about the
+parameters of each command call. This option may be convenient when creating
+proprietary software, as it allows not to compile with the open source code.
+At the same time, the blksnap tool can be used for creating backup scripts.
+For example, rsync can be called to synchronize files on the file system of
+the mounted snapshot image and files in the archive on a file system that
+supports compression.
+
+Tests
+-----
+
+A set of tests was created for regression testing [#userspace_tests]_.
+Tests with simple algorithms that use the ``blksnap`` console tool to
+control the module are written in Bash. More complex testing algorithms
+are implemented in C++.
+
+References
+==========
+
+.. [#userspace_libs] https://github.com/veeam/blksnap/tree/stable-v2.0/lib
+
+.. [#userspace_tools] https://github.com/veeam/blksnap/tree/stable-v2.0/tools
+
+.. [#userspace_tests] https://github.com/veeam/blksnap/tree/stable-v2.0/tests
+
+Module interface description
+============================
+
+.. kernel-doc:: include/uapi/linux/blksnap.h
diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index e9712f72cd6d..696ff150c6b7 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -11,6 +11,7 @@ Block
    biovecs
    blk-mq
    blkfilter
+   blksnap
    cmdline-partition
    data-integrity
    deadline-iosched
diff --git a/MAINTAINERS b/MAINTAINERS
index 8336b6143a71..c7dabe785cf1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3589,6 +3589,12 @@ F:	block/blk-filter.c
 F:	include/linux/blk-filter.h
 F:	include/uapi/linux/blk-filter.h
 
+BLOCK DEVICE SNAPSHOTS MODULE
+M:	Sergei Shtepa <sergei.shtepa@veeam.com>
+L:	linux-block@vger.kernel.org
+S:	Supported
+F:	Documentation/block/blksnap.rst
+
 BLOCK LAYER
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
-- 
2.20.1

