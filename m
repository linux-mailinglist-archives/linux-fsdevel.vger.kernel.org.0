Return-Path: <linux-fsdevel+bounces-47938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7D5AA7775
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 18:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98AA1BC799B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A1D25F7B2;
	Fri,  2 May 2025 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoC2S4JB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF325DD07;
	Fri,  2 May 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204037; cv=none; b=V1JCrnp7gTjXpkIAvqZYHd5jI19GuRqMgrF15Ygm9jg9eUEBKywang+jUimijiTbbAL6jtCjUAxbrtpJdokoXjEbVcl94aK0+tIzYfX2OPmN9xdYhVCU/434ywYDyT4fiRj1Uoj4Oobu0N2xCoJi87AFdSeUJgfdOwxAtu/uabA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204037; c=relaxed/simple;
	bh=N//XVIvaq6/HMpjgHBQHsHL01hohbuVsulJUvG3Tr4Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MWkDH2xXf0OgGcuQFArQN+BRmfuGnxYJPCTHugoOlm3Asn1ptIu5g9OCWLuKP3iN9Zi50t+1+kDXDmba0kx+X3sqObh4TfmRILiD6iqnRNShlpx9ZUfRwrGGcsieUox1QrMj+yfKR6IYbW44BHnPbXaC/OnaEbICGWK4AlF78Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoC2S4JB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58203C4CEE4;
	Fri,  2 May 2025 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746204036;
	bh=N//XVIvaq6/HMpjgHBQHsHL01hohbuVsulJUvG3Tr4Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MoC2S4JBAy97StK3A2x7990ekm350aOLkXiY1KoIlMJXTaP4qwlNaOU09ALLpQgns
	 p9EsL+7isnT1Xxt5nurmK++OoeueT9QX/y/zs+1xRKfn0C3NxUO+/oLBdlPcTPdIcu
	 zjXMREGEe3caQYVmj9/stmuo1bIW+up5WhwskQHmY046vcUMcsvpjd3aTkpalsFKGr
	 tibLOTH7w0QUDSyCBcLuRldMrFFisqHBoVE8lufuXg3YPNZ/np93BmghfIuGHkBV2y
	 UAW2yamBUlEDm92S2kPj38KYTMHNqmhH84abGYQVMGu42htlHm6qiva8O5Ve1E8m8v
	 f8jRff8/j0hFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDD3380DBE9;
	Fri,  2 May 2025 16:41:16 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <avyfprbtjpphuhxjqekretgco6xs5r23efrlpkqx6uc5lhec7v@igrgjqacgb7i>
References: <avyfprbtjpphuhxjqekretgco6xs5r23efrlpkqx6uc5lhec7v@igrgjqacgb7i>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <avyfprbtjpphuhxjqekretgco6xs5r23efrlpkqx6uc5lhec7v@igrgjqacgb7i>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-01
X-PR-Tracked-Commit-Id: 6846100b00d97d3d6f05766ae86a0d821d849e78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bfcee565c3a36f2781152a767d34c9dc5432f95
Message-Id: <174620407520.3671706.6155186342341608891.pr-tracker-bot@kernel.org>
Date: Fri, 02 May 2025 16:41:15 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 1 May 2025 21:33:43 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bfcee565c3a36f2781152a767d34c9dc5432f95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

