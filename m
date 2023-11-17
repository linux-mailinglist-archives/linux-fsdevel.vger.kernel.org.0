Return-Path: <linux-fsdevel+bounces-3015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332F27EF472
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 15:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F4F2812B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711736B09;
	Fri, 17 Nov 2023 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS4jM8Gb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FEC1EA7F
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 14:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B306C433C7;
	Fri, 17 Nov 2023 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700231340;
	bh=xQuC6Jvfo0Of8B33Yv/38dKbdxjnoPlyeFBrD4qVPk0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PS4jM8GbjiiSizZTakgFDYGle9YKvHK6zWJi7oZ4N2f5wGkAIkjGfrWlFlJl5ugkq
	 WSljMmXclwhsTJAQAnkJxO2EJY+1rSqquqBADbBvy/9Q7J5GAchIn8pEXCcdt9+M+6
	 EkrgKYI1+cMYo36i0gcNOORxZTxxcxvpKeDpOkpU9S2OdxrF9LdqSRi8zOBnwSZOgo
	 1w41fwH6fzJm0fB8ret0GBaoGF7YUILJiJ3x3dYciArcXEcVDG+o9ppA304uuUiKI0
	 vFAn5akcKmXXvblH3W+U4UQDek0JN0AoGi1iIvQNdmPFYFsOujopdRks8GdaIoemdI
	 JuOaTgbJSh6rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 898E9C4316B;
	Fri, 17 Nov 2023 14:29:00 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 6.7-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231117131315.1927413-1-amir73il@gmail.com>
References: <20231117131315.1927413-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-unionfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231117131315.1927413-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.7-rc2
X-PR-Tracked-Commit-Id: 37f32f52643869131ec01bb69bdf9f404f6109fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bc40e44f1ddef16a787f3501b97f1fff909177c
Message-Id: <170023134055.28622.6849058513211945485.pr-tracker-bot@kernel.org>
Date: Fri, 17 Nov 2023 14:29:00 +0000
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Nov 2023 15:13:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bc40e44f1ddef16a787f3501b97f1fff909177c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

