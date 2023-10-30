Return-Path: <linux-fsdevel+bounces-1575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB11B7DC0F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AEC1F21E3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51EE1BDD4;
	Mon, 30 Oct 2023 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhK0qcjA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B511A731
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD538C433CB;
	Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698696340;
	bh=sUoWGUnX2EgeLCClb7nbzCH4wjN/XcLkZTB6pfNlp+I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qhK0qcjA3MQvWDabeLZ1NVVioU1L5mjJ/AMmrWFg08KvLC7r3RkTM6m5DqlOFVhDf
	 EWVGmDYaJif2wzvZ9k9VNUh0IxC0K8+dJKgk/r9c0/GpFSIElZRCA5iZURiIAEWCjR
	 sgwl2GKXGRHAzDmEAg7JzUTq//nItLe/Vu517KIpf5D/8K9bgKytaV5rV415qndjq3
	 OHJAO9aIYLAnjrmBpJLsBdZQh8U5zDMfBPu/NISOi6Atm54KAIg/8F++A3XtpHtw1C
	 3LQLHFkvInYxZCJMv591lr9iMZRLoL++EiLVYbZNbzyo9Sa+wi4BdafibxNkFKciW1
	 M81q1IfddpTXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A435C4316B;
	Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7] vfs io updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231027-vfs-io-82cd868e9b4f@brauner>
References: <20231027-vfs-io-82cd868e9b4f@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027-vfs-io-82cd868e9b4f@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.iov_iter
X-PR-Tracked-Commit-Id: b5f0e20f444cd150121e0ce912ebd3f2dabd12bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df9c65b5fc7ef1caabdb7a01a2415cbb8a00908d
Message-Id: <169869634062.3440.16856320624280365187.pr-tracker-bot@kernel.org>
Date: Mon, 30 Oct 2023 20:05:40 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Oct 2023 16:42:35 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.iov_iter

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df9c65b5fc7ef1caabdb7a01a2415cbb8a00908d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

