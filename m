Return-Path: <linux-fsdevel+bounces-23874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A54E934325
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 22:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6987B1C218DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 20:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70B1187878;
	Wed, 17 Jul 2024 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxN1cCmq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F210181D05
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247508; cv=none; b=bVgXjNNILusfU9e0rRdJjk4q5rRt5lkPVtIJa82a7YCUOyqXDegAHuH9Oi7W8gUKv4ApChbuaRUzwc9lmUv7+N39x7sn8xTTja7LUwtnlZTGLRmyElgRA6hDWM3AVLpD3DIUKBRHVvzgdnuyI1sGT/MqmVnEojSYZcZStmDVRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247508; c=relaxed/simple;
	bh=VrmotskkrZzBxIMky8JNOmTBvLJZS50mkAULSgnNyZo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FHnxBg+HO/0imOwz/pnTJ7T3o8qFs3VUPb2OiXb95kL+GegDOrfS1gaD5aNq/QlSvwj6NXCx6udRbDSKuH/LPyMFW4kV6YE9V8ipufl4gqQZBOFM0CkycMvW/rgnJCrzvg/qo4tcyQX5E32Ejc77hqej2FQTAZ7buSOEpwaYDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxN1cCmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4C3BC4AF0D;
	Wed, 17 Jul 2024 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721247507;
	bh=VrmotskkrZzBxIMky8JNOmTBvLJZS50mkAULSgnNyZo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HxN1cCmq0wBM63nDIkBovABiRgKGlsrxypsC9oHBnPu2nHAHrhMDcm6DFuoDSuXcp
	 tsR6zxaBRB1E2ufwaaYEmPGFUwgXPTfy6tUNm5SoqV5pjIVGK7VN/7GpL13a0HHxi+
	 u6nfHFJaarmXgvw7NQEckbNWBZaj2GW5idBcv/6N/pn4BRVbUWNqp3uwhT6KNN0KI2
	 S2TK0FcI4rKzEjCxFAzAGQwzQ6cygz3x/DSq3hl00MTCceEb5dd8ANQS73oy/2zxlQ
	 2R4M1JYpG80hwg2H6ZW5bJP1tQUohIBH+GzQU2Wh2FqXfkUnAYpaT8v/gE98BZ3EGS
	 FBWfq8IpZUcuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C875AC4333D;
	Wed, 17 Jul 2024 20:18:27 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify fix for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240717150636.salwxlk5v64tffzk@quack3>
References: <20240717150636.salwxlk5v64tffzk@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240717150636.salwxlk5v64tffzk@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.11-rc1
X-PR-Tracked-Commit-Id: 172e422ffea20a89bfdc672741c1aad6fbb5044e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d60183211494de0d6af04f82dd3fc301e5562724
Message-Id: <172124750781.12217.9248646078368090271.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:18:27 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jul 2024 17:06:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d60183211494de0d6af04f82dd3fc301e5562724

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

