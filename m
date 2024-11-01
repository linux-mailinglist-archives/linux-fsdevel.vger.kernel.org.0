Return-Path: <linux-fsdevel+bounces-33491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F0D9B96C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 18:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0151F23956
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D9E1CDFDC;
	Fri,  1 Nov 2024 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npME5ecB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36F1CBE9B;
	Fri,  1 Nov 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483295; cv=none; b=hUyESd9c57aArpMYAmM09I2XSJfBmLFwXGMkNfhxxNJEE/5Xok5zSgvUU9XrHlD4CdT620j0YHFJl1vv5+t8sJ3JJR+jw1G7kxgcvDg8Qd59WtNo9dt/+3mlAJ1cNxDvvM5p+VUhAuyFKq3sVMiQt8v02TbR6IoLn+44+UvAVnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483295; c=relaxed/simple;
	bh=gaAAPZh4mAxn5ZKspDg4rTSfplE/yuBtWI88IbJy5/0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B0ocJJJRG22wLzmmQ5Vggz7lUBEBoCE3Ed4J/hcMJvgLHmXaAZeUU0Dq1I4le5Tf8sAsmC8s72CKgR9GQ9HfTNSFJaVKyWZ4g5FQGN8NSfs3wwsHJhjJgKaQ7aIiYnttkgSt0L41kw06df+99h50rm/PdZ3PtBPKdQCUd2wQbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npME5ecB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB7CC4CECD;
	Fri,  1 Nov 2024 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730483295;
	bh=gaAAPZh4mAxn5ZKspDg4rTSfplE/yuBtWI88IbJy5/0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=npME5ecBcLxHnFUK15rroQLDHGIuhGdVz59cB5UQ4MZ7UmuJJvaRqqCqOAPcl2AtZ
	 9ca4EIeMvh5cvieZAqMWeyaoN1B7GO5TaNg5AXRO7ikErasnDsqbhSno+O5v5/lQiD
	 dWMbjh+1d+xXI+vPK8Bqbu4vv6CmBF0Gl5Doxnw/oKs0zitsrpLAZ4HBDia09cK+2X
	 u5/2fijwABYxM6W3AuGBS4mdUohw+P+gTBCoNUDnjwqlYIMnKdZo1J1uTX7Opb088X
	 kmIowOxpepWEo7yoWN5a0UxaUkxg+/eUcvfFxA3l1pMCkgNgwBI4no4CBgrvgw0rFh
	 2/lxy5ypvy/Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714B53AB8975;
	Fri,  1 Nov 2024 17:48:24 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <crtbzb56yioclpibocd7whnjit43dub4hoeycxd5fzvzsnqnou@i22opfzxvitj>
References: <crtbzb56yioclpibocd7whnjit43dub4hoeycxd5fzvzsnqnou@i22opfzxvitj>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <crtbzb56yioclpibocd7whnjit43dub4hoeycxd5fzvzsnqnou@i22opfzxvitj>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-10-31
X-PR-Tracked-Commit-Id: 3726a1970bd72419aa7a54f574635f855b98d67a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b83601da470cfdb0a66eb9335fb6ec34d3dd876
Message-Id: <173048330305.2762608.151251818926231058.pr-tracker-bot@kernel.org>
Date: Fri, 01 Nov 2024 17:48:23 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Nov 2024 00:09:15 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-10-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b83601da470cfdb0a66eb9335fb6ec34d3dd876

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

