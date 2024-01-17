Return-Path: <linux-fsdevel+bounces-8196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058BF830DA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 21:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B09F1C245DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BCB250ED;
	Wed, 17 Jan 2024 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgmjizTy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE2324A0A;
	Wed, 17 Jan 2024 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521828; cv=none; b=nh+2I+TxaXbQaIM7FRK+Gv3JsCWQfIaW5RTHRXEplXlQF4O8Iq6As7Gmuw6n7M+4t6t+2J5PTnHTHMVJS2A6QGK+t/i7ntqsD7vtx7wkEZv9KbgbojX7s4QQ8xQ8iwhD7Dd/qny0JuLJvT/I1q2Sz8eQ1tNNeX29gcjnO13n0XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521828; c=relaxed/simple;
	bh=GIuoqC8ylvl6PYBYBhLCRpXy9wMTOxKdxQBbw1jTHKg=;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:
	 References:X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:
	 X-PR-Tracked-Remote:X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:
	 X-PR-Merge-Refname:X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc; b=a7hrUYVnKvx0KVCCRR4h1jHSjr0HmyiB0ITRz66MTPEP0jSx9xN4BZOqKBhoXqdgI/vthp3AzsPqPchGDefIujRZoOc0WhVjRLBHYlGUewXxnDHbXaNlUGCpKVc+iDj/9OEFyhRoLb7toQb59JnmKWQqdE3YRY0MvZVSLLA3tZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgmjizTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B76EFC43390;
	Wed, 17 Jan 2024 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705521827;
	bh=GIuoqC8ylvl6PYBYBhLCRpXy9wMTOxKdxQBbw1jTHKg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RgmjizTyRzae3GG1BCfstmzn8Sr4TNfW99GmAwu/tob3DcKO3D/OLIJ5ZsCHLUiOd
	 1ZikaQP4PyeXEN8V/dYpaX1dZQHkVKdx7pki3ZR/Y+akyERcqp1rTnlUylijfjurgK
	 4gxLv+3rrnJUjqQQCoYavXqskyaVwg2WqT0q/lYzwCOn9jIlNg+2k/mLMO7heQ/pu5
	 6CiX0YeOQVbxosUFxHmwAVbfIu7JTg05vjXFy7ZNJ/Ia7OHtbHTKPd3gIDh+fkGk1y
	 uRHubKpQMZQzMfnLqIN4oYMV1mlYMbd8CrnWHEnqsgjS13+u81UztgKbLkJKy/xkpi
	 dwMBT+UclZ4bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9DED6D8C96C;
	Wed, 17 Jan 2024 20:03:47 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt fix for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240113175604.GA1409@sol.localdomain>
References: <20240113175604.GA1409@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fscrypt.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240113175604.GA1409@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: c919330dd57835970b37676d377de3eaaea2c1e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eebe75827b73b0a61e84acd2033ce304a3166d70
Message-Id: <170552182764.2985.5742337421585450900.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jan 2024 20:03:47 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 13 Jan 2024 09:56:04 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eebe75827b73b0a61e84acd2033ce304a3166d70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

