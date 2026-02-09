Return-Path: <linux-fsdevel+bounces-76679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOI1ESUriWkx3gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 01:32:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A7710ABD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 01:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B0993005673
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 00:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD66F1DF26B;
	Mon,  9 Feb 2026 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J9XT7ZCX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83058DDA9
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 00:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770597151; cv=none; b=sArcKA5UM7J5O+6pj0TmV8WhBho4awh01kI+ZWCWYPVJJaSTU+OuvL5vjeAtjJ1HVEitmaY4Iw+A1uQBYhFDhee2N3KKdpSi2Es+PTFz41SmFwgyA4iTkUw7NtOH0H28UUdRv/SJYcBrectFwbhPhS9rVczn+vJO+dwamp9rToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770597151; c=relaxed/simple;
	bh=6ZPbe7+e/efTT0QlF0n09hw4Uou9OP+i8vmz6pF/g1M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IhLHsFky88NWXQMU4HoUOAJs8aE2TadDQgN8BV2j7lPzFfx6sjtfB0OaS7cayqKgC8LVCHTa0dHLKtUw129rfcc0+vGRDCkaJa/gg9m4cPJJ1z/QszBTw/c4Esp+z98M8DvCN90cd0w34h2ZEdgFJLVTOmIBMMsKnZsaVXR040Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=J9XT7ZCX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nNXjLncOUn8X9AlBi0+nAt3kLGqLpSDBqVslOuFLKK4=; b=J9XT7ZCX/WXOKmVk+uCT4DSpsI
	5HV2EFX/4wx3io4OoTm8a4yg54UlVbH5kVMM49u7dl9dnhMqw/aPvIMdW1+uKMMKQmUmC9w8sTBDV
	Gyv5QUvXJvlzF9D0Xo0lIoLtNjt7OyAHori3c0Bsdr5cV4dpL594j+f5sIylWspEmMMX71KQI4XjP
	dyLtml6JnXjl4KdtbWBd4TM0IhgpmEL7vWiaCW/gwYZeo4z2/pzUcPCAIMn2lQPrv963oR35KYUNn
	yeWSHUZIMc/LGUbVCtoaoxWkn0JppyxO+9jsGVLhsJhSHe/jk484nRVanlj+q/iGEJYwuw2EnDRRR
	f8vg5qKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vpFEb-00000006i8d-0l1W;
	Mon, 09 Feb 2026 00:34:37 +0000
Date: Mon, 9 Feb 2026 00:34:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <christian@brauner.io>, Jan Kara <jack@suse.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Werner Almesberger <werner@almesberger.net>
Subject: [RFC] pivot_root(2) races
Message-ID: <20260209003437.GF3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76679-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lkml.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1A7710ABD6
X-Rspamd-Action: no action

	pivot_root(2) semantics is unique in one respect: this is the
only syscall that changes current directory and root of other processes.

	All other syscalls affect that only for the caller and the
threads that happen to share its fs_struct (i.e. if CLONE_FS had been
used all the way back to common ancestor).

	pivot_root(), OTOH, goes over all threads in the system and every
thread that had the same root as the caller gets switched to new root;
ditto for current directories.

	AFAICS, the original rationale had been about the kernel threads
that would otherwise keep the old root busy.  These days that could've
been dealt with much easier, but that behaviour is cast in stone -
it's been 25 years since Werner had brought that thing into the tree
(2.3.41-pre4), and the time for objections is long gone.

	Unfortunately, the way it's been done (all the way since the
original posting) is racy.  If pivot_root() is called while another
thread is in the middle of fork(), it will not see the fs_struct of
the child to be.  The race window is from the call of copy_fs() to the
point where copy_process() finally decides that everything is ready and
grabs tasklist_lock.  There's enough blocking allocations in that range
to make it an issue even on UP, without any kind of preemption, etc. -
that race had been there since the very beginning.

	If pivot_root() comes before that window, child will get the root
and current directory already switched; if it comes after the window, the
child will have its root and current directory switched by pivot_root()
itself.  If it's in the window, though, the child ends up born chrooted
into wherever the original root has been moved to by pivot_root().

	Similar races exist for other syscalls that create new fs_struct
instances (unshare(2) and setns(2)), with the same underlying mechanism -
embryonic fs_struct instances are missed by the function that does that
switchover (chroot_fs_refs()).	Making those instances visible to it is
possible; I've tried to play with that idea, but that leads to really
disgusting code and adds a cost to each fork(), all for the sake of a
rarely used syscall.  IMO it's a non-starter.

	If it was just the fork() alone, we could deal with that simply
by delaying the copying of ->fs->{root,pwd} until copy_process() has
grabbed tasklist_lock.  Unfortunately, the things are more complicated.

	First of all, there's CLONE_NEWNS to deal with.  It does flip
the root and current directory of the caller from locations in original
namespace to the corresponding locations in the copy.  These days it's
done by passing child's fs_struct all the way to copy_mnt_ns(), where we
use that fs_struct to pick the original locations from *and* to store
the new locations into.  That, of course, opens the same pivot_root()
race; child's fs_struct is invisible to it, and if it has happened
between copy_fs() and copy_mnt_ns() we'll get the new namespace with
mount tree reflecting the changes from pivot_root() and child chrooted
into the subtree where the original root had been moved to.  pivot_root()
done to the old namespace after that point is not an issue (we get the
same result as if clone(CLONE_NEWNS) had won the race) and pivot_root()
to the new namespace is not possible until the child becomes visible
to chroot_fs_refs().

	Note that fs_struct passed to copy_mnt_ns() serves two purposes -
we need the original locations to calculate the new ones and we need
some way to report those locations to the rest of the system.  The former
role should be served by current->fs; for the latter I would prefer to
give it a pointer to pair of struct path, so that setting the child's
fs_struct would be done by the caller.  We could keep using child's
fs_struct for that (it will always be an embryonic instance - CLONE_NEWNS
is mutually exclusive with CLONE_FS), but that makes for considerably
messier cleanup logics in copy_process().

	Doing that closes the race for all clone(2) variants - we add
a two-element array of struct path in copy_process(), initialize it with
all NULLs and pass it to copy_namespaces() instead of child's ->fs.
Then, once we have grabbed the tasklist_lock, we do the following:
	struct fs_struct *fs = current->fs;
	struct fs_struct *new_fs = p->fs;
	read_seqlock_excl(&fs->seq);
	if (fs != new_fs) {
		new_fs->root = likely(!path[0].mnt) ? fs->root : path[0];
		new_fs->pwd = likely(!path[1].mnt) ? fs->root : path[1];
		path_get(&fs->root);
		path_get(&fs->pwd);
	} else {
		fs->users++;
	}
	read_sequnlock_excl(&fs->seq);
for switchover.  copy_fs() would allocate the new fs_struct (in !CLONE_FS case,
that is), but do no copying of pwd/root into it.  Failure exits would not use
exit_fs() - that has a side benefit of using exit_fs() only for current; new
fs_struct would be freed directly and references in path[] would be dropped
by path_put(), success of failure.

	unshare(2) also has a similar race, with similar solution:
* copy pwd/root from original to replacement fs_struct in the same scope
where we change current->fs
* pass a pair of struct path to unshare_nsproxy_namespaces() instead of
giving it fs_struct
* use exact same logics as in copy_process() for filling ->root and ->pwd
of new fs_struct (that gives a side benefit in unshare_nsproxy_namespaces() -
instead of the
kernel/nsproxy.c:226:   *new_nsp = create_new_namespaces(unshare_flags, current, user_ns,
kernel/nsproxy.c:227:                                    new_fs ? new_fs : current->fs);
we simply pass struct path array as-is)

	Other callers of create_new_namespaces() can simply pass NULL instead of
bothering with struct path pairs - they never get CLONE_NEWNS in flags, so...

	At that point we are left with two callers of copy_fs_struct().  One
is unshare_fs_struct(), with only one user (knfsd thread setup).  It does have
the same race with pivot_root(), not that it had been likely, but that race
is trivially closed in the same way as with fork() et.al. - just delay copying
until we are about to switch current->fs.

	The remaining caller is something entirely different - it's prepare_nsset().
There the embryonic fs_struct is not going end up as any task's ->fs; it's used
only to get the root of namespace we are joining - mntns_install() sets it, and
later it goes into current->fs->{root,pwd} once we are sure that joining other
namespaces won't fail (if it's only CLONE_NEWNS, nothing gets allocated and the
damn thing goes straight into current->fs->{root,pwd}).

	It's also racy; unlike copy_mnt_ns(), there's no exclusion whatsoever
wrt pivot_root(2) (cloning namespace obviously needs it to stabilize the mount
tree it's copying).  Even the case of pure CLONE_NEWNS is racy - it switches
fs->{root,pwd} to whatever overmounts the namespace root and each of those is
done under fs->seq, but that's two scopes and neither covers finding that overmount,
so chroot_fs_refs() might come and mess the things up.  If it's more than just
CLONE_NEWNS and we end up with the damn thing stored in the embryonic fs_struct,
the race window includes joining the other namespaces as well.

	Another problem with "CLONE_NEWS + something else" case is that we
end up screwing the logics in mntns_install() that tried to reject the case
of shared current->fs; embryo isn't shared, so the test in there passes just
fine and it's not repeated in the caller, so it's possible to have one of
the fs_struct-sharing threads join a namespace, switching the root and current
directory for the rest without having their namespace switched.

	TBH, looking at that one I'd say that we move finding the namespace
root to separate helper and have _that_ switch root and current directory of
the caller, with commit_nsset() using it.  The interesting part is whether
we want to deal with the possibility of errors at that point...  It *can*,
in theory, happen, but only if the namespace root is overmounted by a mount
trap and stepping onto it ends up failing.  That's an insane setup, of course,
but...

	Comments?

PS: Werner and hpa Cc'd as the folks involved in introducing pivot_root(2) in
the first place.  See https://lkml.org/lkml/2000/1/25/111; thanks to Sasha Levin
for finding that thread, BTW - lore doesn't seem to have it and google not just
fails to find it, their "AI" had fed me an impressive gaslighting session,
complete with inventing inexistent l-k postings from me, claiming that syscall
in question had been introduced by one Al Viro ;-/  Telling it that no such
postings exist on any of the suggested sites got the expected waffling, request
for URL of specific posting has ended up with "https://lore.kernel.org", once
we got through the difference between the site name and clickable link...
Pity whoever tries to use that shite for "research".

For the record - pivot_root(2) is from Werner Almesberger, with suggestions from
Linus and Peter; I hadn't been involved at all.

