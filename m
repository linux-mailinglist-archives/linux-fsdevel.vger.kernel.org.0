Return-Path: <linux-fsdevel+bounces-39723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADA8A172ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E121685C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF321F1315;
	Mon, 20 Jan 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSYS8EkL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5351F1301;
	Mon, 20 Jan 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399574; cv=none; b=d5F7XZ/cIkyk4/H9os3cKNxNQxzE/31bdQuvdsS+/DsT0s7IPpD9CCe7IHiFYxaNAKikESNQQTCjVhB/XHUFeNetRx5nI1I8wFaGy4xNgVQSozFikPAJ9vHpDMZiAfp7quiQOvJ5ReXW+pynBQM6hdryoUd7rYA+s1ndH1XSat8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399574; c=relaxed/simple;
	bh=2gA+l70BL5bV37QicpmHURwqh+8nRWv/+ablJGnkC/U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Uio+Z0yH0prRSiXYPqM7thlOSVk3TWFhqAcswPc3TbQu6hpp1ZCYTTJNCUh9bBVAAHC1g37bxWctctScb1dfCX+zfRvxjzYOGmL124AJRIj0PXouMnbSBZZcFHEnSvQfQtSj9U8gX6BOjvF+4YwXIBoExP558dYvFLurK9W2PZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSYS8EkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F28DC4CEE0;
	Mon, 20 Jan 2025 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737399574;
	bh=2gA+l70BL5bV37QicpmHURwqh+8nRWv/+ablJGnkC/U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WSYS8EkLw/esuK+1pqd2m/yRij+FLW+IRUMu9Ig2FlfEvQWiYvUbgQc/r5PlFK3+J
	 pHDeP4rPiOF7mN8/lIocnVUQttwNhzuCnaM+dWH5mA8MQXPBphIOayhnCtmyP5PEzI
	 M8UurbQixV8atGFgRklP44bVWfPJSHRC8e8wMOnxTKuo85W27eMkXGt36tZ1IsTbts
	 i/xqOXYH6LZRwRUgr5szn8e0w0czbaiHHQ76h01RMzK19BN6gtFxrPwuHJ+MbqNJEM
	 85peo2mVBouBvoDHPjT0kyDjGyH/MK6ddo0SlGg0MuE8byHYzPhv6tpWeDhywAvkIQ
	 ObGy9sjLn4gtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDCB380AA62;
	Mon, 20 Jan 2025 18:59:59 +0000 (UTC)
Subject: Re: [GIT PULL] vfs mount
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250118-vfs-mount-bc855e2c7463@brauner>
References: <20250118-vfs-mount-bc855e2c7463@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250118-vfs-mount-bc855e2c7463@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.mount
X-PR-Tracked-Commit-Id: f79e6eb84d4d2bff99e3ca6c1f140b2af827e904
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9d94f78a8749e15de8aeb2e281898aa980e62d9
Message-Id: <173739959830.3620259.6366389242171643864.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 18:59:58 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Jan 2025 14:06:58 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9d94f78a8749e15de8aeb2e281898aa980e62d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

