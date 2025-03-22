Return-Path: <linux-fsdevel+bounces-44782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 269C1A6C929
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8828B18925E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB51FFC74;
	Sat, 22 Mar 2025 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDwuryew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D81FAC4E;
	Sat, 22 Mar 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638662; cv=none; b=fL/l63OZXgF+yTcEf5rQfsrAgK9oXTJNFeJ7OmgI2hqrYvgk4ktbEQKGC98aUAMfipyNniyD7UYpIdR5dEC3Ye7fHR/nksATC4LTVIpIGpY4/oEoj47RTe0j9PDAOnECQ5oq5HBfULFhEwnnkFJ79D4JatzZVsrE1FCQH9sKf/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638662; c=relaxed/simple;
	bh=Ld/oZkTZBA+PFwG21jQhw2+3ZvbPKFk6g7n/nG2Rj1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUMMc3dbzMbGqmFy2LGthyFOA0XaR0egQeOfA7hiuUejQSxo0vQeSIyRIgds7a/HHd9Dev0OAfaT/u7bwzlsHNapPF5IWmP/DqTE4YoDQ5E2WosdKSmBh7z/Lm/51GBv/Fg6d+qTcghqyBeSPmBEK/rwIG98L/gDH1Xcq4xm4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDwuryew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A21C4CEDD;
	Sat, 22 Mar 2025 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638662;
	bh=Ld/oZkTZBA+PFwG21jQhw2+3ZvbPKFk6g7n/nG2Rj1o=;
	h=From:To:Cc:Subject:Date:From;
	b=kDwuryewJ6UqdQVUsArpj9KtrTD2xE1FHqfVPZnq9er9UFHYFKgYb1l6DW32IGvtc
	 G5xNzIkthjVt5SKGTkmTIl9TQMlukvO2tU+K9qjV8UkdJy9Cr03e4bIYViTUgqnK8N
	 lpQ31imyH+JG8+DEU5cVayA1+1ix8DHmE40qHY+2sVGuQ9/cZMzFGm6LsRnqsdtsqx
	 f5I1MTrEc/mlaCtlIFPost7G7XrSUQIeXqh3YNfCpPzdvQNQeOD3l8H7nHkz0nTXQJ
	 L1M/vJKyPeLkkGA/vOi7PsnCkx/ronOmBFf/iAHHvDrxBV1K8jHgjNPHGm0TVSTZWR
	 xhsccR1Cm0hIw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs rust
Date: Sat, 22 Mar 2025 11:17:35 +0100
Message-ID: <20250322-vfs-rust-22efd627df4b@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488; i=brauner@kernel.org; h=from:subject:message-id; bh=Ld/oZkTZBA+PFwG21jQhw2+3ZvbPKFk6g7n/nG2Rj1o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf63O0ec4qsdUk5sSy38X75t5kjK9YH2nJrXPb7ZDAr 3gZ00VeHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPhf8Xw3zPxjfDkL2laaefm PM7S+Grw73zD+TLfkoi73VJ3BPYmyjL8d/VcZTiLyTnL4kHH82eztsUVWl7onLw1dsfFhftziy7 t4wAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains minor fixes and improvements to rust file bindings:

- Optimize rust symbol generation for FileDescriptorReservation.

- Optimize rust symbol generation for SeqFile.

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

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.rust

for you to fetch changes up to 0b9817caac1d4d6bf7dc8f7f23ffd95a3f5bb43a:

  rust: optimize rust symbol generation for SeqFile (2025-03-18 09:26:24 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.rust tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.rust

----------------------------------------------------------------
Kunwu Chan (2):
      rust: file: optimize rust symbol generation for FileDescriptorReservation
      rust: optimize rust symbol generation for SeqFile

 rust/kernel/fs/file.rs  | 4 ++++
 rust/kernel/seq_file.rs | 1 +
 2 files changed, 5 insertions(+)

