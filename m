Return-Path: <linux-fsdevel+bounces-76603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO87IU0dhmmTJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:56:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C16100A18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 231CA305464A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2454034C9AB;
	Fri,  6 Feb 2026 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u61HCP3Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE9346A0C;
	Fri,  6 Feb 2026 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396691; cv=none; b=nZpn/6PfI7rITaPFlH9WVQx/OQPNGdbVr0vHjb4U+LCPePCwORIAAjjklGAUOpxYWCCS6HqsJUidLQuYt7ZZSh3MNw07U9T7V1jz5d5W5Bko9DMZWCDORAvP9Wlq7ymqIWtaHlnyZla3aki+xjR3rY6pUZqZtCGYS+gzoZkmDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396691; c=relaxed/simple;
	bh=dJuzU3uEgcWyh/8iVhdyj3dQCzEGwQ5bacFDfCQRSKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/pnJpCDo/XirHkvbFKaZbixQT235ONJ7yvrj3X/UgwEJAtAmxwxm7vokqtYW3UVNKDOH/rqGYBrzENoAS6ebKgpANvJ8mNF5mtXZlB9z7aSfC9tvIp8aK4gsbIJGddnoqyRz2XbN82jYRLQW2EZxOwTKjT8PqwnDDkp1c1FWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u61HCP3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4855BC19423;
	Fri,  6 Feb 2026 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396691;
	bh=dJuzU3uEgcWyh/8iVhdyj3dQCzEGwQ5bacFDfCQRSKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u61HCP3YCv7tFU8JSi2o2J/dcsOmBuLitUpqV1mvnl3AZFSJU5CrT4wj+vsXAQ7zb
	 FvKdaWcuwByOFOKHJWTD1rz1In6PnJWP1IgLCbxkHYn/XAkn1Kxai9ZYvancu3dS2T
	 9JA4YW4U0ufDDApLQ58syXsdNuCTpm+iPr884o0cwYHRdAgZqmjJtDO5X5uZVTtIj3
	 APVNwisjmIPbZrtPJeC0w6u66Ah1jigyycSxaB58Zpu62IJ/+HOoTk0hvUVosxTCu3
	 LdaI8iP0s359zaQml8WjVaYEJ4MqYb+qGpG6pSdVRE8uuBB4BOBBzNquLRzT4JEqEh
	 hL8ugL19LP6qg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 05/12 for v7.0] vfs fserror
Date: Fri,  6 Feb 2026 17:50:01 +0100
Message-ID: <20260206-vfs-fserror-v70-7d1adc65b98d@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4336; i=brauner@kernel.org; h=from:subject:message-id; bh=dJuzU3uEgcWyh/8iVhdyj3dQCzEGwQ5bacFDfCQRSKs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS2Se9crvjpJmdPVfbZP4qRTPPdHj/NOOD+4lbiqvlz5 02JVVlh2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARvZ+MDLOkFxmxrtJ//W3G sdmXFV3jWXTWPNefcMXZ7VPqfR/e/XsZ/hdNSfuiJiHJPv9WVPru95OYog7brfB6eP8Hs2jlUW3 +bEYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76603-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00C16100A18
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

This contains the changes to support generif I/O error reporting.

Filesystems currently have no standard mechanism for reporting metadata
corruption and file I/O errors to userspace via fsnotify. Each
filesystem (xfs, ext4, erofs, f2fs, etc.) privately defines
EFSCORRUPTED, and error reporting to fanotify is inconsistent or absent
entirely.

This series introduces a generic fserror infrastructure built around
struct super_block that gives filesystems a standard way to queue
metadata and file I/O error reports for delivery to fsnotify. Errors
are queued via mempools and queue_work to avoid holding filesystem locks
in the notification path; unmount waits for pending events to drain. A
new super_operations::report_error callback lets filesystem drivers
respond to file I/O errors themselves (to be used by an upcoming XFS
self-healing patchset).

On the uapi side, EFSCORRUPTED and EUCLEAN are promoted from private
per-filesystem definitions to canonical errno.h values across all
architectures.

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

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.fserror

for you to fetch changes up to 347b7042fb26beaae1ea46d0f6c47251fb52985f:

  Merge patch series "fs: generic file IO error reporting" (2026-01-13 09:58:07 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.fserror

Please consider pulling these changes from the signed vfs-7.0-rc1.fserror tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "fs: generic file IO error reporting"

Darrick J. Wong (6):
      uapi: promote EFSCORRUPTED and EUCLEAN to errno.h
      fs: report filesystem and file I/O errors to fsnotify
      iomap: report file I/O errors to the VFS
      xfs: report fs metadata errors via fsnotify
      xfs: translate fsdax media errors into file "data lost" errors when convenient
      ext4: convert to new fserror helpers

 arch/alpha/include/uapi/asm/errno.h        |   2 +
 arch/mips/include/uapi/asm/errno.h         |   2 +
 arch/parisc/include/uapi/asm/errno.h       |   2 +
 arch/sparc/include/uapi/asm/errno.h        |   2 +
 fs/Makefile                                |   2 +-
 fs/erofs/internal.h                        |   2 -
 fs/ext2/ext2.h                             |   1 -
 fs/ext4/ext4.h                             |   3 -
 fs/ext4/ioctl.c                            |   2 +
 fs/ext4/super.c                            |  13 +-
 fs/f2fs/f2fs.h                             |   3 -
 fs/fserror.c                               | 194 +++++++++++++++++++++++++++++
 fs/iomap/buffered-io.c                     |  23 +++-
 fs/iomap/direct-io.c                       |  12 ++
 fs/iomap/ioend.c                           |   6 +
 fs/minix/minix.h                           |   2 -
 fs/super.c                                 |   3 +
 fs/udf/udf_sb.h                            |   2 -
 fs/xfs/xfs_fsops.c                         |   4 +
 fs/xfs/xfs_health.c                        |  14 +++
 fs/xfs/xfs_linux.h                         |   2 -
 fs/xfs/xfs_notify_failure.c                |   4 +
 include/linux/fs/super_types.h             |   7 ++
 include/linux/fserror.h                    |  75 +++++++++++
 include/linux/jbd2.h                       |   3 -
 include/uapi/asm-generic/errno.h           |   2 +
 tools/arch/alpha/include/uapi/asm/errno.h  |   2 +
 tools/arch/mips/include/uapi/asm/errno.h   |   2 +
 tools/arch/parisc/include/uapi/asm/errno.h |   2 +
 tools/arch/sparc/include/uapi/asm/errno.h  |   2 +
 tools/include/uapi/asm-generic/errno.h     |   2 +
 31 files changed, 373 insertions(+), 24 deletions(-)
 create mode 100644 fs/fserror.c
 create mode 100644 include/linux/fserror.h

