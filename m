Return-Path: <linux-fsdevel+bounces-63050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052C8BAA77A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75CB61923EAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7552882D7;
	Mon, 29 Sep 2025 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVqDMcoA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005D286425;
	Mon, 29 Sep 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174280; cv=none; b=l3Rv1uOgEktTP9chc6HBTVWhAYuq9KberoX4QM+gL2B2D/N2WXoSsz8oxLJtTVmhdI3caV90z6gmB4IzMEf7OjN/DGy+7PsldXk9OdHpWgQ5a1ZD1W5YfJx5Jmip97rlIhwn13IVdDJYjyyENxFZlu5v5waygUjGX2KIxGlg0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174280; c=relaxed/simple;
	bh=esQR7Knyd3G/fbNo6sk3KAyS/YFvqMSLjMfmTUUB/GU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Jrv49KROu/cuny1RCi34jVDB15RRcbvwDNDYn1mkB9z4kq/83kw0ls8LCiJ0i9BWbyikzn2CIjbFhS7+Ry+hINPlmJj4y9b1bVqPrwbl8inTDd9BiLkcZwTfQ3hrVPnafU+vZyGzA3bPlr33z2o7dktJNC0YkmSjs5XU2EWc4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVqDMcoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1789C116B1;
	Mon, 29 Sep 2025 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174279;
	bh=esQR7Knyd3G/fbNo6sk3KAyS/YFvqMSLjMfmTUUB/GU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SVqDMcoAmcNiLZI7CwGVMZpgs0k6y9uZMadyl+s9O/Zh5kwdmIoDjOEmWSuaoQsmm
	 a+v9NHa4viS92iw+Ec0MknnzspW83tVntigGVfkVu17hXv1FDR13TfA+s1edv2nseH
	 ASK5btjhOIROvc/CiKHIqLq6+dxCPhS/W/psJdJKMiKvTuXzX9f8TmB9tb4pfldJ/6
	 D1TT1nnntsZzx/IFwxTxEgXk+fQtyx9NyX786ppbXl9K1L7HkDarZaqMPzeyjdEdSq
	 M3Dkvv9wt8VyvHDd1PPi7WaCSGMhrA/v0yf7b6ochS6tUClq/GucJE684GOauo9yE8
	 /rY+mC7MzPrvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8439D0C1A;
	Mon, 29 Sep 2025 19:31:14 +0000 (UTC)
Subject: Re: [GIT PULL 07/12 for v6.18] workqueue
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-workqueue-6bff38a4de55@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner> <20250926-vfs-workqueue-6bff38a4de55@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-workqueue-6bff38a4de55@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.workqueue
X-PR-Tracked-Commit-Id: 56ce6c8b11a95c65764e27cb6021b1e98ccc4212
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b786405685087912601e24d94c1670523c829137
Message-Id: <175917427330.1690083.4486073761650526519.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 19:31:13 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:19:01 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.workqueue

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b786405685087912601e24d94c1670523c829137

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

