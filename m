Return-Path: <linux-fsdevel+bounces-62881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32AEBA4187
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9D37A25C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE751DDC0B;
	Fri, 26 Sep 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw8SpYll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830D34BA4D;
	Fri, 26 Sep 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896347; cv=none; b=Kl3C3nXQ/CLSWrIXgqx/MSShXRAP3la2im0xmrcMUE+hDPw36GXbaVWQMdV3gtgh/SgC8Vg8qaWNR5ogmKZrq7MkwA/g3tsX9RGKeK7pOBESRnr8k7QtO0RwGPkYe+GrWhGqwZ5jAlhYzUCHN4a4w19QioZgY1sxJ+Qp3GqEeTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896347; c=relaxed/simple;
	bh=qzTwg2HoHU3hwf3rVuy8SQVfWxkZoVuJxLauK3ugXMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxAwk5fB1PthTf7BUtO9Ifyr7STXqIU/ylNnVxEfCjoBG+V2g47R72KniqRLs/BdLWv39LEpW+DfTa2OhUqPtNFA6I33hX259CjysGeGCxny/LbIcMi8POwXksJjBMxni9DfasrKY6bTZGh5fBKVKy5d1yhQdKAZjLVzZwvUeEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw8SpYll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D921C4CEF4;
	Fri, 26 Sep 2025 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896347;
	bh=qzTwg2HoHU3hwf3rVuy8SQVfWxkZoVuJxLauK3ugXMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bw8SpYll5VXBbD88Z9FbmK9wMyxnp7+XZY06QkJ6htaOCQdAPy3kZ5kxfOrfBaUKb
	 HYcw2x+SGEluZqIjF1QL/VDfKE3IDMM65xQA1++jdH4grQOqzbKSzzela5bxmuwpft
	 z6jNlJc/v+smaex27tWezcfROVOjo6eeFhB+OL4HSGJQ0Bt17bRb08vrRkO5prFM5x
	 Va2vXu9OplT+kvY00rp27WvQbLr4DghshaJljUIqMMFaycy/j8qjkLGSVqIsAnmqwH
	 J29iyS5VvKZkQHhurLHCSJvhJXsdH5+xOUr7wAoJiAqQb6FxA2GxqkqjM6VpPauK39
	 ZCghkMW8lzQvw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 02/12 for v6.18] mount
Date: Fri, 26 Sep 2025 16:18:56 +0200
Message-ID: <20250926-vfs-mount-743c2ca07c6b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926-vfs-618-e880cf3b910f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3598; i=brauner@kernel.org; h=from:subject:message-id; bh=qzTwg2HoHU3hwf3rVuy8SQVfWxkZoVuJxLauK3ugXMI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3A+dtHNCU+bIw4s3PMnV+KmEZfCzzCR67ObinRrH vRdUrye2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRmiCG//W2/9/m77N8zv/5 uO2+aR17Kl1Wn70uMvvOpiPSqdssfS8w/A/ckGjKe7g3ZoX+mkUHMrZZifuzCGbPXt4zb++j+2y pXcwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains some work around mount api handling:

* Output the warning message for mnt_too_revealing() triggered during
  fsmount() to the fscontext log. This makes it possible for the mount
  tool to output appropriate warnings on the command line. For example,
  with the newest fsopen()-based mount(8) from util-linux, the error
  messages now look like:

  # mount -t proc proc /tmp
  mount: /tmp: fsmount() failed: VFS: Mount too revealing.
         dmesg(1) may have more information after failed mount system call.

* Do not consume fscontext log entries when returning -EMSGSIZE

  Userspace generally expects APIs that return -EMSGSIZE to allow for
  them to adjust their buffer size and retry the operation. However, the
  fscontext log would previously clear the message even in the -EMSGSIZE
  case.

  Given that it is very cheap for us to check whether the buffer is too
  small before we remove the message from the ring buffer, let's just do
  that instead.

* Drop an unused argument from do_remount().

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

[1] https://lore.kernel.org/linux-next/aNO0BKAXphoFEgUk@finisterre.sirena.org.uk

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.mount

for you to fetch changes up to 1e5f0fb41fccf5ecbb5506551790335c9578e320:

  vfs: fs/namespace.c: remove ms_flags argument from do_remount (2025-08-11 16:08:31 +0200)

Please consider pulling these changes from the signed vfs-6.18-rc1.mount tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc1.mount

----------------------------------------------------------------
Aleksa Sarai (4):
      fscontext: add custom-prefix log helpers
      vfs: output mount_too_revealing() errors to fscontext
      fscontext: do not consume log entries when returning -EMSGSIZE
      selftests/filesystems: add basic fscontext log tests

Askar Safin (1):
      vfs: fs/namespace.c: remove ms_flags argument from do_remount

Christian Brauner (3):
      Merge patch series "fs: Remove old mount API helpers"
      Merge patch series "vfs: output mount_too_revealing() errors to fscontext"
      Merge patch series "fscontext: do not consume log entries when returning -EMSGSIZE"

Pedro Falcato (3):
      fs: Remove mount_nodev
      fs: Remove mount_bdev
      docs/vfs: Remove mentions to the old mount API helpers

 Documentation/filesystems/vfs.rst              |  27 +----
 fs/fsopen.c                                    |  70 +++++++------
 fs/namespace.c                                 |  10 +-
 fs/super.c                                     |  63 ------------
 include/linux/fs.h                             |   6 --
 include/linux/fs_context.h                     |  18 +++-
 tools/testing/selftests/filesystems/.gitignore |   1 +
 tools/testing/selftests/filesystems/Makefile   |   2 +-
 tools/testing/selftests/filesystems/fclog.c    | 130 +++++++++++++++++++++++++
 9 files changed, 192 insertions(+), 135 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fclog.c

