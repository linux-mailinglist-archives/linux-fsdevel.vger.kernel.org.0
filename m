Return-Path: <linux-fsdevel+bounces-12708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F9A862994
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 07:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AFE281B29
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 06:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1A1D2E5;
	Sun, 25 Feb 2024 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjUMoJRx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0780C8F3
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708844283; cv=none; b=PXuNxq/xyHPsFRuwIs8mgHBWK9Z3kH+J1bT0JTnByBjn2hW7h1JUxewBq6VsCUUClw9+YgY2c+ff1p8gECh8sjSIu+JTxvtlSdTzzu3QC7hYxKPP51LwRSrzlWW775vI6XCfaOpBP1lobbqrnJLZ0qPNtbqFDam/x/VbG0+Vg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708844283; c=relaxed/simple;
	bh=16iX1JZXynwe+pbX5XdejkSGxvXRUmGNhV+A4+w9BQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PBnfcUEUsQPSVSXE95wr4dKTCb8jcs/SwsvIi2DqjwKhVGB2rMhwAlYSrHrS+jxBrenDq4IRA+WyHByzjdWw9HOAEjSpTv7FDxXmqmgk23Ud+pq4KvAgBCC6Gx4Pp0vnWWi1VQFmTgoocR42gMxMHZ1t16YJ2c7jv913xqWh0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjUMoJRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E978C433F1;
	Sun, 25 Feb 2024 06:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708844283;
	bh=16iX1JZXynwe+pbX5XdejkSGxvXRUmGNhV+A4+w9BQo=;
	h=Date:From:To:Cc:Subject:From;
	b=RjUMoJRxwmc51rP5qXOaPlpCH2EZHkPT2xIEvCxyyVQf880cWi1bk6dptJV2XcEvX
	 FJIDI36LyyCVKNFFpIWeTfreiapHvt1UoPdt4/Z6lwSna+Dm9+bch/g1K3Xuz/2ZBG
	 zFktS/NRcz3ZTYa/5CCRSZCPbc+z1MMr4ikBjGC13Ymk38OPsY+Ma695V/JhqBgRQs
	 iziqoHj/vEScv7ZVyrs+uK+PkKdErG5XBIsicHXa70lRf5Tfg76oSAwMVs/FgqGDba
	 jay0VcW/B+wKPHB3EWwdlD7WzzUWvtT1PR7orAk9E+t0Gn57SaNC1UQz2lQlV+QJov
	 35t5n+hxxs/9Q==
Date: Sun, 25 Feb 2024 01:59:16 -0500
From: Al Viro <viro@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <ZdrlRJQOzKnaXh7d@duke.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 2c88c16dc20e88dd54d2f6f4d01ae1dce6cc9654:

  erofs: fix handling kern_mount() failure (2024-02-20 02:09:02 -0500)

----------------------------------------------------------------
	A couple of fixes - revert of regression from this cycle
and a fix for erofs failure exit breakage (had been there since
way back).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (2):
      Revert "get rid of DCACHE_GENOCIDE"
      erofs: fix handling kern_mount() failure

 fs/dcache.c            | 5 ++++-
 fs/erofs/fscache.c     | 7 ++++---
 include/linux/dcache.h | 1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

