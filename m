Return-Path: <linux-fsdevel+bounces-7009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13881FB5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 22:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E521C21F60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 21:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FE310964;
	Thu, 28 Dec 2023 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnNCSJ/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F2107BA;
	Thu, 28 Dec 2023 21:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A8A8C433C7;
	Thu, 28 Dec 2023 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703798789;
	bh=wwUHoYtBd+l/dvrkQzEk/EWT4KkFtGnBMOmrOb5rNbc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZnNCSJ/MPyJRxmNBPOTxpTbrefK6sxdf7crP9oox/9fWUEjhGFZ6ObT7xmsmumoEv
	 0mFKXCe/3bVUuUjksxeFw0nxsHjUoeTjO6qxYBahwa4I2MaZrnikaAMhPuVbOk5c2C
	 jcL1UIDSoM9cEooVHXgFyXzB0GmXZwe5bk2FPB/ndPlJfBB3W7M5Nqds6U75Cbr8vM
	 W3gkedB9bj2J8oaDzxlpmyeV+r1y3KXE4PF/LZRezTl5LzO6W+X4k5fhskkljLaJgo
	 SmNFgOR+2Yg9Gn0bN2i+okDUm8oIE3kfSbqyJEbaLH/hweYHvDHnPcah1liBW3+8K5
	 i6McykWOEjm5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6FECE333D5;
	Thu, 28 Dec 2023 21:26:28 +0000 (UTC)
Subject: Re: [GIT PULL] more bcachefs fixes for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <2uukaswjjfuudinozm3igqtfwx2sgkmpwxp7t4jgq2icseoygm@sr3pst2cwvlq>
References: <2uukaswjjfuudinozm3igqtfwx2sgkmpwxp7t4jgq2icseoygm@sr3pst2cwvlq>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2uukaswjjfuudinozm3igqtfwx2sgkmpwxp7t4jgq2icseoygm@sr3pst2cwvlq>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-12-27
X-PR-Tracked-Commit-Id: 7b474c77daddaf89bbb72594737538f4e0dce2fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eeec2599630ac1ac03db98f3ba976975c72a1427
Message-Id: <170379878894.15710.480601333610120560.pr-tracker-bot@kernel.org>
Date: Thu, 28 Dec 2023 21:26:28 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Dec 2023 11:44:50 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-12-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eeec2599630ac1ac03db98f3ba976975c72a1427

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

