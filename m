Return-Path: <linux-fsdevel+bounces-50241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB94FAC95F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 21:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96681C20F60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 19:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E2E278152;
	Fri, 30 May 2025 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DiLO6nNU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96E23E35B
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748632360; cv=none; b=VmTwZ6Sxh70KaV+wkKpza/BOq4X5F7FRAGkw4NLrVkpwsr2YoPtz90wWX/fHxzf2FXH3YnDFFzpoSQWyI9JHlta9Ds7J6nSdOmlwMT7C1YhYM9W+j9NIPnOs5HOAXWlosU+ohnuV27xcj9E+vfBByXwQ4qaIvnw8C44sLsWNI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748632360; c=relaxed/simple;
	bh=pcgIc+bMiAAaUsILs3rY4kVXRLSb+Uwmr+r7ZO5pWg0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YXB4Uu3ZR6IYFQnwOWCgxdH+JNf2A4eozSKwIa51Gua9AJhyLmV7yorDmmixFlFEeI6jzGzWZLm5SAav/0fdmTHHBXetsq7SJH9/AUmRAzW0DX1AXnRx0NvUydOFxYhicVP738/RM6h0kpLIyDYyTKWaFHjTcPpgjzmhvcC/ZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DiLO6nNU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5sXZvunz79941pZluxN5dH6Zpaf41a8NE3s+d6TfTsI=; b=DiLO6nNUEdMy+BG0F0X1rsR+MG
	mn9pND0wAQDO+uMwZNRPZpBnlH0UzVutrcx5atsTYIYFJ+cw4hA9gm7UoV4PPkYAC5RPsBcqyyyt4
	0Lt8HVphhDh241MCTz54ACn7JE/ERzn3r+opOJ2mcU8E/WCgUkdRcRQ4HxJTGdf9vTxHp1rUhLadU
	4nFTlU8eQoqPmD330onA9p9NnOeJP7I4MaiIpG6fXDZ57bcQj79i52Jgl9QkabZilzKTZbNdP5ubO
	mPi4+WzNj5Ps+zw52pe/z++RY3wrqqHxuWCpy06SRRtDIj/GcE2LhK5Y6NYbkqC5S6Hw4nCXIfuM7
	CSrVikcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL59h-0000000F6oQ-0fA2;
	Fri, 30 May 2025 19:12:37 +0000
Date: Fri, 30 May 2025 20:12:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] UFS pile
Message-ID: <20250530191237.GB3574388@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The bulk of that is Eric's conversion of UFS to new mount API, with
a bit of cleanups from me.  I hoped to get stricter sanity checks
on superblock flags into that pile, but... next cycle, hopefully.

The following changes since commit 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3:

  Linux 6.15-rc6 (2025-05-11 14:54:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ufs

for you to fetch changes up to b70cb459890b7590c6d909da8c1e7ecfaf6535fb:

  ufs: convert ufs to the new mount API (2025-05-14 22:40:55 -0400)

----------------------------------------------------------------
Mostly the conversion to new API

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (2):
      ufs: split ->s_mount_opt - don't mix flavour and on-error
      ufs: reject multiple conflicting -o ufstype=... on mount

Eric Sandeen (1):
      ufs: convert ufs to the new mount API

 fs/ufs/super.c | 307 +++++++++++++++++++++++++--------------------------------
 fs/ufs/ufs.h   |   9 +-
 2 files changed, 139 insertions(+), 177 deletions(-)

