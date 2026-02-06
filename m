Return-Path: <linux-fsdevel+bounces-76598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM/fNbYchmmTJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:54:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DD5100951
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3201B3040FBC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D4B2DC765;
	Fri,  6 Feb 2026 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzp0RkYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4A25228D;
	Fri,  6 Feb 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396683; cv=none; b=JrNAyuash5dcqtgwlALslWuZQF7P2jcEBzTplOxUmUYZsW4rIIPcez6gIjQ4XLfZ/ggAN4FAWU5fXllImTufXcDHIz9WdyYJbqoVor9mCYQ/K4Pffq+9WiNSUaPFGxnIGA3Mf6I+Z5gC9qBneMRFDWzIfR5f7PhqJSyNy4baJWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396683; c=relaxed/simple;
	bh=WDeK4uvoh4jPKgz0FrJQbEnqItAMD9vDshI1c8Vh32s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r4UdRnwt8ueHSib0PMUAebOKaTx2y4xgqz3dQFFkrjDWxopbcx4HtC6Yy7MFzODq8QQATXcbs37f1VaHvp/9+bkwNz+iDaRpLO4ZRrMt43Zkn1PL7o37rPxb2eeEYSVLvWZTZ4/bKqVmOW7DRtW3RHoBO3JnFN8hNhhzYlzBMnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzp0RkYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04631C116C6;
	Fri,  6 Feb 2026 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396683;
	bh=WDeK4uvoh4jPKgz0FrJQbEnqItAMD9vDshI1c8Vh32s=;
	h=From:To:Cc:Subject:Date:From;
	b=nzp0RkYnFF4iU034xBnlDpMCO6R8YtWNsyz1fVEZD7Y1oypYBWC1/IZ743ZA0fNKK
	 cWHURjwZPBsNiAHUdKcrVDN6WiiuyFjs3v4mez8bhyMeeigV/UZlAOoXlMT0TDrKmq
	 avFVeswaEgGyaPi3CjAN0TRVHv02zkmufUtUrOI7N6DE1ucpEKNToU9Fzxsh1uGMfX
	 +hSZP+dlnbdNA0ffOEZz1iFmVTYMpqP8zddVooVr96ok9ecANp11fUhIPYHpVSQHNV
	 GC/ZMdOKgM0buXx7YvbE3bGDkXbWsmUB041gXRbwcCW0upjcfUknQ05COdp8taOwmj
	 uJRNILcNxNo9w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 00/12 for v7.0] v7.0
Date: Fri,  6 Feb 2026 17:49:56 +0100
Message-ID: <20260206-vfs-v70-7df0b750d594@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4892; i=brauner@kernel.org; h=from:subject:message-id; bh=WDeK4uvoh4jPKgz0FrJQbEnqItAMD9vDshI1c8Vh32s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS2Se/g3Vw+03L/dfuv/+Id3j3R+NTJr3Nw+4xW+9XBh UfCZh6Z2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR58eMDK8d7qz+sVHhQ01w ltUE5i3hkot/vTjVsp9P67iguM+bvnJGhsaItJqb7u3eXvcqJzd33KkQmfYzMi57gf3HVluRkNN 2DAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76598-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52DD5100951
X-Rspamd-Action: no action

Hey Linus,

This is the batch of pull requests for the v7.0 merge window.

This cycle has a few infrastructure pieces worth highlighting.

There's nullfs, a completely catatonic minimal pseudo filesystem that
serves as the immutable root of the mount hierarchy. The mutable rootfs
(tmpfs/ramfs) is mounted on top of it. This allows userspace to simply
pivot_root() in the initramfs without the traditional switch_root
workarounds. nullfs is enabled unconditionally. If we see any real
regression we'll hide it behind a boot option. There's an easy to revert
change to make that happen. It will also serve as a foundation for
creating completely empty mount namespaces in a future cycle.

Along with nullfs, we remove the deprecated linuxrc-based initrd code
path is removed. It was deprecated in 2020 and this completes the
removal. Initramfs is entirely unaffected. The non-linuxrc initrd path
(root=/dev/ram0) is preserved but now carries a deprecation warning
targeting January 2027 removal.

There a new OPEN_TREE_NAMESPACE extension for open_tree(). Container
runtimes currently use CLONE_NEWNS to copy the caller's entire mount
namespace only to then pivot_root() and recursively unmount everything
they just copied. With large mount tables and thousands of parallel
container launches this creates significant contention on the namespace
semaphore. OPEN_TREE_NAMESPACE copies only the specified mount tree and
returns a mount namespace fd instead of a detached mount fd —
functioning as a combined unshare(CLONE_NEWNS) + pivot_root() in a
single syscall. Using it for container creation brings about a 40%
increase in throughput.

We added a new STATMOUNT_BY_FD extension to statmount(). It now accepts
a file descriptor as a parameter, returning mount information for the
mount the fd resides on, including detached mounts.

With every in-tree filesystem now converted to the new mount API, we can
remove all the legacy code in fs_context.c for unconverted filesystems -
about 280 lines including legacy_init_fs_context() and friends. The
mount(2) syscall path for userspace is untouched.

The timestamp update path is reworked to propagate IOCB_NOWAIT through
->update_time so that filesystems which can update timestamps without
blocking are no longer penalized. Previously, file_update_time_flags()
unconditionally returned -EAGAIN when IOCB_NOWAIT was set, making
non-blocking direct writes impossible on essentially all filesystems.
XFS implements non-blocking timestamp updates as the first user.

Lease support is changed to require explicit opt-in. Previously
kernel_setlease() fell through to generic_setlease() when a filesystem
did not define ->setlease(), silently granting lease support to every
filesystem. The new default returns -EINVAL when ->setlease is NULL.
With the new default simple_nosetlease() becomes redundant and is
removed.

There's a new generic fserror infrastructure for reporting metadata
corruption and file I/O errors to userspace via fsnotify. EFSCORRUPTED
and EUCLEAN are promoted from private per-filesystem definitions to
canonical errno.h values across all architectures. A new
super_operations::report_error callback lets filesystem drivers respond
to file I/O errors themselves.

knfsd can now use atomic_open() via dentry_create(), eliminating the
racy vfs_create() + vfs_open() sequence for combined exclusive create
and open operations.

Btrfs drops its private copies of may_delete() and may_create() in
favor of newly exported may_delete_dentry() and may_create_dentry(),
removing ~70 lines of duplicated code that had drifted out of sync with
the VFS originals.

On the scalability side, pid allocation is reworked to only take
pidmap_lock once instead of twice during alloc_pid(), improving thread
creation/teardown throughput by 10-16%. File lock presence is tracked
via a flag in ->i_opflags instead of reading ->i_flctx, avoiding
false-sharing on open/close hot paths with a measured 4-16% improvement.
A redundant DCACHE_MANAGED_DENTRY check in __follow_mount_rcu() that
caused a 100% mispredicted branch is removed.

Smaller items include minix superblock validation hardening (syzbot),
iomap plumbing for erofs page cache sharing preliminaries, a fix for
invalid folio access after folio_end_read(), posix_acl_to_xattr() now
allocating the buffer internally since every caller was doing it anyway,
chardev cleanup API conversion, the start of deprecating legacy BSD
process accounting (acct(2)), Rust VFS helper annotations for LTO
inlining, and the usual collection of kernel-doc fixes and cleanups.

Note that I will have some pull requests coming in during the second
half of the merge window as linux-next had to temporarily drop them last
week when a selftest build error happened. So I'm delaying them a bit.

Thanks!
Christian

