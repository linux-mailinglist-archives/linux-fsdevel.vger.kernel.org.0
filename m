Return-Path: <linux-fsdevel+bounces-14366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F3D87B3C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C52289017
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 21:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548C259B4D;
	Wed, 13 Mar 2024 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayKaDpBi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B558AB8
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366448; cv=none; b=TsGB53PAFs3Q5FgIC4dTu+5NlwM03jcvpJEtxJX36+5kplAVGrMLeMltQP67j2StVJy5eMcbX2mru9cWjXNAmgf4Jo8b0ohxH8CCdmTvgiK+Ke1jjo01T8PcWCXeMw3mWvOA5wQoqICQQQdt+/9CB3G+VnbhX9xqpcnlFKFF64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366448; c=relaxed/simple;
	bh=u6s2nv4TbL9At8IkaEOyev5JAKENMVh3wpHB3a9P4Ho=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pA9x7Y6SD2s19YnXUs9b4ukQPtCtQyuvoXzI9f5NEq+vzw8gBwluOtA3du/9hii1LHAF3RcL2osoGenv1d+AmCacc9lEaTlpNXBN09NeaK1azl9saLz+Uie+vXzlUEQ8G5HXo43r9e0+54DZsxl+MMbrrRt3goA6RsdI5rMVGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayKaDpBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B4CBC4167D;
	Wed, 13 Mar 2024 21:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710366448;
	bh=u6s2nv4TbL9At8IkaEOyev5JAKENMVh3wpHB3a9P4Ho=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ayKaDpBiOKRJuO/diu9vaJkHeTBRvXuOV6UaS0a90P2knns6pS1I3s6Z9rcaWwQgR
	 RZRLme6YuKSHeD1/+MnVRqJ+fT8LxBwSwmMPbBVN6sQzaueNOKjmjWw76/RKbaDVSz
	 XtS5slePWPAdWeLjqX7U636VLiQR/MspZgAocd7GSNbzUvcm9E2Gn29rW0eEnRdmCU
	 Q+iHgdDP7eC4MjPjrEtsUHYomTUVEgtKP6egNaeoCu4LsGStS+GP5fSaIkotZOAzsj
	 k1WWDMifemll1F81slGg1zOeEbLjbPUBcUvIk8rOYhX/1yWkqKGrreRZIeksaXB5Pw
	 d+SwI72T4DrvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 670E9D95054;
	Wed, 13 Mar 2024 21:47:28 +0000 (UTC)
Subject: Re: [GIT PULL] ext2, isofs, udf, quota fixes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240313175452.tr6vqhy7u4fbe3ow@quack3>
References: <20240313175452.tr6vqhy7u4fbe3ow@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240313175452.tr6vqhy7u4fbe3ow@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.9-rc1
X-PR-Tracked-Commit-Id: a78e41a67bef099ca3ffee78c7eda8d43b693f27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5e038b7ae9da96b93974bf072ca1876899a01a3
Message-Id: <171036644841.31875.7945449752449067084.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 21:47:28 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 18:54:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5e038b7ae9da96b93974bf072ca1876899a01a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

