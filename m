Return-Path: <linux-fsdevel+bounces-63011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD123BA8B94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977463A3225
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8A92E03F0;
	Mon, 29 Sep 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+298Ff7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DC427E06D;
	Mon, 29 Sep 2025 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139247; cv=none; b=sIlI84tYpG5FSjkMctc5LYcCQ+NTRhMfnFw4n5mzCwQWAjS5M6Y+9Rc8BhuJirKSYqaGVRmbG+03W6c046A+3Fultxct4NX/1BzAW8QknyuJZFfBzUpH5mKg7RA117u+af1EfqwDocgv6LAfcP8T306NyUWHiQDBUey/6OgucnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139247; c=relaxed/simple;
	bh=SWxVtS/I90cKp0//idHYCioZS7tVz03JzDpic4FXwek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6b/1JzjjUc+83iVQjTrr7bdBS73u2fSjy84YE3Q0LaLop+NNMXrK5CpRQK0g8/2mYc4i4og6HHFm8u4yVQ0S+fSa7wXCV4o4BxWgcZPHfbCio3TqdCVQU4O/Hrh3kmqqA61s4BQsyn375uTS2rkybYMhCs9k+wYKJ57SU6oum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+298Ff7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2079AC4CEF4;
	Mon, 29 Sep 2025 09:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759139247;
	bh=SWxVtS/I90cKp0//idHYCioZS7tVz03JzDpic4FXwek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s+298Ff7MNjVbt+HJRjRUlVi81AmGqLair3fvDRI41cgeNx2c2e5JOqaNETy1P/tR
	 jfha/HtcvfrSoIbOKlyZbKAOcYd5MOwCX/zTxBWC8et8O8V6PCm8IlbylZOsCqSg+0
	 JVGOKRErTXI0VJn0AoyIJ4XExpKuTom5vyeY7cFsJNAbCWAKEF82rltvtqLZsLElzV
	 agkFYQLWqKNU5I05O71SNCDPnyyh2Ho7klQqZB3cha0V2rKkzm5fZPZHy8n9/RhsEa
	 JUfMVdoH5M5JuyWiGcIqMcwXIbpHHoPo1S8hEg/ZGFT1znESzHhgGoEINXgdwnwPtk
	 /UsnxYmFtx9DQ==
Date: Mon, 29 Sep 2025 11:47:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 01/12 for v6.18] misc
Message-ID: <20250929-trivial-zoodirektor-9e2bc1148d03@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
 <20250926-vfs-misc-fdd0c7318e6a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vib54rji3wezmzgu"
Content-Disposition: inline
In-Reply-To: <20250926-vfs-misc-fdd0c7318e6a@brauner>


--vib54rji3wezmzgu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Sep 26, 2025 at 04:18:55PM +0200, Christian Brauner wrote:
> Hey Linus,
> 
> /* Summary */
> This contains the usual selections of misc updates for this cycle.
> 
> Features:
> 
> - Add "initramfs_options" parameter to set initramfs mount options. This
>   allows to add specific mount options to the rootfs to e.g., limit the
>   memory size.
> 
> - Add RWF_NOSIGNAL flag for pwritev2()
> 
>   Add RWF_NOSIGNAL flag for pwritev2. This flag prevents the SIGPIPE
>   signal from being raised when writing on disconnected pipes or
>   sockets. The flag is handled directly by the pipe filesystem and
>   converted to the existing MSG_NOSIGNAL flag for sockets.
> 
> - Allow to pass pid namespace as procfs mount option
> 
>   Ever since the introduction of pid namespaces, procfs has had very
>   implicit behaviour surrounding them (the pidns used by a procfs mount
>   is auto-selected based on the mounting process's active pidns, and the
>   pidns itself is basically hidden once the mount has been constructed).
> 
>   This implicit behaviour has historically meant that userspace was
>   required to do some special dances in order to configure the pidns of
>   a procfs mount as desired. Examples include:
> 
>   * In order to bypass the mnt_too_revealing() check, Kubernetes creates
>     a procfs mount from an empty pidns so that user namespaced
>     containers can be nested (without this, the nested containers would
>     fail to mount procfs). But this requires forking off a helper
>     process because you cannot just one-shot this using mount(2).
> 
>   * Container runtimes in general need to fork into a container before
>     configuring its mounts, which can lead to security issues in the
>     case of shared-pidns containers (a privileged process in the pidns
>     can interact with your container runtime process).
>     While SUID_DUMP_DISABLE and user namespaces make this less of an
>     issue, the strict need for this due to a minor uAPI wart is kind of
>     unfortunate.
> 
>     Things would be much easier if there was a way for userspace to just
>     specify the pidns they want. So this pull request contains changes
>     to implement a new "pidns" argument which can be set using
>     fsconfig(2):
> 
>         fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
>         fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid", 0);
> 
>     or classic mount(2) / mount(8):
> 
>         // mount -t proc -o pidns=/proc/self/ns/pid proc /tmp/proc
>         mount("proc", "/tmp/proc", "proc", MS_..., "pidns=/proc/self/ns/pid");
> 
> Cleanups:
> 
> - Remove the last references to EXPORT_OP_ASYNC_LOCK.
> 
> - Make file_remove_privs_flags() static.
> 
> - Remove redundant __GFP_NOWARN when GFP_NOWAIT is used.
> 
> - Use try_cmpxchg() in start_dir_add().
> 
> - Use try_cmpxchg() in sb_init_done_wq().
> 
> - Replace offsetof() with struct_size() in ioctl_file_dedupe_range().
> 
> - Remove vfs_ioctl() export.
> 
> - Replace rwlock() with spinlock in epoll code as rwlock causes priority
>   inversion on preempt rt kernels.
> 
> - Make ns_entries in fs/proc/namespaces const.
> 
> - Use a switch() statement() in init_special_inode() just like we do in
>   may_open().
> 
> - Use struct_size() in dir_add() in the initramfs code.
> 
> - Use str_plural() in rd_load_image().
> 
> - Replace strcpy() with strscpy() in find_link().
> 
> - Rename generic_delete_inode() to inode_just_drop() and
>   generic_drop_inode() to inode_generic_drop().
> 
> - Remove unused arguments from fcntl_{g,s}et_rw_hint().
> 
> Fixes:
> 
> - Document @name parameter for name_contains_dotdot() helper.
> 
> - Fix spelling mistake.
> 
> - Always return zero from replace_fd() instead of the file descriptor number.
> 
> - Limit the size for copy_file_range() in compat mode to prevent a signed
>   overflow.
> 
> - Fix debugfs mount options not being applied.
> 
> - Verify the inode mode when loading it from disk in minixfs.
> 
> - Verify the inode mode when loading it from disk in cramfs.
> 
> - Don't trigger automounts with RESOLVE_NO_XDEV
> 
>   If openat2() was called with RESOLVE_NO_XDEV it didn't traverse
>   through automounts, but could still trigger them.
> 
> - Add FL_RECLAIM flag to show_fl_flags() macro so it appears in tracepoints.
> 
> - Fix unused variable warning in rd_load_image() on s390.
> 
> - Make INITRAMFS_PRESERVE_MTIME depend on BLK_DEV_INITRD.
> 
> - Use ns_capable_noaudit() when determining net sysctl permissions.
> 
> - Don't call path_put() under namespace semaphore in listmount() and statmount().
> 
> /* Testing */
> 
> gcc (Debian 14.2.0-19) 14.2.0
> Debian clang version 19.1.7 (3+b1)
> 
> No build failures or warnings were observed.
> 
> /* Conflicts */

There is one issue that was reported after I had generated the pull
request. The mnt_ns_release() function can be passed a NULL pointer and
that case needs to be handled.

I'm appending a patch that I would ask you to please just apply on top
of it. If you rather want me resend the pull request please just tell
me!

--vib54rji3wezmzgu
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mount-handle-NULL-values-in-mnt_ns_release.patch"

From 9f11a1a5cab7e70bdb31077e475ab15d86d03682 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 29 Sep 2025 11:41:16 +0200
Subject: [PATCH] mount: handle NULL values in mnt_ns_release()

When calling in listmount() mnt_ns_release() may be passed a NULL
pointer. Handle that case gracefully.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6686c9f54b40..8db446cd7f4a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -180,7 +180,7 @@ static void mnt_ns_tree_add(struct mnt_namespace *ns)
 static void mnt_ns_release(struct mnt_namespace *ns)
 {
 	/* keep alive for {list,stat}mount() */
-	if (refcount_dec_and_test(&ns->passive)) {
+	if (ns && refcount_dec_and_test(&ns->passive)) {
 		fsnotify_mntns_delete(ns);
 		put_user_ns(ns->user_ns);
 		kfree(ns);
-- 
2.47.3


--vib54rji3wezmzgu--

