Return-Path: <linux-fsdevel+bounces-79444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIoyEXiwqGmfwQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 23:21:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1408208739
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 23:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9FA6302CE91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 22:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AD5388386;
	Wed,  4 Mar 2026 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qisjdlni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844BF38642F;
	Wed,  4 Mar 2026 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662894; cv=none; b=C2gimHZQDAF1W0hmodGXR/auCQ+Je1B3m5v/V5Ju5tv2a4X/99q9zkiTBfWDiVfcFVMAF0K0UboQ4+kysSQdgiQpYIQ8C/EqBZugc2dPhlfLxX+Xsdw6i/lRY/gcHLYhgfDXq087FIrK/agAYt8C85kPveCMWYHnklY4XXUtWgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662894; c=relaxed/simple;
	bh=ccyliel1dd7g6ZKjsbHYkE57M3LqpT8n6jwQvC1Uldo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BzT783x3NH/iruMUE55gSKsAlrMLaFiP4ebQNmGRKC+pxm5VsYMYzMY9nGqYSPGRGzIO5jh/2dDWatW5vxAAEnqYh/DTAK9et/4Zy9SveiZcQMmYO7TeZk/kTuHw36Cpa5LgZQr+joIii6sdFFSBK3KgwPixIbOgdDhcg1SLGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qisjdlni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8112C2BCB1;
	Wed,  4 Mar 2026 22:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772662894;
	bh=ccyliel1dd7g6ZKjsbHYkE57M3LqpT8n6jwQvC1Uldo=;
	h=From:To:Cc:Subject:Date:From;
	b=QisjdlniFoNUdgz4gr4hzqK1GxQNN7PxZmIsf27NFWCI56aeA1Am56Qmceo2A2G79
	 Ww+iQeQGrA3s0vqPM7fz3Z5A2EquEeB3A7icrZhsDg/cAN6Azchm8ZFowbmqgPCtaE
	 8zBwZJ4+3kwzinfv8RDBX6lmouUr+EXJiDgfiveTru42nUWw9cQHooV+2iLRdExxQi
	 fxXzRoz6I7yOIDYJmIqvmDVaXqW6XvZlqARqAY2n/ERFgXarlHm/a58sXxdAOTgwxb
	 dcLP/D1egPO8NVof3W3Vh59wul3ndmtRXvuTzuuFnFHGfngDlg6jMrsz6cAyFodnnG
	 SbROz6soeOdag==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.0] vfs fixes
Date: Wed,  4 Mar 2026 23:19:50 +0100
Message-ID: <20260304-vfs-fixes-af2573b1092b@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3287; i=brauner@kernel.org; h=from:subject:message-id; bh=ccyliel1dd7g6ZKjsbHYkE57M3LqpT8n6jwQvC1Uldo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSu2BBrx7A/29+seEF1faW5UMei/YtW7v5e5BS+isNcb 1b3xCqFjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl4LWP4H/Hk1YJmz9o5FsVN 3olfd1Tcm66d2t+l7qUulPN2246YGYwMs9qNgk72+S6LX8Xkbb6x6ZMcyzItdfHIPTvmmM2W71/ OAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1408208739
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-79444-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

This contains a few fixes for this cycle:

- kthread: consolidate kthread exit paths to prevent use-after-free

- iomap: don't mark folio uptodate if read IO has bytes pending

- iomap: don't mark folio uptodate if read IO has bytes pending

- iomap: don't report direct-io retries to fserror

- ns: tighten visibility checks

- netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence

- iomap: reject delalloc mappings during writeback

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit d9d32e5bd5a4e57675f2b70ddf73c3dc5cf44fc2:

  Merge tag 'ata-7.0-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux (2026-02-25 10:41:14 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc3.fixes

for you to fetch changes up to d320f160aa5ff36cdf83c645cca52b615e866e32:

  iomap: reject delalloc mappings during writeback (2026-03-04 14:31:56 +0100)

----------------------------------------------------------------
vfs-7.0-rc3.fixes

Please consider pulling these changes from the signed vfs-7.0-rc3.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (7):
      kthread: consolidate kthread exit paths to prevent use-after-free
      nsfs: tighten permission checks for ns iteration ioctls
      nsfs: tighten permission checks for handle opening
      nstree: tighten permission checks for listing
      selftests: fix mntns iteration selftests
      Merge patch series "tighten nstree visibility checks"
      Merge patch "iomap: don't mark folio uptodate if read IO has bytes pending"

Darrick J. Wong (2):
      iomap: don't report direct-io retries to fserror
      iomap: reject delalloc mappings during writeback

David Howells (1):
      netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence

Joanne Koong (1):
      iomap: don't mark folio uptodate if read IO has bytes pending

 fs/iomap/buffered-io.c                             |  15 +-
 fs/iomap/direct-io.c                               |  15 +-
 fs/iomap/ioend.c                                   |  13 +-
 fs/netfs/direct_write.c                            | 228 +++++++++++++++++++--
 fs/netfs/internal.h                                |   4 +-
 fs/netfs/write_collect.c                           |  21 --
 fs/netfs/write_issue.c                             |  41 +---
 fs/nsfs.c                                          |  15 +-
 include/linux/kthread.h                            |  21 +-
 include/linux/ns_common.h                          |   2 +
 include/trace/events/netfs.h                       |   4 +-
 kernel/exit.c                                      |   6 +
 kernel/kthread.c                                   |  41 +---
 kernel/nscommon.c                                  |   6 +
 kernel/nstree.c                                    |  29 +--
 .../selftests/filesystems/nsfs/iterate_mntns.c     |  25 ++-
 16 files changed, 326 insertions(+), 160 deletions(-)

