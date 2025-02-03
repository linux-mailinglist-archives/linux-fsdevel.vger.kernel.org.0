Return-Path: <linux-fsdevel+bounces-40669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C724A26605
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3770162BCE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 21:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E417E2040B4;
	Mon,  3 Feb 2025 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpWULPTb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF278F54
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619323; cv=none; b=GVaDHkOAlG91FMlqbHTvcON9pMcw1gmfb6Z69UITZyYi7pflRQkdaeOTpd6ls+CWQf/fdsDwy9vOiU/fHUMayuv8lE5lUkljzOCIluYrorMh7Z4nDA2hZm/MFJ8+OpN5AeURhukI9p3YUvtpgjC0ygCsjn+S1HIKOMrWejnEPK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619323; c=relaxed/simple;
	bh=vnNMqdsvOuhYi9QUWW4dDyGKD72503pgxX/WPcdJcD0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lXSa4ZrfL7NLOcfJOgcS/GtH1qB5WlsObWNZ8dyj/2+cDmUS/Zt8/HXywdL+1TFSjcpZAbEsXmjaertY5c630zWPSiqzzmgqWxle5jzLbo+uMTJ3Dj36x9CB67FP1eY7bIkugVfMu2gsLmU+TvTmeEjGupkhiMwXs4Ren/1S1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpWULPTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B850C4CED2;
	Mon,  3 Feb 2025 21:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738619323;
	bh=vnNMqdsvOuhYi9QUWW4dDyGKD72503pgxX/WPcdJcD0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JpWULPTbUiQbP89H8z/9QkHJhfl10qN+hwYn0+f0pj8d0jrOoxAmklSRjoQomIo0+
	 DPmSINSzaEEwhz3LPWNqrXbNuaxTJROROm4h5bM4dGTsBhyf7H0xF16+5bi5VvmgB5
	 j2I8qqjq6ucS7BUOLsKb4Ee7QFdEraXj/0QbFcPvtWbX3UmDMwOMXdD0ZW0y0v5M7a
	 IKBWeb5A4mXHS7CWMmD6V+Ph154K2YHsxEQ0ufDhxr2gxwFZKztwT7zK6iDknH8WiO
	 9r3ERtfDzJXROjjKxEqamLctdzTtA4EM9MDr47LjkPw/IGCuN4NjRUI+4GfI2BI194
	 Fb9pZD3g1DIUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F6F380AA67;
	Mon,  3 Feb 2025 21:49:11 +0000 (UTC)
Subject: Re: [git pull] fix for regression in d_revalidate() series
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250203211637.GA1977892@ZenIV>
References: <20250203211637.GA1977892@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250203211637.GA1977892@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fix
X-PR-Tracked-Commit-Id: 902e09c8acde117b00369521f54df817a983d4ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0de63bb7d91975e73338300a57c54b93d3cc151c
Message-Id: <173861935000.3512035.9334732335462804484.pr-tracker-bot@kernel.org>
Date: Mon, 03 Feb 2025 21:49:10 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 3 Feb 2025 21:16:37 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0de63bb7d91975e73338300a57c54b93d3cc151c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

