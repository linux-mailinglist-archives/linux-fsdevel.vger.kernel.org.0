Return-Path: <linux-fsdevel+bounces-5998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC73C811EF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 20:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC181C212B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 19:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE8968275;
	Wed, 13 Dec 2023 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm8TMtBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498168265
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 19:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C42BDC433C8;
	Wed, 13 Dec 2023 19:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702495965;
	bh=rbmHVytUb1V53aPqe32fijD88KUqOLYNVRjVaPk4Rt4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mm8TMtBMPlZ2BL9D1AEhA8qB1BvtXeT7HTWUqOmOtvKvZ4+EQZrNR1ROCS67cAEv1
	 NStmaw40UHlAzaxJQItrYRmm4r0/nksPsjKOGqARME7Gb3VSZGexXZmkSdsiDXZQQL
	 cRwXGtz6AuNhRscsyX6GouQjIJfFsVaSYM0mL5DR/lAnqNOdy7A3Vs2c2ZemeOPDPY
	 t8ZBCJmdlPccOKpzD6uEMootIxXIenZbx23wGqPPMFMWKUnBABMi3JDVzN+yqc23KV
	 b3Ebr5dCSQifZ43LackJsy2ixrdxKR4i5c0/LICAPRq2lKA+TciKDLwyNYw9yPtN+6
	 k1ow4dNnPAdvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFF70C4314C;
	Wed, 13 Dec 2023 19:32:45 +0000 (UTC)
Subject: Re: [git pull] ufs fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231213161857.GN1674809@ZenIV>
References: <20231213161857.GN1674809@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231213161857.GN1674809@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 485053bb81c81a122edd982b263277e65d7485c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
Message-Id: <170249596571.3944.15321090833418459973.pr-tracker-bot@kernel.org>
Date: Wed, 13 Dec 2023 19:32:45 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Dec 2023 16:18:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

