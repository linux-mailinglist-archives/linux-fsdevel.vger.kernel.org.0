Return-Path: <linux-fsdevel+bounces-70388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20400C99582
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 23:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94343A21A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAF32FB09A;
	Mon,  1 Dec 2025 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl4wC62x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E266E286415;
	Mon,  1 Dec 2025 22:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627085; cv=none; b=XinRD12+yQi18F0NMw+dyWRqwUtG7BmMVLJEG+84+ASHRpvJ/LuhGbSSglmuqqzP2mWnbZP197kxdFq3ohjWXfUmtpEqZ5wEBnXseAtWDwHhkMINuF8SYkwBriBNbGzd1HShd2/ufQKlKm+W5MZRYyD7li6uZIDhAgAMCMZdwMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627085; c=relaxed/simple;
	bh=dFlqEdJ5U3CMULi9bTBIYrQM4vbHvb0TX+4F9NI4cIQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YgUb71gkXb0sffr8jCi6tMXHAUarY169vBklUNhuv+v6LnpB1HtjG5Km90+yJolrfQwmRqobkRsGPg0VyNaQPuCu+V4PHNHLFk2umHeqWnP/2SoHDxCCxRGu1bBkizh38I2rP6MkWEZ7+LYoQC8Xw0JNNL0DJbQ3E94e3F6HgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl4wC62x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6793C4CEF1;
	Mon,  1 Dec 2025 22:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764627084;
	bh=dFlqEdJ5U3CMULi9bTBIYrQM4vbHvb0TX+4F9NI4cIQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Cl4wC62x5XZwQsuUAsX4rzn9pthHH1rGRLnjfNVF2xsgQqTo51i8k4YwAuuIEN9Sr
	 DFeLTTpWhTtyLU27lBb7v67ZU1wd15aTuNCJJsTmEtNdgzmf46qPk91LnvOlV+TjdC
	 MRB3vKlbnJ6T4DCg/JxhkWvNsyz8ht9ESTIRQTytY68YvfWDDB1rJ7KmTe49PJX9n5
	 srEcA1Fm/rzNIaYSt38iSY+AaaeiXIDpL9TNjlzdZPGfG3LEdOjrDJF8ZWSR6EU0ZC
	 n1p/q2O3Akg6OnaA9eTa+noioLSS398wCtgRBI4ccXvzT2aijnJQ4qosiswQDPZI90
	 /YLb34hwOnbFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F28A8381196A;
	Mon,  1 Dec 2025 22:08:25 +0000 (UTC)
Subject: Re: [GIT PULL 05/17 for v6.19] namespaces
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-kernel-namespaces-v619-28629f3fc911@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-kernel-namespaces-v619-28629f3fc911@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-kernel-namespaces-v619-28629f3fc911@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/namespace-6.19-rc1
X-PR-Tracked-Commit-Id: a71e4f103aed69e7a11ea913312726bb194c76ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 415d34b92c1f921a9ff3c38f56319cbc5536f642
Message-Id: <176462690462.2567508.15700462186469010361.pr-tracker-bot@kernel.org>
Date: Mon, 01 Dec 2025 22:08:24 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:16 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/namespace-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/415d34b92c1f921a9ff3c38f56319cbc5536f642

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

