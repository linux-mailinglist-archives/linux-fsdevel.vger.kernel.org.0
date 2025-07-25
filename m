Return-Path: <linux-fsdevel+bounces-56032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0067AB11D99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21038AE32E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E1B2114;
	Fri, 25 Jul 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPS49W+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26112EE60D;
	Fri, 25 Jul 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442871; cv=none; b=HlUeuxT1CCMfRPa3SjsTfTLWbyXWi/CeXNiU3HEgct0TmZo4ZAjjqburoy/YgDxEv9mkgDkRXotorzoy0uqnBATFHYACazofrXogTrpXrf94tfCaDctL6OzwfF2BqupfArz74MRORXQrJAk07augUSpfvh/HDueen5jIw+PJOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442871; c=relaxed/simple;
	bh=Rx0aGR1fwgTJK/LfZkvwTuFfV8RHwi7XJSQS9rry3IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqkIZ7e4ocU+xTvenxVXq6yfAZemK5ndytducpcVXtP8OUvxYaNPgUiQxha+/1NKY8413XgkxTdPAKohNASkWdZ9tbghQo6XkmRe2dbguYQWJNJ12hQLdalKeSmNaBsSFrShOcXlKD7m7hyLTVLGrSrzG7FHBW+C2uVbUKyMYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPS49W+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B30BC4CEEF;
	Fri, 25 Jul 2025 11:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442871;
	bh=Rx0aGR1fwgTJK/LfZkvwTuFfV8RHwi7XJSQS9rry3IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qPS49W+W0VBrpRGzN2Ae/e4mzuPd6LFuttw4BPOQpX/Arli4msVbON1M2RGRkjbUO
	 J380Dzr7aabrbBi172qU3n++yJSxnqHpyLwUsBS+JuY1ZaynnhR5N56KQrpu7QzEtL
	 WSPRCJjlpQaYpNERIAmoLm0VPFO2EZ4wepZnfX3w3PvdwkhnW5/PlmiT/NhzWgLvDb
	 OrgWmg3/lZviqpzWJ8LbRCLwT5sfR4uSo/xnIoqDqMjH6aSrNCxoa4rtyLOy48izoZ
	 cYtBGLWcLUMMGoAOGr7VXPxD0S8xfSBuDaK2nQpPQ5Ev0qREeaLe9LcJat9W/PC69R
	 Hj+OchdTBRgDw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 13/14 for v6.17] vfs super
Date: Fri, 25 Jul 2025 13:27:27 +0200
Message-ID: <20250725-vfs-super-5977952856e4@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2426; i=brauner@kernel.org; h=from:subject:message-id; bh=Rx0aGR1fwgTJK/LfZkvwTuFfV8RHwi7XJSQS9rry3IE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4nbiR2v/i+lavBiaf/sU0+0n+YkWh7Wq/rYl5avm 65jbv2vo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCI3fzP8jz7L9/PaNbd7219l PlU99zVuzzuNPQXRR+vdmmdLC76818fIcEZh+q8niyYcWi/ZE/lgrT+Pn/LzP9lNV3ay7Dc1MWg 25wEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
Currently all filesystems which implement super_operations::shutdown()
can not afford losing a device.

Thus fs_bdev_mark_dead() will just call the ->shutdown() callback for the
involved filesystem.

But it will no longer be the case, as multi-device filesystems like
btrfs can handle certain device loss without the need to shutdown the
whole filesystem.

To allow those multi-device filesystems to be integrated to use
fs_holder_ops:

- Add a new super_operations::remove_bdev() callback

- Try ->remove_bdev() callback first inside fs_bdev_mark_dead()
  If the callback returned 0, meaning the fs can handling the device
  loss, then exit without doing anything else.

  If there is no such callback or the callback returned non-zero value,
  continue to shutdown the filesystem as usual.

This means the new remove_bdev() should only do the check on whether the
operation can continue, and if so do the fs specific handlings. The
shutdown handling should still be handled by the existing ->shutdown()
callback.

For all existing filesystems with shutdown callback, there is no change
to the code nor behavior.

Btrfs is going to implement both the ->remove_bdev() and ->shutdown()
callbacks soon.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.super

for you to fetch changes up to d9c37a4904ec21ef7d45880fe023c11341869c28:

  fs: add a new remove_bdev() callback (2025-07-15 13:36:40 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.super tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.super

----------------------------------------------------------------
Qu Wenruo (1):
      fs: add a new remove_bdev() callback

 fs/super.c         | 11 +++++++++++
 include/linux/fs.h |  9 +++++++++
 2 files changed, 20 insertions(+)

