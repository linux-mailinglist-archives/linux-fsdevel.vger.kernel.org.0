Return-Path: <linux-fsdevel+bounces-20014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD88CC604
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 20:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1891C21428
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC87146A63;
	Wed, 22 May 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNPy/Ezx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33295146013;
	Wed, 22 May 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401120; cv=none; b=iuiNJ3jexchV96IXcfyz6xTOqGhe214yZG2+wgW4rtdGdHB20GS6gO7Eyeh7tfra6DcSzbc2U9E+cSGQt36DOEnjrDEgzb3w4wL0vIjpP99zikObUch4QfNVBLe/3fLSqfOJE3jUrt5wH7of2jxj3aMSgdE468QKQXegDVzPYVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401120; c=relaxed/simple;
	bh=1lacsQyR4j52HqJr1m92NS6XwhJgS7D/XuViCf53rlg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L8UCDwuhNI/G1Z+AhdmWQ5PUEUinU0MvQYhvIxVeGgUZ/s7zfzH0+4o5uRC7AB/9h4BlR8MZimWgZwzCbSlexwAeDTgALlxtzSz8DMG1+t90C4KVuYuHLkUuxj8c352IBorq8dcVdteMaqEVsd7AE4XgJ1bLkFU1R1usmfWPBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNPy/Ezx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FD74C4AF09;
	Wed, 22 May 2024 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716401120;
	bh=1lacsQyR4j52HqJr1m92NS6XwhJgS7D/XuViCf53rlg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BNPy/Ezxnt3QnV0BmepnFcupEqdqiGMyCPS74It1z3+xLV/jjAw/njPXHKX4/5gS1
	 edwYzcTPP4kpbFJj3cbSVzqHqIqSh02iEKDYlMGyU0E9mOmkX4zr1Qzr0+j3BUhf+V
	 HlySS1PeS9oGUNnxStKVuiePi/VpDp0Wz7OIfMzv8UspR70+eAjsG0KIVRsenr9L//
	 Y5Udf3FzAoyTKHeZ0yIYGsHT0SRoNlGXa42ntw8tIt7jXsqM+aPIN0VAUGqNMbwPfw
	 FSyFTLwRp+WADrG0Osks/0ccORswJgOUx774EnyLBJCyz+w6eyArNyb1AY87knOBtd
	 pfc7tMqoqIajQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 066E8C43618;
	Wed, 22 May 2024 18:05:20 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegs9w+yNAvFCj9Ne54H6WMCJ9T16CrNDO-NRJwb9V5ieTw@mail.gmail.com>
References: <CAJfpegs9w+yNAvFCj9Ne54H6WMCJ9T16CrNDO-NRJwb9V5ieTw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegs9w+yNAvFCj9Ne54H6WMCJ9T16CrNDO-NRJwb9V5ieTw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.10
X-PR-Tracked-Commit-Id: 529395d2ae6456c556405016ea0c43081fe607f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f2d34b65b40937b43c38ba34ece5aa3bc210e0d
Message-Id: <171640112001.25247.15882612239209450060.pr-tracker-bot@kernel.org>
Date: Wed, 22 May 2024 18:05:20 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 May 2024 12:07:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f2d34b65b40937b43c38ba34ece5aa3bc210e0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

