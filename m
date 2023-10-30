Return-Path: <linux-fsdevel+bounces-1573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F98B7DC0F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F80D1C20B69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 20:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B011B29B;
	Mon, 30 Oct 2023 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiY3fT+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD91A727
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72BCCC433C7;
	Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698696340;
	bh=wLp8OHmDsYZqQvYrmDZDmxOH+XMPSfAm1E7ffIiFgSI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eiY3fT+3hTAsImFt11RZHrpC0Fpvm+J5HgNiWTtxVUA5vd+F5IKSMJhPFKsbU3/XO
	 XrxxnR5IucPj5ndzKxo4kPf8aVb7GQ8Yw4Fsp1Eots5pKR89/I/0NBk3IIcm6Uj4+L
	 BtqX6X0aYFDrNxKq5aT42EqEo8238fVfrU4o/Vh01Oya8Y/5Zi8XSvL39/hvMgLx+O
	 IwzZSnBKyVNhuPuNWJr/hGJ+UJRDrgtT+dLOaVT5evffESzrhIgXCj90mX+7NAxgsE
	 pqnGvOWJ6niHUnF5695NgTvw219pqCbGtdLj38xOP5xyafJnP5iIzUD1JEA6j8ZBdQ
	 5+cLup0Zq9veQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58534EAB088;
	Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7] vfs misc updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231027-vfs-misc-7ebef2b5a462@brauner>
References: <20231027-vfs-misc-7ebef2b5a462@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027-vfs-misc-7ebef2b5a462@brauner>
X-PR-Tracked-Remote: https://lore.kernel.org/r/20230926162228.68666-1-mjguzik@gmail.com Cleanups
X-PR-Tracked-Commit-Id: 61d4fb0b349ec1b33119913c3b0bd109de30142c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b3f874cc1d074bdcffc224d683925fd11808fe7
Message-Id: <169869634035.3440.6255914098831091774.pr-tracker-bot@kernel.org>
Date: Mon, 30 Oct 2023 20:05:40 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Oct 2023 16:30:46 +0200:

> https://lore.kernel.org/r/20230926162228.68666-1-mjguzik@gmail.com Cleanups

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b3f874cc1d074bdcffc224d683925fd11808fe7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

