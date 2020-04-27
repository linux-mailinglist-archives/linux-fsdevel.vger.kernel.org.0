Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282131BB048
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 23:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgD0VRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 17:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgD0VRZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:17:25 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5F552075E;
        Mon, 27 Apr 2020 21:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022243;
        bh=diHIQNdW9tXwNaigHoaDIpMGH+WAB2UEy0sdibZm2Fc=;
        h=From:To:Cc:Subject:Date:From;
        b=P4ErDB3UqWrQeqbLqijoEa8kkqGyrk6Qu0y5yI2MKzjqNm6ch/xu4WEb6bki8G/bw
         w+R3JWBW/0iVAtsV2f2EZCbEipIeFB47JUs0l47yQSuVBVgGt6XiHW+EvIw5b5nHYD
         JW8gpsqNwh6fZ1haUh2NStOV0V/kj5diMisolXXs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTB7y-000Hjc-03; Mon, 27 Apr 2020 23:17:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-cachefs@redhat.com, codalist@coda.cs.cmu.edu,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-xfs@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v3 00/29] Convert files to ReST - part 2
Date:   Mon, 27 Apr 2020 23:16:52 +0200
Message-Id: <cover.1588021877.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the second part of a series I wrote sometime ago where I manually
convert lots of files to be properly parsed by Sphinx as ReST files.

As it touches on lot of stuff, this series is based on today's linux-next, 
at tag next-20190617.

The first version of this series had 57 patches. The first part with 28 patches
were already merged. Right now, there are still ~76  patches pending applying
(including this series), and that's because I opted to do ~1 patch per converted
 directory.

That sounds too much to be send on a single round. So, I'm opting to split
it on 3 parts for the conversion, plus a final patch adding orphaned books
to existing ones. 

Those patches should probably be good to be merged either by subsystem
maintainers or via the docs tree.

I opted to mark new files not included yet to the main index.rst (directly or
indirectly) with the :orphan: tag, in order to avoid adding warnings to the
build system. This should be removed after we find a "home" for all
the converted files within the new document tree arrangement, after I
submit the third part.

Both this series and  the other parts of this work are on my devel git tree,
at:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=convert_rst_renames_v5.1

The final output in html (after all patches I currently have, including 
the upcoming series) can be seen at:

	https://www.infradead.org/~mchehab/rst_conversion/

It contains all pending work from my side related to the conversion, plus
the patches I finished a first version today with contains the renaming 
patches and de-orphan changes.

---

Version 3:

- Rebased on the top of next-20200424
- configfs.rst conversion moved to the end of the series;
- avoided almost all markups at configfs.rst while still preserving
  a reasonable output and not generating build warnings.

Version 2:

- Removed patches merged via other trees;
- rebased on the top of today's linux-next (next-20190617);
- Fix a typo on one patch's description;
- Added received acks.

Mauro Carvalho Chehab (29):
  docs: filesystems: convert caching/object.txt to ReST
  docs: filesystems: convert caching/fscache.txt to ReST format
  docs: filesystems: caching/netfs-api.txt: convert it to ReST
  docs: filesystems: caching/operations.txt: convert it to ReST
  docs: filesystems: caching/cachefiles.txt: convert to ReST
  docs: filesystems: caching/backend-api.txt: convert it to ReST
  docs: filesystems: convert cifs/cifsroot.txt to ReST
  docs: filesystems: convert automount-support.txt to ReST
  docs: filesystems: convert coda.txt to ReST
  docs: filesystems: convert devpts.txt to ReST
  docs: filesystems: convert dnotify.txt to ReST
  docs: filesystems: convert fiemap.txt to ReST
  docs: filesystems: convert files.txt to ReST
  docs: filesystems: convert fuse-io.txt to ReST
  docs: filesystems: convert locks.txt to ReST
  docs: filesystems: convert mandatory-locking.txt to ReST
  docs: filesystems: convert mount_api.txt to ReST
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
  docs: filesystems: convert configfs.txt to ReST

 Documentation/admin-guide/sysctl/kernel.rst   |    2 +-
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
 .../{configfs/configfs.txt => configfs.rst}   |  131 +-
 Documentation/filesystems/devpts.rst          |   36 +
 Documentation/filesystems/devpts.txt          |   26 -
 .../filesystems/{dnotify.txt => dnotify.rst}  |   11 +-
 .../filesystems/{fiemap.txt => fiemap.rst}    |  133 +-
 .../filesystems/{files.txt => files.rst}      |   15 +-
 .../filesystems/{fuse-io.txt => fuse-io.rst}  |    6 +
 Documentation/filesystems/index.rst           |   23 +
 .../filesystems/{locks.txt => locks.rst}      |   14 +-
 ...tory-locking.txt => mandatory-locking.rst} |   25 +-
 .../{mount_api.txt => mount_api.rst}          |  329 ++--
 Documentation/filesystems/proc.rst            |    2 +-
 .../filesystems/{quota.txt => quota.rst}      |   41 +-
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
 Documentation/usb/gadget_configfs.rst         |    4 +-
 MAINTAINERS                                   |   14 +-
 fs/cachefiles/Kconfig                         |    4 +-
 fs/coda/Kconfig                               |    2 +-
 fs/configfs/inode.c                           |    2 +-
 fs/configfs/item.c                            |    2 +-
 fs/fscache/Kconfig                            |    8 +-
 fs/fscache/cache.c                            |    8 +-
 fs/fscache/cookie.c                           |    2 +-
 fs/fscache/object.c                           |    4 +-
 fs/fscache/operation.c                        |    2 +-
 fs/locks.c                                    |    2 +-
 include/linux/configfs.h                      |    2 +-
 include/linux/fs_context.h                    |    2 +-
 include/linux/fscache-cache.h                 |    4 +-
 include/linux/fscache.h                       |   42 +-
 include/linux/lsm_hooks.h                     |    2 +-
 54 files changed, 3843 insertions(+), 3408 deletions(-)
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
 create mode 100644 Documentation/filesystems/devpts.rst
 delete mode 100644 Documentation/filesystems/devpts.txt
 rename Documentation/filesystems/{dnotify.txt => dnotify.rst} (90%)
 rename Documentation/filesystems/{fiemap.txt => fiemap.rst} (70%)
 rename Documentation/filesystems/{files.txt => files.rst} (95%)
 rename Documentation/filesystems/{fuse-io.txt => fuse-io.rst} (95%)
 rename Documentation/filesystems/{locks.txt => locks.rst} (91%)
 rename Documentation/filesystems/{mandatory-locking.txt => mandatory-locking.rst} (91%)
 rename Documentation/filesystems/{mount_api.txt => mount_api.rst} (79%)
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
2.25.4


