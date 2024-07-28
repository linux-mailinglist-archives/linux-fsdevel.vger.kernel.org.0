Return-Path: <linux-fsdevel+bounces-24378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 461DF93E8EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 20:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5344B20FCF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 18:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0647441F;
	Sun, 28 Jul 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkt0akAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB866F312;
	Sun, 28 Jul 2024 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722192379; cv=none; b=sfnx+TiMu0MKOzzRXecdded8HudF39q59NLnTGPnTiK4oOvUfolzHgEtp16Kgmq4UAaOXi0xTADWDxUGT1ilydqxBKFCOGfX0ecbNj7P9BJFfG4TowdAtHsFfSmPFTw9hZvUH5pkk5siSxoGjKncGl9BA+XPwDXf2DIYzrroxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722192379; c=relaxed/simple;
	bh=jLn0ohpaDUCKQ9A5QOqN9mJQuJJqAJ1Cx7Ss6CQTA0Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o7rwU/Erb5QragN4sI6FrRJIEywE9PzN0srse2SLHyh0ofD7/SKx/nYGu8QkAObEU9waqXhqnc4OzhaebRe4BSnkmVBf1dHy0mqx+FxafOuLlBhkZ81gsDVXnOUX1WUDfVik5lXoUIXozfvcmR8kl2yYnO5KYAz4uGWiPwafrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkt0akAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD21BC4AF09;
	Sun, 28 Jul 2024 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722192378;
	bh=jLn0ohpaDUCKQ9A5QOqN9mJQuJJqAJ1Cx7Ss6CQTA0Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tkt0akAgwE7xWzKzxbuarbrNqerHWaFfiFA393Ie9gYJve/1gl45EdsvnxGpmygqk
	 /jtT5y868u0XzQWlgiTX+XDMi97fXuF5lgH+mzW7nrEioyBOPYF8Lh4ybH6OqTsE1Y
	 Hgyrdoo39/uJ9wN3/RYf5YaFFSV0HZVVgT4GbqTjLZwmHqX+GU2W8m/ZsCfhEQa3cO
	 R4zp49BczgSaA1i2sjgs0jL4aYs6T1pviFQ+qbdVLWjfiVKl5AqMp2hB9FOwF1jFwE
	 DqRnHO+TwsFIOu6LrMqbwRz7TjJ5eDWz+gh2hBeIvElj5yWuEXl70kHGSyIg4I4p15
	 E9qb433r63Xhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C560BC4332F;
	Sun, 28 Jul 2024 18:46:18 +0000 (UTC)
Subject: Re: [GIT PULL] trivial unicode patches for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <87bk2nsmn7.fsf@mailhost.krisman.be>
References: <87bk2nsmn7.fsf@mailhost.krisman.be>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bk2nsmn7.fsf@mailhost.krisman.be>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-next-6.11
X-PR-Tracked-Commit-Id: 68318904a7758e11f16fa9d202a6df60f896e71a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b5d48188942178985cc185a17c754539cb9a4d3
Message-Id: <172219237880.25784.12078662852014411828.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jul 2024 18:46:18 +0000
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Jeff Johnson <quic_jjohnson@quicinc.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Jul 2024 19:40:12 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-next-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b5d48188942178985cc185a17c754539cb9a4d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

