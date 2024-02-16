Return-Path: <linux-fsdevel+bounces-11886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDD28585CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 19:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B031F21BE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9A6135A6E;
	Fri, 16 Feb 2024 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC/7YRdL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ECB137C58
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109521; cv=none; b=V2ihOr2Bmxtsy1bYj8RxCeTmuLqe7bFyxFcfSGI2ii9g2T12qlSgXza+jq4x7W+yQwMDa27ndVw4mVgjWfVOb/XuviXfS0YAWXtu82KRS5Y39S7vygAMM7q2wmqHgzZ1KBwk0CxAURO9yI8dMNJjoBl+j/esJ9t1uAQMdaXDW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109521; c=relaxed/simple;
	bh=kxPFgkD5hViKKSLK+vjQtA+A4JvJyLp+hNsZn6wCiVQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UEJTyMPBOnq+nnIBP8Svvi0R9M12IPAYJzwznvuYcDJOjC6qdBrqy6pCMm5So7E2Z9abi5IHmT05YGPProw3tU518QzWHrvL71BZYektkOW0zxZfeOL40jZVAZhQdSK6+6xKy87ydWayLQdAZAgKAaUDwlWcG2Yn5i1FM8+3I+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC/7YRdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2450C433C7;
	Fri, 16 Feb 2024 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708109520;
	bh=kxPFgkD5hViKKSLK+vjQtA+A4JvJyLp+hNsZn6wCiVQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OC/7YRdLyOQ2DZBwutPqXw4pMl5ggXj7+3rlsYthyv+bJJQERxMYTqMbhVJ1u2Kms
	 rn7a08nBa0hrjsCJVgmwz25ZxrXTXnLKf/5ZJUuv2PLTkwapLa3iWoir8I1UkbFCs7
	 sFJLBySjceiMfS80tflogkWVcs7dID1PetJ5JyaHr0aDWp5DwF4a3cFZy6OCY4jal7
	 Uo5lhzrgmAxtyCRA5kqKzbw+FchS3hVmz2tpD2cQS3/9P6TuXdEzGYMq0W0RYG0UQK
	 nwBr4aWHIMtMToiqsumwn415DVbAXNZWktiAiCFXHjVMCjrLuxdqvToYh5p/szVWy5
	 qXh/ZmMNuPi9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97CF8D84BCD;
	Fri, 16 Feb 2024 18:52:00 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240216122107.3914026-1-dlemoal@kernel.org>
References: <20240216122107.3914026-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240216122107.3914026-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.8-rc5
X-PR-Tracked-Commit-Id: 14db5f64a971fce3d8ea35de4dfc7f443a3efb92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efb0b63afce6a6f470ee8eda5abe70d1e8aa558a
Message-Id: <170810952061.23532.1079305408113535338.pr-tracker-bot@kernel.org>
Date: Fri, 16 Feb 2024 18:52:00 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Feb 2024 21:21:07 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efb0b63afce6a6f470ee8eda5abe70d1e8aa558a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

