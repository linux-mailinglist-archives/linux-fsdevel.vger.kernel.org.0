Return-Path: <linux-fsdevel+bounces-16062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D73897759
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CF51C25C78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285ED1581E8;
	Wed,  3 Apr 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxjOmmVw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87929153BF3;
	Wed,  3 Apr 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165730; cv=none; b=WA+4jm6TyjJhS/mG+4BR+wDR23RM8g5ICy4gS2UUd6cQsvtDKWCJPuvkqIh2qdMKrFOzqT8eV++D5MVPBPAwbZ+1ZthmjqRInCj8kb1Jn/ahrEorboVSwDWNHnygJrPGTPkW6VljWj0p5bLtqQ+r9vJ5CeUFCph1G3rpHGv4CIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165730; c=relaxed/simple;
	bh=2Viq3p1Bd1ie0KUr3mQGEXe7edCstAXhzbPLpExk00o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VJFGriD8/KEttxf+zLydW1z0c9P4Um7pignHGXYIRQng0NkFxBMK9grOoKhRrlgDghhs67CVNVvInxyFrJYMkZpn63gI7xHBm50nz3kM5SbGFOE4Un0H+hwWc54HkgxrNRiFO3PONOdOm59bqLVgKJJr0/p0cPAlfGOhU5aRu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxjOmmVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DAB1C433C7;
	Wed,  3 Apr 2024 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712165730;
	bh=2Viq3p1Bd1ie0KUr3mQGEXe7edCstAXhzbPLpExk00o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XxjOmmVw/31rqjQK51GxFbv1KsX1mYseiC5LdvDuyTLNZJ8m3FTewWhtaHbeqBONh
	 ED0r7QNVtVxHeTJdeFb6jchgDRBuswPWMaTE1Ab2HBtpnnjaDR71iHjSTh0EpeQntd
	 +qeuExgx9ZKJeTcL5dhR7OFWEPrnJnUuVHC/1N4a2pj41w5aB2LJdwZ8WWvEJI+QhM
	 EVM6jZ4yHDF01Nh+xvO3TD7PcgOmTWaGZqYUG1nEpdeaa0PAJnZCqvuHIv3VxWkHd5
	 kzVumg6oszeCHjhdZ5RC/xAC3pWw4xffQJhi3GFBt1FIS2wT1XZ3ymCFpLj8ELYhzZ
	 9WH+cEMDVIuhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 570EED9A151;
	Wed,  3 Apr 2024 17:35:30 +0000 (UTC)
Subject: Re: [GIT PULL] vboxsf fixes for 6.9-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <88f45a04-4218-4d40-8338-86cbc4e3e61b@redhat.com>
References: <88f45a04-4218-4d40-8338-86cbc4e3e61b@redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <88f45a04-4218-4d40-8338-86cbc4e3e61b@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git tags/vboxsf-v6.9-1
X-PR-Tracked-Commit-Id: 1ece2c43b88660ddbdf8ecb772e9c41ed9cda3dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c85af715cac0a951eea97393378e84bb49384734
Message-Id: <171216573034.31118.10174074835328380199.pr-tracker-bot@kernel.org>
Date: Wed, 03 Apr 2024 17:35:30 +0000
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Colin Ian King <colin.i.king@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Apr 2024 17:55:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git tags/vboxsf-v6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c85af715cac0a951eea97393378e84bb49384734

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

