Return-Path: <linux-fsdevel+bounces-48524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B370AB0571
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 23:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54E6E7B267C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 21:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93222423D;
	Thu,  8 May 2025 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amp97yM9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC622331E;
	Thu,  8 May 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746740465; cv=none; b=KOCItBetW1eGB48lC5fXlA1mxDRARkutD8zqWy47ch9eEDpRDfTMSscPKS3ZBxxmf61EeZY4lKaGZr57Xg3Puag58uvqpPD/BinKRNf+kQu5Re9gxpcwTHf9Cd4aH/O/uueluUeho4CysWMSQdQrGIUoS+RY8HWRFIeIZbWYfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746740465; c=relaxed/simple;
	bh=eWLDivHb/Zs+9pB7oUXg8LbBxLoPvxtOqcSg0bj0akQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LDVKZcNHv1F5OemIIwJ7/z6geZCFoalx2czGMmVaPnjSW/2XSzukoEgIzME8rWu7Cu5cnnqN94qY5SSXK970Vo/Uk0wKTRKLEj//Oa06xEyjGbqU/3gPO2fIKwMyxE5sE95QKWy1zajmUV+RAxMEvqEr6QnCU3hgJP8crSfnq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amp97yM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3C2C4CEE7;
	Thu,  8 May 2025 21:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746740464;
	bh=eWLDivHb/Zs+9pB7oUXg8LbBxLoPvxtOqcSg0bj0akQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Amp97yM98EcKIJtug5LfW9weVRAZBgbS7ff8v6KVUVAypNuQhxEWbbz9spIGM24iI
	 4WKpcR02nsis0Ls2i3ZUN7JnHEqJoKuXyAlgL2TuG/dCuOrCQLOcMOZ9mTccShU9nA
	 iirYXv9JKPy+SmXlhXK9wEPVgWHdBlYgX30nBREwTyso5dCdcIPkL/oA7jGcGF27zY
	 KCbEVTulxKkHsYWlCgFsImUJUTfNGHSgWQeBveSUH4PifUs0MSkYFXkgg9mnDvPVqO
	 g/zws+2MR8jXhmdOi8httkWFgF9gHMQFRj62JoSi1Ibaf13PK3/HhHODcAROlWbNC6
	 3aLG4ApShPOeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE95380AA70;
	Thu,  8 May 2025 21:41:44 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdixxswan4bhmajjvnczxa2nxh5tm52itlttopnuk3w6lzv3ms@inq7k7aws2rg>
References: <pdixxswan4bhmajjvnczxa2nxh5tm52itlttopnuk3w6lzv3ms@inq7k7aws2rg>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdixxswan4bhmajjvnczxa2nxh5tm52itlttopnuk3w6lzv3ms@inq7k7aws2rg>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-08
X-PR-Tracked-Commit-Id: 8e4d28036c293241b312b1fceafb32b994f80fcc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c69f88849045499e8ad114e5e13dbb3c85f4443
Message-Id: <174674050327.3050618.15775685558013664884.pr-tracker-bot@kernel.org>
Date: Thu, 08 May 2025 21:41:43 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 8 May 2025 15:58:00 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c69f88849045499e8ad114e5e13dbb3c85f4443

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

