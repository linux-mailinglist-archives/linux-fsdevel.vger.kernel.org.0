Return-Path: <linux-fsdevel+bounces-41267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72B8A2D06D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 23:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F573AC2F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 22:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817921D0F5A;
	Fri,  7 Feb 2025 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WI5994/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA01C700E;
	Fri,  7 Feb 2025 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967128; cv=none; b=av5kohfw2D90jgjpZdDCGsSiZeHlolKErcrY8XGZUyLXSZff3EXwANxyvTFHmzG9SmiESrZUDcrWXeUGKSmaQMcHUf6KKJvtX5+JM6l88BHfWz04hxixnIY/lRwCYLQYhVKmdfS7HBA4SMoxCeUdHDLj84XSXB40VpC32NqFlFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967128; c=relaxed/simple;
	bh=w4NZfenP2gP64AtvDvAeTBAB5PW3D9MybjAsXzXHQtY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eAWHf9AUzmDoMYHK2GqDK4XTGLXyJuYl4wbW+Q4h4plI6pvQD/pHRDgK+wlUs8IeK3HOHDrFCNhb8PBPfmfa1dQerUn44fC971M+YcU1z48EgvwhjNEI6ArbEXPqip3rmH+H5AxbMwcaGyY+4awmQFrO7yGE9GMdcqaBztrUjmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WI5994/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE93C4CEE2;
	Fri,  7 Feb 2025 22:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738967127;
	bh=w4NZfenP2gP64AtvDvAeTBAB5PW3D9MybjAsXzXHQtY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WI5994/Ye0vsC6E93WJHxtDDL1wS/DAM2PkRuK6gZu9ZBYaqz3AEknnlAmtg8rN/2
	 rbkC+2uEkrP42t4jrUhXbf0eq3McgrLl1m9hhomD5Wokknz09L/U0V67V7nGkFkbDj
	 MUM+4TdIZ+Inj952+MgHdlu2QpYJDBAr9VongYY0rLFTt6BlHKCH22veIqtqtIT0Pq
	 XXW8ALUtEXiSIVi5+0zS4WQDSVmwRQctFKkC+hbsi/8WYa4I6C91Yz/i/bX+0YLlKy
	 vrTDDbPSPWVOvCj41cW3O13nUerssWCHljQmX+b+xz5F3Lth95WwBifygBG5ou+GuH
	 O6qjxwnFZb3Dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCA380AAEB;
	Fri,  7 Feb 2025 22:25:56 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250207-vfs-fixes-304444b009fc@brauner>
References: <20250207-vfs-fixes-304444b009fc@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250207-vfs-fixes-304444b009fc@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc2.fixes
X-PR-Tracked-Commit-Id: 37d11cfc63604b3886308e2111d845d148ced8bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c67da5bc11a79833d9fd464e82b1b271c67fc87
Message-Id: <173896715568.2405435.10562300116506440400.pr-tracker-bot@kernel.org>
Date: Fri, 07 Feb 2025 22:25:55 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  7 Feb 2025 11:52:03 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc2.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c67da5bc11a79833d9fd464e82b1b271c67fc87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

