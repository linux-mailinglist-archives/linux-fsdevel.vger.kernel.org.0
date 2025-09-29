Return-Path: <linux-fsdevel+bounces-63045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA96DBAA759
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 21:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0331C67EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AEB25A35F;
	Mon, 29 Sep 2025 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWlqgrFR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90125782D;
	Mon, 29 Sep 2025 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174272; cv=none; b=e4j/UWPZngFZIXUgoQvnanJ58Av591mx4nTC/tOKozP4f1yGpSq1wRU2zl5fZ+vyi8hwd2bQLDPePStcGrCoXHko40eHvdFiq5FPGLCGYK3KL6Zmp8tiHsnC5nfZn+kkKUk+DjH9jPubiGK20DwzUkk7eJMdRyv9RAGs9EAUKqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174272; c=relaxed/simple;
	bh=gX9WgR36khgNJhCG4LmiIzz+6Wq8xAOQXO3tztw27I8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q86AKNjTfSsJLgrnu1TNgqTEW0nkifOqN1q6H3U9LQc7x+GmEjeN4fRXHsx9UEjm3Sh1smgJummX2HO0lx7vWb5SYd+jtjHLySDbK7MTHQkqw718cbTbeul9heJANbLeUk+qERm8a4OTAqa+3337CMUPG31QI6tjgj4UAAjloDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWlqgrFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602F8C4CEF4;
	Mon, 29 Sep 2025 19:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759174272;
	bh=gX9WgR36khgNJhCG4LmiIzz+6Wq8xAOQXO3tztw27I8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qWlqgrFRurnEmYmLwMyiKLXaneBWlFKr9rQ0tBNTzqu0mEqxTXbH5lKUo5NDCfH8L
	 JkdPn2r/FmqQvCb3kNfOSZ3UiV12wXkmAu/HkYbRokOkdu7Dxui7T07AnFVCH1vW13
	 qlTegkM9nUDxFN/PoukEBKHVPt99GU69WRjxqWM32MUCkRf1MmYgPZZPlfR4vCYZ0z
	 URV1G2aZ+ZloJo9rPZLAuSGowwp36cN18tMqeTzmITLoaOoO2atAmrWq1hN1lOW11R
	 9SQnQPD7+RHV1S+ox3sVPpVYVAPdrl3eSi85XD9WjiX9O/itFCFxyo3Bik+vglPJPO
	 PpW4uSUQgTtdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CA239D0C1A;
	Mon, 29 Sep 2025 19:31:07 +0000 (UTC)
Subject: Re: [GIT PULL 01/12 for v6.18] misc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926-vfs-misc-fdd0c7318e6a@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner> <20250926-vfs-misc-fdd0c7318e6a@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926-vfs-misc-fdd0c7318e6a@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.misc
X-PR-Tracked-Commit-Id: 28986dd7e38fb5ba2f180f9eb3ff330798719369
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7ce6fa90fd9554482847b19756a06232c1dc78c
Message-Id: <175917426580.1690083.8534590499453643654.pr-tracker-bot@kernel.org>
Date: Mon, 29 Sep 2025 19:31:05 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:18:55 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7ce6fa90fd9554482847b19756a06232c1dc78c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

