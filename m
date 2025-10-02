Return-Path: <linux-fsdevel+bounces-63206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08182BB2910
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 07:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A2F3212C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 05:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1B3265CBB;
	Thu,  2 Oct 2025 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Esq1MFZX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33441482F2
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384486; cv=none; b=At39W7hOrDlt23k0/ojXto4P3HllhsNISYrSFrAm92Ob/3ZNjsANUj5Yt7rR+oyaRL2U7AumO1qGBtiGZTn1g3sthILMxRUCb0wr1OdRWO7V7665Q9jKhg911sv+N08BAdnwZdUyq71ukR5mQap1sDJjvSc1fSBCzvTTpX4jLeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384486; c=relaxed/simple;
	bh=UBIpO3qkQwq93ovpMOdH4Re4+PTXLkvmn98Su6VDzdI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YBH720ktSN1Dp0D4u4DxLCzE6K5kjRgivMXy1LGCm67mjFPjWWsLHzeHEDx+HnuAuE3jyyHn74DF232D0y/ytOEqLZP4QYAlq/o6YzhldHVKCawC/Hf5+toLbAU7LMB8QOGnl/6eZddAM4gaV8ZaSjVSAwPPOUUWzV/fClVbLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Esq1MFZX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ilkW8EGnqGOQKd61ebDqwXxoZawMMABfF0H049jsWhw=; b=Esq1MFZX4BRYbFAmKkHl5KePZK
	4iY6j/uASrSrBoGDB5xKaQPscND9F24WsBdENoz9IbSU/3oJjzekGmWcZoZKACJek1sr5TsUWydxB
	gFqiwVTZ9qRwBeZsZbTefOiqdilM71OzB7a76hDDlc2n0aN2XmyLF5eLL+TYDRUQ2fEwT4ujxBTgC
	oqdBGlANOdAv6Rt5RiA0+jLVUmaPS54E03Bo3/XYe3CItASY3/NbR7QO4GKpuwKay1ZnHyPVGxWsQ
	GskhXjq2mZt4lgs0n579oC8BBktAOuxynuI1PRvrKy6N28hHcC3YMX4REoymyNEq/h05KVV2q8ubz
	NnYXPgwA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4CGz-0000000CGym-2mbP;
	Thu, 02 Oct 2025 05:54:37 +0000
Date: Thu, 2 Oct 2025 06:54:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull] pile 1: mount stuff
Message-ID: <20251002055437.GG39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	My apologies for being that late with pull requests - went down
with flu last week, took that long to get back to normal ;-/

	Several piles this cycle, this one being the largest and trickiest.
There are several trivial conflicts in fs/namespace.c; I've pushed a conflict
resolution variant into #proposed.merge.

The following changes since commit 38f4885088fc5ad41b8b0a2a2cfc73d01e709e5c:

  mnt_ns_tree_remove(): DTRT if mnt_ns had never been added to mnt_ns_list (2025-09-16 00:33:37 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-mount

for you to fetch changes up to a79765248649de77771c24f7be08ff4c96f16f7a:

  constify {__,}mnt_is_readonly() (2025-09-17 15:58:29 -0400)

----------------------------------------------------------------
mount-related stuff for this cycle
        * saner handling of guards in fs/namespace.c, getting
rid of needlessly strong locking in some of the users.

	* lock_mount() calling conventions change - have it set
the environment for attaching to given location, storing the
results in caller-supplied object, without altering the passed
struct path.  Make unlock_mount() called as __cleanup for those
objects.  It's not exactly guard(), but similar to it.

	* MNT_WRITE_HOLD done right - mnt_hold_writers() does *not*
mess with ->mnt_flags anymore, so insertion of a new mount into
->s_mounts of underlying superblock does not, in itself, expose
->mnt_flags of that mount to concurrent modifications.

	* getting rid of pathological cases when umount() spends
quadratic time removing the victims from propagation graph -
part of that had been dealt with last cycle, this should finish
it.

	* a bunch of stuff constified.

	* assorted cleanups.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (65):
      fs/namespace.c: fix the namespace_sem guard mess
      introduced guards for mount_lock
      fs/namespace.c: allow to drop vfsmount references via __free(mntput)
      __detach_mounts(): use guards
      __is_local_mountpoint(): use guards
      do_change_type(): use guards
      do_set_group(): use guards
      mark_mounts_for_expiry(): use guards
      put_mnt_ns(): use guards
      mnt_already_visible(): use guards
      check_for_nsfs_mounts(): no need to take locks
      propagate_mnt(): use scoped_guard(mount_locked_reader) for mnt_set_mountpoint()
      has_locked_children(): use guards
      mnt_set_expiry(): use guards
      path_is_under(): use guards
      current_chrooted(): don't bother with follow_down_one()
      current_chrooted(): use guards
      switch do_new_mount_fc() to fc_mount()
      do_move_mount(): trim local variables
      do_move_mount(): deal with the checks on old_path early
      move_mount(2): take sanity checks in 'beneath' case into do_lock_mount()
      finish_automount(): simplify the ELOOP check
      do_loopback(): use __free(path_put) to deal with old_path
      pivot_root(2): use __free() to deal with struct path in it
      finish_automount(): take the lock_mount() analogue into a helper
      do_new_mount_fc(): use __free() to deal with dropping mnt on failure
      finish_automount(): use __free() to deal with dropping mnt on failure
      change calling conventions for lock_mount() et.al.
      do_move_mount(): use the parent mount returned by do_lock_mount()
      do_add_mount(): switch to passing pinned_mountpoint instead of mountpoint + path
      graft_tree(), attach_recursive_mnt() - pass pinned_mountpoint
      pivot_root(2): use old_mp.mp->m_dentry instead of old.dentry
      don't bother passing new_path->dentry to can_move_mount_beneath()
      new helper: topmost_overmount()
      do_lock_mount(): don't modify path.
      constify check_mnt()
      do_mount_setattr(): constify path argument
      do_set_group(): constify path arguments
      drop_collected_paths(): constify arguments
      collect_paths(): constify the return value
      do_move_mount(), vfs_move_mount(), do_move_mount_old(): constify struct path argument(s)
      mnt_warn_timestamp_expiry(): constify struct path argument
      do_new_mount{,_fc}(): constify struct path argument
      do_{loopback,change_type,remount,reconfigure_mnt}(): constify struct path argument
      path_mount(): constify struct path argument
      may_copy_tree(), __do_loopback(): constify struct path argument
      path_umount(): constify struct path argument
      constify can_move_mount_beneath() arguments
      do_move_mount_old(): use __free(path_put)
      do_mount(): use __free(path_put)
      umount_tree(): take all victims out of propagation graph at once
      ecryptfs: get rid of pointless mount references in ecryptfs dentries
      fs/namespace.c: sanitize descriptions for {__,}lookup_mnt()
      path_has_submounts(): use guard(mount_locked_reader)
      open_detached_copy(): don't bother with mount_lock_hash()
      open_detached_copy(): separate creation of namespace into helper
      Merge branch 'no-rebase-mnt_ns_tree_remove' into work.mount
      copy_mnt_ns(): use the regular mechanism for freeing empty mnt_ns on failure
      copy_mnt_ns(): use guards
      simplify the callers of mnt_unhold_writers()
      setup_mnt(): primitive for connecting a mount to filesystem
      preparations to taking MNT_WRITE_HOLD out of ->mnt_flags
      struct mount: relocate MNT_WRITE_HOLD bit
      WRITE_HOLD machinery: no need for to bump mount_lock seqcount
      constify {__,}mnt_is_readonly()

 fs/dcache.c                   |   4 +-
 fs/ecryptfs/dentry.c          |  14 +-
 fs/ecryptfs/ecryptfs_kernel.h |  27 +-
 fs/ecryptfs/file.c            |  15 +-
 fs/ecryptfs/inode.c           |  19 +-
 fs/ecryptfs/main.c            |  24 +-
 fs/internal.h                 |   4 +-
 fs/mount.h                    |  39 +-
 fs/namespace.c                | 992 +++++++++++++++++++-----------------------
 fs/pnode.c                    |  75 +++-
 fs/pnode.h                    |   1 +
 fs/super.c                    |   3 +-
 include/linux/fs.h            |   4 +-
 include/linux/mount.h         |   9 +-
 kernel/audit_tree.c           |  12 +-
 15 files changed, 600 insertions(+), 642 deletions(-)

