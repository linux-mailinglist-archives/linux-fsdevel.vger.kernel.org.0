Return-Path: <linux-fsdevel+bounces-7275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E399B8237A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F71284328
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0473D1EB3C;
	Wed,  3 Jan 2024 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFdqC/0F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1251EB24;
	Wed,  3 Jan 2024 22:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 415A1C433C8;
	Wed,  3 Jan 2024 22:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704320345;
	bh=6O/Uk8aKPJQgS2gexoGKPVyyCafx/btMDUEMY3NUN1A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YFdqC/0FDp7/g1yjZZb1u+uIxxpbTp6gR2AmbJGlZdwDshjUgUyi0YYQO6S7mdR5I
	 MYuW+edwfqJAQ955XIDhzGyvXxsKReqABCgVICUX1DEESvoCTaui6YZ7ZhS6SSJwBg
	 yFRhFgZLx2Ut5Rtge3Bc4uxZNHm0D8KB0UvgHa3+QsGd3cFtmwnTv9VkS/wS0NJPFz
	 wPku9c++87BYGPFlURhXPkGjrZoodP0kAOAEC4rR//rEU7aZFllLyzLheS0jaJN9+f
	 Rf889Tj5RGmtfnkU975jF8mMn+U8f0BtO5WPxhVwC2dVbBuPqsb0T3K7nUVdvgSHGs
	 C0aWfttxCN15A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2812BDCB6FE;
	Wed,  3 Jan 2024 22:19:05 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs new years fixes for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <o7py4ia3s75popzz7paf3c6347te6h3qms675lz3s2k5eltskl@cklacfnvxb7k>
References: <o7py4ia3s75popzz7paf3c6347te6h3qms675lz3s2k5eltskl@cklacfnvxb7k>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <o7py4ia3s75popzz7paf3c6347te6h3qms675lz3s2k5eltskl@cklacfnvxb7k>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-01
X-PR-Tracked-Commit-Id: 0d72ab35a925d66b044cb62b709e53141c3f0143
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 981d04137a4b5ea95133572bdb3d888c9b515850
Message-Id: <170432034515.19489.15575432447802603893.pr-tracker-bot@kernel.org>
Date: Wed, 03 Jan 2024 22:19:05 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 1 Jan 2024 11:57:04 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/981d04137a4b5ea95133572bdb3d888c9b515850

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

