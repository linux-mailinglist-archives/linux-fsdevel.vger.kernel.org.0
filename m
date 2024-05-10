Return-Path: <linux-fsdevel+bounces-19268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D7E8C23D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBF528744D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8351B16F27C;
	Fri, 10 May 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp2Jk0+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7E16EC08;
	Fri, 10 May 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341631; cv=none; b=eYD1VavBuXNUjixz+VQ05D0yo9CCO7O/SsMw3OAtfVZdj61tn712TIyenk35kSuEKv9+iusLk3MkPsa6WGcuvGkQbmOpRDreCXhVzlWJOyqha67Th+8DwFj+ogaNHfNMNfiy9MMagR7yPQa4x0UEhnGgFAp8slQSIhtqqDROaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341631; c=relaxed/simple;
	bh=H237JJlYEBEojzy/jU9rLbj/JXb7X508QlglCuudjLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5DKJhmD9n/NqOML7LFGTBT0dPZiyenAdDIxzTIfIN5mc38bXKcZfgPDwC3vC4wb7hPZPG6vwM4JuRTIHg2DSi4wjdXbohc5cLwYWW/MkaTayuNvF7ZHqGdWCMYyfAT/ly/lnCzgejjs2KY+mvbU0skIGCl0HPart4hD1CV2AM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp2Jk0+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37520C113CC;
	Fri, 10 May 2024 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715341630;
	bh=H237JJlYEBEojzy/jU9rLbj/JXb7X508QlglCuudjLw=;
	h=From:To:Cc:Subject:Date:From;
	b=Pp2Jk0+XPPvzfhcId96EOoYYy1gJT52hP1WUSohhQyp4WF1aQ5WSkE6CpZ7tKHCZt
	 6kMKyAYOWGS3ESC7jcK+JEaqFW+TxsLNRRfRont+C9stammc48bcCl5WulsZy+XK1O
	 jFRwwPTOFWCXmEJJUIAOLJi5lx8+h3gIaZ9xWWlmobc/diPUPGDSLbBDL9k7V3hAmr
	 hfu1Nhcpd4O2FvGLueDUvb6KyzpgsWTObUONK2J9t8JOgV7r44Uj90Q9KDd9Vh5DoD
	 srp6wyA4tDhyYfanK0DZM32uXvgu3SuYez8D635Juk1SZLAQiqMeW3bkC8WKH0fTfd
	 JcnisEF1HntwA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs netfs
Date: Fri, 10 May 2024 13:47:02 +0200
Message-ID: <20240510-vfs-netfs-f805bdd4c8ad@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7054; i=brauner@kernel.org; h=from:subject:message-id; bh=H237JJlYEBEojzy/jU9rLbj/JXb7X508QlglCuudjLw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTZcVo+2aeR6nrcV2trtInYndOLN+39O03z9Yw1qlMLL U0tZh0T7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIA1OGP9wnTNnPP7r24/H8 dndmnnmvPVZK5ss9+hypvME7zvRaWATD/8jadekn+jt836jZH5SpuOqkcUVHPm5mlmd+eY55waE 77AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This reworks the netfslib writeback implementation so that pages read
from the cache are written to the cache through ->writepages(), thereby
allowing the fscache page flag to be retired.

The reworking also:

 (1) builds on top of the new writeback_iter() infrastructure;

 (2) makes it possible to use vectored write RPCs as discontiguous streams
     of pages can be accommodated;

 (3) makes it easier to do simultaneous content crypto and stream division.

 (4) provides support for retrying writes and re-dividing a stream;

 (5) replaces the ->launder_folio() op, so that ->writepages() is used
     instead;

 (6) uses mempools to allocate the netfs_io_request and netfs_io_subrequest
     structs to avoid allocation failure in the writeback path.

Some code that uses the fscache page flag is retained for compatibility
purposes with nfs and ceph. The code is switched to using the synonymous
private_2 label instead and marked with deprecation comments.

The merge commit contains additional details on the new algorithm that
I've left out of here as it would probably be excessively detailed.

On top of the netfslib infrastructure this contains the work to convert
cifs over to netfslib.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.9-rc6 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

No known conflicts.

The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.netfs

for you to fetch changes up to e2bc9f6cfbd62c72a93a70068daab8886bec32ce:

  Merge branch 'cifs-netfs' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs (2024-05-02 11:23:31 +0200)

Please consider pulling these changes from the signed vfs-6.10.netfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.10.netfs

----------------------------------------------------------------
Christian Brauner (2):
      Merge branch 'netfs-writeback' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
      Merge branch 'cifs-netfs' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs

David Howells (38):
      netfs: Update i_blocks when write committed to pagecache
      netfs: Replace PG_fscache by setting folio->private and marking dirty
      mm: Remove the PG_fscache alias for PG_private_2
      netfs: Remove deprecated use of PG_private_2 as a second writeback flag
      netfs: Make netfs_io_request::subreq_counter an atomic_t
      netfs: Use subreq_counter to allocate subreq debug_index values
      mm: Provide a means of invalidation without using launder_folio
      9p: Use alternative invalidation to using launder_folio
      afs: Use alternative invalidation to using launder_folio
      netfs: Remove ->launder_folio() support
      netfs: Use mempools for allocating requests and subrequests
      mm: Export writeback_iter()
      netfs: Switch to using unsigned long long rather than loff_t
      netfs: New writeback implementation
      netfs: Add some write-side stats and clean up some stat names
      netfs, afs: Implement helpers for new write code
      netfs, 9p: Implement helpers for new write code
      netfs, cachefiles: Implement helpers for new write code
      netfs: Cut over to using new writeback code
      netfs: Remove the old writeback code
      netfs: Miscellaneous tidy ups
      netfs, afs: Use writeback retry to deal with alternate keys
      cifs: Use alternative invalidation to using launder_folio
      cifs: Replace cifs_readdata with a wrapper around netfs_io_subrequest
      cifs: Replace cifs_writedata with a wrapper around netfs_io_subrequest
      cifs: Use more fields from netfs_io_subrequest
      cifs: Make wait_mtu_credits take size_t args
      cifs: Replace the writedata replay bool with a netfs sreq flag
      cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c
      cifs: Set zero_point in the copy_file_range() and remap_file_range()
      cifs: Add mempools for cifs_io_request and cifs_io_subrequest structs
      cifs: Make add_credits_and_wake_if() clear deducted credits
      cifs: Implement netfslib hooks
      cifs: Cut over to using netfslib
      cifs: Remove some code that's no longer used, part 1
      cifs: Remove some code that's no longer used, part 2
      cifs: Remove some code that's no longer used, part 3
      cifs: Enable large folio support

 fs/9p/vfs_addr.c             |   60 +-
 fs/afs/file.c                |    8 +-
 fs/afs/internal.h            |    6 +-
 fs/afs/validation.c          |    4 +-
 fs/afs/write.c               |  189 +--
 fs/cachefiles/io.c           |   76 +-
 fs/ceph/addr.c               |   24 +-
 fs/ceph/inode.c              |    2 +
 fs/netfs/Makefile            |    3 +-
 fs/netfs/buffered_read.c     |   40 +-
 fs/netfs/buffered_write.c    |  829 ++-----------
 fs/netfs/direct_write.c      |   56 +-
 fs/netfs/fscache_io.c        |   14 +-
 fs/netfs/internal.h          |   55 +-
 fs/netfs/io.c                |  162 +--
 fs/netfs/main.c              |   55 +-
 fs/netfs/misc.c              |   10 +-
 fs/netfs/objects.c           |   81 +-
 fs/netfs/output.c            |  478 --------
 fs/netfs/stats.c             |   17 +-
 fs/netfs/write_collect.c     |  808 +++++++++++++
 fs/netfs/write_issue.c       |  684 +++++++++++
 fs/nfs/file.c                |    8 +-
 fs/nfs/fscache.h             |    6 +-
 fs/nfs/write.c               |    4 +-
 fs/smb/client/Kconfig        |    1 +
 fs/smb/client/cifsfs.c       |  124 +-
 fs/smb/client/cifsfs.h       |   11 +-
 fs/smb/client/cifsglob.h     |   65 +-
 fs/smb/client/cifsproto.h    |   12 +-
 fs/smb/client/cifssmb.c      |  120 +-
 fs/smb/client/file.c         | 2720 ++++++------------------------------------
 fs/smb/client/fscache.c      |  109 --
 fs/smb/client/fscache.h      |   54 -
 fs/smb/client/inode.c        |   45 +-
 fs/smb/client/smb2ops.c      |   10 +-
 fs/smb/client/smb2pdu.c      |  186 +--
 fs/smb/client/smb2proto.h    |    5 +-
 fs/smb/client/trace.h        |  144 ++-
 fs/smb/client/transport.c    |   17 +-
 include/linux/fscache.h      |   22 +-
 include/linux/netfs.h        |  197 +--
 include/linux/pagemap.h      |    2 +
 include/net/9p/client.h      |    2 +
 include/trace/events/netfs.h |  250 +++-
 mm/filemap.c                 |   60 +-
 mm/page-writeback.c          |    1 +
 net/9p/Kconfig               |    1 +
 net/9p/client.c              |   49 +
 49 files changed, 3298 insertions(+), 4588 deletions(-)
 delete mode 100644 fs/netfs/output.c
 create mode 100644 fs/netfs/write_collect.c
 create mode 100644 fs/netfs/write_issue.c

