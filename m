Return-Path: <linux-fsdevel+bounces-76599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B9gGdwchmmTJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:54:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F344A100988
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A77F6307C064
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F9D2E1758;
	Fri,  6 Feb 2026 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqUKjL19"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447A72E06EF;
	Fri,  6 Feb 2026 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396685; cv=none; b=iWRCfV9ILojrt1XjqTAPfDCEH/QeIuUJ/kTDt0EPRvW6BxXeGMo5Y726wW8pEGViQE7/Zp3iSnlsoJ9R3k0AMJqP/PF5cGTxSff4iPbrs1vWvwr0N6G3NhAltZ6hV+RgITmikGjP8bxIANkCTMeybVgYOpmJ+kE+PlgTRgRbXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396685; c=relaxed/simple;
	bh=7DRIFxqR4U6fjYc9fP2eyp5vFTcckxBtr82YBfJAZqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SivWb301cVMXiNY3QedKNd2L2OZogtTIvqz3+Kpya84JZ1xFD8mWTimx+9cKSwf5+0nRNYTLJRz4lbJAKJlEF+yQH4WwMZcAueeN1oB+16uxCXN8vdXlGMIYdFaxbrdbxTz6wC1zLEB5Qwip+hPnoyZVw66DjIkjdGIDRUjKb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqUKjL19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E59C19423;
	Fri,  6 Feb 2026 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396684;
	bh=7DRIFxqR4U6fjYc9fP2eyp5vFTcckxBtr82YBfJAZqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqUKjL19pJu6I5y0rRwVs1nYmghd0Szr3YDKW9mGIh2HeC0NBUXvpscRLfMWJ0OQY
	 +QehnCtyg5pECdUhViYaQCWZ8qsUbMf0xQnFrdUmAaN+0EPmB3BMozoaKtI+L3CCoh
	 tMoWuWBPIw0zhWn2wHUvAeU9BvLBFpehH5BfPxh+oUlTHwlCnJXdRDhQUTW4I7zyLY
	 Tbp6Xgu9awL+z+DYHumXQIhn0Ixnogr8XysBmPaU3peADp1qUD+NmiHuMnVUuXoqYp
	 oaXJKJgaOBkjPEqY102FTG8ZMLyIrAQsu2aB3FqbTAxLV0LGwxQhHtABAC1SlL9lg5
	 EvhxAZUHXoTdA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 01/12 for v7.0] vfs rust
Date: Fri,  6 Feb 2026 17:49:57 +0100
Message-ID: <20260206-vfs-rust-v70-e1fb02c09eaa@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2252; i=brauner@kernel.org; h=from:subject:message-id; bh=7DRIFxqR4U6fjYc9fP2eyp5vFTcckxBtr82YBfJAZqQ=; b=kA0DAAoWkcYbwGV43KIByyZiAGmGG7ijL5J8RWWOpA8n48Y2OEA2tpXhEEapjAyb0/0piFagm Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmmGG7gACgkQkcYbwGV43KJ1CQEA1j4H Aj6VaEdf1xrEf0lO/qtS0246bPWqVpnDuTl9MFEBAOUZ6ETq9PkCls04dHZx6RePuKNz/msPbQS jFirJS8kH
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76599-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: F344A100988
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

This contains the rust changes for this cycle.

llow inlining C helpers into Rust when using LTO: Add the __rust_helper
annotation to all VFS-related Rust helper functions.

Currently, C helpers cannot be inlined into Rust code even under LTO because
LLVM detects slightly different codegen options between the C and Rust
compilation units (differing null-pointer-check flags, builtin lists, and
target feature strings). The __rust_helper macro is the first step toward
fixing this: it is currently #defined to nothing, but a follow-up series will
change it to __always_inline when compiling with LTO (while keeping it empty
for bindgen, which ignores inline functions).

This picks up the VFS portion (fs, pid_namespace, poll) of a larger tree-wide
series.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.rust

for you to fetch changes up to 5334fc280735dcf5882511a219a99b5759e14870:

  Merge patch series "Allow inlining C helpers into Rust when using LTO" (2025-12-15 14:13:04 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.rust

Please consider pulling these changes from the signed vfs-7.0-rc1.rust tag.

Thanks!
Christian

----------------------------------------------------------------
Alice Ryhl (3):
      rust: fs: add __rust_helper to helpers
      rust: pid_namespace: add __rust_helper to helpers
      rust: poll: add __rust_helper to helpers

Christian Brauner (1):
      Merge patch series "Allow inlining C helpers into Rust when using LTO"

 rust/helpers/fs.c            | 2 +-
 rust/helpers/pid_namespace.c | 8 +++++---
 rust/helpers/poll.c          | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

