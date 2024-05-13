Return-Path: <linux-fsdevel+bounces-19391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD98C479E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 21:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01132286845
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 19:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AF57E579;
	Mon, 13 May 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzvqKrK4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E04977F13;
	Mon, 13 May 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629081; cv=none; b=QOTcAGWd5OsPENOpZ/38pmXcSr6lVi3aKdYcpMxc9qg1lD/+FRalo4KU3VCQ+G28cdmA7ZGjDireMQFlYDo/kLS0/h1wZkOQwcKhr3o/9I+I8IOygUS1yKGLyYqNdwJBaxVmPYGD1GnoF0MWf/LiRqpTfIVVxldM+z5EwbdlJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629081; c=relaxed/simple;
	bh=jxNMR4aPWxyI1qydG2otq7UgvsJDosqofpj/0kSuUr8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SbTuOGmSkzkXTwkmdIGFA92d9hy1o02rjiERHgXa3yuqiwYnEHTLbJGbSLLtjVgu0AxG7A6uhUsZGAGa/qf0pESyT/BjdVAo/rlVBR7wUYjxwA4P3pZJGOkxCp6bA/JuUB8Oyq3C3JAc7tOdIkoQYJsbTnFl5RmUfMVd86Xp2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzvqKrK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27B9CC32786;
	Mon, 13 May 2024 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715629081;
	bh=jxNMR4aPWxyI1qydG2otq7UgvsJDosqofpj/0kSuUr8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EzvqKrK4B/cBoDv1ERCNg5lb3jmYUqzAEQhz+MYUKovQsKfwMuWi1M7mtkY6SoUWA
	 RjXJ+I3L7RTb8owBRH2SI0WxmpoKPwzFWx94ezs7HdUd/cJMKReI2GmzQHTCmIy7MF
	 +Elel7qLCWRH7PHCmg/DUtmPLpNNXkYFYQqGnp3eWhis/eSjfbZ8Fni7yMZbNObSLK
	 cBhCDddn6OndvB3jhETEfuMrExg6WrcZLsUS2shK+uojOTfdB2m8ZpA8soZzmpVu4M
	 0+6rXlGtRIziNN/psu2ZsyLoWb6ARh9B4BysMOAZiN6qmVyKRaD835cic5vEPH54eM
	 Gk5YEiGFV/c+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BC03C43443;
	Mon, 13 May 2024 19:38:01 +0000 (UTC)
Subject: Re: [GIT PULL] vfs netfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240510-vfs-netfs-f805bdd4c8ad@brauner>
References: <20240510-vfs-netfs-f805bdd4c8ad@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240510-vfs-netfs-f805bdd4c8ad@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.netfs
X-PR-Tracked-Commit-Id: e2bc9f6cfbd62c72a93a70068daab8886bec32ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef31ea6c2774c015946d2ffa26795766f7caaa42
Message-Id: <171562908110.8710.14690901939724304863.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 19:38:01 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 13:47:02 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.netfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef31ea6c2774c015946d2ffa26795766f7caaa42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

