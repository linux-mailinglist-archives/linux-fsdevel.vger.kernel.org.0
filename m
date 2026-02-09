Return-Path: <linux-fsdevel+bounces-76681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBs6LoZciWlY7gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 05:03:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E01810B7E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 05:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D96A7300614B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 04:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563DF1E0B86;
	Mon,  9 Feb 2026 04:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J+x9sJMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D61862A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770609793; cv=none; b=SpPg2QRqNK6CD8KPoQLJbofAHX05nR1mYGic6iC9xEfU89nAcQ8H4EaovZzLWJnGTAjPxlac85HkPkz0mlODkXpOu2Z6JrNgqID4f5sfRZ78kSRWgQP1Rtbe3sK+v+siYQciCk8K5K44Q9+j9s58QqfZqL4LGZRL46BafzBmtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770609793; c=relaxed/simple;
	bh=yIY3S1dd7KDVvNacBwqyZPjCRJPmbd28EkZ4//q7Pow=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CBR7xbJkNIHw5fa+PinLHVcZlsYeDRvq2cyXMF777me/yRNTz44x5uK1h2RbQAI4AixC5aEuWkFG1wqWlRzoZfwvWA8okJGTpcsH11M0hJGj+9Ue4+9Kt/6VbJRzm1C1MhHd5bK4/77RPg4AJhua9scbQj7+EF3UMP7/UNlQxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=J+x9sJMT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+OwnQnMlsodh6yrgBffH6UtEODFPjGrGIX7q5xvbYuo=; b=J+x9sJMTyMX8CFf42+dkwpQD62
	NR+rccsFFhQAfNJ2siQE4neA9NMidtm/R5K9x5lYW9G058x/C7YJRZBf3fQPcFsN4buy0nLGPvcwu
	hARktbdkB1AkNZHa5iNTc5vvMNGvWEZj+RSea8J+PJLIhCW3jfUPJ9fa59ETF8shVDiUHlTYUuTY+
	3fm7zogzD5K0je4J/OVCm5ephFb79pGZ9vu0JhHRW34TUVJFqMPw7Qsv3lhW/BpOSbAEDRsMBsFg6
	CP9Y3tLzYdTVjgSi6EGG9F8lEV7//PA+FVxja/+/vIaAjLX572xc/bq9vsgYR5IXjRCTKS1IUEFhB
	PD5OHPIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vpIWU-00000008H07-45E0;
	Mon, 09 Feb 2026 04:05:20 +0000
Date: Mon, 9 Feb 2026 04:05:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] struct filename series
Message-ID: <20260209040518.GH3183987@ZenIV>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-76681-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E01810B7E1
X-Rspamd-Action: no action

The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632193:

  Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-filename

for you to fetch changes up to 0787a93baa1aab9fd0cb8500105d11d3d3a58f7a:

  sysfs(2): fs_index() argument is _not_ a pathname (2026-01-16 12:52:04 -0500)

----------------------------------------------------------------
struct filename series

[mostly] sanitize struct filename hanling

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (67):
      init_mknod(): turn into a trivial wrapper for do_mknodat()
      init_mkdir(): turn into a trivial wrapper for do_mkdirat()
      init_symlink(): turn into a trivial wrapper for do_symlinkat()
      init_link(): turn into a trivial wrapper for do_linkat()
      allow to use CLASS() for struct filename *
      do_faccessat(): import pathname only once
      do_fchmodat(): import pathname only once
      do_fchownat(): import pathname only once
      do_utimes_path(): import pathname only once
      chdir(2): import pathname only once
      chroot(2): import pathname only once
      user_statfs(): import pathname only once
      do_sys_truncate(): import pathname only once
      do_readlinkat(): import pathname only once
      get rid of audit_reusename()
      ntfs: ->d_compare() must not block
      getname_flags() massage, part 1
      getname_flags() massage, part 2
      struct filename: use names_cachep only for getname() and friends
      struct filename: saner handling of long names
      switch __getname_maybe_null() to CLASS(filename_flags)
      allow incomplete imports of filenames
      struct filename ->refcnt doesn't need to be atomic
      file_getattr(): filename_lookup() accepts ERR_PTR() as filename
      file_setattr(): filename_lookup() accepts ERR_PTR() as filename
      move_mount(): filename_lookup() accepts ERR_PTR() as filename
      ksmbd_vfs_path_lookup(): vfs_path_parent_lookup() accepts ERR_PTR() as name
      ksmbd_vfs_rename(): vfs_path_parent_lookup() accepts ERR_PTR() as name
      do_filp_open(): DTRT when getting ERR_PTR() as pathname
      rename do_filp_open() to do_file_open()
      do_sys_openat2(): get rid of useless check, switch to CLASS(filename)
      simplify the callers of file_open_name()
      simplify the callers of do_open_execat()
      simplify the callers of alloc_bprm()
      execve: fold {compat_,}do_execve{,at}() into their sole callers
      do_execveat_common(): don't consume filename reference
      switch {alloc,free}_bprm() to CLASS()
      non-consuming variant of do_renameat2()
      non-consuming variant of do_linkat()
      non-consuming variant of do_symlinkat()
      non-consuming variant of do_mkdirat()
      non-consuming variant of do_mknodat()
      non-consuming variants of do_{unlinkat,rmdir}()
      filename_...xattr(): don't consume filename reference
      file_[gs]etattr(2): switch to CLASS(filename_maybe_null)
      mount_setattr(2): don't mess with LOOKUP_EMPTY
      do_open_execat(): don't care about LOOKUP_EMPTY
      vfs_open_tree(): use CLASS(filename_uflags)
      name_to_handle_at(): use CLASS(filename_uflags)
      fspick(2): use CLASS(filename_flags)
      do_fchownat(): unspaghettify a bit...
      chdir(2): unspaghettify a bit...
      do_utimes_path(): switch to CLASS(filename_uflags)
      do_sys_truncate(): switch to CLASS(filename)
      do_readlinkat(): switch to CLASS(filename_flags)
      do_f{chmod,chown,access}at(): use CLASS(filename_uflags)
      namei.c: convert getname_kernel() callers to CLASS(filename_kernel)
      namei.c: switch user pathname imports to CLASS(filename{,_flags})
      move_mount(2): switch to CLASS(filename_maybe_null)
      chroot(2): switch to CLASS(filename)
      quotactl_block(): switch to CLASS(filename)
      statx: switch to CLASS(filename_maybe_null)
      user_statfs(): switch to CLASS(filename)
      mqueue: switch to CLASS(filename)
      ksmbd: use CLASS(filename_kernel)
      alpha: switch osf_mount() to strndup_user()
      sysfs(2): fs_index() argument is _not_ a pathname

Mateusz Guzik (1):
      fs: hide names_cache behind runtime const machinery

 Documentation/filesystems/porting.rst |  11 +
 arch/alpha/kernel/osf_sys.c           |  34 +--
 fs/coredump.c                         |   3 +-
 fs/dcache.c                           |   8 +-
 fs/exec.c                             | 178 +++++---------
 fs/fhandle.c                          |   5 +-
 fs/file_attr.c                        |  12 +-
 fs/filesystems.c                      |   9 +-
 fs/fsopen.c                           |   6 +-
 fs/init.c                             |  98 ++------
 fs/internal.h                         |  17 +-
 fs/namei.c                            | 420 ++++++++++++++++++----------------
 fs/namespace.c                        |  22 +-
 fs/ntfs3/dir.c                        |   5 +-
 fs/ntfs3/fsntfs.c                     |   4 +-
 fs/ntfs3/inode.c                      |  13 +-
 fs/ntfs3/namei.c                      |  17 +-
 fs/ntfs3/xattr.c                      |   5 +-
 fs/open.c                             | 119 ++++------
 fs/quota/quota.c                      |   3 +-
 fs/smb/server/vfs.c                   |  15 +-
 fs/stat.c                             |  28 +--
 fs/statfs.c                           |   3 +-
 fs/utimes.c                           |   8 +-
 fs/xattr.c                            |  33 +--
 include/asm-generic/vmlinux.lds.h     |   3 +-
 include/linux/audit.h                 |  11 -
 include/linux/fs.h                    |  41 ++--
 io_uring/fs.c                         | 106 +++++----
 io_uring/openclose.c                  |  26 +--
 io_uring/statx.c                      |  17 +-
 io_uring/xattr.c                      |  30 +--
 ipc/mqueue.c                          |  11 +-
 kernel/acct.c                         |   4 +-
 kernel/auditsc.c                      |  29 +--
 mm/huge_memory.c                      |  15 +-
 mm/swapfile.c                         |  21 +-
 37 files changed, 563 insertions(+), 827 deletions(-)

