Return-Path: <linux-fsdevel+bounces-24099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54CB9394E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 22:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB0D1F21FBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 20:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300938DCC;
	Mon, 22 Jul 2024 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgDOMPp1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10D2C879;
	Mon, 22 Jul 2024 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681085; cv=none; b=KUDXWut60lC0RoyKhCQSXIHn/rN7wJ58JBsPQ6KCMdlVi9O9yrU1lHgU8dqw0Ze0yVnDtb7OaDAAzsgUkb5E+jExQ8MRygIxMLeW6xAupiGeeLs91FS2xd9aTQNAAZhlHmacy10sOUEVlrQC8bSulazGIxuMqsmwNkmPIKB9wpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681085; c=relaxed/simple;
	bh=9HziypFt7UmheTx1kExdsVxWElmmGCTeLc5pkbsTTUM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XRYEFMj31/4sDui+g1qNuquUHzSfh8cQXJz/AddfU5q7uUSeWUNrvh88t+izhmoFEPU+1JogPEoPiBY0AWLGeua4/BlsaWElrCggbZb2BiBgOJAp5NBt83YnsPeufKy1FblGf6g/2NC7ovLk5vvcbi/c1ELfDZlOGoyOcXZS/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgDOMPp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E669C116B1;
	Mon, 22 Jul 2024 20:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721681085;
	bh=9HziypFt7UmheTx1kExdsVxWElmmGCTeLc5pkbsTTUM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OgDOMPp1UCE+WgZzfTlABPTWuXowicAixlJatrDPbQiRyc1JAr11q7ku0gtme70Rn
	 5Xh32qp7KzoFicrUxCcRsR+SsIBm6LQq97Sz8itF/ZjD0sP99ZrQnw3cAx51Oq3HK5
	 Wa5oed4nfRRpfNmezNjjI0RZpU+TfSUsVScUimchE1OU5XGqMFIuSZvklHrC2KDCP/
	 UrLK24Ka0mpvHJN68oIfCibI2lecO3GYZRqbAqHLqdYfspqzkq60KeukDVeBUk35Vr
	 hybIvWPKk/3/wt5zXPnxfLi1gfq8qU0Yjg46vknnnf6FOgoIapdWG3mj79efObDAtN
	 9pSrJocgdEROA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3287AC433E9;
	Mon, 22 Jul 2024 20:44:45 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240722094014.16888-1-almaz.alexandrovich@paragon-software.com>
References: <20240722094014.16888-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <ntfs3.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240722094014.16888-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.11
X-PR-Tracked-Commit-Id: 911daf695a740d9a58daef65dabfb5f69f18190f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ea6d72489a4a937fb9e9f9e81474cdf3483196e
Message-Id: <172168108519.32529.14879953561624262800.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jul 2024 20:44:45 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jul 2024 12:40:14 +0300:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ea6d72489a4a937fb9e9f9e81474cdf3483196e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

