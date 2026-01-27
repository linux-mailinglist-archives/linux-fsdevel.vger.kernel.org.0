Return-Path: <linux-fsdevel+bounces-75559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDTqIWANeGmhngEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:57:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4806F8E93F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 664B43029C1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD81FF1B5;
	Tue, 27 Jan 2026 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="embVdrFC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D81DE885
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769475418; cv=pass; b=ED1/vUzTRSXzzWcZcV3+lmMZR+NED1Yd6Ld0f+RCCN+UU7VeDuGUrcYBdYA4XAu4u0mxFVrAt4/qXhmporM8HS3EfWu9Eh/Z/LIqLPSjA7J/RFHbFnH8csDstNhmTmQI77yEOvvBWvYWsvvapQ4aKw/lXd3y16nnFbcnSRcxH9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769475418; c=relaxed/simple;
	bh=M7AIuDgpfxm84BpjBY6Y6bq5K2LBOrKkxU4MJnN61LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTSsN2ELoEiuerITZJ3J4RST/zyLtsAQlKhS6rF1uRUdBJ70fc0f+hsa4VB6LlAGgcb3840CDtXVxwu6XeoXGsH9IZQv0Ie4qAUSWk2ghKZIlyiKXpCd4eK+liu1s5Ln3KSSGTjbUhN+qL9TcFD2hJ+KqoBAGFmsrvkIydvKsTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=embVdrFC; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so9860941a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 16:56:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769475414; cv=none;
        d=google.com; s=arc-20240605;
        b=XSq3YV75ImWbDyzM0KuT2TLzUZg+ehoMZSIjPEG/ddXSZ/kDhW+O1y172Sn3wECvoD
         ffV4H1YfQd3q4yy6Nlv3ccQexl/Edndh3FSME2/83ZnE7lvMiXA8Gjk2IUGhKh/nvQ9w
         xsIqnUt9BGGmRxfRXaYBjx3HATiYk5XT9eULn3InElfCtqpjyU4gbdNx/buHpTicQ3ft
         FJyDMEGkoNDFEqYIvgoMQJXgLzOpFXP7yFJpLGzU+PE2GMbU/XvHtDA1Uz5nHKil+BfD
         Ry9ZdOTY9tmKYEkJK9BlDC70pL89lyX1MqEoqRy+a6BzzkEymccoy2rtEsNzvjeeIXev
         gTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3zLfNFu5Ej89ae2FOVFTz6sNNJ0wH6QKfxg5HAX5ASo=;
        fh=puPEgJXEUMYQ7wW1PDzBz1KV0A09Ig5EA8TZ1Sht/l0=;
        b=XW91wALlHf+lGj/JPdcrCVQAwSZtBQFjO7xgpbk70cY4rPR7Lr29iuMmIb/h/I/lG4
         xkTw9FSmJMqGAM4Fhjhi1czfNdKy2zScvrGsmdVTqPR49Z8o+rGegp0nd0Wi8nPzP9uK
         iaFfTSPDGAfumuQaWjUbm5Z5uvEtdz35V5qbhqi3pSPfUwJJWNkQeOU4ZpHWtgDA+mxl
         k7wKKK9aRAf1ABOoTWyDpj12VVgnb0eAfZTYXEzlIGBpo/TgtgEh4bVVNUB8WhPuWQ3s
         zRSHFdxLNcxNtMyMqvqmuEJjoqp60EW0sc9QvQZnqKEZiJJ5D3DPy9RcxK6XqmbNYJmN
         3FkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769475414; x=1770080214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zLfNFu5Ej89ae2FOVFTz6sNNJ0wH6QKfxg5HAX5ASo=;
        b=embVdrFC4ARjZMr01Zmfeu9GQ49LWmv4z83m9kXj1N93UsFHIjGBUYy2kWbtxQ7USt
         ODrw8bRkz77T39ygIZp7YSzvFE5bSyQM7lpLRq3NpsrFDx0UCFpXoekOBfRlEsKlgMMP
         /rc/hg3b3FtR+gbFUZwnf4eIqECk9usfOsEEVHsPW2pQ1+GxtLjf5w9PRlsGrp8fv+c3
         7iQG9kuepCxHodbFk0t4c9X09H8lLvWX8C/06X1wn8nhpuppDVEMM0WSOrTKVjB4Viu9
         vjR+81f6j+Qx53/gR+dC+RMQ1zcs7/SXHVZjB9P+70eBOdilhNEJVbqv3K7k+cpc8Fy1
         UpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769475414; x=1770080214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3zLfNFu5Ej89ae2FOVFTz6sNNJ0wH6QKfxg5HAX5ASo=;
        b=TCYFf8Qach4XlJ9YlYM/oeDaJUt5G7DzG1Fs5B8vkCgmfuQjCZJqilvz6xvr4bKa3b
         ie60/qzVUHM/hohzwKyEVb1Z041ohd9ytG1UXHmhmHDsWzLRiFCNhzJsXN5XAiuflWul
         L9rvW2x6g54es2NCxQG4SHlREQqlcMLxp23HQ2/f1ld+kEEjq7BTdpjm3SpcneDguEl9
         Xy9gkMZrFnn2cyy1TcUBOpExieE5AJmglIXn+IS1Pn9b0yr4rdcgaYAwY0dS3L7+mTzv
         zFY+x5nSyUEParV/l9QABB0fyi1yh8CuUJ06E004KcBMJ1Vu6ZaSP+tbDkn7jJettPzR
         rHWQ==
X-Gm-Message-State: AOJu0YzItYOlEyCcXkjIGSnrm9N1+0FlHgyqmKJCOwEI17DW9QRqQjlq
	+Epv4vUbks5e+SyT7tGqqz/AVbYHOYwUFDa4BnZLeyDjqNgBi+KLPoVOd+yv6ZaU8rrSRUgsH8k
	NYnEygA3X1b/YCXKD+3eGq18V0dVTgo11/rLvvdue
X-Gm-Gg: AZuq6aJ8bxmZC85VzIpYLoQWnO/AMEJTpZj7FRl0xezEPDL4O6qy2zs8qk4YAAfGpyq
	ZmB5ZKT0HjRpgBHEgbEuOm/kU9XRJZeaJsH52XEEhLRKFZHU0Z5CQpJUmggoblegLaxAMywt+LP
	dZdR3sze1VAuoMqy8kHsbXcKCZxUashO+ZYxlJ5oq7lFHuI0u9JAA/lKQdYqPNOCabOAKVbyYfm
	8O58s/yVXBfwxWzxToyt9kQgY6XevNsEGBlFdibNG+zPyL3TB3l4PSSy7mfAde6/osg1b3yN2u2
	ZIUaZGn6UIHUsb+tzpuzK2qLuHcLSg==
X-Received: by 2002:a17:907:3e1f:b0:b70:4f7d:24f8 with SMTP id
 a640c23a62f3a-b8ceef90390mr472102366b.22.1769475414121; Mon, 26 Jan 2026
 16:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 26 Jan 2026 16:56:42 -0800
X-Gm-Features: AZwV_QiBMrJYd91OXm8P7lUFLNbyvK6EaRwh_3htJKxjg87yoCQ5TeewXmGGNPs
Message-ID: <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75559-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4806F8E93F
X-Rspamd-Action: no action

On Mon, Nov 17, 2025 at 9:15=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> Some filesystems use a kinda-sorta controlled dentry refcount leak to pin
> dentries of created objects in dcache (and undo it when removing those).
> Reference is grabbed and not released, but it's not actually _stored_
> anywhere.  That works, but it's hard to follow and verify; among other
> things, we have no way to tell _which_ of the increments is intended
> to be an unpaired one.  Worse, on removal we need to decide whether
> the reference had already been dropped, which can be non-trivial if
> that removal is on umount and we need to figure out if this dentry is
> pinned due to e.g. unlink() not done.  Usually that is handled by using
> kill_litter_super() as ->kill_sb(), but there are open-coded special
> cases of the same (consider e.g. /proc/self).
>
> Things get simpler if we introduce a new dentry flag (DCACHE_PERSISTENT)
> marking those "leaked" dentries.  Having it set claims responsibility
> for +1 in refcount.
>
> The end result this series is aiming for:
>
> * get these unbalanced dget() and dput() replaced with new primitives tha=
t
>   would, in addition to adjusting refcount, set and clear persistency fla=
g.
> * instead of having kill_litter_super() mess with removing the remaining
>   "leaked" references (e.g. for all tmpfs files that hadn't been removed
>   prior to umount), have the regular shrink_dcache_for_umount() strip
>   DCACHE_PERSISTENT of all dentries, dropping the corresponding
>   reference if it had been set.  After that kill_litter_super() becomes
>   an equivalent of kill_anon_super().
>
> Doing that in a single step is not feasible - it would affect too many pl=
aces
> in too many filesystems.  It has to be split into a series.
>
> This work has really started early in 2024; quite a few preliminary piece=
s
> have already gone into mainline.  This chunk is finally getting to the
> meat of that stuff - infrastructure and most of the conversions to it.
>
> Some pieces are still sitting in the local branches, but the bulk of
> that stuff is here.
>
> Compared to v3:
>         * fixed a functionfs braino around ffs_epfiles_destroy() (in #40/=
54,
> used to be #36/50).
>         * added fixes for a couple of UAF in functionfs (##36--39); that
> does *NOT* include any fixes for dmabuf bugs Chris posted last week, thou=
gh.
>
> The branch is -rc5-based; it lives in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.persiste=
ncy
> individual patches in followups.
>
> Please, help with review and testing.  If nobody objects, in a few days i=
t
> goes into #for-next.
>
> Shortlog:
>       fuse_ctl_add_conn(): fix nlink breakage in case of early failure
>       tracefs: fix a leak in eventfs_create_events_dir()
>       new helper: simple_remove_by_name()
>       new helper: simple_done_creating()
>       introduce a flag for explicitly marking persistently pinned dentrie=
s
>       primitives for maintaining persisitency
>       convert simple_{link,unlink,rmdir,rename,fill_super}() to new primi=
tives
>       convert ramfs and tmpfs
>       procfs: make /self and /thread_self dentries persistent
>       configfs, securityfs: kill_litter_super() not needed
>       convert xenfs
>       convert smackfs
>       convert hugetlbfs
>       convert mqueue
>       convert bpf
>       convert dlmfs
>       convert fuse_ctl
>       convert pstore
>       convert tracefs
>       convert debugfs
>       debugfs: remove duplicate checks in callers of start_creating()
>       convert efivarfs
>       convert spufs
>       convert ibmasmfs
>       ibmasmfs: get rid of ibmasmfs_dir_ops
>       convert devpts
>       binderfs: use simple_start_creating()
>       binderfs_binder_ctl_create(): kill a bogus check
>       convert binderfs
>       autofs_{rmdir,unlink}: dentry->d_fsdata->dentry =3D=3D dentry there
>       convert autofs
>       convert binfmt_misc
>       selinuxfs: don't stash the dentry of /policy_capabilities
>       selinuxfs: new helper for attaching files to tree
>       convert selinuxfs
>       functionfs: don't abuse ffs_data_closed() on fs shutdown
>       functionfs: don't bother with ffs->ref in ffs_data_{opened,closed}(=
)
>       functionfs: need to cancel ->reset_work in ->kill_sb()
>       functionfs: fix the open/removal races
>       functionfs: switch to simple_remove_by_name()
>       convert functionfs
>       gadgetfs: switch to simple_remove_by_name()
>       convert gadgetfs
>       hypfs: don't pin dentries twice
>       hypfs: switch hypfs_create_str() to returning int
>       hypfs: swich hypfs_create_u64() to returning int
>       convert hypfs
>       convert rpc_pipefs
>       convert nfsctl
>       convert rust_binderfs
>       get rid of kill_litter_super()
>       convert securityfs
>       kill securityfs_recursive_remove()
>       d_make_discardable(): warn if given a non-persistent dentry
>
> Diffstat:
>  Documentation/filesystems/porting.rst     |   7 ++
>  arch/powerpc/platforms/cell/spufs/inode.c |  17 ++-
>  arch/s390/hypfs/hypfs.h                   |   6 +-
>  arch/s390/hypfs/hypfs_diag_fs.c           |  60 ++++------
>  arch/s390/hypfs/hypfs_vm_fs.c             |  21 ++--
>  arch/s390/hypfs/inode.c                   |  82 +++++--------
>  drivers/android/binder/rust_binderfs.c    | 121 ++++++-------------
>  drivers/android/binderfs.c                |  82 +++----------
>  drivers/base/devtmpfs.c                   |   2 +-
>  drivers/misc/ibmasm/ibmasmfs.c            |  24 ++--
>  drivers/usb/gadget/function/f_fs.c        | 144 +++++++++++++----------
>  drivers/usb/gadget/legacy/inode.c         |  49 ++++----
>  drivers/xen/xenfs/super.c                 |   2 +-
>  fs/autofs/inode.c                         |   2 +-
>  fs/autofs/root.c                          |  11 +-
>  fs/binfmt_misc.c                          |  69 ++++++-----
>  fs/configfs/dir.c                         |  10 +-
>  fs/configfs/inode.c                       |   3 +-
>  fs/configfs/mount.c                       |   2 +-
>  fs/dcache.c                               | 111 +++++++++++-------
>  fs/debugfs/inode.c                        |  32 ++----
>  fs/devpts/inode.c                         |  57 ++++-----
>  fs/efivarfs/inode.c                       |   7 +-
>  fs/efivarfs/super.c                       |   5 +-
>  fs/fuse/control.c                         |  38 +++---
>  fs/hugetlbfs/inode.c                      |  12 +-
>  fs/internal.h                             |   1 -
>  fs/libfs.c                                |  52 +++++++--
>  fs/nfsd/nfsctl.c                          |  18 +--
>  fs/ocfs2/dlmfs/dlmfs.c                    |   8 +-
>  fs/proc/base.c                            |   6 +-
>  fs/proc/internal.h                        |   1 +
>  fs/proc/root.c                            |  14 +--
>  fs/proc/self.c                            |  10 +-
>  fs/proc/thread_self.c                     |  11 +-
>  fs/pstore/inode.c                         |   7 +-
>  fs/ramfs/inode.c                          |   8 +-
>  fs/super.c                                |   8 --
>  fs/tracefs/event_inode.c                  |   7 +-
>  fs/tracefs/inode.c                        |  13 +--
>  include/linux/dcache.h                    |   4 +-
>  include/linux/fs.h                        |   6 +-
>  include/linux/proc_fs.h                   |   2 -
>  include/linux/security.h                  |   2 -
>  init/do_mounts.c                          |   2 +-
>  ipc/mqueue.c                              |  12 +-
>  kernel/bpf/inode.c                        |  15 +--
>  mm/shmem.c                                |  38 ++----
>  net/sunrpc/rpc_pipe.c                     |  27 ++---
>  security/apparmor/apparmorfs.c            |  13 ++-
>  security/inode.c                          |  35 +++---
>  security/selinux/selinuxfs.c              | 185 +++++++++++++-----------=
------
>  security/smack/smackfs.c                  |   2 +-
>  53 files changed, 649 insertions(+), 834 deletions(-)
>
>         Overview:
>
> First two commits are bugfixes (fusectl and tracefs resp.)
>
> [1/54] fuse_ctl_add_conn(): fix nlink breakage in case of early failure
> [2/54] tracefs: fix a leak in eventfs_create_events_dir()
>
> Next, two commits adding a couple of useful helpers, the next three addin=
g
> the infrastructure and the rest consists of per-filesystem conversions.
>
> [3/54] new helper: simple_remove_by_name()
> [4/54] new helper: simple_done_creating()
>         end_creating_path() analogue for internal object creation; unlike
> end_creating_path() no mount is passed to it (or guaranteed to exist, for
> that matter - it might be used during the filesystem setup, before the
> superblock gets attached to any mounts).
>
> Infrastructure:
> [5/54] introduce a flag for explicitly marking persistently pinned dentri=
es
>         * introduce the new flag
>         * teach shrink_dcache_for_umount() to handle it (i.e. remove
> and drop refcount on anything that survives to umount with that flag
> still set)
>         * teach kill_litter_super() that anything with that flag does
> *not* need to be unpinned.
> [6/54] primitives for maintaining persisitency
>         * d_make_persistent(dentry, inode) - bump refcount, mark persiste=
nt
> and make hashed positive.  Return value is a borrowed reference to dentry=
;
> it can be used until something removes persistency (at the very least,
> until the parent gets unlocked, but some filesystems may have stronger
> exclusion).
>         * d_make_discardable() - remove persistency mark and drop referen=
ce.
>
> NOTE: at that stage d_make_discardable() does not reject dentries not
> marked persistent - it acts as if the mark been set.
>
> Rationale: less noise in series splitup that way.  We want (and on the
> next commit will get) simple_unlink() to do the right thing - remove
> persistency, if it's there.  However, it's used by many filesystems.
> We would have either to convert them all at once or split simple_unlink()
> into "want persistent" and "don't want persistent" versions, the latter
> being the old one.  In the course of the series almost all callers
> would migrate to the replacement, leaving only two pathological cases
> with the old one.  The same goes for simple_rmdir() (two callers left in
> the end), simple_recursive_removal() (all callers gone in the end), etc.
> That's a lot of noise and it's easier to start with d_make_discardable()
> quietly accepting non-persistent dentries, then, in the end, add private
> copies of simple_unlink() and simple_rmdir() for two weird users (configf=
s
> and apparmorfs) and have those use dput() instead of d_make_discardable()=
.
> At that point we'd be left with all callers of d_make_discardable()
> always passing persistent dentries, allowing to add a warning in it.
>
> [7/54] convert simple_{link,unlink,rmdir,rename,fill_super}() to new prim=
itives
>         See above re quietly accepting non-peristent dentries in
> simple_unlink(), simple_rmdir(), etc.
>
>         Converting filesystems:
> [8/54] convert ramfs and tmpfs
> [9/54] procfs: make /self and /thread_self dentries persistent
> [10/54] configfs, securityfs: kill_litter_super() not needed
> [11/54] convert xenfs
> [12/54] convert smackfs
> [13/54] convert hugetlbfs
> [14/54] convert mqueue
> [15/54] convert bpf
> [16/54] convert dlmfs
> [17/54] convert fuse_ctl
> [18/54] convert pstore
> [19/54] convert tracefs
> [20/54] convert debugfs
> [21/54] debugfs: remove duplicate checks in callers of start_creating()
> [22/54] convert efivarfs
> [23/54] convert spufs
> [24/54] convert ibmasmfs
> [25/54] ibmasmfs: get rid of ibmasmfs_dir_ops
> [26/54] convert devpts
> [27/54] binderfs: use simple_start_creating()
> [28/54] binderfs_binder_ctl_create(): kill a bogus check
> [29/54] convert binderfs
> [30/54] autofs_{rmdir,unlink}: dentry->d_fsdata->dentry =3D=3D dentry the=
re
> [31/54] convert autofs
> [32/54] convert binfmt_misc
> [33/54] selinuxfs: don't stash the dentry of /policy_capabilities
> [34/54] selinuxfs: new helper for attaching files to tree
> [35/54] convert selinuxfs
>
>         Several functionfs fixes, before converting it, to make life
> simpler for backporting:
> [36/54] functionfs: don't abuse ffs_data_closed() on fs shutdown
> [37/54] functionfs: don't bother with ffs->ref in ffs_data_{opened,closed=
}()
> [38/54] functionfs: need to cancel ->reset_work in ->kill_sb()
> [39/54] functionfs: fix the open/removal races
>
>         ... and back to filesystems conversions:
>
> [40/54] functionfs: switch to simple_remove_by_name()
> [41/54] convert functionfs
> [42/54] gadgetfs: switch to simple_remove_by_name()
> [43/54] convert gadgetfs
> [44/54] hypfs: don't pin dentries twice
> [45/54] hypfs: switch hypfs_create_str() to returning int
> [46/54] hypfs: swich hypfs_create_u64() to returning int
> [47/54] convert hypfs
> [48/54] convert rpc_pipefs
> [49/54] convert nfsctl
> [50/54] convert rust_binderfs
>
>         ... and no kill_litter_super() callers remain, so we
> can take it out:
> [51/54] get rid of kill_litter_super()
>
>         Followups:
> [52/54] convert securityfs
>         That was the last remaining user of simple_recursive_removal()
> that did *not* mark things persistent.  Now the only places where
> d_make_discardable() is still called for dentries that are not marked
> persistent are the calls of simple_{unlink,rmdir}() in configfs and
> apparmorfs.
>
> [53/54] kill securityfs_recursive_remove()
>         Unused macro...
>
> [54/54] d_make_discardable(): warn if given a non-persistent dentry
>
> At this point there are very few call chains that might lead to
> d_make_discardable() on a dentry that hadn't been made persistent:
> calls of simple_unlink() and simple_rmdir() in configfs and
> apparmorfs.
>
> Both filesystems do pin (part of) their contents in dcache, but
> they are currently playing very unusual games with that.  Converting
> them to more usual patterns might be possible, but it's definitely
> going to be a long series of changes in both cases.
>
> For now the easiest solution is to have both stop using simple_unlink()
> and simple_rmdir() - that allows to make d_make_discardable() warn
> when given a non-persistent dentry.
>
> Rather than giving them full-blown private copies (with calls of
> d_make_discardable() replaced with dput()), let's pull the parts of
> simple_unlink() and simple_rmdir() that deal with timestamps and link
> counts into separate helpers (__simple_unlink() and __simple_rmdir()
> resp.) and have those used by configfs and apparmorfs.
>

Hi Al, when I apply this patchset my Pixel 6 no longer enumerates on
lsusb or ADB. It was quite hard to bisect to this point, as this is
non-deterministic and seems to be setup specific. Note, I am using
android-mainline, but my understanding is that this build does not
have any out-of-tree USB patches, and that there are no vendor hooks
in the build.

My apologies as I can't offer any other clues; there are no obviously
bad dmesg logs and I'm still working on narrowing down the exact
commit(s) that started this, but just wanted to send a FYI in case
something stands out as obvious.

Thanks!
Sam

