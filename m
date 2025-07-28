Return-Path: <linux-fsdevel+bounces-56117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FF0B13436
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 07:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15AF3ABCE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 05:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F5D220F3E;
	Mon, 28 Jul 2025 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noF4x5cd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232341F3B89
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 05:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753681050; cv=none; b=tsYwUu6wLG7Fm8XGpR2bLUW/hVnOR4TrvrLOESXPmK+3VG147meWGr7vrwuxSKgFtqrNS4rE/dhL+2FprEoNQOh3iLXc/7EWaZA/oRjbyoWS38I381foDj3uq7oGgEKZH9zm9zH2bUA0U9DPjE5oDHkQwTzmYD5D8zXcWmPxgCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753681050; c=relaxed/simple;
	bh=D1aPWg/GEU62DMkMl2G3Al73obacO8tZZ5vhVxa8/r8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XMZgdwUF1GCR918qLBecEflsA+zefU8mtifvpUwzDfhkvqogBYKMOyyqV1aF+/KlQDQlB8sV1hNurlVXuGYSGPD+1Z2ykmYOHIOQaramiIgIH4F6pVLrLKK/VqszyFx3doa8VmYjxLr8R1k3tmJvXCkfF5AMlB9IbODBI5uHLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noF4x5cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F3DC4CEE7;
	Mon, 28 Jul 2025 05:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753681049;
	bh=D1aPWg/GEU62DMkMl2G3Al73obacO8tZZ5vhVxa8/r8=;
	h=From:To:Cc:Subject:Date:From;
	b=noF4x5cd6I7j7P+vC8qhJKdivz/BhKCCOKQw+XagUl/cjdd+WnChEzVl00rwdEco1
	 PFEiXvudn3kxQIRDSWkT8wjqCGDfEr2rEOwGDvhK/Z+fl/Plv82LQ8WBlcn+PlBp20
	 infdAcWTkeuXU8EA4J6VEsGDhMf4MTwhEtDZHI2MkR0Zk5eZ8g6E68w3m4ZyC/43qD
	 lCgEI/BJIrM23VUmw7DKzDTMwiFfxtnZKtY2vqQm1RblT/SYl5/s2zmHOThvZhccmQ
	 ESGe9XXWS8BqmCIPkTmWL46+ftIR1gpocNQ3vSz/dFkOCm6gEY/WgI/xv5lCVJv22m
	 6klW9ko3IwKfA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs changes for 6.17-rc1
Date: Mon, 28 Jul 2025 14:34:59 +0900
Message-ID: <20250728053459.78340-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.17-rc1

for you to fetch changes up to 6982100bb8297c46122cac4f684dcf44cb7d0d8c:

  zonefs: use ZONEFS_SUPER_SIZE instead of PAGE_SIZE (2025-06-13 15:49:00 +0900)

----------------------------------------------------------------
zonefs changes for 6.17-rc1

 - Use ZONEFS_SUPER_SIZE instead of PAGE_SIZE to read from disk the
   super block (Johannes).

----------------------------------------------------------------
Johannes Thumshirn (1):
      zonefs: use ZONEFS_SUPER_SIZE instead of PAGE_SIZE

 fs/zonefs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

