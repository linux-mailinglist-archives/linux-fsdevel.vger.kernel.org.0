Return-Path: <linux-fsdevel+bounces-59021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB461B33F5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21881169434
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D970E248F52;
	Mon, 25 Aug 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8HUxUis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A18244662
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124775; cv=none; b=fB/E6dILcCklJwnKJcG6sBASQVZ47Yos7b5+ZjplBaXXiczcW2SjUX5Okv5zKfAjPM9snmQBW/wG8AlJh3qhS48reEgqGeZGoLFPTzKqmji43ME+Wsq8GGy0TpjDGGnOSmxESjyXyaFmPWRpyMVSqWoc3+tlNdXFWyPczgVFQxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124775; c=relaxed/simple;
	bh=UFN+l/PiU38JWd+hb4tfHg+AqY2WfmOE7JQPHv5jWWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpBjG+fAT1hhbZVQ9nX94pndplo2FAwnrXIkjkjd8kHuaP+zwiUbu6Dk/Zcq4GWv/Vpdp+eFSDtnXO6Pvaz65JnRh+t+ZJ6oAczmokFSV8kpirUG+7JwsaOfEoTS+An5PP7QUXXWF/6tZLZ8BJ8hnBKfkG+BVTAHQhAN7Zxw5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8HUxUis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD989C4CEED;
	Mon, 25 Aug 2025 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756124773;
	bh=UFN+l/PiU38JWd+hb4tfHg+AqY2WfmOE7JQPHv5jWWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8HUxUisHzK5oTOCvqeSVMXPcOzWSRuasbWuq/klVpH8QzCJsRiVct/m9D8ZhMB7M
	 wVEH5haBnVFg5emkrXY54Wl/BraJmQDMfRCg+AbaxquD/NbQEQMqxifMNGLsIHQ6nw
	 Yikr4ISmxn87zajFUvvQ1ml4wBCn7FkC08AnaM8nJ1ybOTzRHF83amIFmsLd7swd7s
	 AjVTb0B/mjiu5nH8R5QRFfy6PSm26gDRRub3HK1wNUDoM0WhGYCtfJ/9TS1iEaq+2N
	 WaOFM0TbY0hN1TvaHO1mPr92r+QO/SsdD248ToMj+MgQjQYuNrOAa8QideG5eXtme8
	 MyKWOilEnb4ow==
Date: Mon, 25 Aug 2025 14:26:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
Message-ID: <20250825-exquisit-allein-20af2555c82e@brauner>
References: <20250825044046.GI39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044046.GI39973@ZenIV>

So for fun I asked one of these A.I. tools wtf "CFT" actually means.
And I have to say it did not disappoint:

Looking at this Linux kernel mailing list context about mount-related
patches, "CFT" likely stands for "Call For Testing" in Al Viro's typical
terse style. But since you asked for alternative interpretations:

- Can't Find Testers
- Completely Funtested Trash  
- Christian's Frustration Trigger
- Cryptic Fileystem Torture
- Carefully Fabricated Terrorcode
- Code For Torvalds
- Chaotic Fs Tweaking
- Crash Friendly Technology
- Coffee Fueled Tinkering
- Confusing Fsdevel Tradition

I vote for "Carefully Fabricated Terrorcode".

On Mon, Aug 25, 2025 at 05:40:46AM +0100, Al Viro wrote:
> 	Most of this pile is basically an attempt to see how well do
> cleanup.h-style mechanisms apply in mount handling.  That stuff lives in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
> Rebased to -rc3 (used to be a bit past -rc2, branched at mount fixes merge)
> Individual patches in followups.
> 
> 	Please, help with review and testing.  It seems to survive the
> local beating and code generation seems to be OK, but more testing
> would be a good thing and I would really like to see comments on that
> stuff.
> 
> 	This is not all I've got around mount handling, but I'd rather
> get that thing out for review before starting to sort out other local
> mount-related branches.
> 
> 	Series overview:
> 
> 	Part 1: guards.
> 
> 	This part starts with infrastructure, followed by one-by-one
> conversions to the guard/scoped_guard in some of the places that fit
> that well enough.  Note that one of those places turned out to be taking
> mount_lock for no reason whatsoever; I already see places where we do
> write_seqlock when read_seqlock_excl would suffice, etc.
> 
> 	Folks, _please_ don't do any bulk conversions in that area.
> IMO one area where RAII becomes dangerous is locking; usually it's not
> a big deal to delay freeing some object a bit, but delay dropping a
> lock and you risk introducing deadlocks that will be bloody hard to spot.
> It _has_ to be done carefully; we had trouble in that area several times
> over the last year or so in fs/namespace.c alone.  Another fun problem
> is that quite a few comments regarding the locking in there are stale.
> We still have the comments that talk about mount lock as if it had been
> an rwlock-like thing.  It hadn't been that for more than a decade now.
> It needs to be documented sanely; so do the access rules to the data
> structures involved.  I hope to get some of that into the tree this cycle,
> but it's still in progress.
> 
> 1/52)  fs/namespace.c: fix the namespace_sem guard mess
> 	New guards: namespace_excl and namespace_shared.  The former implies
> the latter, as for anything rwsem-like.  No inode locks, no dropping the final
> references, no opening files, etc. in scope of those.
> 2/52)  introduced guards for mount_lock
> 	New guards: mount_writer, mount_locked_reader.  That's write_seqlock
> and read_seqlock_excl on mount_lock; obviously, nothing blocking should be
> done in scope of those.
> 3/52)  fs/namespace.c: allow to drop vfsmount references via __free(mntput)
> 	Missing DEFINE_FREE (for mntput()); local in fs/namespace.c, to be
> used only for keeping shit out of namespace_... and mount_... scopes.
> 4/52)  __detach_mounts(): use guards
> 5/52)  __is_local_mountpoint(): use guards
> 6/52)  do_change_type(): use guards
> 7/52)  do_set_group(): use guards
> 8/52)  mark_mounts_for_expiry(): use guards
> 9/52)  put_mnt_ns(): use guards
> 10/52)  mnt_already_visible(): use guards
> 	a bunch of clear-cut conversions, with explanations of the reasons
> why this or that guard is needed.
> 11/52)  check_for_nsfs_mounts(): no need to take locks
> 	... and here we have one where it turns out that locking had been
> excessive.  Iterating through a subtree in mount_locked_reader scope is
> safe, all right, but (1) mount_writer is not needed here at all and (2)
> namespace_shared + a reference held to the root of subtree is also enough.
> All callers had (2) already.  Documented the locking requirements for
> function, removed {,un}lock_mount_hash() in it...
> 12/52)  propagate_mnt(): use scoped_guard(mount_locked_reader) for mnt_set_mountpoint()
> 	This one is interesting - existing code had been equivalent to
> scoped_guard(mount_locked_reader), and it's right for that call.  However,
> mnt_set_mountpoint() generally requires mount_writer - the only reason we
> get away with that here is that the mount in question never had been
> reachable from the mounts visible to other threads.
> 13/52)  has_locked_children(): use guards
> 14/52)  mnt_set_expiry(): use guards
> 15/52)  path_is_under(): use guards
> 	more clear-cut conversions with explanations.
> 16/52)  current_chrooted(): don't bother with follow_down_one()
> 17/52)  current_chrooted(): use guards
> 	this pair might be better off with #16 taken to the beginning
> of the series (or to a separate branch merge into this one); no better
> reason to do as I had than wanting to keep the guard infrastructure
> in the very beginning.
> 
> 	Part 2: turning unlock_mount() into __cleanup.
> 
> 	Environment for mounting something on given location consists of:
> 1) namespace_excl scope
> 2) parent mount - the one we'll be attaching things to.
> 3) mountpoint to be, protected from disappearing under us.
> 4) inode of that mountpoint's dentry held exclusive.
> 	Unfortunately, we can't take inode locks in namespace_excl scopes.
> And we want to cope with the possibility that somebody has managed to
> mount something on that place while we'd been taking locks.  "Cope" part
> is simple for finish_automount() ("drop our mount and go away quietly;
> somebody triggered it before we did"), but for everything else it's
> trickier - "use whatever's overmounting that place now (with the right
> locks, please)".
> 	lock_mount() does all of that (do_lock_mount(), actually), with
> unlock_mount() closing the scope.  And it's definitely a good candidate
> for __cleanup()-based approach, except that
> * the damn thing can return an error and conditional variants of that
> infrastructure are too revolting.
> * parent mount is returned in a fucking awful way - we modify the struct
> path passed to us as location to mount on and then its ->mnt is the parent
> to be... except for the "beneath" variant where we play convoluted games
> with "no, here we want the parent of that".  Implementation is also
> vulnerable to umount propagtion races.
> * the structure we set up (everything except the parent) is inserted
> into a linked list by lock_mount().  That excludes DEFINE_CLASS() -
> it wants the value formed and then copied to the variable we are
> defining.
> * it contains an implicit namespace_excl scope, so path_put() and its
> ilk *must* be done after the unlock_mount().  And most of the users have
> gotos past that.
> 	The first two problems are solved by adding an explicit pointer
> to parent mount into struct pinned_mountpoint.	Having lock_mount()
> failure reported by setting it to ERR_PTR(-E...) allows to avoid the
> problem with expressing the constructor failure.  The third one is dealt
> with by defining local macros to be used instead of CLASS - I went with
> LOCK_MOUNT(mp, path) which defines struct pinned_mountpoint mp with
> __cleanup(unlock_mount) and sets it up.  If anybody has better suggestions,
> I'll be glad to hear those.
> 	The last one is dealt with by massaging the users to form that
> would have all post-unlock_mount() stuff done by __free().
> 
> 	First, several trivial cleanups:
> 18/52)  do_move_mount(): trim local variables
> 19/52)  do_move_mount(): deal with the checks on old_path early
> 20/52)  move_mount(2): take sanity checks in 'beneath' case into do_lock_mount()
> 21/52)  finish_automount(): simplify the ELOOP check
> 
> 	Getting rid of post-unlock_mount() stuff:
> 22/52)  do_loopback(): use __free(path_put) to deal with old_path
> 23/52)  pivot_root(2): use __free() to deal with struct path in it
> 24/52)  finish_automount(): take the lock_mount() analogue into a helper
> 	this one turns the open-coded logics into lock_mount_exact() with
> the same kind of calling conventions as lock_mount() and do_lock_mount()
> 25/52)  do_new_mount_rc(): use __free() to deal with dropping mnt on failure
> 26/52)  finish_automount(): use __free() to deal with dropping mnt on failure
> 
> 	This is the main part:
> 27/52)  change calling conventions for lock_mount() et.al.
> 
> 	Followups, cleaning up the games with parent mount in the user:
> 28/52)  do_move_mount(): use the parent mount returned by do_lock_mount()
> 29/52)  do_add_mount(): switch to passing pinned_mountpoint instead of mountpoint + path
> 30/52)  graft_tree(), attach_recursive_mnt() - pass pinned_mountpoint
> 
> 	Part 3: getting rid of mutating struct path there.
> 
> 	do_lock_mount() is still playing silly buggers with struct path it
> had been given - the logics in that thing hadn't changed.  It's not a pretty
> function and it's racy as well; the thing is, by this point its users have
> almost no use for the changed contents of struct path - dentry can be derived
> from struct mountpoint, parent mount to use is provided directly and we
> want that a lot more than modified path->mnt.  There's only one place
> (in can_move_mount_beneath()) where we still want that and it's not hard
> to reconstruct the value by *original* path->mnt value + parent mount to
> be used.
> 
> 	Getting rid of ->dentry uses.
> 31/52)  pivot_root(2): use old_mp.mp->m_dentry instead of old.dentry
> 32/52)  don't bother passing new_path->dentry to can_move_mount_beneath()
> 
> 	A helper, already open-coded in a couple of places; carved out of
> the next patch to keep it reasonably small
> 33/52)  new helper: topmost_overmount()
> 
> 	Rewrite of do_lock_mount() to keep path constant + trivial change
> in do_move_mount() to adjust the argument it passes to can_move_mount_beneath():
> 34/52)  do_lock_mount(): don't modify path.
> 	
> 
> 	Part 5: a bunch of trivial cleanups (mostly constifications)
> 
> 35/52)  constify check_mnt()
> 36/52)  do_mount_setattr(): constify path argument
> 37/52)  do_set_group(): constify path arguments
> 38/52)  drop_collected_paths(): constify arguments
> 39/52)  collect_paths(): constify the return value
> 40/52)  do_move_mount(), vfs_move_mount(), do_move_mount_old(): constify struct path argument(s)
> 41/52)  mnt_warn_timestamp_expiry(): constify struct path argument
> 42/52)  do_new_mount{,_fc}(): constify struct path argument
> 43/52)  do_{loopback,change_type,remount,reconfigure_mnt}(): constify struct path argument
> 44/52)  path_mount(): constify struct path argument
> 45/52)  may_copy_tree(), __do_loopback(): constify struct path argument
> 46/52)  path_umount(): constify struct path argument
> 47/52)  constify can_move_mount_beneath() arguments
> 48/52)  do_move_mount_old(): use __free(path_put)
> 49/52)  do_mount(): use __free(path_put)
> 
> 	Part 6: assorted stuff, will grow.
> 
> 50/52)  umount_tree(): take all victims out of propagation graph at once
> [had been earlier]
> 	For each removed mount we need to calculate where the slaves
> will end up.  To avoid duplicating that work, do it for all mounts to be
> removed at once, taking the mounts themselves out of propagation graph as
> we go, then do all transfers; the duplicate work on finding destinations
> is avoided since if we run into a mount that already had destination
> found, we don't need to trace the rest of the way.  That's guaranteed
> O(removed mounts) for finding destinations and removing from propagation
> graph and O(surviving mounts that have master removed) for transfers.
> 
> 51/52)  ecryptfs: get rid of pointless mount references in ecryptfs dentries
> 	->lower_path.mnt has the same value for all dentries on given
> ecryptfs instance and if somebody goes for mountpoint-crossing variant
> where that would not be true, we can deal with that when it happens
> (and _not_ with duplicating these reference into each dentry).
> 	As it is, we are better off just sticking a reference into
> ecryptfs-private part of superblock and keeping it pinned until
> ->kill_sb().
> 	That way we can stick a reference to underlying dentry right into
> ->d_fsdata of ecryptfs one, getting rid of indirection through struct
> ecryptfs_dentry_info, along with the entire struct ecryptfs_dentry_info
> machinery.
> 
> 52/52)  fs/namespace.c: sanitize descriptions for {__,}lookup_mnt()
> 	Comments regarding "shadow mounts" were stale - no such thing
> anymore.  Document the locking requirements for __lookup_mnt()...
> 
> 
> FWIW, the current diffstat:
> 
>  fs/ecryptfs/dentry.c          |  14 +-
>  fs/ecryptfs/ecryptfs_kernel.h |  27 +-
>  fs/ecryptfs/file.c            |  15 +-
>  fs/ecryptfs/inode.c           |  19 +-
>  fs/ecryptfs/main.c            |  24 +-
>  fs/internal.h                 |   4 +-
>  fs/mount.h                    |  12 +
>  fs/namespace.c                | 775 +++++++++++++++++++-----------------------
>  fs/pnode.c                    |  75 ++--
>  fs/pnode.h                    |   1 +
>  include/linux/mount.h         |   4 +-
>  kernel/audit_tree.c           |  12 +-
>  12 files changed, 464 insertions(+), 518 deletions(-)

