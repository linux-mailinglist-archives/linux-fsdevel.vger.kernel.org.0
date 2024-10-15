Return-Path: <linux-fsdevel+bounces-32030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EF699F6C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 21:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC802853D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8AF1F80CF;
	Tue, 15 Oct 2024 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBlM5F7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24071F80A0;
	Tue, 15 Oct 2024 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019402; cv=none; b=iRGf0n8+VZTn6CSdB9Q3YfELFuomlJji2CUKfFDdlu6AbJfA/mZxgbxqwKDX6oFgIsL1ifugweSjB3UH6EOPeavzvWcrAI/APslekGk/i8LyJonC0tFTRDbFtZSNc/nET8W4HxFksXJPDu3EJkrgZjY6RkNL8L+43VxP966Jc+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019402; c=relaxed/simple;
	bh=Y1BKoOUsMPJcPccv05l6GZagN+jxFoMXfh5o+m24KCo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kIYwLL0ZyyyiS5UCC6xHmPYNVeMrj9w8ous60aqjRlFhrmIYZuJla4+SIyI7Abk7w9AEgJPutJllDciNR+rbxRaSNk8wkUhT5iwQmozdJIFBoOrI1j0sHy9q2tKufuR9y6ceIXr2EissNm43MhTcSvVpm0WdD4j7UvbPF+01ASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBlM5F7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C033CC4CEC6;
	Tue, 15 Oct 2024 19:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729019401;
	bh=Y1BKoOUsMPJcPccv05l6GZagN+jxFoMXfh5o+m24KCo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KBlM5F7cEtQD9/hmNpt3V63z+37e35KuW0Tsd42jDDOB4vrddviEw5vlQxWLodfcT
	 XGOW8P3rinfjzoHs9aUumwKKNrr/2+aBWC0zynA/wHuafTIgZk307lxjIYnBO2uNB9
	 LlZBtCEtPRz1ZdsPp5A+wuEdeSaOn22Wt12b/gNrxsoDaoFc70vR07SEuXdeWmV2f8
	 sp9xVVa7S6mPZpqWnhd1cti7rdmQBL+W/7qR/ieRS+UcCo1ce1wH60n5uuLe1FTYJi
	 qooLP0ZNdb0ngg1aNj8SQJkYQxSNIcS+bLSG5H9FsUMOV9DOd/xrBSbN9t+zwD7pdf
	 mvqsC49GttTPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349CC3809A8A;
	Tue, 15 Oct 2024 19:10:08 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <lazo4f4eueknrlk5odp37fboznvfxnizhdeqttnmxkbgp7szjj@m3sjqp7mxm5d>
References: <lazo4f4eueknrlk5odp37fboznvfxnizhdeqttnmxkbgp7szjj@m3sjqp7mxm5d>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <lazo4f4eueknrlk5odp37fboznvfxnizhdeqttnmxkbgp7szjj@m3sjqp7mxm5d>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-10-14
X-PR-Tracked-Commit-Id: 5e3b72324d32629fa013f86657308f3dbc1115e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdc72765122356796aa72f6e99142cdf24254ce5
Message-Id: <172901940674.1265862.10138888849562521509.pr-tracker-bot@kernel.org>
Date: Tue, 15 Oct 2024 19:10:06 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 14 Oct 2024 21:27:51 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-10-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdc72765122356796aa72f6e99142cdf24254ce5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

