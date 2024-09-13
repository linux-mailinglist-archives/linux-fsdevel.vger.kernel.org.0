Return-Path: <linux-fsdevel+bounces-29331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C769782CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761071F2133A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEE62575F;
	Fri, 13 Sep 2024 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkEtS2Bv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BFD1F5FA;
	Fri, 13 Sep 2024 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238508; cv=none; b=eSVkwnyGQ6jBpvVm4ToyypySWZxs8Hrht3fgHxY6UShG+HOjOWduOwojF9xKTjER/Yb5TrnztIefqHrjFkwJMPEEvOIzOkSLh7dwif4WU98tq0nRNsF7mtb6XR0ErwdkudGPjZb0wBnQSJ2bgRBlgm/ISjg+gQRmiD+pja4AFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238508; c=relaxed/simple;
	bh=nbN+7aZ5bS8uZsZqBIpuI15Bncn2Flfcu5Qah/M0+F8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fbeJNFMu34wgTYSLBHtjNqHe5T2VfA39plwLpXqmCz85zGgl25OLQrWhjUzsBUBbUc44dAO9/gUuzm1wZ/67pOl92cjmG6UMhO6gBE2TMgftKP4Pya+3Ub/Dn80VF/MHuHpjz5g7ogFQvFbGCGJP7epypoi75uHtCZ0kX49SneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkEtS2Bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE7FC4CEC0;
	Fri, 13 Sep 2024 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726238507;
	bh=nbN+7aZ5bS8uZsZqBIpuI15Bncn2Flfcu5Qah/M0+F8=;
	h=From:To:Cc:Subject:Date:From;
	b=UkEtS2BvZivw3QugomD5qZUEs2vWYkomdfksTNEfKRKfpIHaKdG34nH3Z0Q8cNK3I
	 WW0eCsUVoBhBPPmA6CE7QPt9/sJptSva2GApsSgkIvrNcxnguX1Yni19BXjbbatQJs
	 SG2+JyAkxtYrSLGFDM/ByUKbnv1mP3UcapwdLTizRXfMaGfR+NAkXGxUN9q9w1CkoM
	 V0zk6EL7pDtIx2KjwuNMZ9piH8hR8sYZa1v4B8LUkU+9U+bt75xalwMe3xvq436G6/
	 V6WaLp1VFVBXJQq8FtQXxvaex4cj91fAsffPq9bjzm0nJA+zgnbhY5h5k/+4exi2eJ
	 pshZvXChmUsRQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs misc
Date: Fri, 13 Sep 2024 16:41:28 +0200
Message-ID: <20240913-vfs-misc-348ac639e66e@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17549; i=brauner@kernel.org; h=from:subject:message-id; bh=nbN+7aZ5bS8uZsZqBIpuI15Bncn2Flfcu5Qah/M0+F8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ98ZdeYnN96//F+cduJQfqTakLun48toTZ+V6lQf6/h RbL34X1dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkQz4jw+qy0v//lJ51bpJl CD+zabvFHkeH7EsX+t+/jHbsCKi/nM/wh+PkXkaRujSrVRVVDDPDupozmc4yuJ05cEh7fvuPo/L HmAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the usual pile of misc updates:

Features:

    - Add F_CREATED_QUERY fcntl() that allows userspace to query whether a
      file was actually created. Often userspace wants to know whether an
      O_CREATE request did actually create a file without using O_EXCL. The
      current logic is that to first attempts to open the file without
      O_CREAT | O_EXCL and if ENOENT is returned userspace tries again with
      both flags. If that succeeds all is well. If it now reports EEXIST it
      retries.

      That works fairly well but some corner cases make this more involved.
      If this operates on a dangling symlink the first openat() without
      O_CREAT | O_EXCL will return ENOENT but the second openat() with
      O_CREAT | O_EXCL will fail with EEXIST. The reason is that openat()
      without O_CREAT | O_EXCL follows the symlink while O_CREAT | O_EXCL
      doesn't for security reasons. So it's not something we can really
      change unless we add an explicit opt-in via O_FOLLOW which seems
      really ugly.

      All available workarounds are really nasty (fanotify, bpf lsm etc) so
      add a simple fcntl().

    - Try an opportunistic lookup for O_CREAT. Today, when opening a file
      we'll typically do a fast lookup, but if O_CREAT is set, the kernel
      always takes the exclusive inode lock. This was likely done with the
      expectation that O_CREAT means that we always expect to do the create,
      but that's often not the case. Many programs set O_CREAT even in
      scenarios where the file already exists (see related F_CREATED_QUERY
      patch motivation above).

      The series contained in the pr rearranges the pathwalk-for-open code
      to also attempt a fast_lookup in certain O_CREAT cases. If a positive
      dentry is found, the inode_lock can be avoided altogether and it can
      stay in rcuwalk mode for the last step_into.

    - Expose the 64 bit mount id via name_to_handle_at().
      Now that we provide a unique 64-bit mount ID interface in statx(2), we
      can now provide a race-free way for name_to_handle_at(2) to provide a
      file handle and corresponding mount without needing to worry about
      racing with /proc/mountinfo parsing or having to open a file just to
      do statx(2).

      While this is not necessary if you are using AT_EMPTY_PATH and don't
      care about an extra statx(2) call, users that pass full paths into
      name_to_handle_at(2) need to know which mount the file handle comes
      from (to make sure they don't try to open_by_handle_at a file handle
      from a different filesystem) and switching to AT_EMPTY_PATH would
      require allocating a file for every name_to_handle_at(2) call

    - Add a per dentry expire timeout to autofs.
      There are two fairly well known automounter map formats, the autofs
      format and the amd format (more or less System V and Berkley).

      Some time ago Linux autofs added an amd map format parser that
      implemented a fair amount of the amd functionality. This was done
      within the autofs infrastructure and some functionality wasn't
      implemented because it either didn't make sense or required extra
      kernel changes. The idea was to restrict changes to be within the
      existing autofs functionality as much as possible and leave changes
      with a wider scope to be considered later.

      One of these changes is implementing the amd options:
      1) "unmount", expire this mount according to a timeout (same as the
         current autofs default).
      2) "nounmount", don't expire this mount (same as setting the autofs
         timeout to 0 except only for this specific mount) .
      3) "utimeout=<seconds>", expire this mount using the specified
         timeout (again same as setting the autofs timeout but only for
         this mount).

      To implement these options per-dentry expire timeouts need to be
      implemented for autofs indirect mounts. This is because all map keys
      (mounts) for autofs indirect mounts use an expire timeout stored in
      the autofs mount super block info. structure and all indirect mounts
      use the same expire timeout.

Fixes:

    - Fix missing fput for FSCONFIG_SET_FD in autofs.

    - Use param->file for FSCONFIG_SET_FD in coda.

    - Delete the 'fs/netfs' proc subtreee when netfs module exits.

    - Make sure that struct uid_gid_map fits into a single cacheline.

    - Don't flush in-flight wb switches for superblocks without cgroup writeback.

    - Correcting the idmapping mount example in the idmapping documentation.

    - Fix a race between evice_inodes() and find_inode() and iput().

    - Refine the show_inode_state() macro definition in writeback code.

    - Prevent dump_mapping() from accessing invalid dentry.d_name.name.

    - Show actual source for debugfs in /proc/mounts.

    - Annotate data-race of busy_poll_usecs in eventpoll.

    - Don't WARN for racy path_noexec check in exec code.

    - Handle OOM on mnt_warn_timestamp_expiry().

    - Fix some spelling in the iomap design documentation.

    - Fix typo in procfs comment.

    - Fix typo in fs/namespace.c comment

Cleanups:

    - Add the VFS git tree to the MAINTAINERS file.

    - Move FMODE_UNSIGNED_OFFSET to fop_flags freeing up another f_mode bit
      in struct file bringing us to 5 free f_mode bits.

    - Remove the __I_DIO_WAKEUP bit from i_state flags as we can simplify
      the wait mechanism.

    - Remove the unused path_put_init() helper.

    - Replace a __u32 with u32 for s_fsnotify_mask as __u32 is uapi specific.

    - Replace the unsigned long i_state member with a u32 i_state member in
      struct inode freeing up 4 bytes in struct inode. Instead of using
      the bit based wait apis we're now using the var event apis and using
      the individual bytes of the i_state member to wait on state changes.

    - Explain how per-syscall AT_* flags should be allocated.

    - Use in_group_or_capable() helper to simplify the posix acl mode update
      code.

    - Switch to LIST_HEAD() in fsync_buffers_list() to simplify the code.

    - Removed comment about d_rcu_to_refcount() as that function doesn't
      exist anymore.

    - Add kernel documentation for lookup_fast().

    - Don't re-zero evenpoll fields.

    - Remove outdated comment after close_fd().

    - Fix imprecise wording in comment about the pipe filesystem.

    - Drop GFP_NOFAIL mode from alloc_page_buffers.

    - Missing blank line warnings and struct declaration improved in file_table.

    - Annotate struct poll_list with __counted_by()

    - Remove the unused read parameter in percpu-rwsem.

    - Remove linux/prefetch.h include from direct-io code.

    - Use kmemdup_array instead of kmemdup for multiple allocation in
      mnt_idmapping code.

    - Remove unused mnt_cursor_del() declaration.

Performance tweaks:

    - Dodge smp_mb in break_lease and break_deleg in the common case.

    - Only read fops once in fops_{get,put}().

    - Use RCU in ilookup().

    - Elide smp_mb in iversion handling in the common case.

    - Drop one lock trip in evict().

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-3)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.11-rc4 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

(1) This will have merge conflict with the vfs.file pull request sent as:
    https://lore.kernel.org/r/20240913-vfs-file-53bf57c94647@brauner

    I've provided the conflict resolution there.

(2) This will also very likely cause a merge conflict with the series
    to convert everything to fd_file() accessors. Because we change:

-static int coda_parse_fd(struct fs_context *fc, int fd)
+static int coda_set_idx(struct fs_context *fc, struct file *file)
 {
        struct coda_fs_context *ctx = fc->fs_private;
-       struct fd f;
        struct inode *inode;
        int idx;

-       f = fdget(fd);
-       if (!f.file)
-               return -EBADF;
-       inode = file_inode(f.file);
+       inode = file_inode(file);
        if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR) {
-               fdput(f);
-               return invalf(fc, "code: Not coda psdev");
+               return invalf(fc, "coda: Not coda psdev");
        }
-
        idx = iminor(inode);
-       fdput(f);
-
        if (idx < 0 || idx >= MAX_CODADEVS)
                return invalf(fc, "coda: Bad minor number");
        ctx->idx = idx;
        return 0;
 }

which removes the raw f.file access so the fd_file() replacement becomes mute.

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.misc

for you to fetch changes up to 2077006d4725c82c6e9612cec3a6c140921b067f:

  uidgid: make sure we fit into one cacheline (2024-09-12 12:16:09 +0200)

Please consider pulling these changes from the signed vfs-6.12.misc tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12.misc

----------------------------------------------------------------
Aleksa Sarai (4):
      autofs: fix missing fput for FSCONFIG_SET_FD
      coda: use param->file for FSCONFIG_SET_FD
      uapi: explain how per-syscall AT_* flags should be allocated
      fhandle: expose u64 mount id to name_to_handle_at(2)

Baokun Li (1):
      netfs: Delete subtree of 'fs/netfs' when netfs module exits

Christian Brauner (20):
      fcntl: add F_CREATED_QUERY
      selftests: add F_CREATED_QUERY tests
      Merge patch series "Add an fcntl() to check file creation"
      fs: move audit parent inode
      fs: pull up trailing slashes check for O_CREAT
      fs: remove audit dummy context check
      fs: rearrange general fastpath check now that O_CREAT uses it
      fs: move FMODE_UNSIGNED_OFFSET to fop_flags
      inode: remove __I_DIO_WAKEUP
      fs: remove unused path_put_init()
      fs: s/__u32/u32/ for s_fsnotify_mask
      fs: add i_state helpers
      fs: reorder i_state bits
      inode: port __I_SYNC to var event
      inode: port __I_NEW to var event
      inode: port __I_LRU_ISOLATING to var event
      inode: make i_state a u32
      Merge patch series "fs: add i_state helpers"
      Merge patch series "fhandle: expose u64 mount id to name_to_handle_at(2)"
      uidgid: make sure we fit into one cacheline

Eric Biggers (1):
      MAINTAINERS: add the VFS git tree

Haifeng Xu (1):
      fs: don't flush in-flight wb switches for superblocks without cgroup writeback

Hongbo Li (3):
      fs: Use in_group_or_capable() helper to simplify the code
      doc: correcting the idmapping mount example
      fs: use LIST_HEAD() to simplify code

Ian Kent (1):
      autofs: add per dentry expire timeout

Jeff Layton (3):
      fs: remove comment about d_rcu_to_refcount
      fs: add a kerneldoc header over lookup_fast
      fs: try an opportunistic lookup for O_CREAT opens too

Joe Damato (1):
      eventpoll: Don't re-zero eventpoll fields

Joel Savitz (1):
      file: remove outdated comment after close_fd()

Julian Sun (2):
      vfs: fix race between evice_inodes() and find_inode()&iput()
      writeback: Refine the show_inode_state() macro definition

Kienan Stewart (1):
      fs/pipe: Correct imprecise wording in comment

Li Zhijian (1):
      fs/inode: Prevent dump_mapping() accessing invalid dentry.d_name.name

Marc Aurèle La France (1):
      debugfs show actual source in /proc/mounts

Martin Karsten (1):
      eventpoll: Annotate data-race of busy_poll_usecs

Mateusz Guzik (6):
      exec: don't WARN for racy path_noexec check
      vfs: dodge smp_mb in break_lease and break_deleg in the common case
      vfs: only read fops once in fops_get/put
      vfs: use RCU in ilookup
      vfs: elide smp_mb in iversion handling in the common case
      vfs: drop one lock trip in evict()

Michal Hocko (1):
      fs: drop GFP_NOFAIL mode from alloc_page_buffers

Mohit0404 (1):
      Fixed: fs: file_table_c: Missing blank line warnings and struct declaration improved

Olaf Hering (1):
      mount: handle OOM on mnt_warn_timestamp_expiry

Thorsten Blum (1):
      fs/select: Annotate struct poll_list with __counted_by()

Uros Bizjak (1):
      fs/aio: Fix __percpu annotation of *cpu pointer in struct kioctx

Wang Long (1):
      percpu-rwsem: remove the unused parameter 'read'

Xiaxi Shen (1):
      Fix spelling and gramatical errors

Yan Zhen (1):
      proc: Fix typo in the comment

Youling Tang (1):
      fs/direct-io: Remove linux/prefetch.h include

Yu Jiaoliang (1):
      mnt_idmapping: Use kmemdup_array instead of kmemdup for multiple allocation

Yue Haibing (1):
      fs: mounts: Remove unused declaration mnt_cursor_del()

Yuesong Li (1):
      fs/namespace.c: Fix typo in comment

 Documentation/filesystems/idmappings.rst        |   8 +-
 Documentation/filesystems/iomap/design.rst      |   6 +-
 MAINTAINERS                                     |   1 +
 drivers/char/adi.c                              |   8 +-
 drivers/char/mem.c                              |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |   1 +
 drivers/gpu/drm/drm_file.c                      |   3 +-
 drivers/gpu/drm/gma500/psb_drv.c                |   1 +
 drivers/gpu/drm/i915/i915_driver.c              |   1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c           |   1 +
 drivers/gpu/drm/radeon/radeon_drv.c             |   1 +
 drivers/gpu/drm/tegra/drm.c                     |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c             |   1 +
 drivers/gpu/drm/xe/xe_device.c                  |   1 +
 drivers/md/md-bitmap.c                          |   2 +-
 fs/aio.c                                        |   2 +-
 fs/autofs/autofs_i.h                            |   4 +
 fs/autofs/dev-ioctl.c                           |  97 +++++++++++++++++++-
 fs/autofs/expire.c                              |   7 +-
 fs/autofs/inode.c                               |   5 +-
 fs/bcachefs/fs.c                                |  10 +-
 fs/buffer.c                                     |   8 +-
 fs/coda/inode.c                                 |  43 ++++++---
 fs/dcache.c                                     |  10 +-
 fs/debugfs/inode.c                              |   8 ++
 fs/direct-io.c                                  |   6 --
 fs/eventpoll.c                                  |   7 +-
 fs/exec.c                                       |  31 +++----
 fs/fcntl.c                                      |  10 ++
 fs/fhandle.c                                    |  29 ++++--
 fs/file.c                                       |   2 +-
 fs/file_table.c                                 |   5 +-
 fs/fs-writeback.c                               |  67 ++++++++------
 fs/inode.c                                      | 116 ++++++++++++++++--------
 fs/libfs.c                                      |  28 ++++--
 fs/mnt_idmapping.c                              |  12 +--
 fs/mount.h                                      |   1 -
 fs/namei.c                                      |  75 ++++++++++++---
 fs/namespace.c                                  |  18 +++-
 fs/netfs/locking.c                              |  22 +----
 fs/netfs/main.c                                 |   4 +-
 fs/pipe.c                                       |   2 +-
 fs/posix_acl.c                                  |   4 +-
 fs/proc/base.c                                  |  10 +-
 fs/proc/fd.c                                    |   2 +-
 fs/proc/kcore.c                                 |   2 +-
 fs/read_write.c                                 |   2 +-
 fs/select.c                                     |   2 +-
 fs/super.c                                      |   4 +-
 include/drm/drm_accel.h                         |   3 +-
 include/drm/drm_gem.h                           |   3 +-
 include/drm/drm_gem_dma_helper.h                |   1 +
 include/linux/buffer_head.h                     |   3 +-
 include/linux/filelock.h                        |  14 ++-
 include/linux/fs.h                              |  88 +++++++++++-------
 include/linux/path.h                            |   6 --
 include/linux/percpu-rwsem.h                    |   2 +-
 include/linux/syscalls.h                        |   2 +-
 include/linux/user_namespace.h                  |   6 +-
 include/linux/writeback.h                       |   7 +-
 include/trace/events/writeback.h                |  10 +-
 include/uapi/linux/auto_fs.h                    |   2 +-
 include/uapi/linux/fcntl.h                      |  84 ++++++++++++-----
 kernel/user.c                                   |   6 +-
 mm/mmap.c                                       |   2 +-
 tools/testing/selftests/core/close_range_test.c |  39 ++++++++
 66 files changed, 662 insertions(+), 310 deletions(-)

