Return-Path: <linux-fsdevel+bounces-35892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D369D961B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 389B1B27491
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 11:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0961CEAC3;
	Tue, 26 Nov 2024 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajFXKJcn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA11B413C;
	Tue, 26 Nov 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732619985; cv=none; b=JfsZVq8pPhXGAGMHBLSca8ljpwUbEfsPUv78F7P952PoVuULptKNIwgfzMedu4DOg9DQRPNaSE4PdFVd05uRFiovWOlqhVWgpohfqMaX/OGXzbLQFB+Z9d18SpBnQU7eCg3IS6dQ3hIuLOJf7vJtF6DR91AFnAlnMdYXUtcPXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732619985; c=relaxed/simple;
	bh=NffSGB0/3jaoI6CiPUrqqm3Y5XXiaQ/3NQ71HIuAceQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZKFpAQZ0JVeEhFc4+glqIbsoQUG/pXAj2MqnadMAZiGFnY62rWU4u3KO6Lout7OpVYa1zIxfLum/6yeWPq/tK0mWN9DLVUmQIAYjq6KRGEHmSL+7RArdizQGZoZf8SCQDktyn6OcG793eFg1cPO5tJsbG5ouOZBH3kcaYdSfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajFXKJcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098F5C4CECF;
	Tue, 26 Nov 2024 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732619984;
	bh=NffSGB0/3jaoI6CiPUrqqm3Y5XXiaQ/3NQ71HIuAceQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ajFXKJcndLvUDBvo0ANrXdPe13/D4NGrnWWkvG7xKVHlqaI61i39aKkdU8usIYiJV
	 g5SFrhH5cJFe9X6jlNKq84wOEJIYozpipGKYWkGkb1YL5f8w6y1LhjHno2ssQmW7pj
	 +gJqE0mmL97i8Eq9hlP/eVI73hBY7rsRXRpV9SJ24ENYyWKuq8YA+IPllBNYsfhtBU
	 JfyjiFr3wNjnvLMq7hMOcmi5lUbL47NPKBIyLjfmKUx1+dzk0SpPUPi4F8/7AMhp+h
	 hlxwSZyvHThvWUNOqhhEQh1SpmjccMvxNd1Xpp6Xb2nD9mIYJIbIo40kiamEcAYhkU
	 azjSSSMjfuONQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs exportfs
Date: Tue, 26 Nov 2024 12:19:34 +0100
Message-ID: <20241126-vfs-exportfs-e57e12e4b3cf@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2231; i=brauner@kernel.org; h=from:subject:message-id; bh=NffSGB0/3jaoI6CiPUrqqm3Y5XXiaQ/3NQ71HIuAceQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7rjtRe1qicc1dplORr8reCph05DkId+yRzTr/8bfYs SuWzhVfO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZi+5Lhr4DOwpVtte/vxT0N TFT5Y3aDadLHjr4w2XmpTbnbsqQNtRn+p+3i+Xb682TGo5/nTuZnX/ed76iG4yrduWlzFofbLjB 8zAsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains work to bring NFS connectable file handles to userspace
servers.

The name_to_handle_at() system call is extended to encode connectable
file handles. Such file handles can be resolved to an open file with a
connected path. So far userspace NFS servers couldn't make use of this
functionality even though the kernel does already support it. This is
achieved by introducing a new flag for name_to_handle_at().

Similarly, the open_by_handle_at() system call is tought to understand
connectable file handles explicitly created via name_to_handle_at().

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc3 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.exportfs

for you to fetch changes up to a312c10c0186b3fa6e6f9d4ca696913372804fae:

  Merge patch series "API for exporting connectable file handles to userspace" (2024-11-15 11:35:16 +0100)

----------------------------------------------------------------
vfs-6.13.exportfs

----------------------------------------------------------------
Amir Goldstein (3):
      fs: prepare for "explicit connectable" file handles
      fs: name_to_handle_at() support for "explicit connectable" file handles
      fs: open_by_handle_at() support for decoding "explicit connectable" file handles

Christian Brauner (1):
      Merge patch series "API for exporting connectable file handles to userspace"

 fs/exportfs/expfs.c        | 17 +++++++++--
 fs/fhandle.c               | 75 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/exportfs.h   | 13 ++++++++
 include/uapi/linux/fcntl.h |  1 +
 4 files changed, 98 insertions(+), 8 deletions(-)

