Return-Path: <linux-fsdevel+bounces-14515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F67687D2A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13981F230B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E82548F6;
	Fri, 15 Mar 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGWLD6Yp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0451005;
	Fri, 15 Mar 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523218; cv=none; b=kwsUSclf9bDFUr0yxL4uIH9BXQLjpDbCTsGxFqP994y78xtPgSTOEQO1LrTM/OfNOaz42jFW0pfmeTimkKf08Bi9rwrfJgz9q6t+zUclKER8LuWKDicwmCS/bn6AmW7hrHGvzAoC5Ow04N9O5T82Kds0eC8wla9hJnY9YXZP2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523218; c=relaxed/simple;
	bh=+u4xGtc1p6B7BY3fOhgranOb1hZ7zUFeqB01PNXjYOw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dAb7B14jY8sk+moDYgRrRLBqPioC6JD7TXfiBW9rT7XPMNP7OQ9tiCBzLIsLIAnleYuOVCLHD2wZlPct/s0wjjELTj5SD6hdsqneAVWy+th6ktGrrtVe775CqH+hBbK67UsrGOIChDNZ+roTJqBNWnlmnYmO0v8y8iquhOhcKKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGWLD6Yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49562C43394;
	Fri, 15 Mar 2024 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710523218;
	bh=+u4xGtc1p6B7BY3fOhgranOb1hZ7zUFeqB01PNXjYOw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qGWLD6YpDM7BMxgAcIr8Zu27jYTDt0/Z9U9sYlBhAbcH4LofIB3Qxsqky3CoScgL4
	 iRYwBJ3CuxdkAVI/G4j8WWuTb843iBFl24oFAfPKJnPXLeuvP5LcwSpsLg29TiKp6A
	 H8Ul32lJkXI0FjmqBk9zwIm8RachkGGJ3kCyEfrJGkznhe1625vpkjM9AH8SOVpyAQ
	 +oCYyeXK09bgUiOlQF8Bu6QFo2QQ7RXSN641s7vJG03JEK40OPfJ02gHobWqn1Upx8
	 rJetjv707Oc59V3LO7xCd47cB7zxvzwakiHjRh348PPuFfzD7RuAv0IEFcLNLlwKt0
	 BdyPcObPsyLBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 366EFD84BA8;
	Fri, 15 Mar 2024 17:20:18 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegsZoLMfcpBXBPr7wdAnuXfAYUZYyinru3jrOWWEz7DJPQ@mail.gmail.com>
References: <CAJfpegsZoLMfcpBXBPr7wdAnuXfAYUZYyinru3jrOWWEz7DJPQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegsZoLMfcpBXBPr7wdAnuXfAYUZYyinru3jrOWWEz7DJPQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.9
X-PR-Tracked-Commit-Id: cdf6ac2a03d253f05d3e798f60f23dea1b176b92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ce8b2ce0d7e3a621cdc9eb66d74436ca7d0e66e
Message-Id: <171052321821.31681.13880051934148095319.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 17:20:18 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Mar 2024 16:40:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ce8b2ce0d7e3a621cdc9eb66d74436ca7d0e66e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

