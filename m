Return-Path: <linux-fsdevel+bounces-44771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD610A6C913
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2828E188CA55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF7E1F7919;
	Sat, 22 Mar 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzIqw4QP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B71F5438;
	Sat, 22 Mar 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638540; cv=none; b=MRldh/hXSzUJsoL8/YBFsuF+FKGXyTQ3ecQjzUB20PqS/V2AG5Xzq9JO2M0dDOSvsoOt7tDZg5t5oVaFDX4lGzmqaJUeUaZbLjaww65o3sZhxPgQox01WI9q0CkHvYVR4q//fP3+OTJUEq4NthHgNK0RdmQRMS7bCoqOk/FVOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638540; c=relaxed/simple;
	bh=2mRXse8SzmewVgr5DOOLsPV3GMSJEE3+1tVaE83kFsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfS8j2/mWJkhR4Xa3vx9y2BWkAu21yKXTSkFS/Sfv+vJ+vYchuqQs3xzH14n4dubctMUdPSZ7QZQa4Eh4AhWDC89ki/NeW6Rbq9+0NM0b0iBWqwVm7P5NQbkdWskNnGURvh9tA6enpT2CxuKxMPsH6Yvdo7vv5jhTOeMVteQB/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzIqw4QP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F70C4CEDD;
	Sat, 22 Mar 2025 10:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638540;
	bh=2mRXse8SzmewVgr5DOOLsPV3GMSJEE3+1tVaE83kFsY=;
	h=From:To:Cc:Subject:Date:From;
	b=jzIqw4QPmdbp1Wb79Xm9em8PqAh7fTU1AD2/8hjV1FFAyoDUWFn7A+s68gKhHQUNi
	 vRy09AnjIDZU6/Xgm+0CnOip3lK3wgKLG5Kwx0BnWsQ5JY7WUdn4MSNOrhvkh/Aj8Y
	 zgw9m5vRLdOUGMIIqZrc0vudfqjS/NTBHJafIs+wDsOVeEZ1ONqOrDpDUi+JogzjxN
	 cDAI8zJ4eTX3my4n3AiOWtfg5sqEqY0h4HkOFFKZKZJA9G6H5HDF9Dcmd/fwIuUpTA
	 48UrBtpZKd1+uqyIO/Z0tswPle6jdfzAnExWZeSaukJI1b8SyZru9c9nar8VRAZKBd
	 IcSDBDPR+rz8w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs nsfs
Date: Sat, 22 Mar 2025 11:15:32 +0100
Message-ID: <20250322-vfs-nsfs-76eda2ef1600@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1557; i=brauner@kernel.org; h=from:subject:message-id; bh=2mRXse8SzmewVgr5DOOLsPV3GMSJEE3+1tVaE83kFsY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf6z06b734t5C5x97Mby+ROKvZ4u/Mk7Wvrf20cJx8l m7m+5jqjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl0mTAynBT+qaEquXOXyrnS ojW8abKa3oenpy79yvqm/fjL2sdOwowM95k2v0u/7sK3/vlaz8rTl5xTpwcu39fP8KeCI4PPLUS VHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains non-urgent fixes for nsfs to validate ioctls before
performing any relevant operations. We alredy did this for a few other
filesystems last cycle.

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

No known conflicts.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.nsfs

for you to fetch changes up to 58c6cbd97cd51738cb231940c00519dd2b7ace2d:

  Merge patch series "nsfs: validate ioctls" (2025-02-20 09:13:57 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.nsfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.nsfs

----------------------------------------------------------------
Christian Brauner (3):
      nsfs: validate ioctls
      selftests/nsfs: add ioctl validation tests
      Merge patch series "nsfs: validate ioctls"

 fs/nsfs.c                                          | 32 +++++++++++++++++++++-
 .../selftests/filesystems/nsfs/iterate_mntns.c     | 14 ++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

