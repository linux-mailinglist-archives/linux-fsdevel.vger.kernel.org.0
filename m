Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACFB1AAA22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 16:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394086AbgDOOdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 10:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394033AbgDOOcw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:32:52 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE72520857;
        Wed, 15 Apr 2020 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961170;
        bh=KiqG+YaH9TfLHMU7kAk5iZVq2iZm2vOE/nCgWZIaKyc=;
        h=From:To:Cc:Subject:Date:From;
        b=zmtkQ2yvb4lMCW7VyZbrY08AHuA6jaNelMxk+XjbrMt6hLetgzFtmSoM/epsya/Qn
         SEsnxu9G/tLR8lcHUuNuNcTbKgVyOplhVgI6xMcESplhJZCdGjqpBiZ/9grkpTlftr
         a1iGFMi+kSC7G4SOvfHDNZD5/3QnrIy5wZXFM5Y4=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5s-006kNi-SJ; Wed, 15 Apr 2020 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        ecryptfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-unionfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-usb@vger.kernel.org,
        codalist@coda.cs.cmu.edu, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org
Subject: [PATCH 00/34] fs: convert remaining docs to ReST file format
Date:   Wed, 15 Apr 2020 16:32:13 +0200
Message-Id: <cover.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series convert the remaining files under Documentation/filesystems
to the ReST file format. It is based on linux-next (next-20200414).

PS.: I opted to add mainly ML from the output of get_maintainers.pl to the c/c
list of patch 00/34, because  otherwise the number of c/c would be too many,
with would very likely cause ML servers to reject it.

The results of those changes (together with other changes from my pending
doc patches) are available at:

   https://www.infradead.org/~mchehab/kernel_docs/filesystems/index.html

Mauro Carvalho Chehab (34):
  docs: filesystems: fix references for doc files there
  docs: filesystems: convert caching/object.txt to ReST
  docs: filesystems: convert caching/fscache.txt to ReST format
  docs: filesystems: caching/netfs-api.txt: convert it to ReST
  docs: filesystems: caching/operations.txt: convert it to ReST
  docs: filesystems: caching/cachefiles.txt: convert to ReST
  docs: filesystems: caching/backend-api.txt: convert it to ReST
  docs: filesystems: convert cifs/cifsroot.rst to ReST
  docs: filesystems: convert configfs.txt to ReST
  docs: filesystems: convert automount-support.txt to ReST
  docs: filesystems: convert coda.txt to ReST
  docs: filesystems: convert dax.txt to ReST
  docs: filesystems: convert devpts.txt to ReST
  docs: filesystems: convert dnotify.txt to ReST
  docs: filesystems: convert fiemap.txt to ReST
  docs: filesystems: convert files.txt to ReST
  docs: filesystems: convert fuse-io.txt to ReST
  docs: filesystems: convert gfs2-glocks.txt to ReST
  docs: filesystems: convert locks.txt to ReST
  docs: filesystems: convert mandatory-locking.txt to ReST
  docs: filesystems: convert mount_api.txt to ReST
  docs: filesystems: rename path-lookup.txt file
  docs: filesystems: convert path-walking.txt to ReST
  docs: filesystems: convert quota.txt to ReST
  docs: filesystems: convert seq_file.txt to ReST
  docs: filesystems: convert sharedsubtree.txt to ReST
  docs: filesystems: split spufs.txt into 3 separate files
  docs: filesystems: convert spufs/spu_create.txt to ReST
  docs: filesystems: convert spufs/spufs.txt to ReST
  docs: filesystems: convert spufs/spu_run.txt to ReST
  docs: filesystems: convert sysfs-pci.txt to ReST
  docs: filesystems: convert sysfs-tagging.txt to ReST
  docs: filesystems: convert xfs-delayed-logging-design.txt to ReST
  docs: filesystems: convert xfs-self-describing-metadata.txt to ReST

 Documentation/ABI/stable/sysfs-devices-node   |    2 +-
 Documentation/ABI/testing/procfs-smaps_rollup |    2 +-
 Documentation/admin-guide/cpu-load.rst        |    2 +-
 Documentation/admin-guide/ext4.rst            |    2 +-
 Documentation/admin-guide/nfs/nfsroot.rst     |    2 +-
 Documentation/admin-guide/sysctl/kernel.rst   |    2 +-
 .../driver-api/driver-model/device.rst        |    2 +-
 .../driver-api/driver-model/overview.rst      |    2 +-
 ...ount-support.txt => automount-support.rst} |   23 +-
 .../{backend-api.txt => backend-api.rst}      |  165 +-
 .../{cachefiles.txt => cachefiles.rst}        |  139 +-
 Documentation/filesystems/caching/fscache.rst |  565 ++++++
 Documentation/filesystems/caching/fscache.txt |  448 -----
 Documentation/filesystems/caching/index.rst   |   14 +
 .../caching/{netfs-api.txt => netfs-api.rst}  |  172 +-
 .../caching/{object.txt => object.rst}        |   43 +-
 .../{operations.txt => operations.rst}        |   45 +-
 .../cifs/{cifsroot.txt => cifsroot.rst}       |   56 +-
 Documentation/filesystems/coda.rst            | 1670 ++++++++++++++++
 Documentation/filesystems/coda.txt            | 1676 -----------------
 .../{configfs/configfs.txt => configfs.rst}   |  129 +-
 .../filesystems/{dax.txt => dax.rst}          |   11 +-
 Documentation/filesystems/devpts.rst          |   36 +
 Documentation/filesystems/devpts.txt          |   26 -
 .../filesystems/{dnotify.txt => dnotify.rst}  |   13 +-
 Documentation/filesystems/ext2.rst            |    2 +-
 .../filesystems/{fiemap.txt => fiemap.rst}    |  133 +-
 .../filesystems/{files.txt => files.rst}      |   15 +-
 .../filesystems/{fuse-io.txt => fuse-io.rst}  |    6 +
 .../{gfs2-glocks.txt => gfs2-glocks.rst}      |  147 +-
 Documentation/filesystems/index.rst           |   26 +
 .../filesystems/{locks.txt => locks.rst}      |   14 +-
 ...tory-locking.txt => mandatory-locking.rst} |   25 +-
 .../{mount_api.txt => mount_api.rst}          |  329 ++--
 .../{path-lookup.txt => path-walking.rst}     |   88 +-
 Documentation/filesystems/porting.rst         |    2 +-
 Documentation/filesystems/proc.rst            |    2 +-
 .../filesystems/{quota.txt => quota.rst}      |   41 +-
 .../filesystems/ramfs-rootfs-initramfs.rst    |    2 +-
 .../{seq_file.txt => seq_file.rst}            |   61 +-
 .../{sharedsubtree.txt => sharedsubtree.rst}  |  394 ++--
 Documentation/filesystems/spufs/index.rst     |   13 +
 .../filesystems/spufs/spu_create.rst          |  131 ++
 Documentation/filesystems/spufs/spu_run.rst   |  138 ++
 .../{spufs.txt => spufs/spufs.rst}            |  304 +--
 .../{sysfs-pci.txt => sysfs-pci.rst}          |   23 +-
 .../{sysfs-tagging.txt => sysfs-tagging.rst}  |   22 +-
 ...ign.txt => xfs-delayed-logging-design.rst} |   65 +-
 ...a.txt => xfs-self-describing-metadata.rst} |  182 +-
 Documentation/iio/iio_configfs.rst            |    2 +-
 .../powerpc/firmware-assisted-dump.rst        |    2 +-
 Documentation/process/adding-syscalls.rst     |    2 +-
 .../it_IT/process/adding-syscalls.rst         |    2 +-
 .../translations/zh_CN/filesystems/sysfs.txt  |    6 +-
 Documentation/usb/gadget_configfs.rst         |    4 +-
 MAINTAINERS                                   |   16 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |    2 +-
 fs/Kconfig                                    |    2 +-
 fs/Kconfig.binfmt                             |    2 +-
 fs/adfs/Kconfig                               |    2 +-
 fs/affs/Kconfig                               |    2 +-
 fs/afs/Kconfig                                |    6 +-
 fs/bfs/Kconfig                                |    2 +-
 fs/cachefiles/Kconfig                         |    4 +-
 fs/coda/Kconfig                               |    2 +-
 fs/configfs/inode.c                           |    2 +-
 fs/configfs/item.c                            |    2 +-
 fs/cramfs/Kconfig                             |    2 +-
 fs/dcache.c                                   |    6 +-
 fs/ecryptfs/Kconfig                           |    2 +-
 fs/fat/Kconfig                                |    8 +-
 fs/fscache/Kconfig                            |    8 +-
 fs/fscache/cache.c                            |    8 +-
 fs/fscache/cookie.c                           |    2 +-
 fs/fscache/object.c                           |    4 +-
 fs/fscache/operation.c                        |    2 +-
 fs/fuse/Kconfig                               |    2 +-
 fs/fuse/dev.c                                 |    2 +-
 fs/hfs/Kconfig                                |    2 +-
 fs/hpfs/Kconfig                               |    2 +-
 fs/isofs/Kconfig                              |    2 +-
 fs/locks.c                                    |    2 +-
 fs/namei.c                                    |    2 +-
 fs/namespace.c                                |    2 +-
 fs/notify/inotify/Kconfig                     |    2 +-
 fs/ntfs/Kconfig                               |    2 +-
 fs/ocfs2/Kconfig                              |    2 +-
 fs/overlayfs/Kconfig                          |    6 +-
 fs/proc/Kconfig                               |    4 +-
 fs/romfs/Kconfig                              |    2 +-
 fs/sysfs/dir.c                                |    2 +-
 fs/sysfs/file.c                               |    2 +-
 fs/sysfs/mount.c                              |    2 +-
 fs/sysfs/symlink.c                            |    2 +-
 fs/sysv/Kconfig                               |    2 +-
 fs/udf/Kconfig                                |    2 +-
 include/linux/configfs.h                      |    2 +-
 include/linux/fs_context.h                    |    2 +-
 include/linux/fscache-cache.h                 |    4 +-
 include/linux/fscache.h                       |   42 +-
 include/linux/lsm_hooks.h                     |    2 +-
 include/linux/relay.h                         |    2 +-
 include/linux/sysfs.h                         |    2 +-
 kernel/relay.c                                |    2 +-
 104 files changed, 4048 insertions(+), 3572 deletions(-)
 rename Documentation/filesystems/{automount-support.txt => automount-support.rst} (92%)
 rename Documentation/filesystems/caching/{backend-api.txt => backend-api.rst} (87%)
 rename Documentation/filesystems/caching/{cachefiles.txt => cachefiles.rst} (90%)
 create mode 100644 Documentation/filesystems/caching/fscache.rst
 delete mode 100644 Documentation/filesystems/caching/fscache.txt
 create mode 100644 Documentation/filesystems/caching/index.rst
 rename Documentation/filesystems/caching/{netfs-api.txt => netfs-api.rst} (91%)
 rename Documentation/filesystems/caching/{object.txt => object.rst} (95%)
 rename Documentation/filesystems/caching/{operations.txt => operations.rst} (90%)
 rename Documentation/filesystems/cifs/{cifsroot.txt => cifsroot.rst} (72%)
 create mode 100644 Documentation/filesystems/coda.rst
 delete mode 100644 Documentation/filesystems/coda.txt
 rename Documentation/filesystems/{configfs/configfs.txt => configfs.rst} (87%)
 rename Documentation/filesystems/{dax.txt => dax.rst} (96%)
 create mode 100644 Documentation/filesystems/devpts.rst
 delete mode 100644 Documentation/filesystems/devpts.txt
 rename Documentation/filesystems/{dnotify.txt => dnotify.rst} (88%)
 rename Documentation/filesystems/{fiemap.txt => fiemap.rst} (70%)
 rename Documentation/filesystems/{files.txt => files.rst} (95%)
 rename Documentation/filesystems/{fuse-io.txt => fuse-io.rst} (95%)
 rename Documentation/filesystems/{gfs2-glocks.txt => gfs2-glocks.rst} (63%)
 rename Documentation/filesystems/{locks.txt => locks.rst} (91%)
 rename Documentation/filesystems/{mandatory-locking.txt => mandatory-locking.rst} (91%)
 rename Documentation/filesystems/{mount_api.txt => mount_api.rst} (79%)
 rename Documentation/filesystems/{path-lookup.txt => path-walking.rst} (91%)
 rename Documentation/filesystems/{quota.txt => quota.rst} (81%)
 rename Documentation/filesystems/{seq_file.txt => seq_file.rst} (92%)
 rename Documentation/filesystems/{sharedsubtree.txt => sharedsubtree.rst} (72%)
 create mode 100644 Documentation/filesystems/spufs/index.rst
 create mode 100644 Documentation/filesystems/spufs/spu_create.rst
 create mode 100644 Documentation/filesystems/spufs/spu_run.rst
 rename Documentation/filesystems/{spufs.txt => spufs/spufs.rst} (57%)
 rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst} (92%)
 rename Documentation/filesystems/{sysfs-tagging.txt => sysfs-tagging.rst} (72%)
 rename Documentation/filesystems/{xfs-delayed-logging-design.txt => xfs-delayed-logging-design.rst} (97%)
 rename Documentation/filesystems/{xfs-self-describing-metadata.txt => xfs-self-describing-metadata.rst} (83%)

-- 
2.25.2


