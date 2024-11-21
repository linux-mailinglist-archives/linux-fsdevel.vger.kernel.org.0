Return-Path: <linux-fsdevel+bounces-35470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 938989D524A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 19:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC211F21886
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BCE1C4A37;
	Thu, 21 Nov 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgVvHhNh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87701C230E
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212281; cv=none; b=aAGEUZ8qm76FR5tmH3n1QfIxg4B53N9rwlB6mArazce2VZOOruH71Oq9aDTlln229+1u6vMyxqDIr7HNZv6rNf/kcieNj1UnpIRi75C8tWm7tfCPwM24FtNbE/xALqQHXXZM7SFzhsgJNjdAwlA/y5s2Dm7AWqffvnm5zy+D/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212281; c=relaxed/simple;
	bh=/usNy39tc+HwpBsDOJapbBUudGC3i0MNP7V8Cwwv9bY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OF/Nb8BxbeKyZV8NBndczrcnNBmoOmfqL2+douAPKLhlVUhX1xHhAwZBvR1EmETJmWLSmXn+2QTu6LartOo5U0mY3sROgR/PnVvR3mnHvlH779WMe1mPTI5+rhCX7SDRJ0Z+8aGb1p74OF18bzit/ZB+C6GtpjRbqiGogNJor1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgVvHhNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA98C4CECC;
	Thu, 21 Nov 2024 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732212281;
	bh=/usNy39tc+HwpBsDOJapbBUudGC3i0MNP7V8Cwwv9bY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jgVvHhNhH5/SXMrlbWuvDD9j8bCuNiaIN5sfHRCkcFHQgPZPhTLyynT7sIkA7fXjv
	 4PJAHziReLKD8PJjhkseHR3kJ+KiPsFJQMNJ4YTjUDhx+FheZx6kv/Ro04bYrnoNAY
	 ab1y/jI3Np0rF2+gBUjQ7wGMk1no28x7cS84wJAXk83OSWYyiLRvuTA+pzF8GFUueQ
	 F5pCBVE6HMUkWuv/8nAnEgagcAKYPZMKdcBToWJjGUBU433kyRfCJiifXUcVKK7C/F
	 5uT52kSBpWo5+0A13IPZ458dBr2Jp8UKij9xeth5sFcMVchdfalXRbGnpYq34vk/IK
	 jL0OWTab3xo0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD463809A00;
	Thu, 21 Nov 2024 18:04:54 +0000 (UTC)
Subject: Re: [GIT PULL] Quota and isofs fixes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241121160108.vu2g7nknhxrvqlkx@quack3>
References: <20241121160108.vu2g7nknhxrvqlkx@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241121160108.vu2g7nknhxrvqlkx@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.13-rc1
X-PR-Tracked-Commit-Id: 344044d8c9e256f86d51fd30212dd63ecb9f3333
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 597861d6cd343a6ded4cf0302f6fc25ec548e1cc
Message-Id: <173221229355.2032550.4598300179761894355.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 18:04:53 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 17:01:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/597861d6cd343a6ded4cf0302f6fc25ec548e1cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

