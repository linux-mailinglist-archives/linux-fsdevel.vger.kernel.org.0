Return-Path: <linux-fsdevel+bounces-34922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15789CEAC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C4A4B36943
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BBC1D54CB;
	Fri, 15 Nov 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bjyZAvnA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4871D515F;
	Fri, 15 Nov 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682934; cv=none; b=tDIsJ6E7P5UXeksN3W4v/uNNQA1HJ3y8ba6lfj5WN9ySwh/vpGnyAhNhKo++5Z9YmSsoLWQQJWCKEnJky8LMEejYNkl9DegMJSm5q75VGD7ZBDUugyOnkESBzCcfNw3LXdru/t/PxOfzCGZMVMg7CBDCRk/YZD8W8NbWJamTLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682934; c=relaxed/simple;
	bh=kmDPOOZ5alTamz+lSxvBNdSW1X0/yCN2u5D/LedwvQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S9x/TKPIdMPo0nlywk+H5c6kMpr9O8EAMA53z/j9phJiqvzBkEyw/EP5aooqQ3D/Epr05f4B6unSmCa5b6maB6SyYnnjRcjZdzf2tNcF7a6DSfEUPHqp56Gkf63JIluZTYYKpxdk3KAqtBMvr9BQ0d/rRaKm1V3Qesv1UxZDI/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bjyZAvnA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xNhLoVoMkxCxssTgr514qh4r1XYBiDrn8PKDO+l7x0I=; b=bjyZAvnAPscgLwkG1OQLuma4ze
	skebZ8P8Vov+aKsKCOWa/QcnMzqZrpzlTJHvpwlB43z0ReEhPXi8XiW2XOqLywIfH8HRlGLK8f9bz
	JRrE70fLym9sgO+7pNtscGbdTQTbWGd3S62eshrcmhY6Bb50FdjWkt/4CDf65qVtvZ54W3G9WR0r4
	ExtsM/u5um1lIbO+wnaoaqObl0MfeNNbtoD0BdOSt5HZ7UPOrgs4jABofrhKXJIVzjZmk/hoUo+Nk
	9UG9Blo2V5B8NSVze++cke5m8yN1Q0npo9k+RAomBmwvmD4ZabCo5fBceve4WTusZiN8m2G4u4fjk
	RuYAXKZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBxpp-0000000FTSS-1CB2;
	Fri, 15 Nov 2024 15:02:09 +0000
Date: Fri, 15 Nov 2024 15:02:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] struct fd series
Message-ID: <20241115150209.GT3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fd

for you to fetch changes up to 38052c2dd71f5490f34bba21dc358e97fb205ee5:

  deal with the last remaing boolean uses of fd_file() (2024-11-03 01:28:07 -0500)

----------------------------------------------------------------
the bulk of struct fd memory safety stuff

Making sure that struct fd instances are destroyed in the same
scope where they'd been created, getting rid of reassignments
and passing them by reference, converting to CLASS(fd{,_pos,_raw}).

We are getting very close to having the memory safety of that stuff
trivial to verify.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (28):
      net/socket.c: switch to CLASS(fd)
      regularize emptiness checks in fini_module(2) and vfs_dedupe_file_range()
      timerfd: switch to CLASS(fd)
      get rid of perf_fget_light(), convert kernel/events/core.c to CLASS(fd)
      switch netlink_getsockbyfilp() to taking descriptor
      do_mq_notify(): saner skb freeing on failures
      do_mq_notify(): switch to CLASS(fd)
      simplify xfs_find_handle() a bit
      convert vmsplice() to CLASS(fd)
      fdget_raw() users: switch to CLASS(fd_raw)
      introduce "fd_pos" class, convert fdget_pos() users to it.
      o2hb_region_dev_store(): avoid goto around fdget()/fdput()
      privcmd_ioeventfd_assign(): don't open-code eventfd_ctx_fdget()
      fdget(), trivial conversions
      fdget(), more trivial conversions
      convert do_preadv()/do_pwritev()
      convert cachestat(2)
      switch spufs_calls_{get,put}() to CLASS() use
      convert spu_run(2)
      convert media_request_get_by_fd()
      convert cifs_ioctl_copychunk()
      convert vfs_dedupe_file_range().
      convert do_select()
      do_pollfd(): convert to CLASS(fd)
      assorted variants of irqfd setup: convert to CLASS(fd)
      memcg_write_event_control(): switch to CLASS(fd)
      css_set_fork(): switch to CLASS(fd_raw, ...)
      deal with the last remaing boolean uses of fd_file()

 arch/alpha/kernel/osf_sys.c                |   5 +-
 arch/arm/kernel/sys_oabi-compat.c          |  10 +-
 arch/powerpc/kvm/book3s_64_vio.c           |  21 +-
 arch/powerpc/kvm/powerpc.c                 |  24 +--
 arch/powerpc/platforms/cell/spu_syscalls.c |  68 +++----
 arch/x86/kernel/cpu/sgx/main.c             |  10 +-
 arch/x86/kvm/svm/sev.c                     |  39 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c  |  23 +--
 drivers/gpu/drm/drm_syncobj.c              |   9 +-
 drivers/infiniband/core/ucma.c             |  19 +-
 drivers/infiniband/core/uverbs_cmd.c       |   8 +-
 drivers/media/mc/mc-request.c              |  18 +-
 drivers/media/rc/lirc_dev.c                |  13 +-
 drivers/vfio/group.c                       |   6 +-
 drivers/vfio/virqfd.c                      |  16 +-
 drivers/virt/acrn/irqfd.c                  |  13 +-
 drivers/xen/privcmd.c                      |  28 +--
 fs/btrfs/ioctl.c                           |   5 +-
 fs/eventfd.c                               |   9 +-
 fs/eventpoll.c                             |  38 ++--
 fs/ext4/ioctl.c                            |  21 +-
 fs/f2fs/file.c                             |  15 +-
 fs/fcntl.c                                 |  42 ++--
 fs/fhandle.c                               |   5 +-
 fs/fsopen.c                                |  19 +-
 fs/fuse/dev.c                              |   6 +-
 fs/ioctl.c                                 |  23 +--
 fs/kernel_read_file.c                      |  12 +-
 fs/locks.c                                 |  15 +-
 fs/namei.c                                 |  13 +-
 fs/namespace.c                             |  47 ++---
 fs/notify/fanotify/fanotify_user.c         |  44 ++---
 fs/notify/inotify/inotify_user.c           |  38 ++--
 fs/ocfs2/cluster/heartbeat.c               |  24 +--
 fs/open.c                                  |  61 +++---
 fs/quota/quota.c                           |  12 +-
 fs/read_write.c                            | 145 +++++---------
 fs/readdir.c                               |  28 +--
 fs/remap_range.c                           |  11 +-
 fs/select.c                                |  48 ++---
 fs/signalfd.c                              |   9 +-
 fs/smb/client/ioctl.c                      |  11 +-
 fs/splice.c                                |  78 +++-----
 fs/statfs.c                                |  12 +-
 fs/sync.c                                  |  29 ++-
 fs/timerfd.c                               |  40 ++--
 fs/utimes.c                                |  11 +-
 fs/xfs/xfs_exchrange.c                     |  18 +-
 fs/xfs/xfs_handle.c                        |  16 +-
 fs/xfs/xfs_ioctl.c                         |  69 ++-----
 include/linux/cleanup.h                    |   2 +-
 include/linux/file.h                       |   7 +-
 include/linux/netlink.h                    |   2 +-
 io_uring/sqpoll.c                          |  29 +--
 ipc/mqueue.c                               | 109 +++--------
 kernel/cgroup/cgroup.c                     |  21 +-
 kernel/events/core.c                       |  63 ++----
 kernel/module/main.c                       |  15 +-
 kernel/nsproxy.c                           |   5 +-
 kernel/pid.c                               |  20 +-
 kernel/signal.c                            |  29 +--
 kernel/sys.c                               |  15 +-
 kernel/taskstats.c                         |  18 +-
 kernel/watch_queue.c                       |   6 +-
 mm/fadvise.c                               |  10 +-
 mm/filemap.c                               |  17 +-
 mm/memcontrol-v1.c                         |  44 ++---
 mm/readahead.c                             |  17 +-
 net/core/net_namespace.c                   |  10 +-
 net/netlink/af_netlink.c                   |   9 +-
 net/socket.c                               | 303 +++++++++++++----------------
 security/integrity/ima/ima_main.c          |   7 +-
 security/landlock/syscalls.c               |  45 ++---
 security/loadpin/loadpin.c                 |   8 +-
 sound/core/pcm_native.c                    |   2 +-
 virt/kvm/eventfd.c                         |  15 +-
 virt/kvm/vfio.c                            |  14 +-
 77 files changed, 751 insertions(+), 1395 deletions(-)

