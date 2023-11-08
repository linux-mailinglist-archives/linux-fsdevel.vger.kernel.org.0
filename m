Return-Path: <linux-fsdevel+bounces-2448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7130F7E6005
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 22:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB76C281355
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71D6374DE;
	Wed,  8 Nov 2023 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoMb2fBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F87374D8
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 21:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA6CAC433C7;
	Wed,  8 Nov 2023 21:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699479275;
	bh=5EvGUdYLYqyi4ZMwGxn2WzczuJ9GNl7+hCZ37o0W/ds=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UoMb2fBDF01S3n0hR7EtexgTSf3G3JrxfuNO7B82p7s7/7x7BWqjjt2+giPykBLqe
	 KHo50IBfNCQgfH+JWD4hEBq8dzKsQuEzv/QlX1Q++/rnV34VisGP1PPOkQ19xVXkEm
	 x8jNUQMO6zRXztmMeI2MB2561XsEE+SEDFAY3pFxmYIQ4nGAM40IXbDx4lKLANSnb0
	 bHHM1GRWFky/GpQYix3n87kz0PP28xhtrfuQGiqJrryC43wAMTfIzJo/vhAKwHTTpm
	 UAJLt6peNH8/4D1YdzE852WjYnR9qlgdSzJ3bRVbIkbX/a/NyrCFjIvLmXXBqRSl3T
	 uaRq342M5usdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98FE8E00081;
	Wed,  8 Nov 2023 21:34:35 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <87fs1g1rac.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87fs1g1rac.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fs1g1rac.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.7-merge-2
X-PR-Tracked-Commit-Id: 14a537983b228cb050ceca3a5b743d01315dc4aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34f763262743aac0847b15711b0460ac6d6943d5
Message-Id: <169947927562.28494.985381701076184538.pr-tracker-bot@kernel.org>
Date: Wed, 08 Nov 2023 21:34:35 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, catherine.hoang@oracle.com, cheng.lin130@zte.com.cn, dchinner@redhat.com, djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, osandov@fb.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 08 Nov 2023 15:26:29 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.7-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34f763262743aac0847b15711b0460ac6d6943d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

