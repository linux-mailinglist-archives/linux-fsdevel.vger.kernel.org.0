Return-Path: <linux-fsdevel+bounces-42183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65898A3E1E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 18:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62D73A3B2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 17:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE8A212B02;
	Thu, 20 Feb 2025 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEG9Pfus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E9D13BACC;
	Thu, 20 Feb 2025 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071002; cv=none; b=eZJbiUIk0Ysv0cDvJ0ZmGv9NEG35cjjOBtRU5kIBguhlEFPqL54eFB5u6XFh6BcxV0cjeVOOd8amdTcRCiGVkZOtJKUAbt97g8vm4CuczmLMbA0WQmnDejGkd67e+TgJ3PK3tNf6e6rTEtxAmIKPDRWIZHwbpQM5ZemdlyXxyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071002; c=relaxed/simple;
	bh=/kJdVtmKgt2YP83yBKD6PS7pu4rJBcdNXhTio+K2Sic=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ajV+acq2URPE0zqLEc2sxz1jURz5ji3qKGX3wX7A8J7mf0UaGegI+DwGR8NzuqXcrp8eYuMWnU+8JFQwxTsaoayQhgy2xvZHwS4UWNhgSr3Od36n4X7XVV9Hvg4Yrhk4erwJ47tSVY41Q80QxPJMo4PDM6FFJw2l1uKXRqFArb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEG9Pfus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE6EC4CED1;
	Thu, 20 Feb 2025 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740071002;
	bh=/kJdVtmKgt2YP83yBKD6PS7pu4rJBcdNXhTio+K2Sic=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UEG9PfusBqvAP0LesZMTNpvUspo6H++WBHGPe2iQLPbNZogKqVxx4wS2PiT6SHXtT
	 XSTBWFbNeejKhea+8XyZv/ud9UNNmheL511IIlDsAg8O1exuKIMtiLQSKtmEwjlI7V
	 cNz5zlYOTtfXUhX8exJfAEk/Vcy3iceYpj9iM14Cz2PAv6zAqeiUngS1/ol/8ANdPH
	 ktBGw37mm1yNmxHEHooVDUXaAzf6tLwdfh2zEoK2NrvkpQerprpNfPATKYbOvFXZuN
	 mSRMLZeGRQWCS66650bJiXyIp2e/yTE90hxTzJJqqU2eIcCAmmBLak1MxUIsgwqsnJ
	 1odjzNXnaXTcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34040380CEE2;
	Thu, 20 Feb 2025 17:03:54 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <jq44ty6ueeadfnlwsfihsvzzfxv64buipdncrb65q4lgaflezn@at52sul5ngay>
References: <jq44ty6ueeadfnlwsfihsvzzfxv64buipdncrb65q4lgaflezn@at52sul5ngay>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <jq44ty6ueeadfnlwsfihsvzzfxv64buipdncrb65q4lgaflezn@at52sul5ngay>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-20
X-PR-Tracked-Commit-Id: b04974f759ac7574d8556deb7c602a8d01a0dcc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf0e5ed0082ef0dbaa43c0296b045d6d9832082e
Message-Id: <174007103282.1392144.891991931221065307.pr-tracker-bot@kernel.org>
Date: Thu, 20 Feb 2025 17:03:52 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Feb 2025 10:02:43 -0500:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf0e5ed0082ef0dbaa43c0296b045d6d9832082e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

