Return-Path: <linux-fsdevel+bounces-44916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E99CA6E4F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96318172AF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ACF1F7910;
	Mon, 24 Mar 2025 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eU1XlbOs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAAB1DFD96;
	Mon, 24 Mar 2025 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850046; cv=none; b=f+gs2+WGdQTS0IYdVskBhJDBx8e9rrYuoc86sro96Zxye0EZR7cyFV/DhZ54UcRWqba6z/fsPReJM1kqqIPxuVccLUQrgQN2k+VM7tEE7xcDjNgUeBzN8mf/TSslIDBWqEmeWl3BE7G0zRTpBm9vswhU0DuO/Hx9UTyWNKChQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850046; c=relaxed/simple;
	bh=R9g7DTcIBEMf9SqHhiqsTo9TiIoyk4Pn8knNdFSKWDA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AhOo9mx0gemsKIDF0yrnerZhyxjW5r4wxgEBnOrlmkA8RUGuXaOW27xKGgiaAPW7Z7MsucHB7OHhcJ7YNwf2qF92N6+68x9A0jFYhnrWh+lgOzbdxI7lAchz4+fZf8KbrFS8t/AA1L3UbBstKzxi8bSJzMruTWDuIgkDF1/hF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eU1XlbOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF81C4CEE4;
	Mon, 24 Mar 2025 21:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850045;
	bh=R9g7DTcIBEMf9SqHhiqsTo9TiIoyk4Pn8knNdFSKWDA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eU1XlbOsTo2+iVTaMbQiY23Q7SL+AIaw5zgbmSSZ+oG3t7xqkLWQ7hqfMVH2zF333
	 d75BB2oHi8WKyK86ngmMX8WnQALb/YSFA3DgnqyJQ0/uklJwqUUcJgmlD+2OR5I86v
	 rTyfyLxvp+IwzhJR7cQ0UftOcetLc45gncFtvcV9S7DLDoFqAtpk9ZjjAC/LUwoCwI
	 MCRKbCliFd1vhcXMaUcB35ZEDahh62loplO+ck6E8rMptwMwSvqMzE+HNvuALGULyB
	 GNVxYgSnhxQylv80JAmzfGGHNHixLlB076r6OpxKeXuUfu6YgN/9VeD+hMeJKWnidH
	 DUl743gfmSkow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4064D380664F;
	Mon, 24 Mar 2025 21:01:23 +0000 (UTC)
Subject: Re: [GIT PULL] vfs file
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-file-98e9b1f4bb07@brauner>
References: <20250322-vfs-file-98e9b1f4bb07@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-file-98e9b1f4bb07@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.file
X-PR-Tracked-Commit-Id: 5370b43e4bcf60049bfd44db83ba8d2ec43d0152
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 912b82dc0b27abc407c831e74fbcbdebfe19997b
Message-Id: <174285008198.4171303.2516969561476725880.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:21 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:17:12 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.file

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/912b82dc0b27abc407c831e74fbcbdebfe19997b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

