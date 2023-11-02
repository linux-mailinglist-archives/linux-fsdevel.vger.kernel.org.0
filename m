Return-Path: <linux-fsdevel+bounces-1874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360DD7DFA06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 19:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2921281CC6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 18:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5161DA39;
	Thu,  2 Nov 2023 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRdSJrsC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4528FA
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 18:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88735C433C9;
	Thu,  2 Nov 2023 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698950259;
	bh=olqP1oMlJ6GffnPZ/1sTsnwDguWh1HMrT8phYIpAOcg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oRdSJrsCEOtDKTypTYSjEGqhv+0Rin866j/uiBTXNXFMIOmiYfQiPAqehwd84W52K
	 8tvmBTxnzrY6Ec7r+RpFFFtALPSJpI2u2NIKZZHKdWQt8bgcDZDd+r7Vrrh+zkbvnf
	 ieaSz8FmQPgGME3QEhGXY6tm4Ouqz825sY/htGPogbnGuMyq2wGzyL7T6rANalRpKe
	 WEMAmG/UfGRN2okNRHHdmVuLmYcdDZacsM2aC98iN9mFPnkOHIUSkvTOuYU7ahlgaT
	 wwlN/pkOLhBXF8RMudo5SUbwiQ0dk7g5mKd+RHUdrnMjTD42jWuNGyxTznKzOP+lCu
	 MCATYOABHJhjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7392BC4316B;
	Thu,  2 Nov 2023 18:37:39 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for 6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231101103150.xa6ghs54s6fz4q7g@quack3>
References: <20231101103150.xa6ghs54s6fz4q7g@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231101103150.xa6ghs54s6fz4q7g@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.7-rc1
X-PR-Tracked-Commit-Id: 1758cd2e95d31b308f29ae3828ae92c8b8d20466
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71fb7b320b2820903210acd60427e09b1962cfd3
Message-Id: <169895025945.19486.6220059415593142678.pr-tracker-bot@kernel.org>
Date: Thu, 02 Nov 2023 18:37:39 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Nov 2023 11:31:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71fb7b320b2820903210acd60427e09b1962cfd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

