Return-Path: <linux-fsdevel+bounces-39585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C50A15D1F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 14:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B4FB7A2E51
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6105B18DF7C;
	Sat, 18 Jan 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwgI96CR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA32188CA9;
	Sat, 18 Jan 2025 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737205626; cv=none; b=J+4IaTYfGzHo9OZEeNucoSDFXLzLIvucw/EtbeOPbEBzWQV/S4iE+rnqJJbVgAbP0/Dseyutcwfzs1xUJhXUrxiNFRHHeEX9iklrTH+sxuQXeF0Q7Inu9rqvYiQ4fAU+dshA8u6CTm1nb2dW5OrnHqtlz/V87zrifKmLqajGetY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737205626; c=relaxed/simple;
	bh=Dcy/a7olfidFEfGFtHKWE7q2/l9XxSdglrnJalOLZQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhNwKwiCl4fL0rMI3bRSXjHaCRZGh295TCEhfq6BhbW7q5pEOrmALxjoYpW2qZ5plSIRF/yVoc5IK1jlePuXX8ZXAp6+SCzmsP0kHzri+ObTbSc6YNROttIyLu2pWh0BGaI9EC//31y3igcKGgW+/RYRkzQPXlA7z4eJmgu2GIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwgI96CR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DACC4CED1;
	Sat, 18 Jan 2025 13:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737205626;
	bh=Dcy/a7olfidFEfGFtHKWE7q2/l9XxSdglrnJalOLZQY=;
	h=From:To:Cc:Subject:Date:From;
	b=HwgI96CRBrBHUrml6nz+7FkDlY8hBx4FIapFoodsuJHNJnYnH1hlrbWmkjX3V3lCE
	 b13x14LhywUbIEkrd/VmYUSE1p8fU5MkfMCgpaVVIduVcUC2ni/BtuKOk3grhWRlza
	 fNAI5R3QCmw4VMJgD+Dt3blSu9Hl3z0ZFyWkK2EQLnkWMiyOU36kdx2rIdeZ0ZxSFj
	 12XS1UDc1Z2zF/5EVS1P90WAQDHoXhJfJXoP+s2NBH1cAmswGMsNRkG345x2XtP4K5
	 p/Ko5AXj9mWD37JEr/gzGkJzSqITYQ3pvJgwMZy1y9OySYAmJXDSvimepIVK9G+HvW
	 JMqfndCVkIu+w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs mount
Date: Sat, 18 Jan 2025 14:06:58 +0100
Message-ID: <20250118-vfs-mount-bc855e2c7463@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6573; i=brauner@kernel.org; h=from:subject:message-id; bh=Dcy/a7olfidFEfGFtHKWE7q2/l9XxSdglrnJalOLZQY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR3Ly/hUrke7mhtWPlzJ8MfR9GoFwzWUz69SD75lJN5Q 5Dgj2X/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiHcDwP//G6Sa+pAj9oM8b edMj3qjaLZ6yWrgy45J+zurPC8/symdk+LfwmCOnzF6jfd9/yPfu7i9UkyurDUxi8NMSeMcRKdX ODAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains mount update for this cycle:

- Add a mountinfo program to demonstrate statmount()/listmount()

  Add a new "mountinfo" sample userland program that demonstrates how to
  use statmount() and listmount() to get at the same info that
  /proc/pid/mountinfo provides.

- Remove pointless nospec.h include.

- Prepend statmount.mnt_opts string with security_sb_mnt_opts()

  Currently these mount options aren't accessible via statmount().

- Add new mount namespaces to mount namespace rbtree outside of the
  namespace semaphore.

- Lockless mount namespace lookup

  Currently we take the read lock when looking for a mount namespace to
  list mounts in. We can make this lockless. The simple search case can
  just use a sequence counter to detect concurrent changes to the
  rbtree.

  For walking the list of mount namespaces sequentially via nsfs we keep
  a separate rcu list as rb_prev() and rb_next() aren't usable safely
  with rcu. Currently there is no primitive for retrieving the previous
  list member. To do this we need a new deletion primitive that doesn't
  poison the prev pointer and a corresponding retrieval helper.

  Since creating mount namespaces is a relatively rare event compared
  with querying mounts in a foreign mount namespace this is worth it.
  Once libmount and systemd pick up this mechanism to list mounts in
  foreign mount namespaces this will be used very frequently.

  - Add extended selftests for lockless mount namespace iteration.

  - Add a sample program to list all mounts on the system, i.e., in all
    mount namespaces.

- Improve mount namespace iteration performance

  Make finding the last or first mount to start iterating the mount
  namespace from an O(1) operation and add selftests for iterating the
  mount table starting from the first and last mount.

- Use an xarray for the old mount id

  While the ida does use the xarray internally we can use it explicitly
  which allows us to increment the unique mount id under the xa lock.
  This allows us to remove the atomic as we're now allocating both ids
  in one go.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

This will have a merge conflict with vfs-6.14.mount pull request sent in
https://lore.kernel.org/r/20250118-vfs-pidfs-5921bfa5632a@brauner
and it can be resolved as follows:

diff --cc fs/namespace.c
index 64deda6f5b2c,371c860f49de..000000000000
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@@ -32,8 -32,6 +32,7 @@@
  #include <linux/fs_context.h>
  #include <linux/shmem_fs.h>
  #include <linux/mnt_idmapping.h>
 +#include <linux/pidfs.h>
- #include <linux/nospec.h>

  #include "pnode.h"
  #include "internal.h"

The following changes since commit 344bac8f0d73fe970cd9f5b2f132906317d29e8b:

  fs: kill MNT_ONRB (2025-01-09 16:58:50 +0100)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.mount

for you to fetch changes up to f79e6eb84d4d2bff99e3ca6c1f140b2af827e904:

  samples/vfs/mountinfo: Use __u64 instead of uint64_t (2025-01-10 12:08:27 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc1.mount tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc1.mount

----------------------------------------------------------------
Christian Brauner (17):
      mount: remove inlude/nospec.h include
      fs: add mount namespace to rbtree late
      Merge patch series "fs: listmount()/statmount() fix and sample program"
      fs: lockless mntns rbtree lookup
      rculist: add list_bidir_{del,prev}_rcu()
      fs: lockless mntns lookup for nsfs
      fs: simplify rwlock to spinlock
      seltests: move nsfs into filesystems subfolder
      selftests: add tests for mntns iteration
      selftests: remove unneeded include
      samples: add test-list-all-mounts
      Merge patch series "fs: lockless mntns lookup"
      fs: cache first and last mount
      selftests: add listmount() iteration tests
      Merge patch series "fs: tweak mntns iteration"
      fs: use xarray for old mount id
      fs: remove useless lockdep assertion

Geert Uytterhoeven (1):
      samples/vfs/mountinfo: Use __u64 instead of uint64_t

Jeff Layton (2):
      samples: add a mountinfo program to demonstrate statmount()/listmount()
      fs: prepend statmount.mnt_opts string with security_sb_mnt_opts()

 fs/mount.h                                         |  31 ++-
 fs/namespace.c                                     | 200 +++++++++------
 fs/nsfs.c                                          |   5 +-
 include/linux/rculist.h                            |  44 ++++
 samples/vfs/.gitignore                             |   2 +
 samples/vfs/Makefile                               |   2 +-
 samples/vfs/mountinfo.c                            | 273 +++++++++++++++++++++
 samples/vfs/test-list-all-mounts.c                 | 235 ++++++++++++++++++
 .../selftests/{ => filesystems}/nsfs/.gitignore    |   1 +
 .../selftests/{ => filesystems}/nsfs/Makefile      |   4 +-
 .../selftests/{ => filesystems}/nsfs/config        |   0
 .../selftests/filesystems/nsfs/iterate_mntns.c     | 149 +++++++++++
 .../selftests/{ => filesystems}/nsfs/owner.c       |   0
 .../selftests/{ => filesystems}/nsfs/pidns.c       |   0
 .../selftests/filesystems/statmount/Makefile       |   2 +-
 .../filesystems/statmount/listmount_test.c         |  66 +++++
 tools/testing/selftests/pidfd/pidfd.h              |   1 -
 17 files changed, 918 insertions(+), 97 deletions(-)
 create mode 100644 samples/vfs/mountinfo.c
 create mode 100644 samples/vfs/test-list-all-mounts.c
 rename tools/testing/selftests/{ => filesystems}/nsfs/.gitignore (78%)
 rename tools/testing/selftests/{ => filesystems}/nsfs/Makefile (50%)
 rename tools/testing/selftests/{ => filesystems}/nsfs/config (100%)
 create mode 100644 tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
 rename tools/testing/selftests/{ => filesystems}/nsfs/owner.c (100%)
 rename tools/testing/selftests/{ => filesystems}/nsfs/pidns.c (100%)
 create mode 100644 tools/testing/selftests/filesystems/statmount/listmount_test.c

