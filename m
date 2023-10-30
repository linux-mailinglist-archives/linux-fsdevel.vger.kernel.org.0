Return-Path: <linux-fsdevel+bounces-1598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF67DC347
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 00:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE528281759
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 23:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7841A731;
	Mon, 30 Oct 2023 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsE3Qy+G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949EB1A71C
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 23:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39A30C433CC;
	Mon, 30 Oct 2023 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698709809;
	bh=8CbYS5dh46H3/5Jl89Y++7Ad6YTTcq+rjqAMrBPBv3o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fsE3Qy+GCScx8NYRBNRXqUlnsJC2WUDiCHZAWuTWfw8jWwKgYbDYaXv7a2DruM6uq
	 KL+Ku16aDVsubiQn2rHKSeVhjzP5csW0kYGgdU+uFAPgO9uiwoBlAyGNZTpyuSMI1L
	 MuSeMOK8YJQ/7BvHgf0P7YpzAPjUGU61T1K54J8fqLNZScaIDfgKR2xKp/rbExbKz9
	 M4RuLtt1OqONerKyEfV/6D2xbjPaAUz3L/4BICeCfZ4nqsHMVgCMxYIUOYep486+XD
	 lEEEpN2jJNR1pbMLqb7uRy2XvyTYv5F3u27+WQwhKYZQ0327GjhZDfoQHhKhOsOF2I
	 8LjmEEjjtM1MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25B37C595D7;
	Mon, 30 Oct 2023 23:50:09 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs for v6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
References: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-10-30
X-PR-Tracked-Commit-Id: b827ac419721a106ae2fccaa40576b0594edad92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e87705289667a6c5185c619ea32f3d39314eb1b
Message-Id: <169870980914.17163.3315949638870235214.pr-tracker-bot@kernel.org>
Date: Mon, 30 Oct 2023 23:50:09 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 30 Oct 2023 10:55:40 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-10-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e87705289667a6c5185c619ea32f3d39314eb1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

