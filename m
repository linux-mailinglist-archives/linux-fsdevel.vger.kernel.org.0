Return-Path: <linux-fsdevel+bounces-56439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B8FB175D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 19:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897051889F02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 17:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E212BD588;
	Thu, 31 Jul 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffnpKXlX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441BA20CCE3
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984472; cv=none; b=fh8/S2fyUx4kMFdgFV+exWh/Qstp/LlgsF4AbNxlFMDKxf4X7cnAC9sZevXK+EfTtl+eCNlnlotlGPLmOp/Z+uWX+g95Pohcq00xQp8qCsgEV033Ubxd6ZYZe5aMt0TC6dt9wcv4Q/2EBcNEU14CKj7sCtzo2KyHc1VsNQOYpg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984472; c=relaxed/simple;
	bh=QB+3PEFxl/7R/M37PX/L16eipvBNm1IPQP7SE8xE1/I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ID96Na0XLX8THWJ0uw/33Wzdbj0GHJcpbBMUgzNCI+ztbYj+i5B5sgheXUahzTAhHD19DX8Wmgc0eGCI+Fdfjyaaom85SHuaogWSsFuUyUXoWMt71aWvH0RYLsQ5JRe8zhkq5MJfd4H7wENVOJjwjmJ/f29hTFSoJKWvqHjiJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffnpKXlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8189C4CEEF;
	Thu, 31 Jul 2025 17:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984471;
	bh=QB+3PEFxl/7R/M37PX/L16eipvBNm1IPQP7SE8xE1/I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ffnpKXlXxUILqfly2tAy46YEX6mg4S4M+NZp25Og0rWz0YZELWid/XisFpniYbSm+
	 pno+oR/4nocWrcD6lAzc7xuZszWQM3Tj0TPdXPY19LKqgxuP3K+pk/VxvxQzUFpVTG
	 npy2eRH+WF7DBfog54ZRzS54R3QPoOnEXVdjEs7LSJjCW2RGCCybrw9FsHTSoNeeic
	 I1RG6HKK32Rf+z/+qrn/womTU+0oDnqxDxZTMUKuM5K4dm+n5wFMS517Xa4tmu8KiE
	 um88NBFHZERvOrhyau6A+a8nbTKkk5jCkVEMj1BOGPq2SMK32/QsqlEW7L7RhS6tiz
	 SlA1TP0RCdxkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE56383BF51;
	Thu, 31 Jul 2025 17:54:48 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs fixes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSSTTgDcyex2gGK5V+JmaNfdXJidWkSkR8XdM+i2SN8NXQ@mail.gmail.com>
References: <CAOg9mSSTTgDcyex2gGK5V+JmaNfdXJidWkSkR8XdM+i2SN8NXQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSSTTgDcyex2gGK5V+JmaNfdXJidWkSkR8XdM+i2SN8NXQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.17-ofs1
X-PR-Tracked-Commit-Id: 2138e89cb066b40386b1d9ddd61253347d356474
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac46ff0f77f1298892a4a1eeac375ed3db495704
Message-Id: <175398448727.3232013.3361407289219669771.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 17:54:47 +0000
To: Mike Marshall <hubcap@omnibond.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, devel@lists.orangefs.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 16:51:20 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-6.17-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac46ff0f77f1298892a4a1eeac375ed3db495704

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

