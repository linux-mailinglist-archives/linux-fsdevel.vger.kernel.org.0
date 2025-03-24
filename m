Return-Path: <linux-fsdevel+bounces-44903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58A1A6E4E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180CB3AE811
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C8B1E5B82;
	Mon, 24 Mar 2025 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwoJtf6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43C1F0E27;
	Mon, 24 Mar 2025 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850027; cv=none; b=YAuhhy5yLVG9hRLXTHlX1nzLY18rfuUS39vTo9gGCkyPiCZ+5SXu0DTa9+Hr+3UbtiM7ciSXD3/llq+taNbwrVmVOqY68tQUe+fnvyV7uZwvvvp6i2sl9C7KzJcka+PEiZnMllXFWz8c4RuRyEg88K/YsQ9OAhh3x0YtIWTCHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850027; c=relaxed/simple;
	bh=yb4dp1dCh5+nc0MoOE1Q2Wwc3gciJKc+Obi/dbCtc5I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Wg26Tz03vwDeiWeII9dfH6dStfJxyykd7Kw/8l81zJjvodZqwlJB9RdBXeWOQ4Qe1vumyC6pdc0NWYdDXu3ut1CA+peWz8gkPgYIx866xqm013Fr28mhtkH6ieyBlV+6F2MXiD6F7pAKzsKlKrsOqwcst5rtWEms0ZB6X7U12zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwoJtf6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407AFC4CEEF;
	Mon, 24 Mar 2025 21:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850027;
	bh=yb4dp1dCh5+nc0MoOE1Q2Wwc3gciJKc+Obi/dbCtc5I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KwoJtf6ODWPzowfqTK2EW3DtOpih1IEkPQrVllJoTgZq/9XkpPOawVhCDqB69LfW7
	 A0VC3vjLYqfs8QjYsB5r4r+RDMTc10bN2xFbT9fPTF4erJHZuiWzrdb5lxzyggtsMb
	 HB+EM7A+f5uRiieJxC8aTE1P6Q2Z3nGQZxfj5+OsIV2nIdc+Su0TECCdHgMeUtmYiu
	 jDGl+SSBIt7zbFfGmrOCFgKYKPmWyBRpOqpRHHyI+thKzt4P1Ft4S9OC+2XZl5lv54
	 yGmJZjd1stO0SM7Na1k+5QUFEQhmEpUA17asBmHlpNt2F70c+6WhBPeglrzUGC6Ooa
	 1bZaUTsQTpXCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B084F380664D;
	Mon, 24 Mar 2025 21:01:04 +0000 (UTC)
Subject: Re: [GIT PULL] tasklist lock
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-kernel-tasklist-lock-38eaec7fea1e@brauner>
References: <20250322-kernel-tasklist-lock-38eaec7fea1e@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-kernel-tasklist-lock-38eaec7fea1e@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.15-rc1.tasklist_lock
X-PR-Tracked-Commit-Id: 0a7713ac0d98d02f2c69145754c93715ab07b307
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0cb56cbbdb4754918c28d6d7c294d56e28a3dd5
Message-Id: <174285006354.4171303.17975829104051741509.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:03 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:14:06 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.15-rc1.tasklist_lock

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0cb56cbbdb4754918c28d6d7c294d56e28a3dd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

