Return-Path: <linux-fsdevel+bounces-15774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0F4892D57
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 21:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B1A1F22143
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 20:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D90482D8;
	Sat, 30 Mar 2024 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOvH6vT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF5D433DB;
	Sat, 30 Mar 2024 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711832091; cv=none; b=lACRY7nsKvcm6nCubdBSlgFvlu6x5a6aIbZ4q8d4cP6azRPZzVYaZCl3ZYhqQzo0yoic2snpY8NoWpB6rjoStrtCSeNyqZlFea1rmyCIQOaEJmgIC3A5Mjz6A7QbUq9u5BwtM+6/I4LU1/5X4RE05ROPhzmSuKiv1YDRLX8vN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711832091; c=relaxed/simple;
	bh=7AKzz/u1thQkRKlpugmN4sEZte2PZWPlEfXsDd4Mzzg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WM98gopJykVR0AZij9CNNCf11MiXKLg47+UvkoB7WV1m97fQ60koplSggxZ5aG/YTRCs3RGfm/IwdsFE6vB9IKoV3WNqGwdRcaVhlaMmmK2UT+JY2QCo1Ur3rhHnXHmwR21vOO0Xm5zjD/h34A+qfCkbSFwbpYiLaES4SfSoUj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOvH6vT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F94AC433F1;
	Sat, 30 Mar 2024 20:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711832091;
	bh=7AKzz/u1thQkRKlpugmN4sEZte2PZWPlEfXsDd4Mzzg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gOvH6vT+gZUGI6xF274Cs9WRgq95S2M8ytNBseGTtBQU9fgNaSPHzb9vtJByYMaMQ
	 moHVkpbWate+JZbcD8C8M5QZZdNv/7VDR+OprvAQvVOA2qBjOmzpPK/DwzQdqG85Ix
	 vA3TGWrpS2N8PjoVyFMNaougnXue0C3+13RbfdNM1KN8bzftmYnD+63eJwT8L17tP1
	 Zs4wrVq1BPkpUX8IBF/EAHv/poO9Vj7K6AGboywfKaP1z76/AYl0W9RJr3rFRE9VpE
	 BvcH66VjkzDTX2CiUSuSWUTxPaT5eHjLrBY8Ys0uCdi+rd902T3T+IxyrNHRt4aUbP
	 3kz9UhgB9xnwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CECBD2D0EB;
	Sat, 30 Mar 2024 20:54:51 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: Bug fixes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <875xx3lta0.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <875xx3lta0.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <875xx3lta0.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.9-fixes-1
X-PR-Tracked-Commit-Id: f2e812c1522dab847912309b00abcc762dd696da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 712e14250dd2907346617eba275c46f53db8fae7
Message-Id: <171183209117.22117.830795128814065840.pr-tracker-bot@kernel.org>
Date: Sat, 30 Mar 2024 20:54:51 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, dchinner@redhat.com, djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, mark.tinguely@oracle.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Mar 2024 19:19:34 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.9-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/712e14250dd2907346617eba275c46f53db8fae7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

