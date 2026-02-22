Return-Path: <linux-fsdevel+bounces-77873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPCbNV9pm2kYzQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 21:38:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47959170578
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 21:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6FDE300C9AB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 20:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817635BDD5;
	Sun, 22 Feb 2026 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOVdqvPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3431C2324;
	Sun, 22 Feb 2026 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771792731; cv=none; b=RgO7d9BlvHFJArEunXE/dCWw8YbHcrbtpXr42ndmq1yg0Sw0gUauuXhEo/UPz4P8RnqwpqjoHsFmCjXYkxXcuq5QPQBap4RO7S0DRatd0cOAraYNxUnyWzWok0Exs5qh5fA6yLXco8+fVXoEr+lAaX3rldqiXcYxA7Ful5V3JLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771792731; c=relaxed/simple;
	bh=+VxpXalskdd5orPNOTRrMLvQxCitqFrTilFoz+NHPRg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jv4DUAEr37LlkyG9SlC9ct6JNBAaozYpJYHBQEmPLJcqJaHoRKwlzVFRtIz+cEOh0FYh8DdZ8RG+eqsvwpexPb4JOjQn7Ma9hfvkbNnjj+jz2H8N0iehDRZ9nmds/VDGTO7yBUs28zrE3bOhQWJStqXyr980/yaYmLqwk03GsCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOVdqvPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA1DC116D0;
	Sun, 22 Feb 2026 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771792731;
	bh=+VxpXalskdd5orPNOTRrMLvQxCitqFrTilFoz+NHPRg=;
	h=Date:From:To:Cc:Subject:From;
	b=nOVdqvPrwtqMJNAYhI3q+GFdqnM4+n7jyx3YNmTfIa+rOJ0hsNqEIQ0wGvR0OGqId
	 brop4oxi6YegxJZEBwejT9LYjhRyySFMFy2iunIpjF+0vOtuWpd1xlpeSldrns22D8
	 kfihpwEQGJ3SCg3RubDkoQ1yjLV4Rpl3AAb6QJ18sKix4RKhINK8RVHWd8k+H6zl3Q
	 vy/H3TNZu2+Ke5tnyI5YVzcUAL2QeoK03O6z0Tw3Zs3BFIwgBTjK8dtJ8C3VZ7KcdT
	 Cp8QPtrAIRckd5juwVsy2hoX9PJNjWB+EFYTSCJNvuMwkqxG4JADt4IPFmmi9ktIa/
	 mZ70i8GjK9xyQ==
Date: Sun, 22 Feb 2026 12:38:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] fsverity fixes for v7.0-rc1
Message-ID: <20260222203843.GD37806@quark>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77873-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47959170578
X-Rspamd-Action: no action

The following changes since commit 64275e9fda3702bfb5ab3b95f7c2b9b414667164:

  Merge tag 'loongarch-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson (2026-02-14 12:47:15 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to 693680b9add63dbebb2505a553ff52f8c706c8c0:

  fsverity: fix build error by adding fsverity_readahead() stub (2026-02-17 23:11:40 -0800)

----------------------------------------------------------------

- Fix a build error on parisc

- Remove the non-large-folio-aware function fsverity_verify_page()

----------------------------------------------------------------
Eric Biggers (4):
      f2fs: remove unnecessary ClearPageUptodate in f2fs_verify_cluster()
      f2fs: make f2fs_verify_cluster() partially large-folio-aware
      fsverity: remove fsverity_verify_page()
      fsverity: fix build error by adding fsverity_readahead() stub

 fs/f2fs/compress.c       | 11 +++++------
 fs/verity/verify.c       |  4 ++--
 include/linux/fsverity.h | 15 +++++++--------
 3 files changed, 14 insertions(+), 16 deletions(-)

