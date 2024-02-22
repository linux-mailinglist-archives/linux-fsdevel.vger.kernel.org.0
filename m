Return-Path: <linux-fsdevel+bounces-12509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F80860167
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 19:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A491F21759
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 18:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11B15B0E6;
	Thu, 22 Feb 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIHaLvsO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718A15AACD;
	Thu, 22 Feb 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625915; cv=none; b=u4pUryzBxxdaOYD2upOyHwguxoIazQShadXiOe4j0tyQUehHBQbF8k2ymxNSbP742pU8EU7LMxLvu2wkuminao/+QrgLUznFg8oNb6O9NvD11L1ioR+Oa4baAZ656DfMfNc8c/5kXhBynRcDybtdRV+tz4CxQlySW1jHhAnUK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625915; c=relaxed/simple;
	bh=+hQ6N1Zh1w41P3Xvt3LfDQHBJ9GKSt0Ew1oKLVxEj1k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NccyRkUWTZoRwuGE3HeW4CHc4HRa0hf1HJ2gHY1BX5nN+W+As0ZmEpo8zL2EBX03NxVl/ZAUwZv3TCM9UeHafVRc7iTV4sMkfNBPrg6CnOnrdd3c2F1B5zoTjrhMk+nS0jtCHfz7cz35MYEAHL344LGo5S+GFsGP9s7SuvcvnRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIHaLvsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE2E5C43394;
	Thu, 22 Feb 2024 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708625914;
	bh=+hQ6N1Zh1w41P3Xvt3LfDQHBJ9GKSt0Ew1oKLVxEj1k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XIHaLvsOfc1anHEZzvfGjkfl++T2qts+av/We/7N1cHTF0Gg5IjjND+H7BbM9sLRd
	 0QGIRcOSxF1CUI+Tze8iEZXJwQ3aqZKzn8qLxBL1qwd9dv67NnKppdNXTJv8inekDa
	 wocXvqORM8nayouG31zEOM2+bH1yELttrmWd1rBsrbf3tOKv5eYuIlL+9o0y5nUn1w
	 /pEup1+Cu4TxwbLJiHlHMguzML4W1dMrbr+9uOulA4DYwIHV3wboBqNyZOr8ynjWM8
	 13qhGd0J+2Oc2vyp0T8KhqyP3A6V1XVR03dvr7nvAh0aj3Ll+gPSikuai848cVhOni
	 xlLmZEo9np1uA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3261D84BBB;
	Thu, 22 Feb 2024 18:18:34 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240222-vfs-fixes-90812d8f4995@brauner>
References: <20240222-vfs-fixes-90812d8f4995@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240222-vfs-fixes-90812d8f4995@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc6.fixes
X-PR-Tracked-Commit-Id: b820de741ae48ccf50dd95e297889c286ff4f760
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c892cdd8fe004ed6cef4501a7141594a1616368
Message-Id: <170862591479.18883.12557048481495703304.pr-tracker-bot@kernel.org>
Date: Thu, 22 Feb 2024 18:18:34 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 22 Feb 2024 15:03:24 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc6.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c892cdd8fe004ed6cef4501a7141594a1616368

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

