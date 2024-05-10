Return-Path: <linux-fsdevel+bounces-19270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874128C23DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8F51F2647B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDE516EC0C;
	Fri, 10 May 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiwcS3bA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C716EC06;
	Fri, 10 May 2024 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341653; cv=none; b=TAFMwtKZouD/O1IDHG6A2No+GVdgos1qkrPWdSVhXsnB4sWwatsaMjrhvaDApzDzd16XW21YtATDAv7ZfNv7dkhtMRMI8+YO5WvMcHgUEOmFNkYPmQNemsq2NJD14AbvYjxgUDUV78kSmnImW1CkGlkMsrNGxG2Co2eW05+qeIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341653; c=relaxed/simple;
	bh=Oyej1uFTgoe8KBmoJe2HNl27X7MRY9hio+5gYNggqqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T5CvYomOb6WFrG1wYzFWvPbcaNNJJH8N1HA8Qpe/vQht4P34d/yQIi8z49n7VxaZE0oJbGMLBb+wnampHaF5SGOkQAKvR4MrluJuIWAk284FoPE2LVAgmgRgShPe4/lbvoV9WQ5bhpLdeUhDjjHABVyJ6cWBv7wLIQuoAHSIK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiwcS3bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB95C2BD11;
	Fri, 10 May 2024 11:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715341652;
	bh=Oyej1uFTgoe8KBmoJe2HNl27X7MRY9hio+5gYNggqqM=;
	h=From:To:Cc:Subject:Date:From;
	b=oiwcS3bA8m6K1xyYg0jpRnIqUNrsGaYn8ALoMxw90meKXyDo+uXnuvI8UrjmNS70M
	 0eMdte84SETJwlOhB2+LoQ/eY5zv+d4evERjaIQmOI/AbRMxsajmd1iev2F/riQ7Mf
	 haAI2ff9RNqBVvIErNlkJDwT+uowf/PcVMG+3fYn6VWbnW/DGrXskLmvyuglqraHvo
	 d7F6dFob5hAkddpMduUJAcihMXk5yYQmh4HDZ2LjS2rJbduVYiGPX3XaW2mu6LtcON
	 rTTY4ls5a0LcMr+tsrc29X+yO5ydR/i5OByr66b6inBzQ9I5adGGD7+aoAuLHGTwVL
	 xiPIEh6Pp2USA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs rw
Date: Fri, 10 May 2024 13:47:17 +0200
Message-ID: <20240510-vfs-rw-332f4a8e1772@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104; i=brauner@kernel.org; h=from:subject:message-id; bh=Oyej1uFTgoe8KBmoJe2HNl27X7MRY9hio+5gYNggqqM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTZcbpus9ZVPPd9jdNDnTlhExtFLl/oW8NzLU+Cy9l16 RVZQaugjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlEz2f4w/9CdF/Eh9gTD9VW tkr/PNRpa5ry47RYlvAyR4HUq7LTexgZ2i6s/J0yU/XKmjvaofFHe7jNmrrX/pwfYHpKYbP5KVU nZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
The core fs signalfd, userfaultfd, and timerfd subsystems did still use
f_op->read() instead of f_op->read_iter(). Convert them over since we
should aim to get rid of f_op->read() at some point.

Aside from that io_uring and others want to mark files as FMODE_NOWAIT
so it can make use of per-IO nonblocking hints to enable more efficient
IO. Converting those users to f_op->read_iter() allows them to be marked
with FMODE_NOWAIT.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.9-rc3 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

No known conflicts.

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.rw

for you to fetch changes up to 3a93daea2fb27fcefa85662654ba583a5d0c7231:

  Merge branch 'read_iter' of git://git.kernel.dk/linux (2024-04-11 10:06:08 +0200)

Please consider pulling these changes from the signed vfs-6.10.rw tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.10.rw

----------------------------------------------------------------
Al Viro (1):
      new helper: copy_to_iter_full()

Christian Brauner (1):
      Merge branch 'read_iter' of git://git.kernel.dk/linux

Jens Axboe (4):
      Merge branch 'work.iov_iter' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs into read_iter
      timerfd: convert to ->read_iter()
      userfaultfd: convert to ->read_iter()
      signalfd: convert to ->read_iter()

 fs/signalfd.c       | 44 ++++++++++++++++++++++++++++----------------
 fs/timerfd.c        | 36 ++++++++++++++++++++++++++----------
 fs/userfaultfd.c    | 44 ++++++++++++++++++++++++++++----------------
 include/linux/uio.h | 10 ++++++++++
 include/net/udp.h   |  9 +--------
 5 files changed, 93 insertions(+), 50 deletions(-)

