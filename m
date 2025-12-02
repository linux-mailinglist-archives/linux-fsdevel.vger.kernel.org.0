Return-Path: <linux-fsdevel+bounces-70423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BDDC99F4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 04:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B6A3A5EAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 03:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED09281357;
	Tue,  2 Dec 2025 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMHICWZM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F327CCF0;
	Tue,  2 Dec 2025 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764645727; cv=none; b=XEpnv6/qjZsvx+Jkd92/U5rDul8/ljHAHiIBUTKqpstv6oyqmqiT0rBSZZxdBHtz4lfZs/e3960BOjJtsRJZHsZsOLllvHh9xQGhoHU55k2A1kdUKlLYE4F0oSCqGRD1lU2YDXWRSa8BCMz8+HhYE7nt6DDmtgrP6d3FS3iQtG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764645727; c=relaxed/simple;
	bh=HESrXcLd8LQ8c9iF/ZKdmJHNMo/4Ox293Q7pc1qRlyI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GzbzgdUSgr/kkevczM4upkPjv4DQJ3ql/VJXP41mSHRgBeSJzH+h2Tkpe8DgsuTmRjEQVPkT4sJUyEIbpM/aJn/Ujpdu9VXPOU63FIltdonT6RRGfDvUG8g57LXOZTL0k8Lp7Kjz/1UsDUACuu9DxEKQB8I4aR/2cnYpdBk2Wvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMHICWZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDB0C116C6;
	Tue,  2 Dec 2025 03:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764645727;
	bh=HESrXcLd8LQ8c9iF/ZKdmJHNMo/4Ox293Q7pc1qRlyI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MMHICWZMa5sQrRmb+payH6X98TChdXKtXQpsJXYXrlIuHdcrJnPSxPna5u7KSZt4H
	 AVM3xbEki2WhLEPrd1Bk11rFkLGMrdE2IxMt+xyLuHaNiHEBO+hnA39QDY+fM8+/T6
	 R+bqLgkiRl0rGSaNOktC7Mf+pffj22qEm//KCWDrkV+XBFN8iM4siI+fT9qDNHgI0a
	 R8mVNxW0vYPKjzQgTB+QDY7UesxABRu1WgLIdiVzE/AoInpSRXgxgqxOu3ucX7vr0A
	 NUm1wPpM9akcoLmxlJ3MybNAh2Fsr467HU6LW/BpRqZ/XZfvVFcNynqkyt/kqbfcTP
	 aXg2LlX23yGpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 790C83811971;
	Tue,  2 Dec 2025 03:19:08 +0000 (UTC)
Subject: Re: [GIT PULL 13/17 for v6.19] vfs directory locking
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-directory-locking-v619-311b82e68064@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-directory-locking-v619-311b82e68064@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-directory-locking-v619-311b82e68064@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.directory.locking
X-PR-Tracked-Commit-Id: eeec741ee0df36e79a847bb5423f9eef4ed96071
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8058f8442df3150fa58154672f4a62a13e833e5
Message-Id: <176464554710.2656713.18436199642848682503.pr-tracker-bot@kernel.org>
Date: Tue, 02 Dec 2025 03:19:07 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:24 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.directory.locking

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8058f8442df3150fa58154672f4a62a13e833e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

