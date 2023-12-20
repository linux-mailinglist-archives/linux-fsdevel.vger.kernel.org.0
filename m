Return-Path: <linux-fsdevel+bounces-6605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 717EC81A78A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 21:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262761F2400E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE484495D8;
	Wed, 20 Dec 2023 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptOIunE0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4298248CFD;
	Wed, 20 Dec 2023 20:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D88DC433CB;
	Wed, 20 Dec 2023 20:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703103193;
	bh=1G8/kmAvRIr/SFbAvDMosY9ejIFn/R7uR+ARSGn68mA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ptOIunE0OjomrvI8TiSOKERlUi3aGJh0sxZXgnB/PgVJPXEmVIpihHzsSXDiXjwup
	 GlUmX/wqfaOy00YAGnuW8hRsPJLA6jrqvaxCe9eQKeMyYi1Pd3ZEUDxnMuZxW0Jm1C
	 LNlu6BuI5h5MeyNtDZVndT1u2goG3PSO+DIXOCmK+THYvb4Q6egTTo/YHAV6rPYy2H
	 kYfZOmkmb8M3yzPXZJ6VHzoQqcl324b9he3zOElSC8LUs7ZTZszE6dhDZUgtmJP0Rz
	 7B65N0XME2yEVaJ47BcZ2uZXPVfBpVzpjQlmHxaXD9bqt6EO6wUS98422fuHJZM+dM
	 TjKn09tTMvC4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F21F4D8C985;
	Wed, 20 Dec 2023 20:13:12 +0000 (UTC)
Subject: Re: [GIT PULL] more bcachefs fixes for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231220033056.hvoespiy4vcbpl32@moria.home.lan>
References: <20231220033056.hvoespiy4vcbpl32@moria.home.lan>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231220033056.hvoespiy4vcbpl32@moria.home.lan>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-12-19
X-PR-Tracked-Commit-Id: 247ce5f1bb3ea90879e8552b8edf4885b9a9f849
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74d8fc2b868ae156dcbd33132029561a8341d659
Message-Id: <170310319298.16038.16087252163185983387.pr-tracker-bot@kernel.org>
Date: Wed, 20 Dec 2023 20:13:12 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Dec 2023 22:30:56 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-12-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74d8fc2b868ae156dcbd33132029561a8341d659

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

