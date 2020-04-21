Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0CF1B2D38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 18:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgDUQyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 12:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUQyp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:54:45 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF7A32072D;
        Tue, 21 Apr 2020 16:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488084;
        bh=I+poV6aWdrEtdHBUr6m4gEt4rVr2SFuzXvvDAKP9Sho=;
        h=From:To:Cc:Subject:Date:From;
        b=qB58J7CdaJxDgs3IwR1BILA82/V832qHRtvohLy/Kb2dIF+RDago1sOUyA3wcPGJm
         THLL/xW1xsSn7snwNLctffrsALp7GFFpR5aKSAh6XUVIxbQC8PeapfYgVMPAaXblew
         /vob6Aoa4APmTstwu4eEJlbcEEo5polgmbJysOSA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwAU-00CmDK-0s; Tue, 21 Apr 2020 18:54:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
        linux-cachefs@redhat.com, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>, codalist@coda.cs.cmu.edu,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Joel Becker <jlbec@evilplan.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Amir Goldstein <amir73il@gmail.com>, coda@cs.cmu.edu,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 00/29] fs: convert remaining docs to ReST file format
Date:   Tue, 21 Apr 2020 18:54:11 +0200
Message-Id: <cover.1587487612.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series convert the remaining files under Documentation/filesystems
to the ReST file format (except for dax.txt and patch-lookup.txt). 

It is based on linux-next (next-2020021).

PS.: I opted to add mainly ML from the output of get_maintainers.pl to the c/c
list of patch 00/34, because  otherwise the number of c/c would be too many,
with would very likely cause ML servers to reject it.

The results of those changes (together with other changes from my pending
doc patches) are available at:

   https://www.infradead.org/~mchehab/kernel_docs/filesystems/index.html

And the series is also on my git tree:

  https://git.linuxtv.org/mchehab/experimental.git/log/?h=fs_docs

If you prefer, feel free to merge the patches via the filesystems git tree(s).

- 

v2:

   - Removed dax.txt, in order to prevent a merge conflict with a dax patchset;
   - Removed patch-lookup.txt conversion, due to patch-lookup.rst.
     (I'll revisit this on some future)
   - Removed a patch that was already merged;
   - Added some Acked-by.


Mauro Carvalho Chehab (29):
  docs: filesystems: convert caching/object.txt to ReST
  docs: filesystems: convert caching/fscache.txt to ReST format
  docs: filesystems: caching/netfs-api.txt: convert it to ReST
  docs: filesystems: caching/operations.txt: convert it to ReST
  docs: filesystems: caching/cachefiles.txt: convert to ReST
  docs: filesystems: caching/backend-api.txt: convert it to ReST
  docs: filesystems: convert cifs/cifsroot.txt to ReST
  docs: filesystems: convert configfs.txt to ReST
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
 .../{configfs/configfs.txt => configfs.rst}   |  129 +-
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
 54 files changed, 3844 insertions(+), 3405 deletions(-)
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
2.25.2


