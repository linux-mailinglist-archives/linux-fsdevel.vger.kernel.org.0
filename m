Return-Path: <linux-fsdevel+bounces-50091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7976FAC81D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 19:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3DAA414C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF122F173;
	Thu, 29 May 2025 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0xX8eS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473078F34
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748540918; cv=none; b=aQ0rPLqHkpNeQcXF3SKInMX9CAb1enoCySZc4T773kWrsGA0BQFRyFEcwUBnhZUuxXoWbuF9Md2NznrvrUf/QBDz3qrB9PycMYM186i9WqNCzSS0mtEcxYE+d8yzbP8Dw8UBQsn8oZgLg88LWhgNk+lRYo1HeJDLi8rUmR/PQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748540918; c=relaxed/simple;
	bh=yZ9pyRGOYPeQ81pkpCqMMCPgE2XDYrOAPPTk92GQ8pE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O32xT7pZBRaubMIMtDLG7TlOwhbzxncQTPG7Ll9XMdxmvIQn0URvvGtnq1WVNMAoCP3D+g1h7rzo3i/sR4NwGGT6L0KWqnZS2qf078AWEJeMhKHiXJ9vOW++r0A0EYaxjpb8gB4XDHVBHHe5QXzCGz4VGdeXLmM2QkNgMFHb/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0xX8eS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07068C4CEE7;
	Thu, 29 May 2025 17:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748540918;
	bh=yZ9pyRGOYPeQ81pkpCqMMCPgE2XDYrOAPPTk92GQ8pE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A0xX8eS9gChtsXQkvgGY8/BP+62XShDCy3U8Jzww2Fi9d3va6MjMxJtWGir8SdIVo
	 BkiDSLmpit/dh8Xinyap8uShPSuoDSo/JvpeAt1h1F2JgJDov3o7a71iMtjpaVX4uG
	 ljxnXIjRyaHhAjAllI5Zh6w0SfaT0tTp4Rqk6wtSeyiGcQEP8/yG1MOVM9Shmj7u+q
	 Pgi9luvu+rSWGphsMAlqmnnWFGtjcH7nBPLcnt/BdKHHGseaCgtW9lzFFnlp22e8FV
	 kVzWxV6jPZDI1mULJqHTo+jrC7UKzRqwMqSZeuKnmrh9zjuzfBOmIzRiGNyKvWBalX
	 CphEhL2/6UyAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE9E380664F;
	Thu, 29 May 2025 17:49:12 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify changes for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <sfxqwp3nbyrg66yio3h3qco2ty4pwsbql6m7goid22ewkybuim@3jhjq5wfcoe3>
References: <sfxqwp3nbyrg66yio3h3qco2ty4pwsbql6m7goid22ewkybuim@3jhjq5wfcoe3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <sfxqwp3nbyrg66yio3h3qco2ty4pwsbql6m7goid22ewkybuim@3jhjq5wfcoe3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.16-rc1
X-PR-Tracked-Commit-Id: 58f5fbeb367ff6f30a2448b2cad70f70b2de4b06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db340159f19ae083afb33fce0aaadc77c6b0d547
Message-Id: <174854095149.3342178.4273474472274915985.pr-tracker-bot@kernel.org>
Date: Thu, 29 May 2025 17:49:11 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 29 May 2025 16:58:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db340159f19ae083afb33fce0aaadc77c6b0d547

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

