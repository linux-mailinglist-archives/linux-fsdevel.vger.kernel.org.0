Return-Path: <linux-fsdevel+bounces-42599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46414A448FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131FE164A36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617E719D881;
	Tue, 25 Feb 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sR1cjay7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A019CC11;
	Tue, 25 Feb 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505917; cv=none; b=VgGZOYtsoOaYjfPOnvkRmTjn673hMFomTUgvu2Fy1XrHRYp+7YBlv0qr96B3MHvDO0b3xUgvPxPMIAPZuXMUmQzU7PD3fcIlhtViZa9lNor9/Bt421A6Yyf91poEmxpSpuCi/84dtVa/MijIon7mtamlvRFT1wGKd8Pn7bxJtGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505917; c=relaxed/simple;
	bh=nf323NbiW/UOuZbUeAQs8c+WNZe3q7/PW8n1P3j9gVY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gI4Fnq/zgiDxCttznL+9rl3plbY1D73ue/rxE0Z2qNxf/uMYTr56vrl42+I3mqI1XTWBKDz02zK+wesFHT44GDSXFgJ63mUkcDWdKjxx00cdwev+FLIO3QnrI8242IL1K5Sw9yVou4u4g1iPVTrfHAeHaelmQo7O/16RNYWhCJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sR1cjay7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E43C4CEEB;
	Tue, 25 Feb 2025 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740505917;
	bh=nf323NbiW/UOuZbUeAQs8c+WNZe3q7/PW8n1P3j9gVY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sR1cjay7e5+LWy7WrHeDXoukC+o6pSYduFR9/V1GH9EW7u6N+TOhUcnmJGPszIvNC
	 7ea1MNFc8hw7fbMZ0PceUMMESROy1GpItG/CU62JIsX4282JgVkKwKuQAaW3em5pIF
	 E6Bt4UbUjJn+tIeKgBw35vTL6kE00Lhgzkh56M3qztT6ePdV9EGRn2VcBYEsuC0OxZ
	 hqv5uwHQN9jil+sly8X7sYvfb3n3uvytmAXKHKP7MOLQoqiKqpSduSGJ1LyJ7ZeYMd
	 ZRbldtgZODfYo/FNzGhf4bCBvnWCyr9lznKDEAWxf5qFuRDVPg5igNOX2Me3Ewmp4u
	 rwelNiUWrsOsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CBE380CEE8;
	Tue, 25 Feb 2025 17:52:30 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250225-vfs-fixes-093d8cb2fe3b@brauner>
References: <20250225-vfs-fixes-093d8cb2fe3b@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250225-vfs-fixes-093d8cb2fe3b@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc5.fixes
X-PR-Tracked-Commit-Id: b5799106b44e1df594f4696500dbbc3b326bba18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d85d6c8539950dfcf4339f9ea865fb5d8f7ce03
Message-Id: <174050594890.66280.8118691533894692775.pr-tracker-bot@kernel.org>
Date: Tue, 25 Feb 2025 17:52:28 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Feb 2025 12:51:12 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc5.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d85d6c8539950dfcf4339f9ea865fb5d8f7ce03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

