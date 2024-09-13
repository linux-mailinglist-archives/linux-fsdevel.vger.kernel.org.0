Return-Path: <linux-fsdevel+bounces-29336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A999782DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 16:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DB2B25926
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F636AF8;
	Fri, 13 Sep 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqWDX5eI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81222BB13;
	Fri, 13 Sep 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238718; cv=none; b=VlrXZMAOd8QwRZdR+hMsESRL9wwQZ1wA5rYLdqDlk5lO41zsDPzJaUayJXWN6m1K4bPLM+5kymka7vcZOQIbvpiVsMLcDIxJS1EkzogEcbFeqp7XWafPAVhtBiglMMAe3WMJOrlDx2DvJNVKk7jKzv+41c5mdyceEwOr/mlpMTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238718; c=relaxed/simple;
	bh=TB2AsdrJ7JEBqRjjSRElrMDhNIYQUq/KDMCtNVT66fU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gtR1cfCIoN72SzQlBfTUND5/vPKn7eAxWkfQYdmSkPR3+HvKAIO13yp8VUeHe8T2LWjZKsNuq7CT6OtuKgKrPnC4xHIoDI6DkYAXP3LwafdMiEFPS7ml8MK57PNp+7SAD1iXCa8heKONyiZQR1GK/VxnvGYOG6oy6NpM8DSVfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqWDX5eI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD0FC4CECC;
	Fri, 13 Sep 2024 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726238718;
	bh=TB2AsdrJ7JEBqRjjSRElrMDhNIYQUq/KDMCtNVT66fU=;
	h=From:To:Cc:Subject:Date:From;
	b=WqWDX5eIL02yeMLAser/aAhKG9lnmWCbmEIm/huZouoUy8ClwnuQle+5tYh18MOdK
	 eBGQpxDQ/pA16d2J67/s4T0zxCkBU5efOTjNioDs4YoEq7sglP7ZzBpaWIsmBlZTjs
	 HUjH3wsPW0PQOmDCP91HVKHFCjhiNGdsB45eCtTsk7gAGjXFdIA3EbnZSyw87QvjJu
	 telu7CYV7+uqaztt5Cm/QRy1BeeP1TgrmOfjskdp8ZAHch8BWxxHjC26DqR+4cwGX+
	 1mcid9SHbYDJC5Vc4SO9QrorRXs4DtOt8XUiY43R5iDX/mbDJ5YrYfj8I6Gzv4o/fY
	 qRtANqI4ok4xg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs procfs
Date: Fri, 13 Sep 2024 16:44:47 +0200
Message-ID: <20240913-vfs-procfs-f4fc141daed2@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4168; i=brauner@kernel.org; h=from:subject:message-id; bh=TB2AsdrJ7JEBqRjjSRElrMDhNIYQUq/KDMCtNVT66fU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ98f9WFFyY5bP+4kYRxvgN6y/ZdJizvA86/m3vNvdjS 0yze1z/dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykVofhn3VgQeb8o4pztDZZ SynN8guuW7W2XM3fVYF/Z1HigzzRCwx/JRpy684Wvz9sXdYQ65NveD9YZp1R6pdatfzX50RWf5T kAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

/* Summary */
Hey Linus,

This contains the following changes for procfs:

* Add config options and parameters to block forcing memory writes.

  This adds a Kconfig option and boot param to allow removing the
  FOLL_FORCE flag from /proc/<pid>/mem write calls as this can be used
  in various attacks.

  The traditional forcing behavior is kept as default because it can
  break GDB and some other use cases.

  This is the simpler version that you had requested.

* Restrict overmounting of ephemeral entities.

  It is currently possible to mount on top of various ephemeral entities
  in procfs. This specifically includes magic links. To recap, magic
  links are links of the form /proc/<pid>/fd/<nr>. They serve as
  references to a target file and during path lookup they cause a jump
  to the target path. Such magic links disappear if the corresponding
  file descriptor is closed.

  Currently it is possible to overmount such magic links. This is mostly
  interesting for an attacker that wants to somehow trick a process into
  e.g., reopening something that it didn't intend to reopen or to hide
  a malicious file descriptor.

  But also it risks leaking mounts for long-running processes. When
  overmounting a magic link like above, the mount will not be detached
  when the file descriptor is closed. Only the target mountpoint will
  disappear. Which has the consequence of making it impossible to unmount
  that mount afterwards. So the mount will stick around until the process
  exits and the /proc/<pid>/ directory is cleaned up during
  proc_flush_pid() when the dentries are pruned and invalidated.

  That in turn means it's possible for a program to accidentally leak
  mounts and it's also possible to make a task leak mounts without it's
  knowledge if the attacker just keeps overmounting things under
  /proc/<pid>/fd/<nr>.

  Disallow overmounting of such ephemeral entities.

* Cleanup the readdir method naming in some procfs file operations.

* Replace kmalloc() and strcpy() with a simple kmemdup() call.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-3)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.11-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

None.

Merge conflicts with other trees
================================

None.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.procfs

for you to fetch changes up to 4ad5f9a021bd7e3a48a8d11c52cef36d5e05ffcc:

  proc: fold kmalloc() + strcpy() into kmemdup() (2024-09-09 10:51:20 +0200)

Please consider pulling these changes from the signed vfs-6.12.procfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12.procfs

----------------------------------------------------------------
Adrian Ratiu (1):
      proc: add config & param to block forcing mem writes

Alexey Dobriyan (1):
      proc: fold kmalloc() + strcpy() into kmemdup()

Christian Brauner (7):
      proc: proc_readfd() -> proc_fd_iterate()
      proc: proc_readfdinfo() -> proc_fdinfo_iterate()
      proc: add proc_splice_unmountable()
      proc: block mounting on top of /proc/<pid>/map_files/*
      proc: block mounting on top of /proc/<pid>/fd/*
      proc: block mounting on top of /proc/<pid>/fdinfo/*
      Merge patch series "proc: restrict overmounting of ephemeral entities"

 Documentation/admin-guide/kernel-parameters.txt | 10 ++++
 fs/proc/base.c                                  | 65 +++++++++++++++++++++++--
 fs/proc/fd.c                                    | 16 +++---
 fs/proc/generic.c                               |  4 +-
 fs/proc/internal.h                              | 13 +++++
 security/Kconfig                                | 32 ++++++++++++
 6 files changed, 127 insertions(+), 13 deletions(-)

