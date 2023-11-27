Return-Path: <linux-fsdevel+bounces-3874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834817F9815
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 05:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CE4280E36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 04:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A5753A9;
	Mon, 27 Nov 2023 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPsvV6x9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97445382
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 04:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 167FEC433C9;
	Mon, 27 Nov 2023 04:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701057623;
	bh=MJhYrf8f29Vrw8fBuxfWISHzDTmZGwDZYtVGyO1ypfs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TPsvV6x9vPbA7+PCk1oUpuOagJve7LYBdtXxzzBJNSidbnBZBQTcg/aZilrPbEgEf
	 gc3egEQedakby5ng75vEET2maeEyYL7iopP6OY3vrmPNudTdkM48qCYFr2MGMqIo1N
	 RykVzQFYJ+3xPMtIOYJmBca7/SC+5+xvMEu14WZiCh23do1snGcKIC7X8l7GXlSMUv
	 SIcillBsCohE3ADMDw1u1ZP9eMdYK+F5e/W4Kar7yFiANOAxlZ6rLMicDvyKmAzLTe
	 CbTD8Zx0bgGVPtd5hk2JlqsQ8j6acwp9/MW7Zp14B2vs9KdFt7aUG5IzuJuaGNu6U/
	 0wOq8CPRcc24Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC6ABC395DC;
	Mon, 27 Nov 2023 04:00:22 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/eventfs: Fixes for v6.7-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231126100356.389c325d@rorschach.local.home>
References: <20231126100356.389c325d@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231126100356.389c325d@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc2
X-PR-Tracked-Commit-Id: 76d9eafff4484547ed9e606c8227ac9799a9f2da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b2b1173a93fa056b4539ef52e5f03148345d498
Message-Id: <170105762292.16434.15747037694024366777.pr-tracker-bot@kernel.org>
Date: Mon, 27 Nov 2023 04:00:22 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Nov 2023 10:04:57 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b2b1173a93fa056b4539ef52e5f03148345d498

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

