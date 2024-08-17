Return-Path: <linux-fsdevel+bounces-26198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C870955924
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 19:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A22B2163F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 17:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7A0156256;
	Sat, 17 Aug 2024 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1YmxeCY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4852F155731;
	Sat, 17 Aug 2024 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723914750; cv=none; b=jbKKsspEn9QHOCAsoGSgwWn4fx9bgC2JS5qblcuxHg938XLQ/218qkDMX6frBzXQ7Ph41I3l1fYzbHR3QpsUsgmUzNwKPSszeQFyJyuG3MoqwFu12Sl0r8fTFNMBqkFhAP62hQjrVZmH3FGEEsHtKkFBW0ANRy2Y/Oo7AVJ74PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723914750; c=relaxed/simple;
	bh=OscG8NLK0C1qmyZNaoIqviAfHzokxatEGBzxrg/56XY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NAgOLuqa5h1GixNg/6qaKvbyioQf0Gb9uyzwRDd7Cv90lT7Lx2CIcnXQzz1t9YBrepF2xPlULyFIzkZjXrb/ashiqYGLCnBNS9fy8u2VldnCLz3jdBvXFM3AKjbA8LIwr/8/1zboHWVMHhI9/uK8XGwa3lKUPonbnBr9SVx7NDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1YmxeCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44D5C116B1;
	Sat, 17 Aug 2024 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723914749;
	bh=OscG8NLK0C1qmyZNaoIqviAfHzokxatEGBzxrg/56XY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b1YmxeCYCg8tSrUgdm6enRMwDukVf3gIf4xVt7mtkkkZg7KTH035XB48i9HlCDZTl
	 alUXh7PUdmoH2RRS0VLhFm66bSUr7DyQ/2TuQQyXz2c1TMu1eYZ7bJUsi75J216qiG
	 uhkifHftpDSYia+PJXzxE4hAjkM1MGCVr1s8L0xBEag486jig03YHmUbMh7SyiZbsX
	 p8v6BQpezqO4jzBv8mVjZtCHbannUjNXBsJjpUnMdnmGDACQKtzmnvQNzSS5bENVuP
	 OMrRMGhjgHpCAEbMPsMlqN3ej1TUincZ/W2gM3haCqmCIsCJLJkBAvwC0XP5TWljmZ
	 mJ7eA2H7QOB/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F4238231F8;
	Sat, 17 Aug 2024 17:12:30 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ikvzm8jt.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87ikvzm8jt.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ikvzm8jt.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.11-fixes-3
X-PR-Tracked-Commit-Id: 8d16762047c627073955b7ed171a36addaf7b1ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d09840f8b362d16a0722d300a6c7c8cca626e628
Message-Id: <172391474898.3799179.6830851943801510863.pr-tracker-bot@kernel.org>
Date: Sat, 17 Aug 2024 17:12:28 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 17 Aug 2024 21:41:24 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.11-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d09840f8b362d16a0722d300a6c7c8cca626e628

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

