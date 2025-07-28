Return-Path: <linux-fsdevel+bounces-56194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F971B144CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93FC55429BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8025FA10;
	Mon, 28 Jul 2025 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX0CsC4V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0856323C4F8;
	Mon, 28 Jul 2025 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746026; cv=none; b=SDQ2toJXRa6o6eyDamN/ooLOSHsriOzf1j8kpeSbmA+h7TVRz12dAfVR7WwpEO/n0sm+6o3GSqNB+3g0lZaNrsg6dIuE81ny2OrBq3238nCk8yuGxdRzgEx/qwPgXqYB1MAn8BHkg6Ifp/3F5tTS2TAvnZcH+YWQs675fHYk6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746026; c=relaxed/simple;
	bh=radi/XzBme2Pvoo9EBdhnebSVpwewRLkmxX/V5KM6J0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ScdQn+SzHkJwDKkBOAaRc0FdOnPoabm2R1X2k854mbdFHujvDfgHWj2uk84UIFfopJlyDRKoDH0lrbWr+7IgTAcqZZYfBRNXyvkrO59udC2iTxUz7UI+waCWRNxunJO05PBEZkYZIR4M/xcVTi6bLFGLJ2J3Xiom8Y52A7S/55M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX0CsC4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04F6C4CEF9;
	Mon, 28 Jul 2025 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746025;
	bh=radi/XzBme2Pvoo9EBdhnebSVpwewRLkmxX/V5KM6J0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NX0CsC4VC/zKYJeadQpdv7I8iRtJGeZBSiO0a9NznUI2OJLOI4qkc5I25vhTS/wH8
	 4Ypy1NoJV1nTnkJl+78CH9bQqI2r7INJkjImvTugC8YOH3lHa8WR27xwA7YVwB6TKn
	 y/+KkU457VSm93C0F1Tco3KCNfqaUTxoK2z7Vjtzj8mL/8Nm28yn19iEnVy74MprLo
	 tmybGrWPNX9LAgKhBdb+sAoaCq3+3Vc2w51i2Xd1Bm5Z7OWQK/pM1e35SqCMe3ugGU
	 uVyS7LnaKoTHgOjlyczWN7VbSdU+vfzCa0L7eRJJopI61uI+yYps6HyZK6b5UiTrrO
	 w4xkytGmXaXjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFFA383BF60;
	Mon, 28 Jul 2025 23:40:43 +0000 (UTC)
Subject: Re: [GIT PULL 05/14 for v6.17] vfs async dir
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-async-dir-c1ddd69d8fd4@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-async-dir-c1ddd69d8fd4@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-async-dir-c1ddd69d8fd4@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.async.dir
X-PR-Tracked-Commit-Id: d4db71038ff592aa4bc954d6bbd10be23954bb98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c4ec4a339b435381bc998f74862bd7a23d33f79
Message-Id: <175374604260.885311.7035210059585680390.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:42 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:14 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.async.dir

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c4ec4a339b435381bc998f74862bd7a23d33f79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

