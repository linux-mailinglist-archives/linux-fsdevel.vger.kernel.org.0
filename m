Return-Path: <linux-fsdevel+bounces-76986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLP/J40sjWnxzgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 02:27:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C641B128F64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 02:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36C6B301FB70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 01:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11831EB19B;
	Thu, 12 Feb 2026 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC8TyQBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B52C8E6;
	Thu, 12 Feb 2026 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770859655; cv=none; b=hn3HZwPGLk/obQxhVJ3EQzuR3GLL6XMkBXHPjUp20d7GmJq+nS6fXa4F+OUIEBCphG9t+ciiVJL7xsII8Ztie04hikjVacTi/3yLRcC29LXHDTNCHoLtyCaZLtsWl21hacvLNAX/2UHIn+xVR/y19U9gbp7RZZr4cK4Svb80ido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770859655; c=relaxed/simple;
	bh=LI9T8ckO6uZfvbB4i3LQ04OePVTEa752sUaYTpdWXPk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z1vBNWmoOiL0g/3vSWTsXMzqGsYMskHZJDkwAVKJ3P1wRW0lEoNXbXPVIDi5PCjcIm0RPwjXbJvmB8AvIAIW2yGTPtshSGbwS0jlO5+ibz7TpT+3C6YwkKs5k7sL415jPGg0XwO43g39VcHjxstPy89NPp0GXLT+KyKgW4+AX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC8TyQBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF65C19423;
	Thu, 12 Feb 2026 01:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770859654;
	bh=LI9T8ckO6uZfvbB4i3LQ04OePVTEa752sUaYTpdWXPk=;
	h=Date:From:To:Cc:Subject:From;
	b=VC8TyQBQCl1ZNhvI97b3cMj0k5IKOhdi2Okelw9VVkk7vUJDiZ3dT48KDUuxLXv10
	 xu6SI0aberuBRiUDCEFe2gbVLhYUq9NT+mc303UfLpGJ7BOZf/ZEUhYvLReS7i2qcT
	 pIcUEvauojisi7uZBoWGx/Uni8GhfjBobkSGrio6+7yGMvkKeSZmMILVJrHYzXo1jP
	 noWt5UlfqbSLMoUWlxFKjtRjbKlQ2g4Sc9pKo/gIutBZsrG4qLK6688ODfTQjzfNA5
	 FsfL0F7pNpEYcTo/5jyFtG4573sqMz4vtmq1WCa2rBHhIo95wehrQHDH8UzSXYZdqu
	 BPAvuQLionkcA==
Date: Wed, 11 Feb 2026 17:26:52 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>
Subject: [GIT PULL] fsverity updates for 7.0
Message-ID: <20260212012652.GA8885@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76986-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C641B128F64
X-Rspamd-Action: no action

The following changes since commit 63804fed149a6750ffd28610c5c1c98cce6bd377:

  Linux 6.19-rc7 (2026-01-25 14:11:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to 433fbcac9ebe491b518b21c7305fba9a748c7d2c:

  fsverity: remove inode from fsverity_verification_ctx (2026-02-04 11:31:54 -0800)

----------------------------------------------------------------

fsverity cleanups, speedup, and memory usage optimization from
Christoph Hellwig:

- Move some logic into common code

- Fix btrfs to reject truncates of fsverity files

- Improve the Merkle tree readahead implementation

- Store each inode's fsverity_info in a hash table instead of using a
  pointer in the filesystem-specific part of the inode.

  This optimizes for memory usage in the usual case where most files
  don't have fsverity enabled.

- Look up the fsverity_info fewer times during verification, to
  amortize the hash table overhead

----------------------------------------------------------------
Christoph Hellwig (17):
      fs,fsverity: reject size changes on fsverity files in setattr_prepare
      fs,fsverity: clear out fsverity_info from common code
      ext4: don't build the fsverity work handler for !CONFIG_FS_VERITY
      f2fs: don't build the fsverity work handler for !CONFIG_FS_VERITY
      fsverity: pass struct file to ->write_merkle_tree_block
      fsverity: start consolidating pagecache code
      fsverity: don't issue readahead for non-ENOENT errors from __filemap_get_folio
      readahead: push invalidate_lock out of page_cache_ra_unbounded
      ext4: move ->read_folio and ->readahead to readpage.c
      fsverity: kick off hash readahead at data I/O submission time
      fsverity: deconstify the inode pointer in struct fsverity_info
      fsverity: push out fsverity_info lookup
      fs: consolidate fsverity_info lookup in buffer.c
      ext4: consolidate fsverity_info lookup
      f2fs: consolidate fsverity_info lookup
      btrfs: consolidate fsverity_info lookup
      fsverity: use a hashtable to find the fsverity_info

Eric Biggers (1):
      fsverity: remove inode from fsverity_verification_ctx

 fs/attr.c                    |  12 ++-
 fs/btrfs/btrfs_inode.h       |   4 -
 fs/btrfs/extent_io.c         |  53 +++++++-----
 fs/btrfs/inode.c             |  13 +--
 fs/btrfs/verity.c            |  11 +--
 fs/buffer.c                  |  25 +++---
 fs/ext4/ext4.h               |   8 +-
 fs/ext4/inode.c              |  31 -------
 fs/ext4/readpage.c           |  64 +++++++++++----
 fs/ext4/super.c              |   4 -
 fs/ext4/verity.c             |  34 +++-----
 fs/f2fs/compress.c           |   7 +-
 fs/f2fs/data.c               | 100 ++++++++++++++---------
 fs/f2fs/f2fs.h               |  12 +--
 fs/f2fs/file.c               |   6 +-
 fs/f2fs/inode.c              |   1 -
 fs/f2fs/super.c              |   3 -
 fs/f2fs/verity.c             |  34 +++-----
 fs/inode.c                   |   9 ++
 fs/verity/Makefile           |   1 +
 fs/verity/enable.c           |  41 ++++++----
 fs/verity/fsverity_private.h |  20 +++--
 fs/verity/open.c             |  84 +++++++++++--------
 fs/verity/pagecache.c        |  58 +++++++++++++
 fs/verity/read_metadata.c    |  19 +++--
 fs/verity/verify.c           |  91 +++++++++++++--------
 include/linux/fsverity.h     | 190 +++++++++++++++++--------------------------
 mm/readahead.c               |  15 ++--
 28 files changed, 516 insertions(+), 434 deletions(-)
 create mode 100644 fs/verity/pagecache.c

