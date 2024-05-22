Return-Path: <linux-fsdevel+bounces-20015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDDC8CC60B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 20:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6961AB21C1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E301145B05;
	Wed, 22 May 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it4yJMD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE57A145B39;
	Wed, 22 May 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401120; cv=none; b=APDlPzky040SBELJDHNlJ4XSmAS4bCvxvVo3pfW9YkUDyBJv94BPpij7HJbSfdbmJOTbws53lGW8a2mh/CQkpEmywPHDyPUClhx3a4Y6DUjyd1vmdjASwfPaiC0E0N12v8y9elUN+/t+AwGEnIv3vFZUYxCad4Fmard9hnZLJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401120; c=relaxed/simple;
	bh=FmQSLezUeSv/uLIvr2DsvNnAcnUZARc4KFDqJ79M6Ak=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=quEXnkmcBfJoA5HF3nl5oVa7jqe6YbsoI/dQP5kT/MUpJsu/snYFanVjrbyu63yOzCcrQycYf/woSFt3sE+VEPokpF5xTCxzdY9GWGjaaMzxTf57/FDHQgn/3J5HMmc6tGd0/jX3SIG/emB2GRmaEqbCVh8fIP0KQIitYwweh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it4yJMD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D55CC2BBFC;
	Wed, 22 May 2024 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716401120;
	bh=FmQSLezUeSv/uLIvr2DsvNnAcnUZARc4KFDqJ79M6Ak=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=it4yJMD0IkBedNPk2fDapc70Fbj+AwPBd8WrdyP91v57fj8V6x7yCHFwSfnGkFqVk
	 ax93ywZcOvfwspszN4lPhdSfKw4CCYpWOEBK3y6WzPvJtYVKydfTDT5ZGOdpd/k8zC
	 0OFLh0EigeV2jc2Jyl17lHd0HR4dU8n/4vTFV5GrwIf2iaEO6TFpE1aWfFDS4AB0R5
	 3L4QiIFDd+Fm/y9KSxbLU/1qkd/78Ce0Tsd88kU2T3lH44cEi7NaM178kIMpmSGllj
	 sXO9Xh72DzpJXIAH9avP1MWfG4H7X78Y8Cf4llhtsV5+GIpJvYeTbKT1DQ8DT+jBlu
	 RVv3ZovZgUw3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66F91C43618;
	Wed, 22 May 2024 18:05:20 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs update for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegu93nZEeEJhepnDhzHO7khEmXkP1UssKNErqXFFUw-8uA@mail.gmail.com>
References: <CAJfpegu93nZEeEJhepnDhzHO7khEmXkP1UssKNErqXFFUw-8uA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegu93nZEeEJhepnDhzHO7khEmXkP1UssKNErqXFFUw-8uA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git tags/ovl-update-6.10
X-PR-Tracked-Commit-Id: e9229c18dae3b3c2556cea8413edd1f76c78d767
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e22bedd758643bc2cc161d54aa181e329da0ab3
Message-Id: <171640112041.25247.22369368346562770.pr-tracker-bot@kernel.org>
Date: Wed, 22 May 2024 18:05:20 +0000
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, overlayfs <linux-unionfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 May 2024 15:29:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git tags/ovl-update-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e22bedd758643bc2cc161d54aa181e329da0ab3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

