Return-Path: <linux-fsdevel+bounces-19702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ACD8C8F41
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 03:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D20B21833
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 01:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0331BBA27;
	Sat, 18 May 2024 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpcD6fzq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2769460;
	Sat, 18 May 2024 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715997256; cv=none; b=KRMZblp/mP2bFwHiMnoPaANvNWidaN27bkFT+vJ7gYsciaJhsxgfS3tBOeaqZ+CkHc0h4WfJfOWVILmXKmv9lRncPq/JkEv+aMMqUb6VtTJkC4VN6LKCLMyb9FI2jiDyeRZNFj8PpaCSssRvUQUH9GLPLqABJaNRFds/anBA9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715997256; c=relaxed/simple;
	bh=bsEu8tl0IDz9teKR6CmkOdbsf/ggIU9I6x1Pg6lbdas=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Hkd/5vs97Zo6PkvX3vj8pr5Ex9hZGL3FmGpi/Ky/MZnnkmOJEXV/gO2bIsZ63lHD1vuoS9DNzMs2Ur6CKsXW3GFzVXwbuR7hWr19RzQzfTZgpI3vVwb838MXoU315aLO+ZQqA7JVDtSxcVOfxcDjGOcnkSTmncxU7/oVUeyi3HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpcD6fzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3531AC2BD10;
	Sat, 18 May 2024 01:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715997256;
	bh=bsEu8tl0IDz9teKR6CmkOdbsf/ggIU9I6x1Pg6lbdas=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dpcD6fzqNxn767dmmg0r0EqOhsprKr4ryGBJixtIq94ErnFXIdUs8mEUXP1W68xXS
	 a6wAnM5j6RZ6iYVtNKuh0fSqTc5/uHGqmyD5GpvGebybPS1A6vrp2GYwJl/sbxLK4T
	 uCRyHglS/enqAeuRY90iNLzgJspxZU1iCrCaE+iel4lP0wsbKjrLKecO/F6ugUcplJ
	 Es/XbvXKpU8MiUfeBrBGF563t6A/X+sb63tY2+RiGy0ZiAlkN+2EozWUof+WCS35Dr
	 AniQvam8BU7hXK9m4bMjlp6kDiODNXfSLvskfAfo8YHyWXxgwVCuuWx1cZx2goVuA7
	 eCHL7yp4LfNhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D115C1614E;
	Sat, 18 May 2024 01:54:16 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240516100239.grazwwcra43imjg3@joelS2.panther.com>
References: <CGME20240516100244eucas1p1cd749a8cc08b1dc0b073e6f0832c2d52@eucas1p1.samsung.com> <20240516100239.grazwwcra43imjg3@joelS2.panther.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240516100239.grazwwcra43imjg3@joelS2.panther.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-6.10-rc1
X-PR-Tracked-Commit-Id: a35dd3a786f57903151b18275b1eed105084cf72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91b6163be404e36baea39fc978e4739fd0448ebd
Message-Id: <171599725617.22868.11909998241445565978.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 01:54:16 +0000
To: Joel Granados <j.granados@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas =?utf-8?B?V2Vp77+9c2NodWg=?= <linux@weissschuh.net>, Valentin Schneider <vschneid@redhat.com>, Kees Cook <keescook@chromium.org>, Joel Granados <j.granados@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 12:02:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91b6163be404e36baea39fc978e4739fd0448ebd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

