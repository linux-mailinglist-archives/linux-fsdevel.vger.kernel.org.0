Return-Path: <linux-fsdevel+bounces-1597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27A97DC348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 00:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2AAB20E2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 23:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F391A70F;
	Mon, 30 Oct 2023 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFLJlvO+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7405B199DC
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 23:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4769C4167D;
	Mon, 30 Oct 2023 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698709804;
	bh=YRuUm4bfW2EB4ANBzXvcekrGTyABOCWpea4WyLpA9kE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tFLJlvO+xv7S4as4euBltdN0oU+rxy6zacIym/GuIP/H2Ou9f7/Xin0j/KPnPJwIz
	 sj98p3Vldxet+2fsIyrhSOywkiOaxThF8vTr+BXLzLLBmVh8uNiqjftnwYcV+O0DLX
	 TIaEIQVt4/zp1KKY4UQfRYf1MltOG/KUh+eU808ZFO2jxHiwQ/0nLV7OTykJqV2TBe
	 5Q3wF7R2/yp6eKy5DtM7b5mfHSVKOnrDCfMots+XogV2XkSb30msQI2ZsQGCpQ2nFR
	 Nad4sNGVVFWdgbMsGQjN4inlu8Ewj1HKkkMVxnsp/GolIbI83aqmHFAzc/iFQaJ5T4
	 pQXgjpdUG096Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8140E00092;
	Mon, 30 Oct 2023 23:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231030040419.GA43439@sol.localdomain>
References: <20231030040419.GA43439@sol.localdomain>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231030040419.GA43439@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 15baf55481de700f8c4494cddb80ec4f4575548b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8829687a4ac1d484639425a691da46f6e361aec1
Message-Id: <169870980481.17163.6617828174238746064.pr-tracker-bot@kernel.org>
Date: Mon, 30 Oct 2023 23:50:04 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 29 Oct 2023 21:04:19 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8829687a4ac1d484639425a691da46f6e361aec1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

