Return-Path: <linux-fsdevel+bounces-50394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64ACACBD92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 00:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42857168762
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 22:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA9253F11;
	Mon,  2 Jun 2025 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGjTbqkf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9B253F39;
	Mon,  2 Jun 2025 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748905071; cv=none; b=CWHTiKfWQM81qWmbWcJE9raTI5SR2UsORGHdjJ9dGI1aTEcUXoi6DscucfUpm+XHZdASCEgAIZPR6E+i9OkjWqUf8wpbUATudDaSp1/PAo/7cVhlE85gg+AndZxtYwH3ezJSddsbPjOXcFKetYftWMzJBbBNpZihlqaYfCWrKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748905071; c=relaxed/simple;
	bh=k0cmNWQ7GIbswY0BEDl86C7ti0iUcEqbtbNQ0m1xCyo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r5mK9xK1Am4vBBVPJMQkRJvOQZ0VoY3amATj9s084ZQcKZI71IPtkWVDk7MCVDT2yvvt4eBbOV/E4UgiYRyMTfooDK52g9+o6F9TWMwm+O6tJL3XVQM03yTQc4wYfdRWGrCNSLdBzTEvoqK1TC5YEnhXDhCHgJx7rSioYZ7HFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGjTbqkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C15C4CEEE;
	Mon,  2 Jun 2025 22:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748905070;
	bh=k0cmNWQ7GIbswY0BEDl86C7ti0iUcEqbtbNQ0m1xCyo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qGjTbqkfXrGcv8Kz2kEQQxHO0lcGb4fk2f1ncui4xLim+LkmEExM1psGCW2RDywsT
	 eld+MX+RnaQywxD907R7H4ZqNW5H3wpx/KZViZHgTRmcJglWRDTC4t8F9ai9V4lES9
	 iIMxf38p1yFNTYfzz0IN9y18voISI/C7auyHznvNHgGjzGIe3ULeQLWKlgOJ+Bw7/X
	 He7tl1jxfAVLIGqitkC02cLg9M14JlgAIPCoJehufFB+qHmcczGlWoSCss1+DGZxTJ
	 ZFQezKyyaeQC7JvZuGZ7FA72ndbYhsFViJshpC99u9GQxkUKP4rZrPX7F4GzZpnT3K
	 6iexCEIBYznog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE06380AAD0;
	Mon,  2 Jun 2025 22:58:24 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegspRzFpTreohM56=ztnjaU2gVFYnvF2WETaD+LiymB8WQ@mail.gmail.com>
References: <CAJfpegspRzFpTreohM56=ztnjaU2gVFYnvF2WETaD+LiymB8WQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegspRzFpTreohM56=ztnjaU2gVFYnvF2WETaD+LiymB8WQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.16
X-PR-Tracked-Commit-Id: dabb90391028799fb524680feb4eb96eb904ca6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2619a6d413f4c3c4c1eddf63e83ecc345f250d07
Message-Id: <174890510331.939710.2793870745688304395.pr-tracker-bot@kernel.org>
Date: Mon, 02 Jun 2025 22:58:23 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 2 Jun 2025 15:19:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2619a6d413f4c3c4c1eddf63e83ecc345f250d07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

