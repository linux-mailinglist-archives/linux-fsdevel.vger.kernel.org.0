Return-Path: <linux-fsdevel+bounces-63405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9ABBB831A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570651B2017F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED562749CB;
	Fri,  3 Oct 2025 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4FSHfy0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B6227380A;
	Fri,  3 Oct 2025 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527075; cv=none; b=FNvQRbGXVW5+T7J/gssY/9v2Eh8GzfYuiOBiL+WsJfvBh0KWCEi1iijJvT8QU6kWyAL0HYSo18lueMUx7oxgx4sVAxZXQ1fS86oINmrD5zI8L86p2POPYhePcrzrplZOm0eV72iQ1srjDJry4kDgdHjGpBSNPeQ6eyGcYzvHRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527075; c=relaxed/simple;
	bh=z6U+YxTYnKydTddjz0wIMiAH5SDcsB7IHUe25UnBZDU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a1ErwjWWIm/1eUladesNRjq2kZvzoduU7vS6NHvaOCT1WyA7G5O80t237dOOy8tH1M8x5t+/2pEXllo6ClXB0DV2P6Sx/NDvjoGgTAUvOjAugMa9RUDfck2I48TZ7h8MgRAespAjUT9JrVqZEUE3xXByr0WqbPuEWyR60IlP1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4FSHfy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEDDC4CEF5;
	Fri,  3 Oct 2025 21:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527075;
	bh=z6U+YxTYnKydTddjz0wIMiAH5SDcsB7IHUe25UnBZDU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A4FSHfy0XmQn810FFeX2rdGkyQbpZDBbm/GDGG6snLt1xH8JWhg6qLQkXsdF6wnVQ
	 WtJ7WsGGJOZIYYQR5C7Izr+R7uuAu1ajloDsz74SCuCUPBXN0MYufjA2vE7Jr6gVlH
	 k2+LySWEd9yNEOE5OV88KUw69L52K3TSELWzWOYqwDK0zKHLe1re1gaFOSF/ALfCas
	 oX6uz88iv9Cfl738eU8ygyX/Jqp5UBVRFii3XVPznohsjxKjeY1shv37sBFAZhWZ1i
	 U7p4BROeumkj1npLJdClG54Xk2/8D31l15cvXoFa70ANtE+PFpRJNCYjY8uNwAdoRq
	 aF5bbi03zIzrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDEE39D0C1A;
	Fri,  3 Oct 2025 21:31:07 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegtWHBZbvMWm2uHq0WAhrF6qHE5N=AG9QjkweyXic-e7gg@mail.gmail.com>
References: <CAJfpegtWHBZbvMWm2uHq0WAhrF6qHE5N=AG9QjkweyXic-e7gg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegtWHBZbvMWm2uHq0WAhrF6qHE5N=AG9QjkweyXic-e7gg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.18
X-PR-Tracked-Commit-Id: cb403594701cd36f7f3f868258655d56f9afaf8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6238729bfce13f94b701766996a5d116d2df8bff
Message-Id: <175952706643.82231.6180553749926660905.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:31:06 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Sep 2025 14:47:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6238729bfce13f94b701766996a5d116d2df8bff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

