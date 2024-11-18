Return-Path: <linux-fsdevel+bounces-35132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19089D1946
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1011F21A31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A831EF087;
	Mon, 18 Nov 2024 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egC0Kf2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50061EE032;
	Mon, 18 Nov 2024 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959346; cv=none; b=QzHGssZdnKYC4P0hckg84DoQgY53dApBBQfs9D5h5Bw58meCps4cmRRvStJqehjIkoc5iShnz9/eaHzTkPd4miVtnPyI92eRyPr02vOoZunLXS51e6fOBRTvoiW5omaZIGvRDoWXU4fK5AevEyRFfbq6KkYe97BXdRYOXdDt6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959346; c=relaxed/simple;
	bh=80b8mZRleRph8CW1fLHHHTftYyc+cJ3223SrhgtI2Do=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BxGGB0Qe+qd8ePQASw9yVgvHKr3MM0Wfiks1/EkYe8DC1PTUYr2fxEqrwamdD1i2FfOcjLt6hv/8ZakYgyMBxP633kwMWdQtEJgSBfW0KuotYRPZvYXZ0yow0i9SMfOIGViehMjIiYWl35lzMUOZXI1EAiY2ZmsZxOW4zoD0unE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egC0Kf2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D95DC4CECC;
	Mon, 18 Nov 2024 19:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959346;
	bh=80b8mZRleRph8CW1fLHHHTftYyc+cJ3223SrhgtI2Do=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=egC0Kf2yFJaQC6WVonZNp4Sb6OKMH/XF15EFFIbbq2FoOJRzFj0zDs8g3rrEIC8wi
	 fuujuQuDDfgjNjQJVByysTQgeD0bwXjKXHZ3mwGVYBEeo/KspbGuLhxXCXRXcY/wpQ
	 YCPZQs5jQtFEksR861WhbOpeEBLEyZcyX0XluuX6lqW7LnfY7tem/j3PqZCaSy4WKZ
	 Gd9Ve3EeAb00UpRmYHqIRaa0iqG0UrSiDA26AHO3K9DX7aaP9V71hrHqDZgZ2Qf1Y9
	 +zP/cIusMnnKVm5H2lMi016Wx4fByKaH2/PvkawqGykCi3K/BHGzKPTyPq+aPhtu/r
	 7VgWMRIDdMNfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C0E3809A80;
	Mon, 18 Nov 2024 19:49:19 +0000 (UTC)
Subject: Re: [GIT PULL] vfs tmpfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-tmpfs-d443d413eb26@brauner>
References: <20241115-vfs-tmpfs-d443d413eb26@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-tmpfs-d443d413eb26@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.tmpfs
X-PR-Tracked-Commit-Id: 552b15103db404c7971d4958e6e28d4e7123a325
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7956186e751bc15541ede638008feedc0e427883
Message-Id: <173195935781.4157972.5560807737438754787.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:17 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 15:06:58 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.tmpfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7956186e751bc15541ede638008feedc0e427883

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

