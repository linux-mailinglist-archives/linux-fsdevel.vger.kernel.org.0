Return-Path: <linux-fsdevel+bounces-8325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FCA832E94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 19:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84A81C21611
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE1156447;
	Fri, 19 Jan 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnk9nh8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5855E52;
	Fri, 19 Jan 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687380; cv=none; b=Al058NN7kqVhgF9noNB2Qxli74hk6QFELqAA3YnCtPDd2Y6p6lg5bEBRgwgC3kbTnOpVz3yYKywwYq0j2+IyB/HADPPDr6G7bnNADo61/ITLeMyLlkvwKECJ0bPS7clMJrD/a7PuJ7bteg/m1EP+CKPvsbb57ry7Aj9qy/nwL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687380; c=relaxed/simple;
	bh=ZHDz6EeUJ3sU70lXnf0UQOq39oxIp37JR47UkVDZ+9U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jvh95DW38hdWWniZzDHTPhr9v9KsbB72zUAXxBdXc6ctmu2KxU9Tm3JmuVuMoqfRBfQytUot2xW0XudqRnRAaNHJN3Ptm4CFl0mHqeAMjEpf8O1as9zADgXopeSW7/XWoA85/4G0e0bqmAJ2ctd9xGYTDb7MkDrmed77h/fodKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnk9nh8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63064C433C7;
	Fri, 19 Jan 2024 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705687380;
	bh=ZHDz6EeUJ3sU70lXnf0UQOq39oxIp37JR47UkVDZ+9U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fnk9nh8UaaiMHxq5LKPORbbaUkCqGvGUC4YkXYRDPQJaTyy8dbPfuwc6f40Rijqfw
	 1onWLJoY6vUv6RLmcqXVNHLmR1HQ86kc8hQYaPjE1suedWqVwy2OeQ4Nb5kQO4n/Ks
	 bydQqZWvwFJNeHATYe/oE4OFEa4tRAAW3eks49XGaRycR+0OLuRyb08QdZfQoobxbs
	 oQ+o9w5iPl7Z7hftNFsrxnhIFppul3v0JC7+VjP/kiOMVGGmZYIjaz4raJcRH9c6Kr
	 U7jOwEbXMCVVoA5ZH8Qi6gPCc32sBZ+y/E5cMN0CvNVtl88dwqpT+wg26GWuulYcgb
	 pdr7SbH1FI7pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F74AD8C96C;
	Fri, 19 Jan 2024 18:03:00 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: More code changes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <87zfx3i363.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87zfx3i363.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zfx3i363.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.8-merge-4
X-PR-Tracked-Commit-Id: d61b40bf15ce453f3aa71f6b423938e239e7f8f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec2d264ae4bb624f1b48a6f6ee1c47d7ea385f0a
Message-Id: <170568738031.12972.5145186023371071129.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 18:03:00 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, djwong@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 11:31:40 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.8-merge-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec2d264ae4bb624f1b48a6f6ee1c47d7ea385f0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

