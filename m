Return-Path: <linux-fsdevel+bounces-39583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6ECA15D18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 14:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDB4166372
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 13:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ADB18C00B;
	Sat, 18 Jan 2025 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko6wiFBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006AEA95C;
	Sat, 18 Jan 2025 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737205428; cv=none; b=VyiQ2qDetDeaOErMxbxxFgRRFtsNh98KltdDf9Lo6mm0KhMM5q9J+4kGHNdiJwAc31Dap2ekIEzGhJhbRFWIrdONYJ8JRqYn9hIFOg07Cu3KcYs0JGn2SB+UU2VDNvaxBzifDlOzlqsmGbMdgq6DQt3GRHbll90QsDMSPy/Be1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737205428; c=relaxed/simple;
	bh=cDHojD1GVaAYB7nwWScX/ybK2GZPcod2nki3UGpJ6DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSA8JwNVU+B+sVu8nWGbDAzgsk9H/Ynzc79IWcaRTRKVSh6jOJmMPzHt5qf8CMKLOAjS9PnTfubzmrpoWUmpfO57wdjNhR41/RwaLS2JKKjc16KRz5Xowsx6YwaBOJ0OzxSnyPGgxrARGAi73+Fp5ebvZW/3ycxi4PKCRk8/cGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko6wiFBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C671C4CED1;
	Sat, 18 Jan 2025 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737205427;
	bh=cDHojD1GVaAYB7nwWScX/ybK2GZPcod2nki3UGpJ6DE=;
	h=From:To:Cc:Subject:Date:From;
	b=ko6wiFBQH/G1gd7he1rN/6tAbR7iWuvNjq8VSvlxHi8eBvHrJjzszUuFY4zQA0RNX
	 XkloUxEZDd3lp3NosCudw54IA88fufTcEM9cqJhDEhg7CQzJEFj8yg+rOjqP2Faifi
	 dvv9AVvYJP1lisnYwl/fwojn9BjlK4ErLaDPKRrxi/gjHiiNgCfo6BDHyqjm/t1guu
	 Z+lKvKwwVx8pdWn2aA9aMDXgUr0jZydOULRGScKdpmpBcalwyyu88qDGqGYpiEkXyJ
	 zIrpOLcxzt1MR6ni/LN9RYLMRBN0zRbe3DLMXvTbj/vUO/oxDRfafE4/Tt/YG+mQBD
	 oytpnbeFLnXXg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] cred
Date: Sat, 18 Jan 2025 14:03:33 +0100
Message-ID: <20250118-kernel-cred-bfe8c6c428d4@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4292; i=brauner@kernel.org; h=from:subject:message-id; bh=cDHojD1GVaAYB7nwWScX/ybK2GZPcod2nki3UGpJ6DE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR3L1uRsXmhvKvU/oTPUy1dD3EWnfrSaXdaTvrFk5l1Y WtMhVO1O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCZMLwh+f+Yc01hbYNrz/J 2+yv2Cn276bl1Yoi47mZn89+v5y37QMjw+zltbarNr9bP9u+fzd/EvdZ/cgTm7z6HwSl3uVazvX wNy8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

For the v6.13 cycle we switched overlayfs to a variant of
override_creds() that doesn't take an extra reference. To this end the
{override,revert}_creds_light() helpers were introduced.

This series generalizes the idea behind {override,revert}_creds_light()
to the {override,revert}_creds() helpers. Afterwards overriding and
reverting credentials is reference count free unless the caller
explicitly takes a reference. All caller's have been appropriately ported.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

[1] linux-next: manual merge of the vfs-brauner tree with the nfs-anna tree
    https://lore.kernel.org/linux-next/20250109084503.1e046ef7@canb.auug.org.au

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.14-rc1.cred

for you to fetch changes up to a6babf4cbeaaa1c97a205382cdc958571f668ea8:

  cred: fold get_new_cred_many() into get_cred_many() (2024-12-02 11:25:15 +0100)

Please consider pulling these changes from the signed kernel-6.14-rc1.cred tag.

Thanks!
Christian

----------------------------------------------------------------
kernel-6.14-rc1.cred

----------------------------------------------------------------
Christian Brauner (31):
      tree-wide: s/override_creds()/override_creds_light(get_new_cred())/g
      cred: return old creds from revert_creds_light()
      tree-wide: s/revert_creds()/put_cred(revert_creds_light())/g
      cred: remove old {override,revert}_creds() helpers
      tree-wide: s/override_creds_light()/override_creds()/g
      tree-wide: s/revert_creds_light()/revert_creds()/g
      firmware: avoid pointless reference count bump
      sev-dev: avoid pointless cred reference count bump
      target_core_configfs: avoid pointless cred reference count bump
      aio: avoid pointless cred reference count bump
      binfmt_misc: avoid pointless cred reference count bump
      coredump: avoid pointless cred reference count bump
      nfs/localio: avoid pointless cred reference count bumps
      nfs/nfs4idmap: avoid pointless reference count bump
      nfs/nfs4recover: avoid pointless cred reference count bump
      nfsfh: avoid pointless cred reference count bump
      open: avoid pointless cred reference count bump
      ovl: avoid pointless cred reference count bump
      cifs: avoid pointless cred reference count bump
      cifs: avoid pointless cred reference count bump
      smb: avoid pointless cred reference count bump
      io_uring: avoid pointless cred reference count bump
      acct: avoid pointless reference count bump
      cgroup: avoid pointless cred reference count bump
      trace: avoid pointless cred reference count bump
      dns_resolver: avoid pointless cred reference count bump
      cachefiles: avoid pointless cred reference count bump
      nfsd: avoid pointless cred reference count bump
      cred: remove unused get_new_cred()
      Merge patch series "cred: rework {override,revert}_creds()"
      cred: fold get_new_cred_many() into get_cred_many()

 Documentation/security/credentials.rst |  5 ----
 drivers/crypto/ccp/sev-dev.c           |  2 +-
 fs/backing-file.c                      | 20 +++++++-------
 fs/nfsd/auth.c                         |  3 +-
 fs/nfsd/filecache.c                    |  2 +-
 fs/nfsd/nfs4recover.c                  |  3 +-
 fs/nfsd/nfsfh.c                        |  1 -
 fs/open.c                              | 11 ++------
 fs/overlayfs/dir.c                     |  4 +--
 fs/overlayfs/util.c                    |  4 +--
 fs/smb/server/smb_common.c             | 10 ++-----
 include/linux/cred.h                   | 43 +++++------------------------
 kernel/cred.c                          | 50 ----------------------------------
 13 files changed, 29 insertions(+), 129 deletions(-)

