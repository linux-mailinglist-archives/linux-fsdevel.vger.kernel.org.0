Return-Path: <linux-fsdevel+bounces-56028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79546B11D90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A2AAE2501
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B06F2ED151;
	Fri, 25 Jul 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJrGB8pw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF22ECE9E;
	Fri, 25 Jul 2025 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442864; cv=none; b=iLmSZqiFMFO8zGtLINAqbSG0V7W0bR1VRfWEj5hJ8yH7YIAYIzsa3j34LvNLyLNMTbIiM8aur/Azc7U79NBdlsKqn+oKIPi3J/Fe8GJBclwx2LEsCspOkIWiBv211iAy0PX1lpyfCWaY9O3e0ynFj28aEnGd4s049WshiEM12sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442864; c=relaxed/simple;
	bh=EH/xv0NnJRFqsiZuYuTkkDmmB7hJQYQTp8AsIPcr7mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKnsJp2Pgpq8SPPyrc450Wc53Ru0ylj+9H2X749mFw9qOy1Jm+x4VUkHO784JbBreDwqQiyKFcZwD+amU+Wif4FmkftVhcJ//dvcqy0m69Bm8vqK91d8gnPAPSQB9WHIQmWLO9WspD9JB2v4rGOGe2cEJydEjA4HmB0MiqmZnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJrGB8pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDB9C4CEEF;
	Fri, 25 Jul 2025 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442864;
	bh=EH/xv0NnJRFqsiZuYuTkkDmmB7hJQYQTp8AsIPcr7mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJrGB8pwhZMrMBZ9/PyyrccCfwoR1rZp7XCECSdJ/Q2UaA2xP9CFhCR/Gzyl6pHkc
	 4HkmjNcRuRea7BkSAJLNeFGZUysLBAUolcN1pxTLtlDD0n4joyj8o2zgX6py5WCTuD
	 XPkEY39/xeauZ3CuFqA/GA/obi75fvydrR5iTmbArGW5wlHYGBDXPMLa1FJZxt4DlF
	 +dZq2pzOIYIzJUkgK+HFRwI8jQA8ScYpZtluOne6eL5i3gaBh66MoQ1AV4qnMg37nW
	 Vd1FvVq0kxeVvFDy8Gs2mlb0I2Ari6sTNIMtmfqqRE6zJtdwibIaQ1hcewKlWCtRDc
	 BqzBJF9/48kpA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 04/14 for v6.17] namespace updates
Date: Fri, 25 Jul 2025 13:27:23 +0200
Message-ID: <20250725-vfs-nsfs-8b26651e63b9@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=brauner@kernel.org; h=from:subject:message-id; bh=EH/xv0NnJRFqsiZuYuTkkDmmB7hJQYQTp8AsIPcr7mo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4nVL9oWOPf+zE1CcrUbNZd7Nh6ez36YoTQhTivmY UBxMmdERykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERkxRj+ewWse/XJrN9LRSfv e/Gc6CSdBSJ88bOfz7RNdGN48/3uZkaGs9fSGrdvF3qaW2bkLq15cI9C05EmgR9vbvRF7bGr2pj PCgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains namespace updates. This time specifically for nsfs:

- Userspace heavily relies on the root inode numbers for namespaces to
  identify the initial namespaces. That's already a hard dependency. So
  we cannot change that anymore. Move the initial inode numbers to a
  public header and align the only two namespaces that currently don't
  do that with all the other namespaces.

- The root inode of /proc having a fixed inode number has been part of
  the core kernel ABI since its inception, and recently some userspace
  programs (mainly container runtimes) have started to explicitly depend
  on this behaviour.

  The main reason this is useful to userspace is that by checking that a
  suspect /proc handle has fstype PROC_SUPER_MAGIC and is
  PROCFS_ROOT_INO, they can then use
  openat2(RESOLVE_{NO_{XDEV,MAGICLINK},BENEATH}) to ensure that there
  isn't a bind-mount that replaces some procfs file with a different
  one. This kind of attack has lead to security issues in container
  runtimes in the past (such as CVE-2019-19921) and libraries like
  libpathrs[1] use this feature of procfs to provide safe procfs
  handling functions.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.nsfs

for you to fetch changes up to 76fdb7eb4e1c91086ce9c3db6972c2ed48c96afb:

  uapi: export PROCFS_ROOT_INO (2025-07-10 09:39:18 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.nsfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.nsfs

----------------------------------------------------------------
Aleksa Sarai (1):
      uapi: export PROCFS_ROOT_INO

Christian Brauner (4):
      nsfs: move root inode number to uapi
      netns: use stable inode number for initial mount ns
      mntns: use stable inode number for initial mount ns
      Merge patch series "nsfs: expose the stable inode numbers in a public header"

 fs/namespace.c            |  4 +++-
 fs/proc/root.c            | 10 +++++-----
 include/linux/proc_ns.h   | 16 +++++++++-------
 include/uapi/linux/fs.h   | 11 +++++++++++
 include/uapi/linux/nsfs.h | 11 +++++++++++
 net/core/net_namespace.c  |  8 ++++++++
 6 files changed, 47 insertions(+), 13 deletions(-)

