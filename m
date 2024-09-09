Return-Path: <linux-fsdevel+bounces-28959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4192F97204E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 19:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED86A1F23A2F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B667A170A1B;
	Mon,  9 Sep 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBLJTSv4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D50F282E2;
	Mon,  9 Sep 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902447; cv=none; b=ttCJZH8gdImoYG3QGeYbiRd9+doJRjcAC55dfeEc0ZlNzLyzYLklMCvDeoBZHWpAlzzy5CXxPZrkxm3EyQhkiZZF5e0aNUx/qU2etOBHOJu+Ji0dD9458ldjs6lvUeJPab7fqGd+3b9HedU1n4LOnd34DH0NctP0n+8JBtDdGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902447; c=relaxed/simple;
	bh=rBdBjn0XNlpSEcc4ZAMVvdALnrEyMDqllQKDkkADKBw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MgM/3+mq6hR1zT0Iyd4x9d8yiH9GVvy0ntNZNhMegHrPtnfBKe9S9AmltWrGa30tJe8amHPMAC0bIPzrhKIsJ+l62YLdbOxdW3DSEfFab4BhXFkLiQXm9idwPtZlOgEYToYYgF16OPRlU9t0L9lMrS3NbV0jzGVaEeS7UGamHAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBLJTSv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F286DC4CEC5;
	Mon,  9 Sep 2024 17:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725902447;
	bh=rBdBjn0XNlpSEcc4ZAMVvdALnrEyMDqllQKDkkADKBw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OBLJTSv4gNLFub4vNmRSbWeamu9M3t8ugYKeFzEeUbZN0xFWU555U3aGUIHl3xFWs
	 ktuVAuahwy9wxYZlzNFZ/bP2p73OXvSVabtu86Tg3qRbv4i9hE+xo2ry+D3dGxFTbx
	 s428mX2gblcXBnj0p4YtdMgMJaiSJegLaURYqYF1n5ibfTgt3gpnyvz2dJSigqxx5N
	 OOy+Mbi0zy2cDzMwgnZ8guVdjM1Bms9Nw4eizG86tm+I3FztNMIFlrZwXOkXi0UWc+
	 BN9pmHs5YWlDAsUDAEm37d6nBYVHCaGRuUs59O78QXSv5flLA3pQbn2qXUrJmLmq0B
	 pBmsXQpVrzG2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3424E3806654;
	Mon,  9 Sep 2024 17:20:49 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc8/final
From: pr-tracker-bot@kernel.org
In-Reply-To: <uyzlav7jahhammvvx2eymn4thh5vvpo3ngu7tdmkmyygdwim6c@3b7dyx3tbqyo>
References: <uyzlav7jahhammvvx2eymn4thh5vvpo3ngu7tdmkmyygdwim6c@3b7dyx3tbqyo>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <uyzlav7jahhammvvx2eymn4thh5vvpo3ngu7tdmkmyygdwim6c@3b7dyx3tbqyo>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-09-09
X-PR-Tracked-Commit-Id: 16005147cca41a0f67b5def2a4656286f8c0db4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc83b4d1f08695e85e85d36f7b803da58010161d
Message-Id: <172590244775.3867163.120052155906121188.pr-tracker-bot@kernel.org>
Date: Mon, 09 Sep 2024 17:20:47 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 9 Sep 2024 09:52:26 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-09-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc83b4d1f08695e85e85d36f7b803da58010161d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

