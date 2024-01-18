Return-Path: <linux-fsdevel+bounces-8243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A5D831939
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 13:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA7C1C22A19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CFE24B3A;
	Thu, 18 Jan 2024 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYhAz02K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78C241E2;
	Thu, 18 Jan 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581458; cv=none; b=c4YzN0tRZxnv2RHGNrTBKMphT+yYdmUossnN22suqmVoA2GvaVks6daQmgbBchV6FutLdR10ndqcPFV2vkZ8bvTmIJHr3dj/NEbWWY9/7A4AYJcWgwtjCfD+qLYrVngvOs/dEj+TNIt7jLhyQlzN4c1emrLKqZNwZHliTsHqsuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581458; c=relaxed/simple;
	bh=ik1NHCtA8OUk9NpUop8jx5337jMu3I6UAWwHGVz7Eok=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding; b=rJaaG+YemG2u0XI2YAmjpET3UQvCtBouqU3XIfARlNX6NjrARLVIJkAs+Ga1y8/Zq0+STcnVx4Uaj3rg+JjH9448G6Dqy2/JEhtt5Wy8oQplW/Co9ViLu4W1pc+H8++2XU/3alKaWyeshotJmylNHlP9lysQK+tByP/7icvnsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYhAz02K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6049EC433F1;
	Thu, 18 Jan 2024 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705581457;
	bh=ik1NHCtA8OUk9NpUop8jx5337jMu3I6UAWwHGVz7Eok=;
	h=From:To:Cc:Subject:Date:From;
	b=LYhAz02KCsoY1p42ihq+y5OT+Pb/OO3Gwj32+EjZpDrGInOfzBUgy4wiFjEugpPiv
	 2l1kMH9W7hdkrvMNUBFKlSbU4Ffl+v4ZajL7mz2e1MQuom+Q0GmPu723nXf0A1+e0f
	 FEV9sdRT3mtlX8H7AzVo2Qv21XZQknMhNduQIskJGpE8Unt+ygBDLwrJ0OD+ujNN9U
	 toB+1a407jaNdeQyLD0GJjsNC39IeoZEAiwckn3xcbosHVrQJ0O7GA0E2YBbO5wYg5
	 aVcG7ctJQV1NMC6o1tBVa/Tkj4M189SGBKldwYga5tyYrmbFWQ8eBirNT/Mu3Eg/iK
	 GtR0gSTrcLneA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs netfs updates
Date: Thu, 18 Jan 2024 13:35:52 +0100
Message-ID: <20240118-vfs-netfs-cf05da67fbe0@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12641; i=brauner@kernel.org; h=from:subject:message-id; bh=ik1NHCtA8OUk9NpUop8jx5337jMu3I6UAWwHGVz7Eok=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSulNZ2N97whTFERkiIZffNZzHebPVVzdqLlikUz8/gl piXNeVdRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERuRzL8Zjef5ZYYJiFwOkhf W/r60rnbTnywr5SSk/i/MMxp6ZIl1owMq7fcsuN5XLz59yS1m8ESRfsKj/tN5JzA9MHa4Dl33xd nJgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

Based on the discussions at Maintainer's Summit I've encouraged relevant
people to provide pulls if they feel comfortable doing so. So same as
vfs-6.8.rw this contains pulls.

I've intentionally delayed sending this until the second week to be able
to include a round of fixes merged beginning of January.

/* Summary */
This extends the netfs helper library that network filesystems can use
to replace their own implementations. Both afs and 9p are ported. cifs
is ready as well but the patches are way bigger and will be routed
separately once this is merged. That will remove lots of code as well.

The overal goal is to get high-level I/O and knowledge of the page cache
and ouf of the filesystem drivers. This includes knowledge about the
existence of pages and folios

The pull request converts afs and 9p. This removes about 800 lines of
code from afs and 300 from 9p. For 9p it is now possible to do writes in
larger than a page chunks. Additionally, multipage folio support can be
turned on for 9p. Separate patches exist for cifs removing another 2000+
lines. I've included detailed information in the individual pulls I
took. Here is an overview:

* Add NFS-style (and Ceph-style) locking around DIO vs buffered I/O
  calls to prevent these from happening at the same time.
* Support for direct and unbuffered I/O.
* Support for write-through caching in the page cache.
* O_*SYNC and RWF_*SYNC writes use write-through rather than writing to
  the page cache and then flushing afterwards.
* Support for write-streaming.
* Support for write grouping.
* Skip reads for which the server could only return zeros or EOF.
* The fscache module is now part of the netfs library and the
  corresponding maintainer entry is updated.
* Some helpers from the fscache subsystem are renamed to mark them as
  belonging to the netfs library.
* Follow-up fixes for the netfs library.
* Follow-up fixes for the 9p conversion.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.7-rc4 and have been sitting in linux-next.

/* Conflicts */
This has two merge conflicts with mainline:

[1] In the MAINTAINERS file as both the vfs-6.8.rw tag and the
    vfs-6.8.netfs tag add new entries. The resolution is just additive.
    IOW, vfs-6.8.rw added an entry and vfs-6.8.netfs does as well.
[2] Mainline has the generic_error_remove_page() helper removed. This
    helper was used in netfs_kill_pages() in fs/netfs/buffered_write.c.
    It simply needs to be replaced with generic_error_remove_folio().
[3] This is a minor merge conflict in fs/afs/write.c. The file as it is in
    vfs-6.8.netfs is correct.

Since mainline doesn't contain the fs/netfs/buffered_write.c where the
helper mentioned in [2] needs to be replaced the resolution is
ridiculously large so I've added the merge resolution for [1] to [3]
here: https://gitlab.com/-/snippets/3640251

The following changes since commit 861deac3b092f37b2c5e6871732f3e11486f7082:

  Linux 6.7-rc7 (2023-12-23 16:25:56 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.netfs

for you to fetch changes up to 1d5911d43cab5fb99229b02bce173b0c6d9da7d2:

  Merge tag 'netfs-lib-20240109' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs into vfs.netfs (2024-01-11 12:22:33 +0100)

Please consider pulling these changes from the signed vfs-6.8.netfs tag.

Happy New Year!
Christian

----------------------------------------------------------------
vfs-6.8.netfs

----------------------------------------------------------------
Christian Brauner (3):
      Merge tag 'netfs-lib-20231228' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
      Merge tag 'netfs-lib-20240104' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
      Merge tag 'netfs-lib-20240109' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs into vfs.netfs

David Howells (52):
      afs: Remove whitespace before most ')' from the trace header
      afs: Automatically generate trace tag enums
      netfs, fscache: Move fs/fscache/* into fs/netfs/
      netfs, fscache: Combine fscache with netfs
      netfs, fscache: Remove ->begin_cache_operation
      netfs, fscache: Move /proc/fs/fscache to /proc/fs/netfs and put in a symlink
      netfs: Move pinning-for-writeback from fscache to netfs
      netfs: Add a procfile to list in-progress requests
      netfs: Allow the netfs to make the io (sub)request alloc larger
      netfs: Add a ->free_subrequest() op
      afs: Don't use folio->private to record partial modification
      netfs: Provide invalidate_folio and release_folio calls
      netfs: Implement unbuffered/DIO vs buffered I/O locking
      netfs: Add iov_iters to (sub)requests to describe various buffers
      netfs: Add support for DIO buffering
      netfs: Provide tools to create a buffer in an xarray
      netfs: Add func to calculate pagecount/size-limited span of an iterator
      netfs: Limit subrequest by size or number of segments
      netfs: Extend the netfs_io_*request structs to handle writes
      netfs: Add a hook to allow tell the netfs to update its i_size
      netfs: Make netfs_put_request() handle a NULL pointer
      netfs: Make the refcounting of netfs_begin_read() easier to use
      netfs: Prep to use folio->private for write grouping and streaming write
      netfs: Dispatch write requests to process a writeback slice
      netfs: Provide func to copy data to pagecache for buffered write
      netfs: Make netfs_read_folio() handle streaming-write pages
      netfs: Allocate multipage folios in the writepath
      netfs: Implement unbuffered/DIO read support
      netfs: Implement unbuffered/DIO write support
      netfs: Implement buffered write API
      netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()
      netfs: Provide netfs_file_read_iter()
      netfs, cachefiles: Pass upper bound length to allow expansion
      netfs: Provide a writepages implementation
      netfs: Provide a launder_folio implementation
      netfs: Implement a write-through caching option
      netfs: Optimise away reads above the point at which there can be no data
      netfs: Export the netfs_sreq tracepoint
      afs: Use the netfs write helpers
      9p: Use netfslib read/write_iter
      cachefiles: Fix __cachefiles_prepare_write()
      9p: Fix initialisation of netfs_inode for 9p
      9p: Do a couple of cleanups
      9p: Use length of data written to the server in preference to error
      netfs: Rearrange netfs_io_subrequest to put request pointer first
      netfs: Fix proc/fs/fscache symlink to point to "netfs" not "../netfs"
      netfs: Mark netfs_unbuffered_write_iter_locked() static
      netfs: Count DIO writes
      netfs: Fix interaction between write-streaming and cachefiles culling
      netfs: Fix the loop that unmarks folios after writing to the cache
      cachefiles: Fix signed/unsigned mixup
      netfs: Fix wrong #ifdef hiding wait

 Documentation/filesystems/netfs_library.rst     |   23 +-
 MAINTAINERS                                     |   21 +-
 arch/arm/configs/mxs_defconfig                  |    3 +-
 arch/csky/configs/defconfig                     |    3 +-
 arch/mips/configs/ip27_defconfig                |    3 +-
 arch/mips/configs/lemote2f_defconfig            |    3 +-
 arch/mips/configs/loongson3_defconfig           |    3 +-
 arch/mips/configs/pic32mzda_defconfig           |    3 +-
 arch/s390/configs/debug_defconfig               |    3 +-
 arch/s390/configs/defconfig                     |    3 +-
 arch/sh/configs/sdk7786_defconfig               |    3 +-
 fs/9p/v9fs_vfs.h                                |    1 +
 fs/9p/vfs_addr.c                                |  353 ++-----
 fs/9p/vfs_file.c                                |   89 +-
 fs/9p/vfs_inode.c                               |   16 +-
 fs/9p/vfs_inode_dotl.c                          |    8 +-
 fs/9p/vfs_super.c                               |   14 +-
 fs/Kconfig                                      |    1 -
 fs/Makefile                                     |    1 -
 fs/afs/dynroot.c                                |    2 +-
 fs/afs/file.c                                   |  213 ++--
 fs/afs/inode.c                                  |   28 +-
 fs/afs/internal.h                               |   72 +-
 fs/afs/super.c                                  |    2 +-
 fs/afs/write.c                                  |  828 +--------------
 fs/cachefiles/Kconfig                           |    2 +-
 fs/cachefiles/internal.h                        |    2 +-
 fs/cachefiles/io.c                              |   34 +-
 fs/cachefiles/ondemand.c                        |    2 +-
 fs/ceph/addr.c                                  |   25 +-
 fs/ceph/cache.h                                 |   45 +-
 fs/ceph/inode.c                                 |    4 +-
 fs/erofs/Kconfig                                |    7 +-
 fs/fs-writeback.c                               |   10 +-
 fs/fscache/Kconfig                              |   40 -
 fs/fscache/Makefile                             |   16 -
 fs/fscache/internal.h                           |  277 -----
 fs/netfs/Kconfig                                |   39 +
 fs/netfs/Makefile                               |   22 +-
 fs/netfs/buffered_read.c                        |  229 ++++-
 fs/netfs/buffered_write.c                       | 1253 +++++++++++++++++++++++
 fs/netfs/direct_read.c                          |  125 +++
 fs/netfs/direct_write.c                         |  171 ++++
 fs/{fscache/cache.c => netfs/fscache_cache.c}   |    0
 fs/{fscache/cookie.c => netfs/fscache_cookie.c} |    0
 fs/netfs/fscache_internal.h                     |   14 +
 fs/{fscache/io.c => netfs/fscache_io.c}         |   42 +-
 fs/{fscache/main.c => netfs/fscache_main.c}     |   25 +-
 fs/{fscache/proc.c => netfs/fscache_proc.c}     |   23 +-
 fs/{fscache/stats.c => netfs/fscache_stats.c}   |   13 +-
 fs/{fscache/volume.c => netfs/fscache_volume.c} |    0
 fs/netfs/internal.h                             |  284 +++++
 fs/netfs/io.c                                   |  213 +++-
 fs/netfs/iterator.c                             |   97 ++
 fs/netfs/locking.c                              |  216 ++++
 fs/netfs/main.c                                 |  109 ++
 fs/netfs/misc.c                                 |  260 +++++
 fs/netfs/objects.c                              |   59 +-
 fs/netfs/output.c                               |  478 +++++++++
 fs/netfs/stats.c                                |   42 +-
 fs/nfs/Kconfig                                  |    4 +-
 fs/nfs/fscache.c                                |    7 -
 fs/nfs/fscache.h                                |    2 +-
 fs/smb/client/cifsfs.c                          |    9 +-
 fs/smb/client/file.c                            |   18 +-
 fs/smb/client/fscache.c                         |    2 +-
 include/linux/fs.h                              |    2 +-
 include/linux/fscache-cache.h                   |    3 +
 include/linux/fscache.h                         |   45 -
 include/linux/netfs.h                           |  181 +++-
 include/linux/writeback.h                       |    2 +-
 include/trace/events/afs.h                      |  496 +++------
 include/trace/events/netfs.h                    |  155 ++-
 mm/filemap.c                                    |    2 +
 74 files changed, 4301 insertions(+), 2504 deletions(-)
 delete mode 100644 fs/fscache/Kconfig
 delete mode 100644 fs/fscache/Makefile
 delete mode 100644 fs/fscache/internal.h
 create mode 100644 fs/netfs/buffered_write.c
 create mode 100644 fs/netfs/direct_read.c
 create mode 100644 fs/netfs/direct_write.c
 rename fs/{fscache/cache.c => netfs/fscache_cache.c} (100%)
 rename fs/{fscache/cookie.c => netfs/fscache_cookie.c} (100%)
 create mode 100644 fs/netfs/fscache_internal.h
 rename fs/{fscache/io.c => netfs/fscache_io.c} (86%)
 rename fs/{fscache/main.c => netfs/fscache_main.c} (84%)
 rename fs/{fscache/proc.c => netfs/fscache_proc.c} (58%)
 rename fs/{fscache/stats.c => netfs/fscache_stats.c} (90%)
 rename fs/{fscache/volume.c => netfs/fscache_volume.c} (100%)
 create mode 100644 fs/netfs/locking.c
 create mode 100644 fs/netfs/misc.c
 create mode 100644 fs/netfs/output.c

