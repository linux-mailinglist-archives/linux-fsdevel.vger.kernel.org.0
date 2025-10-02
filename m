Return-Path: <linux-fsdevel+bounces-63208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1028FBB2926
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 08:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC8D18814B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 06:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7383824337B;
	Thu,  2 Oct 2025 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vjgPGBPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCB134CB
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384854; cv=none; b=fE5nALbG21/IXXGrgKMtxLXGO92fBS/gIChsqHUNWD7rpabX0yJgw4Bl77cvzkZH1raxBOjhGofzd0A0cC6K+ekav37xaIgTSXnRVcFjzOIrbnhNKFwO+xDa+4YFT0+0wO7kpOfLjPvobdGvYCwQW+fLk+SiSVnW5pNpP8cED2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384854; c=relaxed/simple;
	bh=W7cXGIGxHE8foEKrp1SFNBR0nwj/i2l5StNHSX+XpN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BltqOyaW1gbAlvEsY3XbPsw5HjEz9XdK3K1K84DceTGanDoDYJoJVBKgMHFDcGO9qiL1Rdrb/Fa3+7sskTvhXZ7nY0C+VLJR6YNt2QTYvcS+tiWdaJXBAN5KbwFIYTZDAZN6e61A/3xvbIIo2ClPI8QyxQ6MuklwzX9f9DKI6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vjgPGBPM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=HFBkZnj2ulRqCbX2BrHOe+3R8oVygrfsf7Xi2l8+Heg=; b=vjgPGBPMU6Z8KCDifMIRcKLEg1
	IgeqGZA81Z9xphHUUzOkd0hg5w3oJ9EEooyMM3ZeINXVbacag6Ib0TSlOhGlObPe4up8ppG/kJv8L
	7MfJpODwoKR3fmzxe9lyk+GUK/OWQQBC4hUXm8G3IuEc82/jss2Zt5c+9hGA7jLLPWQwOVh3d5J2Z
	GJfCT1ClME5dA6STh6kcP0SLE4kA7Ai7UiNCnyERhz1nw39GSKp8Lpyvn3Ch8RVgTqi9wE5iJ4o1U
	9Kq93olYigeSvlos5NFixuCJQISh/hbhTSogRzmi4hylvwke+2c+0bIttbyT7lKf0tq8iWACW3h6v
	1v9mWwTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4CN0-0000000CO0T-2DqP;
	Thu, 02 Oct 2025 06:00:50 +0000
Date: Thu, 2 Oct 2025 07:00:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull] pile 3: nfsctl
Message-ID: <20251002060050.GI39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

More stuff pulled from tree-in-dcache series - nfsctl this time.  Similar
to rpcpipefs and securityfs piles last cycle...

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-nfsctl

for you to fetch changes up to 92003056e5d45f0f32a87f9f96d15902f2f21fbf:

  nfsd_get_inode(): lift setting ->i_{,f}op to callers. (2025-09-17 19:40:40 -0400)

----------------------------------------------------------------
nfsctl cleanups and a fix

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (5):
      nfsctl: symlink has no business bumping link count of parent directory
      nfsd_mkdir(): switch to simple_start_creating()
      _nfsd_symlink(): switch to simple_start_creating()
      nfsdfs_create_files(): switch to simple_start_creating()
      nfsd_get_inode(): lift setting ->i_{,f}op to callers.

 fs/nfsd/nfsctl.c | 137 ++++++++++++++++++++-----------------------------------
 1 file changed, 49 insertions(+), 88 deletions(-)

