Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641AA48B912
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 21:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiAKU6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 15:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbiAKU6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:58:22 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D79DC06173F
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jan 2022 12:58:22 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z3so646371plg.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jan 2022 12:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=B/uglQFbw2IQVX0qBffrBfjH5SybRgCZv1hi96V0seY=;
        b=Egy5W8u3dMv+djAUOc3X0EYDVA/fwdmNXAikf2hCl1lMRrj8pF4DvAimW6kgkqFv5R
         w3pKZcMWzzD82XQ3rrZH7g7uPC8ma4TQ6tYEhbvuyWydQfF0uegfSHHJjd/xstF7kYLW
         vhPAjC9FvI7J9X8EN7BQph/akIPbxLQOqxdxBxbr1/O1dI7Em3kCDVGGlg8RMkQos6AE
         aQ6pMv68NgRuhslY9yK7ABGX/RYXlSDA/WXY7yrhW7MqD4vRkDSo4ks0NSAG3TldxHo7
         1tUyjqPWvH4B5mpOWqkJ22YcIKoPXzSEhekQopCLIfLYN67oXg9y/loMLM+Oh2mnpm3S
         YUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=B/uglQFbw2IQVX0qBffrBfjH5SybRgCZv1hi96V0seY=;
        b=mq3fD+9M5BAbGqwdajE02G80usXqVwaXIJ3prWyR5D0PvqrK4DxsQWcz9LsugWzwm1
         HSbi1H9xnMxTMXPOk0X5/ikCSaICNHea2wpqCxsNREvJbnNkleFGEo2Hs54aaSIdzCsR
         gRI4BWOs7eocD5Y8UhacQuBTnu0QS1HLBEMt0HF/2BvmNRqDMMXeDSkaDNu++CRPhxqZ
         CZ0gI4tmQw5aBWSFS9X44A6RcocjuBGROdD2bvCH4Ap3R2HMLiTadWZHXDDydAdSQ8aU
         W3oKmko71Qt1Qe+hKZZJKMk3K0EwLZoV8C/pWkrzujD0rX/hsaXaFizWBiQd0W0DQRI9
         EcrQ==
X-Gm-Message-State: AOAM530XMEjoNM2yP6F4G3jewlcbnGJlkzNzWmeSsYP0gV/TZs1Ukrx8
        VijdVfBHpSTwEBS4T7m+QoYZBbA6c96k2PAYJALd7Q==
X-Google-Smtp-Source: ABdhPJyX+sn2dDKTOUv7GuC4lqHIvo1lX3KlZyjo6fxApDEGNP3B/PtmdvahfKjdnSj2iyelxI/gecR7tIaSRjf6m/Y=
X-Received: by 2002:a17:90a:7101:: with SMTP id h1mr5060013pjk.93.1641934701790;
 Tue, 11 Jan 2022 12:58:21 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Jan 2022 12:58:11 -0800
Message-ID: <CAPcyv4jWm57gAL_P2JiU1vm3-CaJwzRQsoNhh_A2C-Jh1trk+w@mail.gmail.com>
Subject: [GIT PULL] DAX / LIBNVDIMM update for v5.17
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.17

...to receive the persistent memory (DAX + LIBNVDIMM) updates for
v5.17. The bulk of this is a rework of the dax_operations API after
discovering the obstacles it posed to the work-in-progress DAX+reflink
support for XFS and other copy-on-write filesystem mechanics.
Primarily the need to plumb a block_device through the API to handle
partition offsets was a sticking point and Christoph untangled that
dependency in addition to other cleanups to make landing the
DAX+reflink support easier.

The DAX_PMEM_COMPAT option has been around for 4 years and not only
are distributions shipping userspace that understand the current
configuration API, but some are not even bothering to turn this option
on anymore, so it seems a good time to remove it per the deprecation
schedule. Recall that this was added after the device-dax subsystem
moved from /sys/class/dax to /sys/bus/dax for its sysfs organization.
All recent functionality depends on /sys/bus/dax.

Some other miscellaneous cleanups and reflink prep patches are
included as well, details in the tag message.

This has been in -next for several weeks, and -next is carrying
resolution for 3 merge conflicts:
- iomap + folio
- ext4
- mm

Links to merge resolutions below:

As mentioned by Willy
(https://lore.kernel.org/r/YdyoN7RU/JMOk/lW@casper.infradead.org) it
collides with the pending iomap+folio work for 5.17. The resolution
that Stephen has been carrying is here:
(https://lore.kernel.org/all/20211224172421.3f009baa@canb.auug.org.au/).
The changes to the mount path where the dax-device is looked up from
the block_device also collided with the ext4 tree. Christoph's
resolution is here:
(https://git.infradead.org/users/hch/misc.git/commit/9cac2bce6b42),
and that is the resolution that -next has been carrying. The mm
collision comes from a cleanup of the memremap API and Joao's pending
support for compound-page backed dax-devices. The merge resolution
that -next has been carrying is here:
(https://lore.kernel.org/r/20211207173938.6d619ba6@canb.auug.org.au).

It has reviews from XFS, DM, EROFS, VIRTIO-FS, and VIRTIO-PMEM
developers. Please pull and/or please let me know if there is a better
way to communicate / organize conflict notifications.

---

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.17

for you to fetch changes up to 9e05e95ca8dae8de4a7a1645014e1bbd9c8a4dab:

  iomap: Fix error handling in iomap_zero_iter() (2021-12-23 14:04:11 -0800)

----------------------------------------------------------------
dax + libnvdimm for v5.17

- Simplify the dax_operations API
  - Eliminate bdev_dax_pgoff() in favor of the filesystem maintaining
    and applying a partition offset to all its DAX iomap operations.
  - Remove wrappers and device-mapper stacked callbacks for
    ->copy_from_iter() and ->copy_to_iter() in favor of moving
    block_device relative offset responsibility to the
    dax_direct_access() caller.
  - Remove the need for an @bdev in filesystem-DAX infrastructure
  - Remove unused uio helpers copy_from_iter_flushcache() and
    copy_mc_to_iter() as only the non-check_copy_size() versions are
    used for DAX.
- Prepare XFS for the pending (next merge window) DAX+reflink support
- Remove deprecated DEV_DAX_PMEM_COMPAT support
- Cleanup a straggling misuse of the GUID api

Tags offered after the branch was cut:
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
Link: https://lore.kernel.org/r/Ydb/3P+8nvjCjYfO@redhat.com

----------------------------------------------------------------
Andy Shevchenko (1):
      ACPI: NFIT: Import GUID before use

Christoph Hellwig (34):
      dm: fix alloc_dax error handling in alloc_dev
      dm: make the DAX support depend on CONFIG_FS_DAX
      dax: remove CONFIG_DAX_DRIVER
      dax: simplify the dax_device <-> gendisk association
      dax: remove the pgmap sanity checks in generic_fsdax_supported
      dax: move the partition alignment check into fs_dax_get_by_bdev
      xfs: factor out a xfs_setup_dax_always helper
      dax: remove dax_capable
      dm-linear: add a linear_dax_pgoff helper
      dm-log-writes: add a log_writes_dax_pgoff helper
      dm-stripe: add a stripe_dax_pgoff helper
      fsdax: remove a pointless __force cast in copy_cow_page_dax
      fsdax: use a saner calling convention for copy_cow_page_dax
      fsdax: simplify the pgoff calculation
      fsdax: simplify the offset check in dax_iomap_zero
      fsdax: factor out a dax_memzero helper
      fsdax: decouple zeroing from the iomap buffered I/O code
      ext2: cleanup the dax handling in ext2_fill_super
      ext4: cleanup the dax handling in ext4_fill_super
      xfs: move dax device handling into xfs_{alloc,free}_buftarg
      xfs: use xfs_direct_write_iomap_ops for DAX zeroing
      xfs: pass the mapping flags to xfs_bmbt_to_iomap
      iomap: add a IOMAP_DAX flag
      dax: return the partition offset from fs_dax_get_by_bdev
      fsdax: shift partition offset handling into the file systems
      dax: fix up some of the block device related ifdefs
      iomap: build the block based code conditionally
      fsdax: don't require CONFIG_BLOCK
      memremap: remove support for external pgmap refcounts
      iomap: turn the byte variable in iomap_zero_iter into a ssize_t
      uio: remove copy_from_iter_flushcache() and copy_mc_to_iter()
      dax: simplify dax_synchronous and set_dax_synchronous
      dax: remove the DAXDEV_F_SYNC flag
      dax: remove the copy_from_iter and copy_to_iter methods

Dan Williams (1):
      dax: Kill DEV_DAX_PMEM_COMPAT

Matthew Wilcox (Oracle) (1):
      iomap: Fix error handling in iomap_zero_iter()

Shiyang Ruan (1):
      xfs: add xfs_zero_range and xfs_truncate_page helpers

 Documentation/ABI/obsolete/sysfs-class-dax  |  22 ---
 drivers/acpi/nfit/core.c                    |   4 +-
 drivers/dax/Kconfig                         |  13 --
 drivers/dax/Makefile                        |   3 +-
 drivers/dax/bus.c                           |  30 +--
 drivers/dax/bus.h                           |  13 --
 drivers/dax/device.c                        |   6 +-
 drivers/dax/{pmem/core.c => pmem.c}         |  36 +++-
 drivers/dax/pmem/Makefile                   |   1 -
 drivers/dax/pmem/compat.c                   |  72 --------
 drivers/dax/pmem/pmem.c                     |  30 ---
 drivers/dax/super.c                         | 272 +++++++---------------------
 drivers/md/dm-linear.c                      |  63 ++-----
 drivers/md/dm-log-writes.c                  | 110 ++---------
 drivers/md/dm-stripe.c                      |  75 ++------
 drivers/md/dm-table.c                       |  22 +--
 drivers/md/dm-writecache.c                  |   2 +-
 drivers/md/dm.c                             |  89 ++-------
 drivers/md/dm.h                             |   4 -
 drivers/nvdimm/Kconfig                      |   2 +-
 drivers/nvdimm/pmem.c                       |  38 ++--
 drivers/pci/p2pdma.c                        |   2 +-
 drivers/s390/block/Kconfig                  |   2 +-
 drivers/s390/block/dcssblk.c                |  26 +--
 fs/Kconfig                                  |   8 +-
 fs/dax.c                                    | 157 +++++++++-------
 fs/erofs/data.c                             |  11 +-
 fs/erofs/internal.h                         |   3 +
 fs/erofs/super.c                            |  15 +-
 fs/ext2/ext2.h                              |   1 +
 fs/ext2/inode.c                             |  15 +-
 fs/ext2/super.c                             |  16 +-
 fs/ext4/ext4.h                              |   1 +
 fs/ext4/inode.c                             |  25 ++-
 fs/ext4/super.c                             |  14 +-
 fs/fuse/Kconfig                             |   2 +-
 fs/fuse/virtio_fs.c                         |  18 +-
 fs/iomap/Makefile                           |   4 +-
 fs/iomap/buffered-io.c                      |  39 ++--
 fs/xfs/libxfs/xfs_bmap.c                    |   4 +-
 fs/xfs/xfs_aops.c                           |   2 +-
 fs/xfs/xfs_bmap_util.c                      |   7 +-
 fs/xfs/xfs_buf.c                            |   8 +-
 fs/xfs/xfs_buf.h                            |   5 +-
 fs/xfs/xfs_file.c                           |   3 +-
 fs/xfs/xfs_iomap.c                          |  84 ++++++---
 fs/xfs/xfs_iomap.h                          |  12 +-
 fs/xfs/xfs_iops.c                           |   7 +-
 fs/xfs/xfs_pnfs.c                           |   4 +-
 fs/xfs/xfs_reflink.c                        |   3 +-
 fs/xfs/xfs_super.c                          |  80 ++++----
 include/linux/dax.h                         |  93 ++++------
 include/linux/device-mapper.h               |   4 -
 include/linux/iomap.h                       |   5 +
 include/linux/memremap.h                    |  18 +-
 include/linux/uio.h                         |  20 +-
 mm/memremap.c                               |  59 ++----
 tools/testing/nvdimm/Kbuild                 |   8 +-
 tools/testing/nvdimm/dax_pmem_compat_test.c |   8 -
 tools/testing/nvdimm/dax_pmem_core_test.c   |   8 -
 tools/testing/nvdimm/test/iomap.c           |  43 ++---
 tools/testing/nvdimm/test/ndtest.c          |   4 -
 tools/testing/nvdimm/test/nfit.c            |   4 -
 63 files changed, 569 insertions(+), 1190 deletions(-)
 delete mode 100644 Documentation/ABI/obsolete/sysfs-class-dax
 rename drivers/dax/{pmem/core.c => pmem.c} (75%)
 delete mode 100644 drivers/dax/pmem/compat.c
 delete mode 100644 tools/testing/nvdimm/dax_pmem_compat_test.c
 delete mode 100644 tools/testing/nvdimm/dax_pmem_core_test.c
