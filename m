Return-Path: <linux-fsdevel+bounces-28655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3B96C904
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D60A1C25C20
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2261487DD;
	Wed,  4 Sep 2024 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVKfvekW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6917E6;
	Wed,  4 Sep 2024 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483393; cv=none; b=IPZeEoRk6trzMx/h5yyF+Fdny+7QMAitQZZ8zx8GNMGjo8Kvd/4eigpSQNPRF+FYARq1zG8Du0cHpv1EpPLXyT+IRBgfSsuCZUJUGm2A2RbyKFBacDOM0TRgKXHtGO1hVhEJ5IGNjkz7bDkuQWvKza3TtDrylcbQ+3VnEO6i2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483393; c=relaxed/simple;
	bh=H5Z1lGuMmRiuMFtVKd05d+cAhGrXu1iVsn+NIbVfEhU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jGXbje9T/9WLL3eCJrRuZdyORoc99IOahAn3AsONAKuQ3B43jbzuX3VLUnfPVVmZ8yhbgbz2pNuvSnA8Opi18LJQdvOASsBxfHGrxl2AD0x87i4pkrwDlJ6pPBzXTXtahnnhBHgRUOw8vj3IGrZYvffIHH0rNCufnn6MTwk8wSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVKfvekW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313E3C4CEC2;
	Wed,  4 Sep 2024 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725483393;
	bh=H5Z1lGuMmRiuMFtVKd05d+cAhGrXu1iVsn+NIbVfEhU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XVKfvekWDBLozmK2HWTwuctFugYUD8v4VVjh+H/z1zVAwuJCzy7VdW6uNyUMi0fGA
	 XD+E44qxJyzEO6QiP8zVDDPGjuG2CLdB0GbycIOcUh2pD+ErXQkOKHlmnNC3O4pzhV
	 +493SMzTjKD8vU4mZtgXlQAG7Rcx2C3mhGfjN3C0NKjkOGHinNRhr0BscaIIcebU0E
	 jedqGyyjgXOMxqOR4+5n/FGxH+myzAi1qH0u4m2vlpSC8aUGar2ebVdEVv8FR/3zJV
	 PUaSpl3r248hMwvIHVMT95lJJo4oZxA9OxiTHk583CLsnBhn1yaPYWhacyNMTbVwPR
	 Rj8rL8ZeaH0Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341663822D30;
	Wed,  4 Sep 2024 20:56:34 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <45wxyfvbqm76vqbdjkasy3a4pxtbnza5qiukvcougseosx4qnt@uqosw6rkccxi>
References: <45wxyfvbqm76vqbdjkasy3a4pxtbnza5qiukvcougseosx4qnt@uqosw6rkccxi>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <45wxyfvbqm76vqbdjkasy3a4pxtbnza5qiukvcougseosx4qnt@uqosw6rkccxi>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-09-04
X-PR-Tracked-Commit-Id: 53f6619554fb1edf8d7599b560d44dbea085c730
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c763c43396883456ef57e5e78b64d3c259c4babc
Message-Id: <172548339266.1166715.18322603051182120164.pr-tracker-bot@kernel.org>
Date: Wed, 04 Sep 2024 20:56:32 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 4 Sep 2024 15:15:18 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-09-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c763c43396883456ef57e5e78b64d3c259c4babc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

