Return-Path: <linux-fsdevel+bounces-39579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3958FA15D09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 13:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD42166430
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6FE18B470;
	Sat, 18 Jan 2025 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n699ELFt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22804163;
	Sat, 18 Jan 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737205064; cv=none; b=HmSCRJCJZO1DjtuJNXnbkEEWat0Sz6Kh3kouINsAFYek0UczeT8O4xq86u+okohTvmy/sRLNnxnE0xuXzhDzXG5mx1rwdFAV2Hn0XNTv14Q3w04VBNQXACtPhMFH79BIphx3/EgqsMNloVa80FGr8zw/NKpvGKRI3J+QivtQWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737205064; c=relaxed/simple;
	bh=QDFTzYgr3YRgq2Z1c6mZY2gOrrZalY/q0QetevVSPFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxTXPbKm612IkhKFbgluhZGJ5bKKHuhcEsxwzGXz3o14G9vhLN4a6bNBsSOqNuUMlTSh98UiVeZCmn0TN/0rLf8NQ/dylRokMJD+VQ6marBiu2k69GkX6d9MdGwYC80BufqJeTXMenY6Kz/VMu6OCfELSOqelA7wK440JkbY4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n699ELFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5B9C4CED1;
	Sat, 18 Jan 2025 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737205063;
	bh=QDFTzYgr3YRgq2Z1c6mZY2gOrrZalY/q0QetevVSPFo=;
	h=From:To:Cc:Subject:Date:From;
	b=n699ELFtjFjzNLnf7E/RwHmv5xUu1xhOKG8wfFdZFneC/1am58Nxmu4Rds72aro2B
	 egZalkjLpibh/H/BelDbLBhk5n8KUjjVwXbiUy4UODoZ1kOyNM0o3v08yGLYwa+rNs
	 SexSHW/pFklqwFcyEd3JBw/Hfn1GED7MevovHTUj+ZkbwwYanKy/7UQqJm2E80eg1w
	 OY/6iDNoKGOIPoeh/Gxlq6vFpIZ6vZbTkIEiKvWBTrHVS9eeFE0Zy5U6pb0LOB2BI0
	 /g6AdzZyVtRV/gmRWyIwVPFljQReWHNHZUaN0TwZwCis4AvWR8KMlXaRcrOR1WZwcG
	 fSw8j9tm7v41w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs kcore
Date: Sat, 18 Jan 2025 13:56:55 +0100
Message-ID: <20250118-vfs-kcore-913a66eabd03@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262; i=brauner@kernel.org; h=from:subject:message-id; bh=QDFTzYgr3YRgq2Z1c6mZY2gOrrZalY/q0QetevVSPFo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR3L3UUXD9lPuuZDbcuRE6XS2Fszc6MsPoYve/eij3fQ vmeOPPe7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI5s+MDJM+rE+4LSN8epu6 8onoJQ2hU5ZK9f1Mu+P7JPZn74UDPxoY/nBXuuZ2TDsz6XiRv6DF9etxOx14TUOiFu+0DX7L9sL dhwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

The performance of /proc/kcore reads has been showing up as a bottleneck
for the drgn debugger. drgn scripts often spend ~25% of their time in the
kernel reading from /proc/kcore.

A lot of this overhead comes from silly inefficiencies. This pull
request contains fixes for the low-hanging fruit. The fixes are all
fairly small and straightforward. The result is a 25% improvement in
read latency in micro-benchmarks (from ~235 nanoseconds to ~175) and a
15% improvement in execution time for real-world drgn scripts:

- Make /proc/kcore entry permanent.

- Avoid walking the list on every read.

- Use percpu_rw_semaphore for kclist_lock.

- Make Omar Sandoval the official maintainer for /proc/kcore.

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

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.kcore

for you to fetch changes up to 4972226d0dc48ddedf071355ca664fbf34b509c8:

  Merge patch series "proc/kcore: performance optimizations" (2024-12-02 11:21:07 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc1.kcore tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc1.kcore

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "proc/kcore: performance optimizations"

Omar Sandoval (4):
      proc/kcore: mark proc entry as permanent
      proc/kcore: don't walk list on every read
      proc/kcore: use percpu_rw_semaphore for kclist_lock
      MAINTAINERS: add me as /proc/kcore maintainer

 MAINTAINERS     |  7 +++++
 fs/proc/kcore.c | 81 +++++++++++++++++++++++++++++----------------------------
 2 files changed, 48 insertions(+), 40 deletions(-)

