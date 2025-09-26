Return-Path: <linux-fsdevel+bounces-62883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5775BA4197
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 698127AB9BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADA81E991B;
	Fri, 26 Sep 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgcDp/EL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F641E5710;
	Fri, 26 Sep 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896350; cv=none; b=f8+gFUkpGb2nxhcqY2yEguLNrCmhvMZHsGTGalDXq9nwRXHxlwjWlHXtvqbHq4q/vi4XKKhJSSGhOyXChPVH0Zb1vMxlNhTHqpJxIOHhufDbq6ScXU7Afi8DgQHHLPM9XrI65wA4IrsMKy103shRg3ErVqzPSMHNxkH0IvmamJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896350; c=relaxed/simple;
	bh=qjDPgR9foN2HSJYYyj/9ZfDUmv1wXnrE6kRJ29m9VVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQywxozfEHdhBYVC1N5cGn4S5USMwDDJ1nNE7lzze6DEw25d8IBF29uikTNyK6BvGZc9o0rdZwVyXbdWlXs0Gg4EJzdDfo7KufvPq3duCzd3ht2OyUZ+6+CLhHxB7QCpXUrlIs6pQtI5R/QJvcK1K+v+XUpp4ZPpdstqnCOKLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgcDp/EL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B61DC113D0;
	Fri, 26 Sep 2025 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896350;
	bh=qjDPgR9foN2HSJYYyj/9ZfDUmv1wXnrE6kRJ29m9VVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgcDp/ELGAMPRQvNp3zgL/6l5mxoU5TiAXo4TCToXFwDBrdY8Mm978w1gUl2F2Ett
	 upJdP6Wa97SUD0DoUyG+k2zyWY+9Kh3N7LzWEf5rA/20uMzouEq512I5Qa5Xet5Z5L
	 EUSsUXTdwa607dB/zfJMZdjg99xzbxSI09Rzma1LMxvTn3hLv5c+mFZ4l0OeM+QtQL
	 Z6e/yNPhF0ar+hcWf1IxnFy5az4e1ZeBc4VO4E3iqXS/eqEU+W18QaF7oBDjZldHEE
	 H7nt/XaPqxee4NdTK9l7r+A7sc7RtD4J2NG3FQiFNWLyIyBfdw2SdO9EfH++RLlOiq
	 k4O6ZONQhfkIQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 04/12 for v6.18] iomap
Date: Fri, 26 Sep 2025 16:18:58 +0200
Message-ID: <20250926-vfs-iomap-47b585a955ab@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926-vfs-618-e880cf3b910f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=brauner@kernel.org; h=from:subject:message-id; bh=qjDPgR9foN2HSJYYyj/9ZfDUmv1wXnrE6kRJ29m9VVc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3Be56w9v2Nt5aJFfxI9ZH7tTHjcu+B84aq5VnZlS om2ZSZxHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZ4Mfw34ltRvPHBM0JP2/r xTnu/uC4ecOhxeKblcTLVBKuxMs8amH4n73hCFOCpk1S+bXLv2//2sT4uYuBd6nZ0qtf3Odd2OV pygkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains minor fixes and cleanups to the iomap code.
Nothing really stands out here.

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

No known conflicts.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.iomap

for you to fetch changes up to c59c965292f75e39cc4cfefb50d56d4b1900812e:

  Merge patch series "iomap: cleanups ahead of adding fuse support" (2025-09-19 14:17:16 +0200)

Please consider pulling these changes from the signed vfs-6.18-rc1.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc1.iomap

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "iomap: cleanups ahead of adding fuse support"

Darrick J. Wong (2):
      iomap: trace iomap_zero_iter zeroing activities
      iomap: error out on file IO when there is no inline_data buffer

 fs/iomap/buffered-io.c | 18 +++++++++++++-----
 fs/iomap/direct-io.c   |  3 +++
 fs/iomap/trace.h       |  1 +
 3 files changed, 17 insertions(+), 5 deletions(-)

