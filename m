Return-Path: <linux-fsdevel+bounces-76609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLSbEc0chmmTJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:54:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C8100977
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BC2C3012CE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4F6346A0C;
	Fri,  6 Feb 2026 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTXGQYr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2053033EC;
	Fri,  6 Feb 2026 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396701; cv=none; b=XxgLwSj3Ae2F7pKabG49lXZyB0hMjN49yX2OZw025yimRUSvdLulzravPVuf3yWC+whBmUszoBJbfR7Af3BimZ0sDhL4ywjPWXI+HXhmQUgwdKWnPCElY7XQsN5gmRSFPj3DxM3NOubRydwAtwnve20LGOdOXZyR5EoXk9hoiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396701; c=relaxed/simple;
	bh=VzHIjPTxuZwyAoSsyc5rZ2lzUTQAH908TN7QbFaBhXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWkBZuiKhWcWrJWhdqqDH1WIM6fp3/I/ZbUpbDMC4kOhrAM6D0ToR3BFvq+rR99n72FhoZNuN460gwT1YTdfb+VJE4wt79NL4SgK3hgirHc1teHq0A0orWYBzVB3Mo582plq7zA2gE3rjGEsg2MR7EVHXq+0QwxTLa4itu9tgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTXGQYr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB554C19423;
	Fri,  6 Feb 2026 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396701;
	bh=VzHIjPTxuZwyAoSsyc5rZ2lzUTQAH908TN7QbFaBhXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTXGQYr0AWpFmmxUxXOCTlzh373ZoBxYV6dvuE3tVe2H6InZebyjHuLixQvWR+sH1
	 2AMXek/OFZZO3/gal7NtZYI4G6lZgagYobKZm6Hu+LchreQFJBnVuYvriPplEP2pZq
	 SHST0PT1aIXPHuTZmjDg4qKmFDn9Lxy3G+tlJMnf+MstNDNacxIjk0kTTYsOuWeEn2
	 0+ZX3QtBDvbeyvWdwGh5c58XeVgGZZc3OUYHlZwa6zF2/y51bUaq9Hbjn478SCImLf
	 cObZ0S5uesupf5KkDc/lhCfJbTZfsQNqaooY++k8VkidgwnmAnsWiCeYsxFTGuxN9L
	 bSjo9Le3G/aRA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 11/12 for v7.0] vfs iomap
Date: Fri,  6 Feb 2026 17:50:07 +0100
Message-ID: <20260206-vfs-iomap-v70-71e0b356ce5c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3146; i=brauner@kernel.org; h=from:subject:message-id; bh=VzHIjPTxuZwyAoSsyc5rZ2lzUTQAH908TN7QbFaBhXc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS2Se9apVx5Q7wn/PSkWc/Z/jRoxSgxLfx6Im4jD7vjp xV1mXdaOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby8B4jw0r3Rt4X8tq+/pei HJcqJxupGn7KDHykn6xjL6UpP0toE8P/xM2H9sbviXbKiimumVrgxGVSt7T56qmLtuax289PPBr ODwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76609-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE2C8100977
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

This contains the iomap changes for this cycle.

Erofs page cache sharing preliminaries:

  Plumb a void *private parameter through iomap_read_folio() and
  iomap_readahead() into iomap_iter->private, matching iomap DIO. Erofs
  uses this to replace a bogus kmap_to_page() call, as preparatory work
  for page cache sharing.

Fix for invalid folio access:

  Fix an invalid folio access when a folio without iomap_folio_state is
  fully submitted to the IO helper — the helper may call
  folio_end_read() at any time, so ctx->cur_folio must be invalidated
  after full submission.

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

Conflict with the ntfs3 tree. commit 099ef9ab9203d ("fs/ntfs3: implement
iomap-based file operations") calls iomap_read_folio() and iomap_readahead()
with two arguments, but commit 8806f279244bf ("iomap: stash iomap read ctx
in the private field of iomap_iter") added a third parameter.

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -678,7 +678,7 @@
-	iomap_read_folio(&ntfs_iomap_ops, &ctx);
+	iomap_read_folio(&ntfs_iomap_ops, &ctx, NULL);
@@ -702,7 +702,7 @@
-	iomap_readahead(&ntfs_iomap_ops, &ctx);
+	iomap_readahead(&ntfs_iomap_ops, &ctx, NULL);

[1]: https://lore.kernel.org/linux-next/aW5AGPFq0HPi440m@sirena.org.uk/
[2]: https://lore.kernel.org/linux-next/202601201453.3N9V4NVP-lkp@intel.com/
[3]: https://lore.kernel.org/linux-next/202601201642.SjxE1oMu-lkp@intel.com/
[4]: https://lore.kernel.org/linux-next/aXdnKldyCVLxrk78@sirena.org.uk/

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.iomap

for you to fetch changes up to aa35dd5cbc060bc3e28ad22b1d76eefa3f024030:

  iomap: fix invalid folio access after folio_end_read() (2026-01-29 13:42:05 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.iomap

Please consider pulling these changes from the signed vfs-7.0-rc1.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "iomap: erofs page cache sharing preliminaries"

Hongbo Li (2):
      iomap: stash iomap read ctx in the private field of iomap_iter
      erofs: hold read context in iomap_iter if needed

Joanne Koong (1):
      iomap: fix invalid folio access after folio_end_read()

 fs/erofs/data.c        | 67 ++++++++++++++++++++++++++++++++++----------------
 fs/fuse/file.c         |  4 +--
 fs/iomap/buffered-io.c | 57 ++++++++++++++++++++++--------------------
 include/linux/iomap.h  |  8 +++---
 4 files changed, 83 insertions(+), 53 deletions(-)

