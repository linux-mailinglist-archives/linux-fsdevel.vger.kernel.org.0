Return-Path: <linux-fsdevel+bounces-4616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8083D801671
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14BF1C20A40
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7CD3F8CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLDx7iKp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448A262B6;
	Fri,  1 Dec 2023 21:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61E42C433C7;
	Fri,  1 Dec 2023 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701465704;
	bh=a6VAM6LKqNgD6Puv2OUlj5CEqPB85sLEtOqOcxbQwlo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SLDx7iKpthiLbFqW+7PvI3+HtgLLVSvM5Z9mfJJqVR87TK4P+/tsZmr0O9ZPVWnI3
	 GcOrdwnVanyvlhsCUeBt2wbLKb0nYcRKEFE+OVxyFV/ajkknGlcSYYbdKUlpPuje1f
	 bRY0JKsgEuwzYNpuACQ2UzEmeSk2mLpM+Dv0HNG8YiUsHX7Tqa3kCoDg6NQN/xjVzZ
	 A5Z8hX9Uxg1U3lO2KhiJJDFSu9jN6KYYZ8HMTEY0iWfPvvza7Kt3Kgj8NVqB90I2Yy
	 HpRttsrAxNTWyQ/+cchi/OH1q2VT30MpSrEXLRkBucahgKKxfwIw/tEnE0vNxR/5e8
	 /bU6DTDZ8RbWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EA48DFAA94;
	Fri,  1 Dec 2023 21:21:44 +0000 (UTC)
Subject: Re: [GIT PULL] more bcachefs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231129204336.4yfhhptdgrfaguur@moria.home.lan>
References: <20231129204336.4yfhhptdgrfaguur@moria.home.lan>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231129204336.4yfhhptdgrfaguur@moria.home.lan>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-11-29
X-PR-Tracked-Commit-Id: 415e5107b0dce0e5407ae4a46700cd7e8859e252
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6861be452a53a5de3e1a048eabd811a05a44915
Message-Id: <170146570431.19100.16520157136518044796.pr-tracker-bot@kernel.org>
Date: Fri, 01 Dec 2023 21:21:44 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 29 Nov 2023 15:43:36 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-11-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6861be452a53a5de3e1a048eabd811a05a44915

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

