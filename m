Return-Path: <linux-fsdevel+bounces-23875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8715B934326
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 22:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310741F211E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 20:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D1188CB4;
	Wed, 17 Jul 2024 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQxztYsh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765971849F0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247508; cv=none; b=UCAhexBWlNjBCclgVt3Adjym7aiqYJ2DQn/+GYdb1GuAFrJoTZ7N2Pmp773A1rDxRVauuVdKAUF+rtczfKMkmY7zqk3gOcAaI+5W9ktpRoRqzacRgXWyMECD6MsxdmWijTa7Ci99kt/yqp+/6lFn4hlxHNsoROmKEdMWKkDqfQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247508; c=relaxed/simple;
	bh=5GBnoyt0P8Hr8j3SFNoxTDvqBDprkCnvckHNSbELSdk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L7nKQdgI7V6IDT2Cs+i8AjrtJ84pH+CN/3ZTL4gvUhaRtTQkzA9VjgVhoeLtk6fKl0DbPm6HRFlj8TJnezktf2J0L0DiNPqegUOQD6iBuforDXcpZ8eRCwMKN0u6LHgObZXvGD6E6/HbPYRqd/WyZHmIg0bW6rqmIffF5j+9dx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQxztYsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C69CC4AF0C;
	Wed, 17 Jul 2024 20:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721247508;
	bh=5GBnoyt0P8Hr8j3SFNoxTDvqBDprkCnvckHNSbELSdk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HQxztYshVqtGI8a4VGO3DI6HRzaWCqs8i8QoCL42jvvXqizagdjyHQYEenDeD2ieS
	 cpTbKZxIk2K3Z3UWEErD8rYDzC2wBCUWUZua/ROuwr/dve0Hslk7Lq/GHNbXQ8fPTZ
	 BbJFoUc6vp3LS4ivJfgupUBfkMcuSjKfraAX0/Jhz9ILlCxqzPqZzeHLGm9Z7uJ9jQ
	 ImxDVoe17m8xZjvzdEFQsRNMTI7wL4P8CgbI8P67h4XmEvJl25eSRE5Yxw7VeXFe4s
	 KHL6Ph6zQFoeXE4QqBlPHvk7LmCkSmRP95iZcIEE362TIyg08hUuqROg4MRZ8WBeQD
	 1bP9F0NwrwWKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11878C4332D;
	Wed, 17 Jul 2024 20:18:28 +0000 (UTC)
Subject: Re: [GIT PULL] udf, ext2, isofs fixes and cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240717151634.yc5wzy5oel7oue6h@quack3>
References: <20240717151634.yc5wzy5oel7oue6h@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240717151634.yc5wzy5oel7oue6h@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.11-rc1
X-PR-Tracked-Commit-Id: 322a6aff03937aa1ece33b4e46c298eafaf9ac41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b0f0bb27c32ed46da0d67d056a6aacccd7c48bf
Message-Id: <172124750806.12217.5980863303636912188.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:18:28 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 17 Jul 2024 17:16:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b0f0bb27c32ed46da0d67d056a6aacccd7c48bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

