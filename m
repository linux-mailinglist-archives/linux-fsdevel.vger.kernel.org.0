Return-Path: <linux-fsdevel+bounces-130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17DB7C5FB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 23:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B2B28247B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 21:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA6C3E493;
	Wed, 11 Oct 2023 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NThsv6j/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E32230D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 21:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF06EC433C8;
	Wed, 11 Oct 2023 21:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697061521;
	bh=AsLatXnMOGzISy2Kp+MgVVESmREHNSpt9Pi0NfdfwlM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NThsv6j/E/WsfJ3KUcK3JMY73kNkIAxrNK7DrKUw6SAyg/1+Aw2ia7zesc77/fviQ
	 qeyTlIEC2Iew4kP55OhqmdmA5CmHTp/oJdm/NNzzp5jmRk2OL3/RRtLzjkXWFZ81og
	 iwZTG/EPWPhbkJTJ8Ezvr3p+A6O6UMSgUHRjTHhzOLT7xXkn3uqBLTzYL7LT6nJFke
	 XDuCycwPmLK6foNrKvQGzyUzFnkQf6GQala+FYpB9HKHKjs53rxSoaOiBJRODk3XQU
	 ORJ37RTUIlakK+k3Cp+GK++lIwCqcEyfpbGXyOElPnZgmRVGuLj5uNU/gYYO8/Y75j
	 N0W92WT7cgnjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA6C2E000BB;
	Wed, 11 Oct 2023 21:58:40 +0000 (UTC)
Subject: Re: [GIT PULL] quota regression fix for 6.6-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231011122347.zf33iokgq3yl6e77@quack3>
References: <20231011122347.zf33iokgq3yl6e77@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231011122347.zf33iokgq3yl6e77@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.6-rc6
X-PR-Tracked-Commit-Id: 869b6ea1609f655a43251bf41757aa44e5350a8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 401644852d0b2a278811de38081be23f74b5bb04
Message-Id: <169706152089.2549.17174829495791522699.pr-tracker-bot@kernel.org>
Date: Wed, 11 Oct 2023 21:58:40 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 11 Oct 2023 14:23:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/401644852d0b2a278811de38081be23f74b5bb04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

