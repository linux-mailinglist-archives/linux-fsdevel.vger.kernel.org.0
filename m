Return-Path: <linux-fsdevel+bounces-19202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1CB8C126F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 18:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBA91F2239F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0A316F82E;
	Thu,  9 May 2024 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us37hta6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47661383BD
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715270919; cv=none; b=MD+aj9ht3mOhDLZPZ+JMMLlMNcpXWTp0U42wc84C4EK+TBwcWfHmFa9SvwHLcLU6pXuv9DXF1XgjPh9yzykGafWuDig0bPLrCEmCd7Q93SsEaO10+2I7pdP4DgJm+aB/lJLF2QakaerTEhAveHAHKQeo3NVgFHfXcf4ZY4Qvu+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715270919; c=relaxed/simple;
	bh=hFb3V4XfzcQ+cQpXqJhvh1cYNHXm/QDugK2bqpbG/N0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TjWFeVmKi+b0yqsTW9RKekp48HjTGjBslhiZvY9059GdkfGTjJbOSy0QLyTIyUWUcBXgfivRw4tE+wfywJ/GDESouvNdtxdBDGouTkOUAN3uBErY9ZDsCzVCaQsALzXfZmh3AK5PEcxlIhX+kSST/TAc6ypQpBLUhN7JVobKDhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us37hta6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0B7BC2BD11;
	Thu,  9 May 2024 16:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715270918;
	bh=hFb3V4XfzcQ+cQpXqJhvh1cYNHXm/QDugK2bqpbG/N0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=us37hta61VixfpAzn3FgUG50R1wASeIKGGIKAzOu7UkdFac+mn9YNZeOvnpeZDdSU
	 9HJuZpUeEUU425c1xHqOlwczMnNT7T3KlcueE4kz/gn4PDqQZRoml5w4YHGfDgHu2H
	 CM/TuFAAujIr4JNim4mfzwesysnepK2CnaFR/UxHSljQ+oH/D0A8MEMMbaOFCHdbVE
	 vr2u9yozR5PV2wswIa/fyItEkx60vXa8EonAhGfmO6L5sjL+gOPcIkvzUarW3dTDqx
	 n94OaYf1UzIFszN350BpyW8TrJXcPjeIt9zXhBilx+HSxxcvV91npqsPSJmH0uBA3z
	 SV6sQjhfMmsYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6F39E7C0E0;
	Thu,  9 May 2024 16:08:38 +0000 (UTC)
Subject: Re: [git pull] vfs.git qibfs leak fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240509011243.GQ2118490@ZenIV>
References: <20240509011243.GQ2118490@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240509011243.GQ2118490@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: aa23317d0268b309bb3f0801ddd0d61813ff5afb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bbc99158504a335cf150d070c76f7edef4ed45d
Message-Id: <171527091880.25065.14747666871319080115.pr-tracker-bot@kernel.org>
Date: Thu, 09 May 2024 16:08:38 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 9 May 2024 02:12:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bbc99158504a335cf150d070c76f7edef4ed45d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

