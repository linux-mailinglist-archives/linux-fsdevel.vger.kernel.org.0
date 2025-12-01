Return-Path: <linux-fsdevel+bounces-70385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB32C9958A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 23:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D93AA4E320B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D2A2D878C;
	Mon,  1 Dec 2025 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAcvPJZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900A2C11EF;
	Mon,  1 Dec 2025 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627080; cv=none; b=d3p4SOpKzaaguLz8Bk/IFChYtHN9erwFOZyfw4kAxjm/7rHAKn3PtUIoPyu/sUXjuiDY0UavBqA/Cb3+WwBb99ZPxMyn9FF8/XUUwfdc73AlIgebd+E+O/r4cbzSb4F6j2wcHqwmgEQNXamR9VSzyRGwXwPtM9U0GRawce2eJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627080; c=relaxed/simple;
	bh=vVPgRA00EWHqyPMgj1sDrioxIk6HH4SG7ynBsE/XHzs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hEX1n4zoadEIKB6rrDL99wn3l1SksJR6i5DDdLj0t1KQiITYiySF0YX+8GNuaqPD4N8eEvR11D7iGbjPj+dpDnRj2+VGduA/lKq+DBpbOkysrt4OR+TGs8ioTz73aEbJYQwQ5dlhHg1qmxezUpJjbG8RUbONEnS91aYjOqd/GqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAcvPJZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53934C4CEF1;
	Mon,  1 Dec 2025 22:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764627080;
	bh=vVPgRA00EWHqyPMgj1sDrioxIk6HH4SG7ynBsE/XHzs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NAcvPJZV4m/uqWBslkONTcyc3cgycSIWbxpQhbnZnO5CJokSMt4jpLphJXVNZX6dp
	 rPzuFR5Gkw6yKpFrGFjBkRr86SEPRAtzSKVaWbEqQZxPiNhs5F2grBS87uOXudahda
	 cDia2whpI0Jv0KwBAGTFetgL0FrtzcNBkMVGbp7kTHQfHsdlDNE6wPE8gkuCge4CmU
	 48E8ijHzP0gtvXqFG7yP3308YBh9AFnQwdKea5Y6LkwOnb8IZqboShpWDjxkrAqbe7
	 Ei4xldv7bon8TOO45HfarE8JYi5YVO+Ib+Kxz1Zdv9H+BNB8DJ88JA+v7BjX9g0+iU
	 63rcwm7zR5jsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78F48381196A;
	Mon,  1 Dec 2025 22:08:21 +0000 (UTC)
Subject: Re: [GIT PULL 01/17 for v6.19] vfs iomap
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-iomap-v619-1b28bca81324@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-iomap-v619-1b28bca81324@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-iomap-v619-1b28bca81324@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.iomap
X-PR-Tracked-Commit-Id: 7fd8720dff2d9c70cf5a1a13b7513af01952ec02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1885cdbfbb51ede3637166c895d0b8040c9899cc
Message-Id: <176462690003.2567508.12819857894953086162.pr-tracker-bot@kernel.org>
Date: Mon, 01 Dec 2025 22:08:20 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:12 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.iomap

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1885cdbfbb51ede3637166c895d0b8040c9899cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

