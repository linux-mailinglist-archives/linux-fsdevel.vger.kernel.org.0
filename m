Return-Path: <linux-fsdevel+bounces-8279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D830D832210
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 00:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E4D1C23302
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 23:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BFD28E10;
	Thu, 18 Jan 2024 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhph1s5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20E28DA1;
	Thu, 18 Jan 2024 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618907; cv=none; b=a3bVPpU50S7Jebp8+vjgBqlyfggi4W4kjcVzztkba+yGkPlJsrEvTrf3LhgEImOQtd77YU1/aM43Dwzc7jZFuEw7W9csp2bFELJJ2J6L1ai/PVZka2sAW2oBeZihgP3FARiBs0Imgw0GXFsg96JPwsAVfUOECnMT+VtSh3CuENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618907; c=relaxed/simple;
	bh=iYEAYxqKw+GfFXR0IYewffq1HciOqW1RYUm1DRJDaO4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HQRqkTwXw8umA1CsK0NKEOx46f2drBTp/S+M8B4bPltTbh5SSIbPMOLzTMJi7wxEHZwFfLb11KCbb+JvIamO2k7U7GvdG/DUXVd9g3ClYxtbN36IKtvmPkrVWOinQkxtdm2DenJuuxlqEKOUx6hMN3ELAnhi6K4t1JSruzfJtQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhph1s5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F795C433C7;
	Thu, 18 Jan 2024 23:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705618907;
	bh=iYEAYxqKw+GfFXR0IYewffq1HciOqW1RYUm1DRJDaO4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Rhph1s5HA8UF3VNiC3RAx/Sam/dxmCNvfJ0t0YaFPhLFGJbtaiZoHVICLEVyDVlfd
	 Wquax4w27VQxnvFKFYMJStFUK6pQxUmbL0MWdwi0wa6BcFt0abSN78TBuZkzQ/gAoP
	 GAE4I1ndg37KDNEdIP8FRYLKtLDLnFaknqh/mE3wpYmFM4tJB2pa7UMTh2U/9Z2zB4
	 /ObSUSWf63fVNdwwaVyRTD3YJoVJLqvqtYqqWX9MEGocvDNbnNQmzXverDTxg6H8H9
	 FQj/whk5hweMZ4rxUWT16vJ1MtBh+Wb1exlh73Q2uUpZEZTai+HyUtddDKa+yvL32m
	 c0SP0+voGPEOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D93CD8C970;
	Thu, 18 Jan 2024 23:01:47 +0000 (UTC)
Subject: Re: [GIT PULL] eventfs: Updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240107180924.38e25155@rorschach.local.home>
References: <20240107180924.38e25155@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240107180924.38e25155@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git eventfs-v6.8
X-PR-Tracked-Commit-Id: 1de94b52d5e8d8b32f0252f14fad1f1edc2e71f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53c41052ba3121761e6f62a813961164532a214f
Message-Id: <170561890711.14039.547641852669205981.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 23:01:47 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 7 Jan 2024 18:09:24 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git eventfs-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53c41052ba3121761e6f62a813961164532a214f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

