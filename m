Return-Path: <linux-fsdevel+bounces-879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F467D1EC5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 19:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763761F21BE1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0E21E52B;
	Sat, 21 Oct 2023 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC4Z2N5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50456D291
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 17:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD99DC433C8;
	Sat, 21 Oct 2023 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697911026;
	bh=pFrOkwxTre0sOV+Eoz+9LtgVNs6Suir0YHRmZXpiw8E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gC4Z2N5DQZLNcvgn+TCi+7wVHnaVWKWlLKMxG0g4VZEbbbHLirdU8hMJ3t/Mvvl9q
	 PQL7prRbT+tgFzYCMcR0qqv6+yg6X3pFy18X30ochMAsfZ9lFjMbuxLDVkxUtRGkaK
	 3j8IENdoKZWihRLSdCv2V31dkaQD8Ca+LPz8JjtQwUxSAM96JQ8wAZ355NfrOiYWUx
	 2fIeug+n5TRe4mo7N3wnMdDWLaTSck6b8I90Hm89t8rQnm+wBYHyE+o8Eap9W7QnKI
	 bGaMJxTa+NrdhJipix9ybcrg41uqwxUJUr+grltcIvjneM4B8MaLv64Uxy5XWgGPNo
	 jXcAN83MKbHag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFE7EC04DD9;
	Sat, 21 Oct 2023 17:57:06 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
References: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git iomap-6.6-fixes-5
X-PR-Tracked-Commit-Id: 3ac974796e5d94509b85a403449132ea660127c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5722119f674d81eb88d51463ece8096855d94cc0
Message-Id: <169791102670.24251.2347842521338954833.pr-tracker-bot@kernel.org>
Date: Sat, 21 Oct 2023 17:57:06 +0000
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: djwong@kernel.org, torvalds@linux-foundation.org, hch@lst.de, jstancek@redhat.com, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Oct 2023 23:27:44 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git iomap-6.6-fixes-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5722119f674d81eb88d51463ece8096855d94cc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

