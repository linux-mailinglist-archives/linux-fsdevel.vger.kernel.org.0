Return-Path: <linux-fsdevel+bounces-19938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8318CB4AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 22:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6684B281459
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FDC1494D7;
	Tue, 21 May 2024 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM/+LlAj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F63FB8B
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716323171; cv=none; b=avkkxEvXPJcmpssQe5d45UMzt2cTlzny6Fo3NBZPrV5/1AjOpBgWg868/46n2Aln5QhIyY3hW9E3f7NB8NE3xJojg/0P/0jLosL9UiUhP48WNEcspHIwZBNaYAUTFl5F45lww56AtSE0rxRcL+jxVf51Z6KyVBu4LimMItIzFyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716323171; c=relaxed/simple;
	bh=Boj8fQ+V/lYqDoG950MHCRg1dC77E+ppIg6IeJwKvLU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H+Yg9ynHnEJR3XRNf1HZNS4n+mLX248yTDXMjCPqOj1XxlCGHeBN8y9x2+DYQepw1W+OlRsygB5JKJFShOBu6OyUeI34A7LzXLm0t+o2QUZs7z2o7Eus/oOMMtobsZnVkfBDSm87h+RGA/lil7rUqzLd4tfOXSjc88xS+qzzRVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM/+LlAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6052CC2BD11;
	Tue, 21 May 2024 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716323170;
	bh=Boj8fQ+V/lYqDoG950MHCRg1dC77E+ppIg6IeJwKvLU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EM/+LlAjNjs8ixJ6apNTVm9lYrc55liam9iNbHZpoSM2urSg45lIYUu9UtW70THvf
	 aeLvDRlk7SrZFiP+AYdVxa9LYpIJ2jIH10n2M7gtU84F4Ho+6FkkcvI1i4LekSA4rs
	 JuvGyDZ91t+BlubPoem1wjqypCwQ2mTgXCdLYft0gu9fgJZEonjD8Xv78YO/dr64qg
	 XyzoGN6UnngBlZ0O0oYN19gswfv0s1/wNgLQbrD3QT/ZoNlUoY065qlxRg7X9gl2rX
	 KARtu5k1axy/ZQVQgW2s0JOjeMmu5eT6TlQdhdG+9altZK/qXM+JnhTp5tRm/TjXsj
	 EgiO7QQ3D4cWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57BC4C54BB1;
	Tue, 21 May 2024 20:26:10 +0000 (UTC)
Subject: Re: [git pull] vfs.git last bdev series
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240521183524.GQ2118490@ZenIV>
References: <20240521183524.GQ2118490@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240521183524.GQ2118490@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-bd_flags-2
X-PR-Tracked-Commit-Id: 811ba89a8838e7c43ff46b6210ba1878bfe4437e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3413efa8885d7a714c54c6752eaf49fd17d351c9
Message-Id: <171632317035.11031.15207469742603983057.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 20:26:10 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 19:35:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-bd_flags-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3413efa8885d7a714c54c6752eaf49fd17d351c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

