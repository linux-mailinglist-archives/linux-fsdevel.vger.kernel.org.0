Return-Path: <linux-fsdevel+bounces-63413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E646EBB8439
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 00:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9E284E79A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 22:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8264D264A8D;
	Fri,  3 Oct 2025 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JK0V2fGS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D215853B
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 22:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759529763; cv=none; b=TvI3Lqn1aI1BoSfld48YiheX0qVYbotg13ddYQVL4wQn1NwQK6BrFIPcLO/KmgBBKC1yYbzh0NUPXfAmW2K5i97ZYPL5YGjpYRVEu8MbcdUa+DIN1g8zAK5VGKbvsEcanwCtTqXEPD9+6tLMf3J3ZqccGT2tT7nORWr61KCurb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759529763; c=relaxed/simple;
	bh=379JGnYVEmX14BwUTe1qQoA2ohSfVHCWrCpWkpbkjx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CueJT5pmYf3nyvg49eg087reYwIEKCXp62muUon4aPXSUk9BTBFgX0Iy9dJh4aEph4p/prBxwS1zd8f3gq9ndIaJt2CDhRA+K3F5AYOrbaMcDL92zXx+5mAodbqwswHaM3zIrDheddn6W89ermAro1R8OO1oRM+0noZzl/6lUV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JK0V2fGS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xxeMNpurkE+ksxmbBgnHla3VymnvjIDuC74agu4Y1dI=; b=JK0V2fGSoYiB0ZTRx28d+e5L/2
	FIZV2I+SwuzdM88esMAZMutX9AGppfE1EB64EoErRfsQHaYrRG0y6f1kq+hj7tCOoHuyTUxTF1I73
	VMr8yFvD3IXNc0KMfbRVDrrTNKNtknjp8cIvjaht8fDMd/BAcVxs287GVWjRuLjQ6y3DZ2QTEDXMb
	YitJXRqvX/J7sPC2OX2esaZdi14I/I8vIX4TyMHmyw/lEx0/HFSvx2sKJYOYGowhdK3b4DXyQ+5fu
	8u05lPzQLmBgnB1aWrO2ZuVOT8aXqv2ikouCw6isjjdxz8yFkKalSvSCs+Yjk/oQjkJ0JdnGcysOg
	HTaROSVQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4o4E-0000000BBNn-3Lll;
	Fri, 03 Oct 2025 22:15:58 +0000
Date: Fri, 3 Oct 2025 23:15:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull] pile 6: f_path stuff
Message-ID: <20251003221558.GA2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	The last of the stuff in -next - file->f_path constification.
Only one thing was modifying ->f_path of an opened file - acct(2).
Massaging that away and constifying a bunch of struct path * arguments
in functions that might be given &file->f_path ends up with the
situation where we can turn ->f_path into an anon union of const
struct path f_path and struct path __f_path, the latter modified only
in a few places in fs/{file_table,open,namei}.c, all for struct file
instances that are yet to be opened.

Several conflicts:
[fs/namei.c, include/linux/namei.h]: s/done_path_create/end_creating_path/
	in mainline.
[include/linux/namei.h]: end_removing_path() is a wrapper around the same thing,
	also needs struct path * argument constified.
[fs/open.c]: trivial conflict in finish_no_open()
[fs/nsfs.c]: less obvious: fs/nsfs.c:nsfs_export_open() needs struct path *
	argument constified.

See proposed resolution in #proposed.merge-2...

The following changes since commit a79765248649de77771c24f7be08ff4c96f16f7a:

  constify {__,}mnt_is_readonly() (2025-09-17 15:58:29 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git pull-f_path

for you to fetch changes up to 2f7d98f10b8f64525b2c74cae7d70ae5278eb654:

  Have cc(1) catch attempts to modify ->f_path (2025-09-27 20:18:41 -0400)

----------------------------------------------------------------
file->f_path constification

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (24):
      backing_file_user_path(): constify struct path *
      constify path argument of vfs_statx_path()
      filename_lookup(): constify root argument
      done_path_create(): constify path argument
      bpf...d_path(): constify path argument
      nfs: constify path argument of __vfs_getattr()
      rqst_exp_get_by_name(): constify path argument
      export_operations->open(): constify path argument
      check_export(): constify path argument
      ksmbd_vfs_path_lookup_locked(): root_share_path can be const struct path *
      ksmbd_vfs_kern_path_unlock(): constify path argument
      ksmbd_vfs_inherit_posix_acl(): constify path argument
      ksmbd_vfs_set_init_posix_acl(): constify path argument
      ovl_ensure_verity_loaded(): constify datapath argument
      ovl_validate_verity(): constify {meta,data}path arguments
      ovl_get_verity_digest(): constify path argument
      ovl_lower_dir(): constify path argument
      ovl_sync_file(): constify path argument
      ovl_is_real_file: constify realpath argument
      apparmor/af_unix: constify struct path * arguments
      configfs:get_target() - release path as soon as we grab configfs_item reference
      kernel/acct.c: saner struct file treatment
      Merge branches 'work.path' and 'work.mount' into work.f_path
      Have cc(1) catch attempts to modify ->f_path

 fs/bpf_fs_kfuncs.c                             |  2 +-
 fs/configfs/symlink.c                          | 33 ++++-----
 fs/file_table.c                                |  6 +-
 fs/internal.h                                  |  2 +-
 fs/namei.c                                     | 12 ++--
 fs/nfs/localio.c                               |  2 +-
 fs/nfsd/export.c                               |  4 +-
 fs/nfsd/export.h                               |  2 +-
 fs/open.c                                      | 10 +--
 fs/overlayfs/copy_up.c                         |  2 +-
 fs/overlayfs/file.c                            |  2 +-
 fs/overlayfs/overlayfs.h                       |  8 +--
 fs/overlayfs/super.c                           |  2 +-
 fs/overlayfs/util.c                            |  8 +--
 fs/pidfs.c                                     |  2 +-
 fs/smb/server/vfs.c                            |  8 +--
 fs/smb/server/vfs.h                            |  6 +-
 fs/stat.c                                      |  2 +-
 include/linux/exportfs.h                       |  2 +-
 include/linux/fs.h                             |  9 ++-
 include/linux/namei.h                          |  2 +-
 kernel/acct.c                                  | 96 ++++++++++----------------
 kernel/trace/bpf_trace.c                       |  2 +-
 security/apparmor/af_unix.c                    | 14 ++--
 tools/testing/selftests/bpf/bpf_experimental.h |  2 +-
 25 files changed, 107 insertions(+), 133 deletions(-)

