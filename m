Return-Path: <linux-fsdevel+bounces-22976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4219249A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 22:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C601F22812
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 20:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0BE20125D;
	Tue,  2 Jul 2024 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdsF9hJU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C3C1BA096;
	Tue,  2 Jul 2024 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953798; cv=none; b=B525/ZwfC/0zifdFWIf3jSYB+yR7H0bZeDQx/ZLK7eQtYDb8YUUfy+8YWIcEjUsMAxWlxlecG+t8VDyjtleUHQBakyue/+XUk3laaOB9gJIJJ7XSZapFA/aR62ZTRss3M0e/Za+8+BeMOL5sbzo7cYPzczN17gI5WwIkC3Vs9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953798; c=relaxed/simple;
	bh=pQOFBDK3jDAJf5H+jjZOSGLaf0hNHzIigPqH7V1kdxQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HsJQmLWIT7l/7mNz4Sw/YKf92ILOIcGmzgB73fhIUWtNsw7IWfwqTAIrGE+svMn7i/LSWs7bIGmGAVPOCQILVfcyfkgt1BjaZwXfDc83raZcD9V0tisz3wVoiF4K7oTd7XLwSkAeNpvkyMYTYvn92iQ7lSWP3/0Mo9UqXkkghwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdsF9hJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 162B1C116B1;
	Tue,  2 Jul 2024 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719953798;
	bh=pQOFBDK3jDAJf5H+jjZOSGLaf0hNHzIigPqH7V1kdxQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fdsF9hJUCdHD9MZzolsPbrZc00kvjZzaZqR6AcWQD2hhROu87eaA9lZIZy4n+hfOw
	 WSHBkfk1X17bjcIhCuoXRQ9JyhRsjSm7RI1YjWNN6q002C4jLl6QO0FBQYQWzSOEOA
	 51EmCY7D82Y9D32Ht/vnobRG0AiarY4i7jZ9GTArV8XZyykrHO/VtSdVIMwKHhk+f2
	 fY9OJEOXnHaee9pgSyYmN62kUQ7EZMdyK+2IL5h3u4k3Ev3hz8EuKVgO1biQrtk35Y
	 iB+U1c8NogQwvxKcNyFymabG68dmAvQq46eZP1ikqpn2w/QTmwfs+ls2v7CoBviO+v
	 4SHJwtHFPFnSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0113BC43331;
	Tue,  2 Jul 2024 20:56:38 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240702-vfs-fixes-7b80dba61b09@brauner>
References: <20240702-vfs-fixes-7b80dba61b09@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240702-vfs-fixes-7b80dba61b09@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc7.fixes.2
X-PR-Tracked-Commit-Id: 655593a40efc577edc651f1d5c5dfde83367c477
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbd8132aced4596ce8386af3041dfd310c8f42c8
Message-Id: <171995379799.5346.4648857822596764102.pr-tracker-bot@kernel.org>
Date: Tue, 02 Jul 2024 20:56:37 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  2 Jul 2024 21:44:27 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc7.fixes.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbd8132aced4596ce8386af3041dfd310c8f42c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

