Return-Path: <linux-fsdevel+bounces-19121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BCF8C038C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 19:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BEE1F23056
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AD12E1C8;
	Wed,  8 May 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRHRb5a7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545712B153;
	Wed,  8 May 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190369; cv=none; b=WEdZQ6r21In6fT+kEI3oJ8STc8h4Gk5RadOBNULuMN28OvUtrV64euAb0Qgnq3Uv0K32kL3wONV8SjWPTIzKRSCZSLpAJ0CegFfKkJ0F75+Dspq0GAsas/TkJsVR9n2MlmRauvUyheUvgtCDl3iLRIwpNyzgslkYLfeNWaho2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190369; c=relaxed/simple;
	bh=6GNO7DW7qnQpWsytAlzat/pnLJU1eugjlP7GeU8ek8Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cHvkr20bjZY2a96KqLCU0otMq4B/odRAT+6WD04msFHw313LjLIhuBDDIy8UxAWx6M7l9f9E1VOf16RFpV0muruPcTal7Jsq66kXI9Wv/WeU38UIEv7qdFXsryGkbT+IpdOFjJkTqcV/ebHYlebQD+EPBJFxI8pbBm+Y10Ixerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRHRb5a7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF0EBC32783;
	Wed,  8 May 2024 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715190368;
	bh=6GNO7DW7qnQpWsytAlzat/pnLJU1eugjlP7GeU8ek8Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mRHRb5a7Cib8XjfOyaPfZE311yKpeAaJCx7ypDF+oMATbectBcF8Q9DnlXDjtMG1H
	 ksm47d+S3cic22sdyt2/pZL1601rE7zzJNSLKpuVcWgt9kXGy/hhOERbHxAeQ3XCt5
	 wvNy9JJF/htDD61TY/wN9iJEoHw4js3PHtbPjXV3K44U09GAuKONxXoTM6KJD9XG3M
	 qw8LxxsxIcMh0mIlzxMewEw8HcS3qVJFXCX8+gpXm487KXtabZYDlgKPolbBUDKZXW
	 OH3v/xT42b5q/JjU+QmvzMm8YdIQhOaL2fW2TgLLxQMYL0NqiEBJxkIsGk7UpQmKCn
	 rP+eXSVAc6ZDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3B95C43331;
	Wed,  8 May 2024 17:46:08 +0000 (UTC)
Subject: Re: Re: [GIT PULL] bcachefs fixes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <4u2imuisg3sxaomerwbss6p22vxyc2lk6esyn5asybytwgrhe3@tccxjeu5hqmq>
References: <3x4p5h5f4itasrdylf5cldow6anxie6ixop3o4iaqcucqi7ob4@7ewzp7azzj7i> <4u2imuisg3sxaomerwbss6p22vxyc2lk6esyn5asybytwgrhe3@tccxjeu5hqmq>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4u2imuisg3sxaomerwbss6p22vxyc2lk6esyn5asybytwgrhe3@tccxjeu5hqmq>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-05-07.2
X-PR-Tracked-Commit-Id: 6e297a73bccf852e7716207caa8eb868737c7155
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5fcbc8b435b483c46fef4a9bab41fd22639b2d1
Message-Id: <171519036879.20720.8019945593485166852.pr-tracker-bot@kernel.org>
Date: Wed, 08 May 2024 17:46:08 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 7 May 2024 11:10:44 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-05-07.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5fcbc8b435b483c46fef4a9bab41fd22639b2d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

