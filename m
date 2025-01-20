Return-Path: <linux-fsdevel+bounces-39718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E2A172E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E42EC7A4294
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C91EF0BA;
	Mon, 20 Jan 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir3KgRS/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F21EF0A6;
	Mon, 20 Jan 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399567; cv=none; b=gNS9iZoh3cYEatvQtm5z159l1ukk9gy10MZUgiRles5i+Lbm6Q6Ev8QguAasQjf97YzKBgjWBNm/og/fGKIfo/KGyEwIH+dXstvXlJXCQ84MPpFv81IOHUw9OGM7m9X5NYsqgFVx6Snnq20zFCej8cHFhBzcL3UEyIueEgoeZQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399567; c=relaxed/simple;
	bh=tDHHvva+BTi+l/HuSz59wEzPekuCs8W41/h/s6ZlCqE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nBHsvV2TBxGU4rSHji5B9AFXUcEnVAswmGeJF3ThPHBUNtati0bJh2z5GZl20ravls28ZSCpDEDClKqoaQ30O7mlxmKZ/s1vqBpAhhs19Fl/BC5IudoSQhN79ZLcwWS50CLVP8rTmUmqWDdT9adebg09whroCTifDy8d5AM7OpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir3KgRS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE5BC4CEE4;
	Mon, 20 Jan 2025 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737399567;
	bh=tDHHvva+BTi+l/HuSz59wEzPekuCs8W41/h/s6ZlCqE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ir3KgRS/qQsAbJSiFjPxSrL2EliQ4d5Hj9ZKug1IwLHVB4EuMUCpupBb3w9gZcvTm
	 RtCro7p97OndWuprKSGDMfakt71slgBBiwkSkDV9rDgsaDxrLf4toz3qe8+qe5iM3z
	 cEmAJ07afudm86Mx9p5XL8MbKvX+vKjIG/EBzu6pKJtwv1GNNsc8iX7fNXDinVtyvl
	 5Fa4db9X78tr5Epunp4Q3+3tOHKpJF7UmdXfQnIZ0yQbSMuBDr344ZDa1xjpfDUTYB
	 HIsJc5EVeTg1zGTyZFJooIPk4Krxfk09etwOO+CywOBlGyijB9Ll4WHoLtYRoxY8Um
	 6od47TAKAVMlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35497380AA62;
	Mon, 20 Jan 2025 18:59:52 +0000 (UTC)
Subject: Re: [GIT PULL] vfs kcore
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250118-vfs-kcore-913a66eabd03@brauner>
References: <20250118-vfs-kcore-913a66eabd03@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250118-vfs-kcore-913a66eabd03@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.kcore
X-PR-Tracked-Commit-Id: 4972226d0dc48ddedf071355ca664fbf34b509c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5829524243652409e3fa2853736649674c294f0
Message-Id: <173739959083.3620259.5784955941437335363.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 18:59:50 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jan 2025 13:56:55 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.kcore

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5829524243652409e3fa2853736649674c294f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

