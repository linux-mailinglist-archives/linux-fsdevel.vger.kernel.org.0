Return-Path: <linux-fsdevel+bounces-56031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC53B11D96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6916AE30F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0562EE5E4;
	Fri, 25 Jul 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUPSMAAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B52EE28C;
	Fri, 25 Jul 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442870; cv=none; b=m9JzjXwfjhe//AwUjxgAErrv0xLPUrlNgyW1xp5ihMQFH421yI8bXSRaIc+pG8VDRw/1lbbsRrKnY4dWO54UJcwDwCw4lIsa9RO9lvtSPJDUw3CpQY6XQRflASelUorMCZ62Q9I/txVPIqMFtQNHW0treXOfSyn8na014wSn09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442870; c=relaxed/simple;
	bh=gmgShYOUJMx+lHklkv/0mq6mB6Wc4V9fGH//hBxdlRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry03PZz/hlc0Xy8ediTfeawurKDwZFS6dDtQaoPofNnCV/irlZZwo9nNoxtiOc8l8CG99snzZINLixla3l6m4xSCaJ3bNmz2mRti5ZhTUbQK8N63c/Lrpor/gFTMpez7fqtekoVO9dyNhw3Y1X8hUU8jHx9wShyllh0zhEZaWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUPSMAAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8298C4CEE7;
	Fri, 25 Jul 2025 11:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442869;
	bh=gmgShYOUJMx+lHklkv/0mq6mB6Wc4V9fGH//hBxdlRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUPSMAAuvN1wq2m1osj9qOWfOi7U1Bat7qYHCF98ECbCcT6bueUHM4SdduMoucRja
	 KJFjaeVB+GIg7+9zMrU4hzGi9UlKvkMFr3/uSKnnDjTCDUden3y0bhh23MWB7Z6jT5
	 /vxm7R4Np2Alhkr0Jjba5A45pZi7bgrWAy6al1zBEaVr3+U2qczNdmSnef0eQM8djP
	 OeGG4dkzhLrXU4lBU2tIIVON77KS5HCeJX8XMJJUPpfv1R6HN6SLKzdnrl+DPeuc6M
	 aZfPu6zv1c/FmNKi1AoHCrNi3ui6VTZtHAt/4WIEX62hhAUphn0xj9G2uFLez8irSd
	 jVEz6+gCL1JRA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 10/14 for v6.17] vfs rust
Date: Fri, 25 Jul 2025 13:27:26 +0200
Message-ID: <20250725-vfs-rust-e01200cf7428@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=brauner@kernel.org; h=from:subject:message-id; bh=gmgShYOUJMx+lHklkv/0mq6mB6Wc4V9fGH//hBxdlRE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4k7JG95UqL3dcL555nMBeH9i9rzWHifCCj9a73Io f1pXVt4RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESOXGf4H5nAf3PJUmOu3YdK T+rdkZy/2emK3/HnN+acPlkT/Z9lWjzD/5BAeyH/9bHTFwgYX1R5lbCIZ11b/U6B6/a2ZzhmOmj s4gAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains vfs rust updates for this cycle:

- Allow poll_table pointers to be NULL.

- Add Rust files to vfs MAINTAINERS entry.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.rust

for you to fetch changes up to 3ccc82e31d6a66600f14f6622a944f580b04da43:

  vfs: add Rust files to MAINTAINERS (2025-07-15 11:50:15 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.rust tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.rust

----------------------------------------------------------------
Alice Ryhl (2):
      poll: rust: allow poll_table ptrs to be null
      vfs: add Rust files to MAINTAINERS

 MAINTAINERS              |  4 +++
 rust/helpers/helpers.c   |  1 +
 rust/helpers/poll.c      | 10 +++++++
 rust/kernel/sync/poll.rs | 68 ++++++++++++++++++------------------------------
 4 files changed, 41 insertions(+), 42 deletions(-)
 create mode 100644 rust/helpers/poll.c

