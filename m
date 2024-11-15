Return-Path: <linux-fsdevel+bounces-34908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 500EA9CE105
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6116B304C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3C1CDA0B;
	Fri, 15 Nov 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUhh24Lq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C771DA23;
	Fri, 15 Nov 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679066; cv=none; b=Ky//YX21OHAEvo8Q00SpcgoNOX33tqB0ghS8wQ1DVPijSe/huEVF+OBppWGiOgW4aEm1d8W1w4YeJ5j7SYfn6K7d/4WQbN/g90ukaz+iB2Gsk5iEv9IJurfSvvqzKgNeGy8MEW3PwAZlvTPKyGktEfy4AC4VGL48+88X4JBuugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679066; c=relaxed/simple;
	bh=m2i2oRc1+ZwJdCAphWrF+EL5SkeOnzqj1wMzbCwzNGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LaVODoc2OB4CHD985RHNi8JR+4FPeI+4fe+YO4IQpE3fWopjYp8DLo8E7NjD+j62Bt4ijrLIG3ByxoN6AQ3k+UeZ3rGHB4e8gIYjT7zDXVijAwgHRzRlbtC04qITWv1RR52TAri93WWI2YB4Z+bt/joH2wMq/jpsrIaB4Fae+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUhh24Lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E15C4CECF;
	Fri, 15 Nov 2024 13:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679065;
	bh=m2i2oRc1+ZwJdCAphWrF+EL5SkeOnzqj1wMzbCwzNGU=;
	h=From:To:Cc:Subject:Date:From;
	b=WUhh24Lqcm2mX1Dg18XTcP5n0W0XH6kUSq8NiQ/6X6y41mgXpysguQQkDg3T1gil8
	 GD9J2HSWnzIwcteqj1SH/g/bm9JH0l6ZrzZxOTimrASzsCPgz+wVpG2pClIhVUkuMv
	 yh1d17+IrNS66mFiuYJBCSdefxmsHJZA4vi8/cpgIS+Af2atPk56SgcJ9hmYXdljcI
	 1o++owZ1jbxCSEH10dUbusj0nl+UXdk+cFyKthMBNPbak9IOaEbL2drv6DWtMC/w3H
	 cmPyj+BXHLcLehzQ6G07BJNUbEgFRXVoXppFJieAvSgLBbCcTzsIZ5X4gAejRh5AMh
	 1Ujm/aYxkWs8g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs rust file
Date: Fri, 15 Nov 2024 14:57:25 +0100
Message-ID: <20241115-vfs-rust-file-c79423c56dcc@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3869; i=brauner@kernel.org; h=from:subject:message-id; bh=m2i2oRc1+ZwJdCAphWrF+EL5SkeOnzqj1wMzbCwzNGU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbB/s0O1xsvKfDrNeotir1ce+qI1dl2Xqn/PRJSythl Q5+fkW+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLZ0owMt2J+WzouVDri6vpi ppqCcbDG9qLITZLveWeJxJdJav1rYWT4OvfsoQft8idPfGFTfdO0/v3aZ5fkdMT1bcoX7OQ3/cX FAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the file abstractions needed by the Rust implementation of
the Binder driver and other parts of the kernel.

Let's treat this as a first attempt at getting something working but I
do expect the actual interfaces to change significantly over time.
Simply because we are still figuring out what actually works. But
there's no point in further theorizing. Let's see how it holds up with
actual users.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc2 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

(1) linux-next: manual merge of the rust tree with the vfs-brauner tree
    https://lore.kernel.org/r/20241004144202.24a9f0ef@canb.auug.org.au

(2) linux-next: manual merge of the rust tree with the vfs-brauner tree
    https://lore.kernel.org/r/20241008165636.0e8d0d4e@canb.auug.org.au

(3) linux-next: manual merge of the ftrace tree with the vfs-brauner tree
    https://lore.kernel.org/r/20241108135504.519ce71e@canb.auug.org.au

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.rust.file

for you to fetch changes up to fe95f58320e6c8dcea3bcb01336b9a7fdd7f684b:

  rust: task: adjust safety comments in Task methods (2024-10-15 16:07:02 +0200)

Please consider pulling these changes from the signed vfs-6.13.rust.file tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.rust.file

----------------------------------------------------------------
Alice Ryhl (7):
      rust: types: add `NotThreadSafe`
      rust: task: add `Task::current_raw`
      rust: security: add abstraction for secctx
      rust: file: add `Kuid` wrapper
      rust: file: add abstraction for `poll_table`
      rust: add seqfile abstraction
      rust: task: adjust safety comments in Task methods

Christian Brauner (1):
      Merge patch series "File abstractions needed by Rust Binder"

Wedson Almeida Filho (3):
      rust: file: add Rust abstraction for `struct file`
      rust: cred: add Rust abstraction for `struct cred`
      rust: file: add `FileDescriptorReservation`

 fs/file.c                       |   7 +
 rust/bindings/bindings_helper.h |   6 +
 rust/helpers/cred.c             |  13 ++
 rust/helpers/fs.c               |  12 ++
 rust/helpers/helpers.c          |   3 +
 rust/helpers/security.c         |  20 ++
 rust/helpers/task.c             |  38 ++++
 rust/kernel/cred.rs             |  85 ++++++++
 rust/kernel/fs.rs               |   8 +
 rust/kernel/fs/file.rs          | 461 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   4 +
 rust/kernel/security.rs         |  74 +++++++
 rust/kernel/seq_file.rs         |  52 +++++
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/lock.rs        |  13 +-
 rust/kernel/sync/poll.rs        | 121 +++++++++++
 rust/kernel/task.rs             | 120 +++++++++--
 rust/kernel/types.rs            |  21 ++
 18 files changed, 1035 insertions(+), 24 deletions(-)
 create mode 100644 rust/helpers/cred.c
 create mode 100644 rust/helpers/fs.c
 create mode 100644 rust/helpers/security.c
 create mode 100644 rust/kernel/cred.rs
 create mode 100644 rust/kernel/fs.rs
 create mode 100644 rust/kernel/fs/file.rs
 create mode 100644 rust/kernel/security.rs
 create mode 100644 rust/kernel/seq_file.rs
 create mode 100644 rust/kernel/sync/poll.rs

