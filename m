Return-Path: <linux-fsdevel+bounces-29334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2549782D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 16:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C828C56C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48BA39ACC;
	Fri, 13 Sep 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUqduUk4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51D381B9;
	Fri, 13 Sep 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238646; cv=none; b=J9Zm880H4y1BpWCGtOg1V4+pXPTdANHmU/zqzfhkPasm2NnPoCwZS0hzYOjgPsYV03lCWLbuD+Ek1N48MtHWUFYJ0aRJpyeOSyL5ak7Ksydtm5n0RnFVanoaukMAYpTlIgWyEdzxj68Y6DDWWnCRW8Mha2ZdM+j2D5W+o0kdfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238646; c=relaxed/simple;
	bh=bftPZ6DnGSfrBcXZPZR7Hx1mV/8icYhGXgepmZwn/kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQOTdJLV/CyqR/vjfYMo6OTXEwr1GzsdEIsrEBdZqY2L8P6jRQu3TPFHI/cYX5do5TDmSaDpVzpkoUu3a+wML6kaiaCzUVbPfyiA9vPsywApIxrxa5A4MqLdiWTU8+pRG2yjgqll3s09Laf7eO4HC11iLloSq6WaGsWwm1z4D7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUqduUk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C57C4CEC0;
	Fri, 13 Sep 2024 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726238646;
	bh=bftPZ6DnGSfrBcXZPZR7Hx1mV/8icYhGXgepmZwn/kI=;
	h=From:To:Cc:Subject:Date:From;
	b=cUqduUk4ahokYnxtG/FrYOXsWWb69zuKm7avUyxzqEgAJaK8X946V9quYvE+GGq4/
	 NeZ5z1xo6qY5l//jnJ+/fNdrmNurCdFXDYJdMaCrhGf1qp2k2EurHNNp9/GmW0vB5b
	 m0urATmy1h+jJu5CyzxWUnRvkNgwoqUL1dYPoVcXOI9b4MXPBo2q8sa8nC55vdoUfV
	 QlfbDu7hpetL7YWq4Hl1xn6nkvtbjIifPHTB76LsGXtswA9KhYsKzdtfL1teyUm/si
	 LSsnH5kutvueR2rsrVRRT8nmhzyoJnGRvvFUylkqJrCsjzYOctqxTM50K2v//EaVh9
	 3py7Gf8lzEs6g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs file
Date: Fri, 13 Sep 2024 16:43:10 +0200
Message-ID: <20240913-vfs-file-53bf57c94647@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8758; i=brauner@kernel.org; h=from:subject:message-id; bh=bftPZ6DnGSfrBcXZPZR7Hx1mV/8icYhGXgepmZwn/kI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ98V+TVSx7XvHL6g87Fyg3cLy/X3f7vMm2bO4Z7kfLb Ti/MBqodJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEZT3DT8Zbp+a+PcngcHDb HL6sngnfNNsj3u4KP76wJ+zRGfUFhU8Z/kf2dLB/XnmX9e/29C6fPbqs2tYB6/L4b0XxFPg9WZN 1mh8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This is the work to cleanup and shrink struct file significantly. You
should've already seen most of the work in here.

Right now, (focussing on x86) struct file is 232 bytes. After this
series struct file will be 184 bytes aka 3 cacheline and a spare 8 bytes
for future extensions at the end of the struct.

With struct file being as ubiquitous as it is this should make a
difference for file heavy workloads and allow further optimizations in
the future.

* struct fown_struct was embeeded into struct file letting it take up 32
  bytes in total when really it shouldn't even be embedded in struct
  file in the first place. Instead, actual users of struct fown_struct
  now allocate the struct on demand. This frees up 24 bytes.

* Move struct file_ra_state into the union containg the cleanup hooks
  and move f_iocb_flags out of the union. This closes a 4 byte hole we
  created earlier and brings struct file to 192 bytes. Which means
  struct file is 3 cachelines and we managed to shrink it by 40 bytes.

* Reorder struct file so that nothing crosses a cacheline. I suspect
  that in the future we will end up reordering some members to mitigate
  false sharing issues or just because someone does actually provide
  really good perf data.

* Shrinking struct file to 192 bytes is only part of the work. Files use
  a slab that is SLAB_TYPESAFE_BY_RCU and when a kmem cache is created
  with SLAB_TYPESAFE_BY_RCU the free pointer must be located outside of
  the object because the cache doesn't know what part of the memory can
  safely be overwritten as it may be needed to prevent object recycling.

  That has the consequence that SLAB_TYPESAFE_BY_RCU may end up adding a
  new cacheline.

  So this also contains work to add a new kmem_cache_create_rcu()
  function that allows the caller to specify an offset where the
  freelist pointer is supposed to be placed. Thus avoiding the implicit
  addition of a fourth cacheline.

* And finally this removes the f_version member in struct file. The
  f_version member isn't particularly well-defined. It is mainly used as
  a cookie to detect concurrent seeks when iterating directories. But it
  is also abused by some subsystems for completely unrelated things.

  It is mostly a directory and filesystem specific thing that doesn't
  really need to live in struct file and with its wonky semantics it
  really lacks a specific function.

  For pipes, f_version is (ab)used to defer poll notifications until a
  write has happened. And struct pipe_inode_info is used by multiple
  struct files in their ->private_data so there's no chance of pushing
  that down into file->private_data without introducing another pointer
  indirection.

  But pipes don't rely on f_pos_lock so this adds a union into struct
  file encompassing f_pos_lock and a pipe specific f_pipe member that
  pipes can use. This union of course can be extended to other file
  types and is similar to what we do in struct inode already.

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

(1) This will have merge conflict with the vfs.misc pull request sent as:
    https://lore.kernel.org/r/20240913-vfs-misc-348ac639e66e@brauner

    Assuming you merge vfs.misc first the conflict resolution looks like this:

diff --cc fs/fcntl.c
index 22ec683ad8f8,0587a0e221a6..f6fde75a3bd5
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@@ -343,12 -414,30 +414,36 @@@ static long f_dupfd_query(int fd, struc
        return f.file == filp;
  }

 +/* Let the caller figure out whether a given file was just created. */
 +static long f_created_query(const struct file *filp)
 +{
 +      return !!(filp->f_mode & FMODE_CREATED);
 +}
 +
+ static int f_owner_sig(struct file *filp, int signum, bool setsig)
+ {
+       int ret = 0;
+       struct fown_struct *f_owner;
+
+       might_sleep();
+
+       if (setsig) {
+               if (!valid_signal(signum))
+                       return -EINVAL;
+
+               ret = file_f_owner_allocate(filp);
+               if (ret)
+                       return ret;
+       }
+
+       f_owner = file_f_owner(filp);
+       if (setsig)
+               f_owner->signum = signum;
+       else if (f_owner)
+               ret = f_owner->signum;
+       return ret;
+ }
+
  static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
                struct file *filp)
  {

(2) linux-next: manual merge of the security tree with the vfs-brauner tree
    https://lore.kernel.org/r/20240910132740.775b92e1@canb.auug.org.au

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.file

for you to fetch changes up to 24a988f75c8a5f16ef935c51039700e985767eb9:

  Merge patch series "file: remove f_version" (2024-09-12 11:58:46 +0200)

Please consider pulling these changes from the signed vfs-6.12.file tag.

Note that this work provides the base for the slab pull request this
cycle. So just to not mess with Vlastimil's pr I pushed two tags:

(1) vfs-6.12.file
(2) vfs-6.12.file.kmem

The second tag only contains what slab relies on and (1) contains
everything for this cycle. If you disagree with additional stuff in (1)
you may still consider pulling (2).

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12.file

----------------------------------------------------------------
Christian Brauner (27):
      file: reclaim 24 bytes from f_owner
      fs: switch f_iocb_flags and f_ra
      fs: pack struct file
      mm: remove unused argument from create_cache()
      mm: add kmem_cache_create_rcu()
      fs: use kmem_cache_create_rcu()
      Merge patch series "fs,mm: add kmem_cache_create_rcu()"
      adi: remove unused f_version
      ceph: remove unused f_version
      s390: remove unused f_version
      fs: add vfs_setpos_cookie()
      fs: add must_set_pos()
      fs: use must_set_pos()
      fs: add generic_llseek_cookie()
      affs: store cookie in private data
      ext2: store cookie in private data
      ext4: store cookie in private data
      input: remove f_version abuse
      ocfs2: store cookie in private data
      proc: store cookie in private data
      udf: store cookie in private data
      ufs: store cookie in private data
      ubifs: store cookie in private data
      fs: add f_pipe
      pipe: use f_pipe
      fs: remove f_version
      Merge patch series "file: remove f_version"

R Sundar (1):
      mm: Removed @freeptr_offset to prevent doc warning

 drivers/char/adi.c             |   1 -
 drivers/input/input.c          |  47 ++++++-----
 drivers/net/tun.c              |   6 ++
 drivers/s390/char/hmcdrv_dev.c |   3 -
 drivers/tty/tty_io.c           |   6 ++
 fs/affs/dir.c                  |  44 +++++++++--
 fs/ceph/dir.c                  |   1 -
 fs/ext2/dir.c                  |  28 ++++++-
 fs/ext4/dir.c                  |  50 ++++++------
 fs/ext4/ext4.h                 |   2 +
 fs/ext4/inline.c               |   7 +-
 fs/fcntl.c                     | 166 +++++++++++++++++++++++++++++++--------
 fs/file_table.c                |  16 ++--
 fs/internal.h                  |   1 +
 fs/locks.c                     |   6 +-
 fs/notify/dnotify/dnotify.c    |   6 +-
 fs/ocfs2/dir.c                 |   3 +-
 fs/ocfs2/file.c                |  11 ++-
 fs/ocfs2/file.h                |   1 +
 fs/pipe.c                      |   8 +-
 fs/proc/base.c                 |  30 ++++++--
 fs/read_write.c                | 171 +++++++++++++++++++++++++++++++----------
 fs/ubifs/dir.c                 |  64 ++++++++++-----
 fs/udf/dir.c                   |  28 ++++++-
 fs/ufs/dir.c                   |  28 ++++++-
 include/linux/fs.h             | 106 +++++++++++++++----------
 include/linux/slab.h           |   9 +++
 mm/slab.h                      |   2 +
 mm/slab_common.c               | 138 +++++++++++++++++++++++----------
 mm/slub.c                      |  20 +++--
 net/core/sock.c                |   2 +-
 security/selinux/hooks.c       |   2 +-
 security/smack/smack_lsm.c     |   2 +-
 33 files changed, 744 insertions(+), 271 deletions(-)

