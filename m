Return-Path: <linux-fsdevel+bounces-7732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5822F829F4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 18:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1631C22B53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 17:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512D44D119;
	Wed, 10 Jan 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0b4HsZ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90644D100;
	Wed, 10 Jan 2024 17:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A368C433F1;
	Wed, 10 Jan 2024 17:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704908253;
	bh=cVnvDpvdoKXwm1as49CyOv5up7khFNJ58d5ex5FD9+o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U0b4HsZ3DvrrXeortqJUrT6j6U3uX6Vz/qs3nisPR457jFEoxtxDlJixuNqv7vQvb
	 hfgHtp/CmRZfyBO+A+X71+3GgPyj+edBOf9Nb0PLuZc2Y0oGxeuKAG+zl7VkXokBfL
	 8/oI+bYoByL+RDGwgXtJ8E2+lYJWoDtQFRmq+5HRYHxoj9xmUTekpqYsM6yASTJC3k
	 GDMNf3vdT8eYu50ojP1RAj+WPrdcMhpFTxliZRWu2x1+WXiZDiBoyb6AlP+ZWtI8+E
	 azgD8s9R66pS/bnl+U4L+06Ld1nURwPoOwUMYgZZB9m0nbTDxBTKaw4psIPPxuR/eh
	 6FeLPnDoYRqEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7728BD8C96F;
	Wed, 10 Jan 2024 17:37:33 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <87jzok72py.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87jzok72py.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <87jzok72py.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.8-merge-3
X-PR-Tracked-Commit-Id: bcdfae6ee520b665385020fa3e47633a8af84f12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12958e9c4c8e93ef694c10960c78453edf21526e
Message-Id: <170490825348.14271.7652576744197748214.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 17:37:33 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, bagasdotme@gmail.com, bodonnel@redhat.com, chandanbabu@kernel.org, cmaiolino@redhat.com, dan.j.williams@intel.com, david@fromorbit.com, dchinner@redhat.com, djwong@kernel.org, glider@google.com, hch@lst.de, leo.lilong@huawei.com, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, oliver.sang@intel.com, ruansy.fnst@fujitsu.com, sandeen@redhat.com, wangjinchao@xfusion.com, zhangjiachen.jaycee@bytedance.com, zhangtianci.1997@bytedance.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 08 Jan 2024 11:35:39 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.8-merge-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12958e9c4c8e93ef694c10960c78453edf21526e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

