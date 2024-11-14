Return-Path: <linux-fsdevel+bounces-34837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE99C91DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 19:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D701F22CB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1701A265B;
	Thu, 14 Nov 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgcI5dIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84073198A0E;
	Thu, 14 Nov 2024 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610233; cv=none; b=WB53nGdNliOi1fdRQIebFMMiBQuHjzsVeqHpwmQMMK504bCm4vAZPVNdQHS/N68qvl7y0ztqLgEndsbo/tQRo5yizbnY716SRPuEIBDkytw2XFz6KAi8cL5nKSA2V7XBpLJYK8/SpfT9BURj6qJMZQ86zg/MkqTq4tMjd4L81tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610233; c=relaxed/simple;
	bh=De6NWvbYYh2aVdxyBbbztlJfm6oOauZ/AiLxm4N4w4o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ull3rhYZcWSi5UFStZ/PJMSlDNGaAXN/YBFsd7bLhwmVGDBShqIeFk+RcdTjh4ajTMlWBC+SCl2NdaCnpgJ0e4ez6qIvf8r5XaoSkCW3FDj5zae8W8ngAHh/zpUjcb2aVEeTjKVsMiBvOxuLbgTQcqPPcBkI+d3sv1Tccflwo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgcI5dIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F62C4CECF;
	Thu, 14 Nov 2024 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731610233;
	bh=De6NWvbYYh2aVdxyBbbztlJfm6oOauZ/AiLxm4N4w4o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YgcI5dIKs5orAAJJZRL6tOy2CSxWUJu+b2kAWz+L/Q+9IM7eIk0UViSmCdmzZVKIQ
	 heVm1IW1mEJKfMhTPiqq4E5c1uPxlhtTyXfloMTrnDr7XILTGFyp/bzpFQX55HZG79
	 OPwAaan7ljhpAkz1Y0jM+kYgqdGHkzeVRkDP2OMmAT2pgZyzB4lJNjojxYJphLwiaH
	 JzvbsMRiPDvupR6L9L+O+/0o0iMaHsvRpo4eT35JUex3r1uQ8uoluV5wvbYMO3HRm7
	 9NXqgn96Zqh4u/mCoeqqlOmRZjs33urLbB2rx+eEy5clr9AmGw2Osh8JYWvc32LvlK
	 8HeY88xwJLRBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D773809A80;
	Thu, 14 Nov 2024 18:50:45 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <seaiutwvlv35bllqy55ajospsaiynelevpcmov7kax4txomo3c@uam4pyhzmzuu>
References: <seaiutwvlv35bllqy55ajospsaiynelevpcmov7kax4txomo3c@uam4pyhzmzuu>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <seaiutwvlv35bllqy55ajospsaiynelevpcmov7kax4txomo3c@uam4pyhzmzuu>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-11-13
X-PR-Tracked-Commit-Id: 840c2fbcc5cd33ba8fab180f09da0bb7f354ea71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4abcd80f23357808b0444d261ed08e5a77dbaa9a
Message-Id: <173161024385.2023216.10579906850437101110.pr-tracker-bot@kernel.org>
Date: Thu, 14 Nov 2024 18:50:43 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Nov 2024 22:52:13 -0500:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-11-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4abcd80f23357808b0444d261ed08e5a77dbaa9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

