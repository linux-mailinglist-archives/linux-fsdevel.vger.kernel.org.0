Return-Path: <linux-fsdevel+bounces-35469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573FF9D5249
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 19:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1695D1F210D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 18:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6FD1C460E;
	Thu, 21 Nov 2024 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiwEJnbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55281C07D3;
	Thu, 21 Nov 2024 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212277; cv=none; b=VfpucgsFcOHPrBVHQVTHBIVdDyCKqh+DtYyUCfb18FDx1Pr8CccXEQcEXGMMhc40h3wc4SLi36lD9rIWH3badw/ckgM9WhVWpoAc13ixWvceC7l3mRoNNok0r9tRVKLHpwIbafpZMqDFHJEbCRoAJCjuz1lALBljQnCTsSXywbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212277; c=relaxed/simple;
	bh=fuwb2hGk4S4w6BD4UP9fm6L7M0kYyft0NsCbuxjozG0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ilQ0nVWMR5BjMs/sc+c5GedR7VQ4FGUWxIGbDJI7qachOWLQthpT1zKx85hFHQwaA/ibSpPE/mRUlmFBQ3uCDvT3XNtG1GNx3bsbYYCd+qAFDw0dV5Zbui0p7ruM1i4MCQVh8ta+0r1GM3USNKsym69nsTML1jahLawvbkcnwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiwEJnbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8791CC4CECC;
	Thu, 21 Nov 2024 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732212277;
	bh=fuwb2hGk4S4w6BD4UP9fm6L7M0kYyft0NsCbuxjozG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UiwEJnbAPOOsQAQVGDNsidZ3kEcP9446q4yGD36vPDQOEMumBge86tHU2a7Ink6L0
	 x8Rian1IIKmbSis5gqbENxn8zUdegxvugfC+8Ji/Bcj4P9hfCR+qvR/YkpBwSuBYlA
	 xrVNaHTW9GhoDr+OFi7fImF7kB6zw07Og5toKAMXFy9K15wVxsJO7wuTrc2wRyc6TR
	 su17vvssQgUYwWpnnzs7/vvjoaBE4ERF8CZxE1OE8lYtS5t28qc2DEJ8F5bQjqp4BZ
	 +joT1KEV1+zIyYbFW8W1bPpxREbGqzeU0qtKfQPoi5IAwQxqLiV3yqXkwHyU8O1Nxu
	 C+usGB8Jlq2Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0B63809A00;
	Thu, 21 Nov 2024 18:04:50 +0000 (UTC)
Subject: Re: [GIT PULL] Remove reiserfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241121160433.2xoi3lorp3y3rows@quack3>
References: <20241121160433.2xoi3lorp3y3rows@quack3>
X-PR-Tracked-List-Id: <reiserfs-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241121160433.2xoi3lorp3y3rows@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git reiserfs_delete
X-PR-Tracked-Commit-Id: fb6f20ecb121cef4d7946f834a6ee867c4e21b4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c01f664e4ca210823b7594b50669bbd9b0a3c3b0
Message-Id: <173221228921.2032550.2839788690971460030.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 18:04:49 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, reiserfs-devel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 17:04:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git reiserfs_delete

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c01f664e4ca210823b7594b50669bbd9b0a3c3b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

