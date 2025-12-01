Return-Path: <linux-fsdevel+bounces-70390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7D9C9959A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 23:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DF83A273F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870562FF176;
	Mon,  1 Dec 2025 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRAuOB+q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7582FF151;
	Mon,  1 Dec 2025 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627088; cv=none; b=cpHGB4Npf1LkNmzwlQBth+FPgMI2qynKwwDsZ0VME3jhL/+a1ETte2bqb9eh+cnoVSCRCyCzVIxIrGgqwHQsiU4TdREqqjmBp+Vlr6onoVd2UDLtwT7gATiTppDj2c5FepVZp+VNrHDLZJn9wclSRwmJUWutEI2OyvmPWeyWLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627088; c=relaxed/simple;
	bh=QSW4z9w2AQZNHNxWnyQUeWuilwLr9cD2O6/l3tHO/hI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FnuwQ9hK2rDEHKhqh/5eNgKWM3lBDkfmmhnZlSUTlTPF2hmLgzo4+tLmeNaeVurkdP6mP7lSj/goS/NsmfJ4xe3P9Ur//LKvAjjOioTfphi8Z37ObpSr7dmvHO7GPFFx5HiNsddE23aj7zrISypXxJBLSQbD8tPrn7KeluDPO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRAuOB+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C241EC4CEF1;
	Mon,  1 Dec 2025 22:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764627087;
	bh=QSW4z9w2AQZNHNxWnyQUeWuilwLr9cD2O6/l3tHO/hI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CRAuOB+qtABOlpmAZVGS2qQVuMc434qebuQTN3mz7fmNJc1g712cMTcvDAVX7+2at
	 l+uFW1Uw72I4QxSOcCfIILuVBS8AOnaDm71o5mZUn/YlF4N+mjwID/rGOmxUXOqlUh
	 8+P2m9Us4950Sy6tmp+UlMWIKz9aFZ/pnthXNK42G/7djqHZ/6vFbiNEpBQWp+BQNq
	 yZE2OVhugE3j+ZFmALW9v0rSGtfaifph+1DCDWMemqU6iWC9Nn9T11KFC74xkqv9MN
	 AikODY2HaT1EJKB4pAhFAwMjneiBZBYXzq2RWGN58sn+UZylWuLVbF4V+faV8N6n+D
	 Vb92XJ7ZNu71w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F280D381196A;
	Mon,  1 Dec 2025 22:08:28 +0000 (UTC)
Subject: Re: [GIT PULL 06/17 for v6.19] vfs coredump
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-coredump-v619-c8892d7188f7@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-coredump-v619-c8892d7188f7@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-coredump-v619-c8892d7188f7@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.coredump
X-PR-Tracked-Commit-Id: 390d967653e17205f0e519f691b7d6be0a05ff45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 212c4053a1502e5117d8cbbbd1c15579ce1839bb
Message-Id: <176462690757.2567508.16183809133889638761.pr-tracker-bot@kernel.org>
Date: Mon, 01 Dec 2025 22:08:27 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:17 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.coredump

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/212c4053a1502e5117d8cbbbd1c15579ce1839bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

