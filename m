Return-Path: <linux-fsdevel+bounces-70624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B02CCA25C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 05:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD25A3027FD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 04:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F28C3043C3;
	Thu,  4 Dec 2025 04:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inZxgAZx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A1272801;
	Thu,  4 Dec 2025 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764823846; cv=none; b=glQ8jNCNlJy44XC/tMM9hyWKKk2aSgKBTf9xqTfc4sITMhUyQGJ1EtXHsQ3ia8eKj++rcUkkN35tGwE26en847Xml9dbCoE662QzM20ntzVahmuuUZ7EbhKtyvKam0yP/IUjg334PJJtNdzs8hbj0veyWFqIoiGkg4NpCIH2ux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764823846; c=relaxed/simple;
	bh=jAOmfSNocjrRuIa3LyUttt1Wcgr6VjL9Fgfs+R/4PPU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TkUgJeM8HDiIhIVmceVz0XiY8O+HndcPqGZTMxaXcybQFW7v9bPjRpaFUePI4zy81EVyLoSDbtWMYWD13ZCKlBIxdm5qaomimAkdLT9LgKSJLFscstFGGTKla+szAiBsxAF7xqTMFkxcuFKJQTJbOVjmy95ejSbBxptTvo3MyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inZxgAZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF88C113D0;
	Thu,  4 Dec 2025 04:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764823845;
	bh=jAOmfSNocjrRuIa3LyUttt1Wcgr6VjL9Fgfs+R/4PPU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=inZxgAZxE+9UM3NN7cTD5bXqBKPRpJ4vRO1lEn0CPE2E2tj8zZDV9Xs7l+1yemGKo
	 yUB4Qa07Pc7266fPn9rnOxSawn+bogwwhQijY4pVr65vDtl22134MNvggYLKBCKbNA
	 8+CfgzuwjTfPns6vzQMhgvTv6ir3kzaxgpHMwD1iBxBh0nc5hm2X3IZknf+xbG4fHF
	 FZUSGA1PWD3lcHM3lrRoSlC3W88Fjywcakq4Xk6wm3doyQEGqJcTUyGEo1nwAIOO8m
	 GDj7yb8JX/ud9PJRULI7YAb1auDULoRsJkcSTYdE6CAkxL70O2SlWfSWOtc9y/Xa3v
	 Pdg3mgXW2nYlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B58523AA9A8A;
	Thu,  4 Dec 2025 04:47:45 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251203124228.6082-1-almaz.alexandrovich@paragon-software.com>
References: <20251203124228.6082-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251203124228.6082-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.19
X-PR-Tracked-Commit-Id: 1b2ae190ea43bebb8c73d21f076addc8a8c71849
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 559e608c46553c107dbba19dae0854af7b219400
Message-Id: <176482366442.238370.17583520005702956590.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 04:47:44 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Dec 2025 13:42:28 +0100:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/559e608c46553c107dbba19dae0854af7b219400

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

