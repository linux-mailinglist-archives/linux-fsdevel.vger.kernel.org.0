Return-Path: <linux-fsdevel+bounces-56068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CED6B129B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 10:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602EB1C21557
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 08:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17473202F67;
	Sat, 26 Jul 2025 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ILV6V7aH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B978F4C
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753517162; cv=none; b=MZMcmsSEM1A4opM0g1w7qQTCFc163BBzJJzF6N5oZY1ftEWxjDyx0+wrTiwm2zOp84Q7CS3bvXZq7J7z7wMuSU0Y1cDW2PTAOQCf0buAbOmZWVYH/zAaZyMiU4CCpH66RVAzYTqLwa06zs7MVic0ImY2ZRkTGExs2Xqn22ditTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753517162; c=relaxed/simple;
	bh=HJ62RlhQhlXEipggN09OkYYL/XPCQ7zZVKW0+5/60Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaWkw2zBhlQOUl0FOmSKsgLgzdirEZkJS1WLQ7tEPccoS3zTJhNmLt2NzQnFYfyCOBHwtIkron5WGJKJVtxgGPLLHOBkwb83UnUfme+Bees7uT8yiBbghKOtGo8paPLxKbawRK75/vFRFBp5HtUv7rN7RFlyEX18kdAB7M1W8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ILV6V7aH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IKo5dR8hCVDTUKAOApR9F0046CldYdof/prbUlFKRqM=; b=ILV6V7aHkclUI8CA2h6j/2HIbs
	J2m3P/vQb9hx7XJfg9hFg+RddoqPlPeJMbqka20dXHvbCOeD7lWPeIC4T7l+O4v4ghePmLZusrkVy
	uaGurlBCN8cX1lCt0pxSZFMqUR850HaZ3XAclviXH0OYUI3RbamUm4Erl6T1m3U6wgecl43o7fXP9
	c/qKQXw8c1di4QctIEn/QoFskvHU2e8MuRTJwWzwuvwCGJ+jqn8qQgfxUvU3zu6iF8Lp2wGgyT/6e
	wdy9CYoX+nsXKJeK67lILWhi25n1HCO5drb3zrXWImGQ4+TO/QuyTGTcUkAmCcywB35iAL8BIHJKV
	N6JG4h9A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufZup-000000068rl-0aMM;
	Sat, 26 Jul 2025 08:05:59 +0000
Date: Sat, 26 Jul 2025 09:05:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull][6.17] vfs.git 6/9: misc pile
Message-ID: <20250726080559.GE1456602@ZenIV>
References: <20250726080119.GA222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726080119.GA222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

for you to fetch changes up to 93c73ab1776fc06f3bee91e249026aad2975e8bf:

  gpib: use file_inode() (2025-07-10 01:43:55 -0400)

----------------------------------------------------------------
VFS-related cleanups in various places (mostly of the "that really can't
happen" or "there's a better way to do it" variety)

----------------------------------------------------------------
Al Viro (5):
      landlock: opened file never has a negative dentry
      apparmor: file never has NULL f_path.mnt
      secretmem: move setting O_LARGEFILE and bumping users' count to the place where we create the file
      binder_ioctl_write_read(): simplify control flow a bit
      gpib: use file_inode()

 drivers/android/binder.c              | 20 ++++++--------------
 drivers/staging/gpib/common/gpib_os.c |  2 +-
 mm/secretmem.c                        |  7 +++----
 security/apparmor/file.c              |  2 +-
 security/landlock/syscalls.c          |  1 -
 5 files changed, 11 insertions(+), 21 deletions(-)

