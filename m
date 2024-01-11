Return-Path: <linux-fsdevel+bounces-7765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A87682A5E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 03:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756E628A339
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 02:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AD12596;
	Thu, 11 Jan 2024 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kANMSHW9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C220F5;
	Thu, 11 Jan 2024 02:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D77BC43390;
	Thu, 11 Jan 2024 02:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704939837;
	bh=y2ACpPFSccQ1JP3SiQtx3rLfeUCDd/ESYlYBC7HNyAw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kANMSHW9rFLyt8wvuUbM4lzRNLd+Og9wn6E4yLE5cTUKgB7j23y2CAX6EDbj+VlPu
	 QO+rIAPE5y144Yc6nst1EgfL3TxO6IraTJNKhWnB+YblBJr8ZISK1dlFQuXkYklD+5
	 YxZKIyvwPxrc36WSH7KGYhnZKwAnb8ffIjjDLtrchzlK8GdGSUinDgsnmYIz3hDQvS
	 i3Oa8Qpsy6Ze+nNDZKIT4e7js6Goqzd/p2xFw9oqdzWJm42HDxt2fEgMO4Tn7kvt+B
	 J7cHCrIi20lbeAYyrwh6vFuhr63cCuoUlvtuBENbjOSVCM1EeolfAK3UD1/c6n2KL7
	 UBOX2mpMVMi9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49958D8C979;
	Thu, 11 Jan 2024 02:23:57 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZZ1aMZdS5GK1tEfn@bombadil.infradead.org>
References: <ZZ1aMZdS5GK1tEfn@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZZ1aMZdS5GK1tEfn@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.8-rc1
X-PR-Tracked-Commit-Id: 561429807d50aad76f1205b0b1d7b4aacf365d4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a05aea98d4052dcd63d9d379613058e9e86c76d7
Message-Id: <170493983729.10151.3045638970272194820.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 02:23:57 +0000
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Joel Granados <joel.granados@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, mcgrof@kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 9 Jan 2024 06:37:37 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a05aea98d4052dcd63d9d379613058e9e86c76d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

