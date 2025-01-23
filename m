Return-Path: <linux-fsdevel+bounces-40014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E569A1AD16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 00:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B70B67A25EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 23:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72551D5AC6;
	Thu, 23 Jan 2025 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KctU/ZOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14167139CEF
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673340; cv=none; b=dZtl6CziBGLtVksmoK4t+fQUkTAY91W2m0Moo5QJEXVtTwFggnLaxBmggnjfowM+bb8H27uTEsNIOekuaMVO0srsMnRRXUezvkbiK5tlgocEDjKLeTp7uNyuqrVoDrFpOkCbhXOr9TtRoWPHebQwnv/mKVcov7DZ+ADfvXyQsTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673340; c=relaxed/simple;
	bh=O98/cUjV6qX0VkqSIJd+cMBOwFXfmp9EDhm9Ys91s+c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=me8anMikohsxR811EQ/iFmrpeFAixIQYpds7osi3gaW/4TZKSmuJwyEXzXoZ85CDTAMMYfvAzWeriGP+PrRBJMi/1LkHvhCo6DN9K+b142aLaybEj6aZOkOvbB5YuaYTDe//wg3InmRbBV2+X4D+QB7qNY2O+PlstdQbO2m6MOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KctU/ZOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC371C4CED3;
	Thu, 23 Jan 2025 23:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737673340;
	bh=O98/cUjV6qX0VkqSIJd+cMBOwFXfmp9EDhm9Ys91s+c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KctU/ZOTELqE25/kAVZ0vxSIh42pD/wfPw8eESF6r0K0YPSg2NJpxPHqJGVpDLkGC
	 Czmh+Cc1NqC8maz9fbW/R6whoe8zeG+qyZK4QDY8Ow1+/m9co9092+ncdBzZMeHvSt
	 UHDxs5kGnqQv4u280pprB64qbPz750P8XE1mTzU39RVvZwiDsFREtEOQyjTQfRNz/+
	 /raenlMExgWGzSRNts0TQwZB1zfriTdWBB8tx0fL3Dp7px/FPCsidrN/SAnVNRlsdI
	 OuDSeiPxzK3vPJhpkXClAhz00b9++e83czI9m8XQgHgJxE+jlvXPXwNgR7W7D22E2g
	 OhUps+esBZcMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACDD380AA79;
	Thu, 23 Jan 2025 23:02:45 +0000 (UTC)
Subject: Re: [GIT PULL] Zisofs folio conversion
From: pr-tracker-bot@kernel.org
In-Reply-To: <ziwnrbaobmlyyxm4gauvzli5sfi26ivl5lj5fs4p776gnvlrup@2dsnusdprdtc>
References: <ziwnrbaobmlyyxm4gauvzli5sfi26ivl5lj5fs4p776gnvlrup@2dsnusdprdtc>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ziwnrbaobmlyyxm4gauvzli5sfi26ivl5lj5fs4p776gnvlrup@2dsnusdprdtc>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.14-rc1
X-PR-Tracked-Commit-Id: 5c44aa21f0863270efbf03a4d5bd6b75fec4134c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb6fec6bdd9b16a935a0557773e313262366d071
Message-Id: <173767336441.1527693.5680050801898539250.pr-tracker-bot@kernel.org>
Date: Thu, 23 Jan 2025 23:02:44 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 15:47:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb6fec6bdd9b16a935a0557773e313262366d071

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

