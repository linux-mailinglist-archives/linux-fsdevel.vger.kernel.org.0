Return-Path: <linux-fsdevel+bounces-29332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF89782CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 16:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962B21F215AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6118C3D966;
	Fri, 13 Sep 2024 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/mYaPBw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE70639FCF;
	Fri, 13 Sep 2024 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238541; cv=none; b=OofLHpEMy8ZF7VGOte9Rp1dKY9FhG+n6NfpVijwrXx6bpp4JfVb0WFzQ5mb354t6mfnRcYfBZkCkhcaMGgXSuaBpNAtks+82qtpwXTvH6qDsnzAh4YrJqHxzaIB09dymOFLovKrDQ18ukHiRH2L4VQsTzXZCzArcvlj8xeBg4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238541; c=relaxed/simple;
	bh=8yB6wiIlyPSVlBf4rJCJJhvxljsZBL+jUgEgkzGOIio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcEKycVsBwM7yvl0CS2RMco0mGxMwvWPEIdPKd+cG1F1MyAroD7DTF28tpRXJVlPJzGk2Y4Hssq+wW0nYe1XGWHOEsoEwTKfLAen1nCKp48w8NQSuq0MVGpybAyCuYDMx9HqEeEfzZpzl1SqLWP9XR1aqWWa7ATg7NVxzPYmQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/mYaPBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421F4C4CEC0;
	Fri, 13 Sep 2024 14:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726238541;
	bh=8yB6wiIlyPSVlBf4rJCJJhvxljsZBL+jUgEgkzGOIio=;
	h=From:To:Cc:Subject:Date:From;
	b=b/mYaPBwbyDstmt/s5IgMu/7Xr9o85dPOOjfi+1Q/tjXo2zqzxtOjWx9buJptOU2k
	 8e/1/Bi++t0JO+87inhLUXhrlmg1zSGyC0Zrt62TEdmcNlj/UVPZ3CRYicg/1I60VR
	 RwrMfkLIaw3Iqi2671J7Tj2R1Te4RUgAHuZvBhJiNhllHx+jjpchuURA+Nsd988IIM
	 2KHRT5ecBjxT9GvTZPWYBG3ljC+dbUZaLLmw4CLZxwd9+9Xe3eyQ0B5O6elqx5NzbG
	 axATpkZbCl2gVcMLSd8ZzfcBhHlt5vn2dmlxgtS8jWXEDIpcRWgsSrubnTVLmmcP2+
	 XuD8p2qeqa9XQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs mount
Date: Fri, 13 Sep 2024 16:41:58 +0200
Message-ID: <20240913-vfs-mount-ff71ba96c312@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3702; i=brauner@kernel.org; h=from:subject:message-id; bh=8yB6wiIlyPSVlBf4rJCJJhvxljsZBL+jUgEgkzGOIio=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ98XcymbR0etTenx1adoyXp5/ZPVPFpSNx/ar8oN3Me 2cc3OS7uKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiZT6MDAdqbDbf2Mr55HLp 7/1nF/Xle2sdLRYLDVpp38j/h5FpkRjDf8csxuSLunKatiLFufGsszi4WSO59z4v3GgyRUCs/tE ZHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Recently, we added the ability to list mounts in other mount namespaces
and the ability to retrieve namespace file descriptors without having to
go through procfs by deriving them from pidfds.

This extends nsfs in two ways:

(1) Add the ability to retrieve information about a mount namespace via
    NS_MNT_GET_INFO. This will return the mount namespace id and the
    number of mounts currently in the mount namespace. The number of
    mounts can be used to size the buffer that needs to be used for
    listmount() and is in general useful without having to actually
    iterate through all the mounts.

    The structure is extensible.

(2) Add the ability to iterate through all mount namespaces over which
    the caller holds privilege returning the file descriptor for the
    next or previous mount namespace.

    To retrieve a mount namespace the caller must be privileged wrt to
    it's owning user namespace. This means that PID 1 on the host can
    list all mounts in all mount namespaces or that a container can list
    all mounts of its nested containers.

    Optionally pass a structure for NS_MNT_GET_INFO with
    NS_MNT_GET_{PREV,NEXT} to retrieve information about the mount
    namespace in one go.

(1) and (2) can be implemented for other namespace types easily.

Together with recent api additions this means one can iterate through
all mounts in all mount namespaces without ever touching procfs. The
merge message contains example code how to do this.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-3)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.11-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

(1) linux-next: build failure after merge of the bpf-next tree
    https://lore.kernel.org/r/20240913133240.066ae790@canb.auug.org.au

    The reported merge conflict isn't really with bpf-next but with the
    series to convert to fd_file() accessors for the changed struct fd
    representation.

    The patch you need to fix this however is correct in that draft. But
    honestly, it's pretty easy for you to figure out on your own anyway.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.mount

for you to fetch changes up to 49224a345c488a0e176f193a60a2a76e82349e3e:

  Merge patch series "nsfs: iterate through mount namespaces" (2024-08-09 12:47:05 +0200)

Please consider pulling these changes from the signed vfs-6.12.mount tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12.mount

----------------------------------------------------------------
Christian Brauner (5):
      fs: allow mount namespace fd
      fs: add put_mnt_ns() cleanup helper
      file: add fput() cleanup helper
      nsfs: iterate through mount namespaces
      Merge patch series "nsfs: iterate through mount namespaces"

 fs/mount.h                    |  13 ++++++
 fs/namespace.c                |  74 +++++++++++++++++++++++++-----
 fs/nsfs.c                     | 102 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/file.h          |   2 +
 include/linux/mnt_namespace.h |   4 ++
 include/uapi/linux/nsfs.h     |  16 +++++++
 6 files changed, 198 insertions(+), 13 deletions(-)

