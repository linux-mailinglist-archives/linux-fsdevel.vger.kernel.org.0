Return-Path: <linux-fsdevel+bounces-14767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932E87F055
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 20:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE0C1F22462
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 19:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9202356764;
	Mon, 18 Mar 2024 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQuB3uA8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1E5674B;
	Mon, 18 Mar 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789671; cv=none; b=IrQ5mPiAZVZqvQEnaSgR6bEMao61yLrxcMCwVFhn45eE9gy0F6aoZWbVt4ACZXv2F7FbGQwF4QBpruVgUb/ghXrkjDwCJw5hl6iZVP3amSpm6AwdenbU7+ROZI0nLjkxUnCKGKKQIwssel83VJ+d8xElL4G+wr8Q9so96wLXGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789671; c=relaxed/simple;
	bh=U8wRvAwN9aKqnzbzN09O1Uh0bCMrFmOV0fyKWXUhUak=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fg4TXe7kgtRno8iavPZStRSMlEdPw2or6tDNC/fM0JiuxcW8sG6sGVEDINmuZqjED34Ugq6vIWQ2NZ8XVQlAuu382oIYt45hspyqkzy3Tn8fGo4AqxC1bUp08dHXTsKm/XzNwUXoRzcBYEBQ6WU8mqY2HmXHRTuaLXpZk29IAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQuB3uA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC801C433C7;
	Mon, 18 Mar 2024 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710789670;
	bh=U8wRvAwN9aKqnzbzN09O1Uh0bCMrFmOV0fyKWXUhUak=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TQuB3uA8aEbcIgyxw5N4K1twsU0fmIKASrlrwlcC+CRZfNLiO4yIp7PXzg8ayyWUB
	 Xt/nRX69/bF2eqdqcRdqux+aFSbXlH2TkpqCp3AoAjGP3uC8JW4hESmDYUCsVMYpvP
	 qv+S8THctBIZGNraad7WPLpas8+EecwQlCDlQSQE3bGPyLDaHwdzesp878GKGfdOQa
	 jWDUEqHelBkA8InEDLxKCUjEdodsKDWCXxH43jmanyOOmQtNfUp3dfLxmP9HAIPb5J
	 zehrUxikDMAffSC+GEsccqOvMGC8abqYuvRIvkajcFXSVKbg2+BPjxpxh6Dv3VkiPp
	 MH9MH2Gzj5h4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3CFE174C8D6;
	Mon, 18 Mar 2024 19:21:10 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240318170638.1229386-1-amir73il@gmail.com>
References: <20240318170638.1229386-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240318170638.1229386-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.9-rc1
X-PR-Tracked-Commit-Id: 77a28aa476873048024ad56daf8f4f17d58ee48e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d7ca657df77a3d97698d6ec392894362d2ad334
Message-Id: <171078967072.17817.14742380840410500097.pr-tracker-bot@kernel.org>
Date: Mon, 18 Mar 2024 19:21:10 +0000
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Mar 2024 19:06:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d7ca657df77a3d97698d6ec392894362d2ad334

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

