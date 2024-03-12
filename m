Return-Path: <linux-fsdevel+bounces-14251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3AA879E79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 23:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BED61F231DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 22:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871EC1448E6;
	Tue, 12 Mar 2024 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tH3AduDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27EA14405D;
	Tue, 12 Mar 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282246; cv=none; b=ajEmJa7oEnHOHBFE2xzF35Ru/q64dx5x2rwwyOgKD22XCZ3Nq3adjgKiTS4TII5xrHVmekXgLlo2NArr4idE8Zl4DC4ehGV7Igj4sOt8rcdBYXQBH92NVPi+C6axycltf5Z+k3//OriGNHGfLW10npvOyWy+jFDHVm5cTo4jK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282246; c=relaxed/simple;
	bh=7ylP2MCGeRgKNrINpixyJIZZaltZRUZoAjvZsLoPX9I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DgNpNPp40v03Pju+uwHqVzXVBkn2Ymceje8CXkpcDeR+qrFK6TQjy8Gc9DBoYLn/qaBDXx9gq0dHRj0W/VjO3heIeABLGEzrB5MNAFZ2i85rrH7tHm8qwi7wtKxozitxd8qhYPUFj2QE4ULHlRRiQVunsMdjjdcMHoVLIm9XY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tH3AduDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C42A0C433F1;
	Tue, 12 Mar 2024 22:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282245;
	bh=7ylP2MCGeRgKNrINpixyJIZZaltZRUZoAjvZsLoPX9I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tH3AduDtDzHoG5JcpnZQypUGLyRtLvrKKQv9m4B9JVGusN9C531vaza5sMNL/p0u2
	 /4mCtHYPspn0N4bBMnd6XL7gGExsnTlNQwUjhGONnIOltTTJXdsT5hW6l9wGlSsaUI
	 zLYiaRGLzDUflYHrRC+iZI+XiHy7LFjaSGrdEHdQQnaFAsQHuFjdb1inshrG404QYs
	 s2pQ4tqMa1cbTQN8tWZ/Mz0NqIGbViI+5NSrNttBdyFrpn5W76hW0+6T5UkYZh8j8g
	 iFnOJi6HFsVzlQ1V4H5JTVHrxe+LkOiG8nBAFuMnEKmlPZpn2VYCN2z5tGsZ1Av8Up
	 1A9cFmITklpXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB343D95053;
	Tue, 12 Mar 2024 22:24:05 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity updates for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240312042053.GI1182@sol.localdomain>
References: <20240312042053.GI1182@sol.localdomain>
X-PR-Tracked-List-Id: <fsverity.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240312042053.GI1182@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 8e43fb06e10d2c811797740dd578c5099a3e6378
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d453cc5a278ddf8fd4f0a89815c5da2c6650bbea
Message-Id: <171028224569.16151.576797111404404042.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:05 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 21:20:53 -0700:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d453cc5a278ddf8fd4f0a89815c5da2c6650bbea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

