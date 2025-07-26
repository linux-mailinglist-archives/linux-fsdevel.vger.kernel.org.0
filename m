Return-Path: <linux-fsdevel+bounces-56071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78DDB129BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 10:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7106E17F76A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 08:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5D20E033;
	Sat, 26 Jul 2025 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z60fnB2f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA99194C96
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753517385; cv=none; b=K292NfHmOtW7RFPpfCJsYabuuqx38l+haY3YWGCusVhB9JddXYGWrO7002csxQGlcE9ZJ0kDlpzJNRmoJ9ByTtqc3/9dKGKS2exFOQenn/u3M6hmX36JI4U2IG2+zwWZlTCnDUc1eJ+/H97+4ILvIHGf9Ov4Jd0qWPiCBf1QEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753517385; c=relaxed/simple;
	bh=cq6ChMMN+p7nGnt3/ioIIhzOBSwDBzETaLJ2238mEgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5bV6fI/wFC4B1neK3D2jLdfWEakvRItvdR8L4IgMZDqOB0YtbfY4KL7Bh5alFbtOJ8s3zPKk/uvIC8odQFwfRAdiIKiy/NEKE0yVXFAxvHFFsGiYsrR27jf/PGllcpdhZ/Q4TNVXAkjjGSM6nkshOmpVFmr4ncrQ6WIUHD1w/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Z60fnB2f; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EdAQgbLfdffdUwz1rv5QEcPhXpZ1jDyNYBdAt+Zu+ek=; b=Z60fnB2f92Lkj+SxhDL2T0+/nn
	bdtwX2TtnqjuyZKPIfok7fKK/6mjaaGJXsPM5Vz/jQbNJFenEBbbiOcLoHx8xQVMNp+DdkDmJ1x24
	SyLO64CEbd9gf+ykvlEZAgnZ7kkVfxknVDob82fuvS4tmcoTiPe5hDbITpDmye3wFadN18r5zyQBH
	2WodsSU67mil9/Ymc5hbn589Mo5+T0GkdJTPD+aZQOzztGxS9Bs1bM0hlyURVXvnGESMZetxI/ZkG
	MBCmYGgL8de3P+rTHBA/6OPodQKW1obzhOwAkgVP6AMMsgOdjBVGbZ9yv12OpzyruPM0C/PYHPc+R
	82R14R5Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufZyQ-00000006ASm-23Ug;
	Sat, 26 Jul 2025 08:09:42 +0000
Date: Sat, 26 Jul 2025 09:09:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull][6.17] vfs.git 9/9: mount pile
Message-ID: <20250726080942.GH1456602@ZenIV>
References: <20250726080119.GA222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726080119.GA222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-mount

for you to fetch changes up to a7cce099450f8fc597a6ac215440666610895fb7:

  statmount_mnt_basic(): simplify the logics for group id (2025-06-29 19:03:46 -0400)

----------------------------------------------------------------
mount changes.  I've got more stuff in the local tree, but
this is getting too much for one merge window as it is.

* mount hash conflicts rudiments are gone now - we do not allow
	multiple mounts with the same parent/mountpoint to be
	hashed at the same time.
* struct mount changes
	mnt_umounting is gone;
	mnt_slave_list/mnt_slave is an hlist now;
	overmounts are kept track of by explicit pointer in mount;
	a bunch of flags moved out of mnt_flags to a new field,
	with only namespace_sem for protection;
	mnt_expiry is protected by mount_lock now (instead of
	namespace_sem);
	MNT_LOCKED is used only for mounts that need to remain
	attached to their parents to prevent mountpoint exposure -
	no more overloading it for absolute roots;
	all mnt_list uses are transient now - it's used only to
	represent temporary sets during umount_tree().
* mount refcounting change
	children no longer pin parents for any mounts, whether they'd
	passed through umount_tree() or not.
* struct mountpoint changes
	refcount is no more; what matters is ->m_list emptiness;
	instead of temporary bumping the refcount, we insert a new object
	(pinned_mountpoint) into ->m_list;
	new calling conventions for lock_mount() and friends.
* do_move_mount()/attach_recursive_mnt() seriously cleaned up.
* globals in fs/pnode.c are gone.
* propagate_mnt(), change_mnt_propagation() and propagate_umount() cleaned up
	(in the last case - pretty much completely rewritten).
* freeing of emptied mnt_namespace is done in namespace_unlock()
	for one thing, there are subtle ordering requirements there;
	for another it simplifies cleanups.
* assorted cleanups.
* restore the machinery for long-term mounts from accumulated bitrot.
	This is going to get a followup come next cycle, when #work.fs_context
	with its change of vfs_fs_parse_string() calling conventions goes
	into -next.

----------------------------------------------------------------
Al Viro (48):
      attach_mnt(): expand in attach_recursive_mnt(), then lose the flag argument
      get rid of mnt_set_mountpoint_beneath()
      prevent mount hash conflicts
      copy_tree(): don't set ->mnt_mountpoint on the root of copy
      constify mnt_has_parent()
      pnode: lift peers() into pnode.h
      new predicate: mount_is_ancestor()
      constify is_local_mountpoint()
      new predicate: anon_ns_root(mount)
      dissolve_on_fput(): use anon_ns_root()
      __attach_mnt(): lose the second argument
      don't set MNT_LOCKED on parentless mounts
      clone_mnt(): simplify the propagation-related logics
      do_umount(): simplify the "is it still mounted" checks
      sanitize handling of long-term internal mounts
      Rewrite of propagate_umount()
      make commit_tree() usable in same-namespace move case
      attach_recursive_mnt(): unify the mnt_change_mountpoint() logics
      attach_recursive_mnt(): pass destination mount in all cases
      attach_recursive_mnt(): get rid of flags entirely
      do_move_mount(): take dropping the old mountpoint into attach_recursive_mnt()
      do_move_mount(): get rid of 'attached' flag
      attach_recursive_mnt(): remove from expiry list on move
      take ->mnt_expire handling under mount_lock [read_seqlock_excl]
      pivot_root(): reorder tree surgeries, collapse unhash_mnt() and put_mountpoint()
      combine __put_mountpoint() with unhash_mnt()
      get rid of mountpoint->m_count
      don't have mounts pin their parents
      mount: separate the flags accessed only under namespace_sem
      propagate_one(): get rid of dest_master
      propagate_mnt(): handle all peer groups in the same loop
      propagate_one(): separate the "do we need secondary here?" logics
      propagate_one(): separate the "what should be the master for this copy" part
      propagate_one(): fold into the sole caller
      fs/pnode.c: get rid of globals
      propagate_mnt(): get rid of last_dest
      propagate_mnt(): fix comment and convert to kernel-doc, while we are at it
      change_mnt_propagation() cleanups, step 1
      change_mnt_propagation(): do_make_slave() is a no-op unless IS_MNT_SHARED()
      do_make_slave(): choose new master sanely
      turn do_make_slave() into transfer_propagation()
      mnt_slave_list/mnt_slave: turn into hlist_head/hlist_node
      change_mnt_propagation(): move ->mnt_master assignment into MS_SLAVE case
      copy_tree(): don't link the mounts via mnt_list
      take freeing of emptied mnt_namespace to namespace_unlock()
      get rid of CL_SHARE_TO_SLAVE
      invent_group_ids(): zero ->mnt_group_id always implies !IS_MNT_SHARED()
      statmount_mnt_basic(): simplify the logics for group id

 Documentation/filesystems/propagate_umount.txt | 484 +++++++++++++++++
 drivers/gpu/drm/i915/gem/i915_gemfs.c          |  21 +-
 drivers/gpu/drm/v3d/v3d_gemfs.c                |  21 +-
 fs/hugetlbfs/inode.c                           |   2 +-
 fs/mount.h                                     |  40 +-
 fs/namespace.c                                 | 711 ++++++++++---------------
 fs/pnode.c                                     | 697 ++++++++++++------------
 fs/pnode.h                                     |  27 +-
 include/linux/mount.h                          |  18 +-
 ipc/mqueue.c                                   |   2 +-
 10 files changed, 1216 insertions(+), 807 deletions(-)
 create mode 100644 Documentation/filesystems/propagate_umount.txt

