Return-Path: <linux-fsdevel+bounces-3767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E47F7DA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 19:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FF0282249
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573C939FD9;
	Fri, 24 Nov 2023 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKXrIA7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A131B39FE1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 18:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D21FC433CA;
	Fri, 24 Nov 2023 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700850381;
	bh=wqOUFpnaHzv8Q4VPq9XcpKKDoJgSUHCKXfYoFOuaCyU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MKXrIA7ntVv2rPSlvT9xufw+rwxRWkUQytiR7iR3DFwIpWqB/cv2VwdR+Aiws01WK
	 XhU+SK5udKO16M/4HEM57rERcF4aI7bKrJwqfE6lDVpArPZJg0cAXybz2jtuAYsSFW
	 Iork0MAeKnfwiPjfgR4fiuU6jH8JLmIVK6rwMKQSACexEswcS4B1s7lOBZznbifyuR
	 cnqL8ExeklRhsGsL/8vFmu1jGY+i6A2yCFcH+Ps5ZgaLOfQxaeccVr7ZADlqSiyZRw
	 bnKxfKH4DzwciKDrXd47H1LdG37l2VcjqtJ0N7FJTOhQiEFhWy27CvR6Aqa8WvLLm8
	 H5wtAmFAO2LFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 498A5C395FD;
	Fri, 24 Nov 2023 18:26:21 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231124-vfs-fixes-3420a81c0abe@brauner>
References: <20231124-vfs-fixes-3420a81c0abe@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231124-vfs-fixes-3420a81c0abe@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7-rc3.fixes
X-PR-Tracked-Commit-Id: 796432efab1e372d404e7a71cc6891a53f105051
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa2b906f5148883e2d0be8952767469c2e3de274
Message-Id: <170085038129.12986.9041931709697424833.pr-tracker-bot@kernel.org>
Date: Fri, 24 Nov 2023 18:26:21 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Nov 2023 11:27:28 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa2b906f5148883e2d0be8952767469c2e3de274

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

