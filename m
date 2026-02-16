Return-Path: <linux-fsdevel+bounces-77273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BeMKY0Uk2nD1QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:58:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0928D14380A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB37A30131C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03912609C5;
	Mon, 16 Feb 2026 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TONBF18c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC321FF47;
	Mon, 16 Feb 2026 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771246667; cv=none; b=PeCs6tBIH1ekT1wRwV5I6RKDzpkMU/V226oOcRzukMHigqWCq6ROHsJVXUao97wmCvOYSp6QwDXvTz5U7U4L4EqS8fIX2H9DyQHrk/FlWF4db0RG6FAQXUZ8/c30GcHOb0xrXeP3VPSjFSPIRNFMBjgJliKXIXWaBmGH0DWI5fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771246667; c=relaxed/simple;
	bh=4tME8pMMFwdaFbFs8qZCCfFs7cr3FbZ7R7CaVWX5GlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iG/Cpf9P+fXYUeRscTI2S0hRxmvEdDSBJ2cOl9MycfZ45d+NT/aekZgxMzJuxnGJjxEF1qzlR2sfQSm2GVC/gom7AGb3iKsL1Tui3rrwg+UWqjEl0GM1938lW9K8qaUHFL0WTKjkQEveSfAzxd4r6qrxgQVbsKaVqBflbtp1C5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TONBF18c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB42C116C6;
	Mon, 16 Feb 2026 12:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771246666;
	bh=4tME8pMMFwdaFbFs8qZCCfFs7cr3FbZ7R7CaVWX5GlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TONBF18cAe66bpyzYUAzlpu6dusJnb8CIVdQ14JSwFEFW0IlilyhN1m+Lts/L2ON6
	 dPeprmP8lqTFFzI9/FRYN8396BqBKxcOxniF3uYRNr7ufyLJbLw6ixISKSF1yqmVL5
	 f1r/4uUwWq0fk/K/J4buEb2kqKmxuyZCg+ci80IVnwSvvar/U+d8AjuO8qrL6ySyNR
	 wRXc/yOOZOjQ9g9dW0hHVEluKv1Q5KVZIDmv298LBgprCbQfmYlIpcfgiJKtvjaT5r
	 jhsiMpAFFwA0ogUzhD6r5aqPZvT/HErdZND4CO+GpbUylZvFOcAhhZ4ZwCpkF4i5rr
	 sHBpvvGujM7lw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 14/12 for v7.0] vfs misc 2
Date: Mon, 16 Feb 2026 13:55:40 +0100
Message-ID: <20260216-vfs-misc-2-v70-fd637c6f249a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7158; i=brauner@kernel.org; h=from:subject:message-id; bh=4tME8pMMFwdaFbFs8qZCCfFs7cr3FbZ7R7CaVWX5GlI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROFpE84vxzO/ujvJcVIraGDZMrCp/Z5xb+5eo1u9ukx ftaPLGko5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCId4YwM7Vs6Nt9TXGR8q8G/ T6t1+dPSBbklk+NSpp/8oVb4OvPyYYa/UiwGiz5+Zd+if+HfG8GEk5v/TY7f9XXzxn/VZXv9pm5 hYwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77273-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0928D14380A
X-Rspamd-Action: no action

Hey Linus,

as announced in [1] this is one of pull requests that was delayed.

/* Summary */

This contains the second and last batch of misc vfs changes.

Features:

- Optimize close_range() from O(range size) to O(active FDs) by using
  find_next_bit() on the open_fds bitmap instead of linearly scanning
  the entire requested range. This is a significant improvement for
  large-range close operations on sparse file descriptor tables.

- Add FS_XFLAG_VERITY file attribute for fs-verity files, retrievable
  via FS_IOC_FSGETXATTR and file_getattr(). The flag is read-only. Add
  tracepoints for fs-verity enable and verify operations, replacing the
  previously removed debug printk's.

- Prevent nfsd from exporting special kernel filesystems like pidfs and
  nsfs. These filesystems have custom ->open() and ->permission() export
  methods that are designed for open_by_handle_at(2) only and are
  incompatible with nfsd. Update the exportfs documentation accordingly.

Fixes:

- Fix KMSAN uninit-value in ovl_fill_real() where strcmp() was used on a
  non-null-terminated decrypted directory entry name from fscrypt. This
  triggered on encrypted lower layers when the decrypted name buffer
  contained uninitialized tail data. The fix also adds VFS-level
  name_is_dot(), name_is_dotdot(), and name_is_dot_dotdot() helpers,
  replacing various open-coded "." and ".." checks across the tree.

- Fix read-only fsflags not being reset together with xflags in
  vfs_fileattr_set(). Currently harmless since no read-only xflags
  overlap with flags, but this would cause inconsistencies for any future
  shared read-only flag.

- Return -EREMOTE instead of -ESRCH from PIDFD_GET_INFO when the target
  process is in a different pid namespace. This lets userspace
  distinguish "process exited" from "process in another namespace",
  matching glibc's pidfd_getpid() behavior.

Cleanups:

- Use C-string literals in the Rust seq_file bindings, replacing the
  kernel::c_str!() macro (available since Rust 1.77).

- Fix typo in d_walk_ret enum comment, add porting notes for the
  readlink_copy() calling convention change.

Link: https://lore.kernel.org/20260206-vfs-v70-7df0b750d594@brauner [1]
/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

This has a merge conflict with my kernel-7.0-rc1.misc pull request:

diff --cc Documentation/filesystems/porting.rst
index 79e2c3008289,bd4128ccbb67..000000000000
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@@ -1336,18 -1339,8 +1336,28 @@@ in-tree filesystems have done)

  **mandatory**

 +The ->setlease() file_operation must now be explicitly set in order to provide
 +support for leases. When set to NULL, the kernel will now return -EINVAL to
 +attempts to set a lease. Filesystems that wish to use the kernel-internal lease
 +implementation should set it to generic_setlease().
 +
 +---
 +
 +**mandatory**
 +
 +fs/namei.c primitives that consume filesystem references (do_renameat2(),
 +do_linkat(), do_symlinkat(), do_mkdirat(), do_mknodat(), do_unlinkat()
 +and do_rmdir()) are gone; they are replaced with non-consuming analogues
 +(filename_renameat2(), etc.)
 +Callers are adjusted - responsibility for dropping the filenames belongs
 +to them now.
++
++---
++
++**mandatory**
++
+ readlink_copy() now requires link length as the 4th argument. Said length needs
+ to match what strlen() would return if it was ran on the string.
+
+ However, if the string is freely accessible for the duration of inode's
+ lifetime, consider using inode_set_cached_link() instead.

The following changes since commit 6cbfdf89470ef3c2110f376a507d135e7a7a7378:

  posix_acl: make posix_acl_to_xattr() alloc the buffer (2026-01-16 10:51:12 +0100)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.misc.2

for you to fetch changes up to dedfae78f00960d703badc500422d10e1f12b2bc:

  fs: add porting notes about readlink_copy() (2026-02-03 15:17:34 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.misc.2

Please consider pulling these changes from the signed vfs-7.0-rc1.misc.2 tag.

Thanks!
Christian

----------------------------------------------------------------
Amir Goldstein (4):
      fs: add helpers name_is_dot{,dot,_dotdot}
      ovl: use name_is_dot* helpers in readdir code
      exportfs: clarify the documentation of open()/permission() expotrfs ops
      nfsd: do not allow exporting of special kernel filesystems

Andrey Albershteyn (3):
      fs: reset read-only fsflags together with xflags
      fs: add FS_XFLAG_VERITY for fs-verity files
      fsverity: add tracepoints

Chelsy Ratnawat (1):
      fs: dcache: fix typo in enum d_walk_ret comment

Christian Brauner (2):
      Merge patch series "name_is_dot* cleanup"
      Merge patch series "Add traces and file attributes for fs-verity"

Luca Boccassi (1):
      pidfs: return -EREMOTE when PIDFD_GET_INFO is called on another ns

Mateusz Guzik (1):
      fs: add porting notes about readlink_copy()

Qiliang Yuan (1):
      fs/file: optimize close_range() complexity from O(N) to O(Sparse)

Qing Wang (1):
      ovl: Fix uninit-value in ovl_fill_real

Tamir Duberstein (1):
      rust: seq_file: replace `kernel::c_str!` with C-Strings

 Documentation/filesystems/fsverity.rst |  16 ++++
 Documentation/filesystems/porting.rst  |  10 +++
 MAINTAINERS                            |   1 +
 fs/crypto/fname.c                      |   2 +-
 fs/dcache.c                            |  10 +--
 fs/ecryptfs/crypto.c                   |   2 +-
 fs/exportfs/expfs.c                    |   3 +-
 fs/f2fs/dir.c                          |   2 +-
 fs/f2fs/hash.c                         |   2 +-
 fs/file.c                              |  10 ++-
 fs/file_attr.c                         |  10 ++-
 fs/namei.c                             |   2 +-
 fs/nfsd/export.c                       |   8 +-
 fs/overlayfs/readdir.c                 |  41 ++++-----
 fs/pidfs.c                             |   2 +-
 fs/smb/server/vfs.c                    |   2 +-
 fs/verity/enable.c                     |   4 +
 fs/verity/fsverity_private.h           |   2 +
 fs/verity/init.c                       |   1 +
 fs/verity/verify.c                     |   9 ++
 include/linux/exportfs.h               |  21 ++++-
 include/linux/fileattr.h               |   6 +-
 include/linux/fs.h                     |  14 +++-
 include/trace/events/fsverity.h        | 146 +++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h                |   1 +
 rust/kernel/seq_file.rs                |   4 +-
 26 files changed, 274 insertions(+), 57 deletions(-)
 create mode 100644 include/trace/events/fsverity.h

