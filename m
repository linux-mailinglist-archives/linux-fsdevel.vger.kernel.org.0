Return-Path: <linux-fsdevel+bounces-45166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F6BA73F82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 21:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710EC3BF33E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 20:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6271F1D934D;
	Thu, 27 Mar 2025 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZizUhPCU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93671D7E52;
	Thu, 27 Mar 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743108495; cv=none; b=P+UPotqWZPHoCGYFd2rhKKq74BQCa8IYaRo6Op7U0OG1ZQeD1VCcei9Xatc01qj8faVdSuRBeEao4Duej0SsUdoP9KWxas1VI9uO+LB6ZYDJqP4UzSTHy6MKHMm9TEP4bO1BNWKdf+nOLUAQqAg06EGcylvpDuwGJImQwxU8JYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743108495; c=relaxed/simple;
	bh=SdPbA0aHeBLqE7nZx4Bu1kmxgHP5+VLI0VP6d+QffGg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UdpmgRz66YKFWePi9fSDAJO1eZttQ4hUrMBYINTGPNx+NH8/qlXzvs3MteppB33nuVCP6bz9pmbwr14j/tRZjUyNMxAXCkBert1lljj7mNPGkqsPLF/4sEZlwgRByskTh/AfTKqWeQK4YMhbNLMBiXQJnpXyvYXpFDugDdQGdTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZizUhPCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92703C4CEDD;
	Thu, 27 Mar 2025 20:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743108495;
	bh=SdPbA0aHeBLqE7nZx4Bu1kmxgHP5+VLI0VP6d+QffGg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZizUhPCUAiblDjVSUe1cDhQr3cvefNf/hqa0qkC7PmGhGRZP5wFB0WoiDBzlLsqM2
	 v+s8vZ3y9Yx7LNFgA5d2I6HIg96kbWFCa2WZt9Vs+Ff2Mavv5JIUNFAOB4069FrLL9
	 Tu7CbE/99qCAJyB4r+/SQYZW0J5Z4v3cXumqNaFOTTQuNCJTWz8kz5OqsVHF3opx9q
	 HZir1cagp+bXXGbv7LAYwRwdtCbySFl7PQFs6XlH12c149xG2wjHy5B0hlRogl7ShH
	 DTfmhWSkQFaAv51e9YgnRzMKIPALPxaniQsDrBMt1DHsEU5AFlDW5wtlJmOOEH1XkM
	 T26EVoa5msDSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D72380AAFD;
	Thu, 27 Mar 2025 20:48:53 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs for 6.15, v2...
From: pr-tracker-bot@kernel.org
In-Reply-To: <wg47lanrvfqkqdospive4b3ymc5snuhqdygcle33q3cxudw3xl@rkllblbmre4v>
References: <wg47lanrvfqkqdospive4b3ymc5snuhqdygcle33q3cxudw3xl@rkllblbmre4v>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <wg47lanrvfqkqdospive4b3ymc5snuhqdygcle33q3cxudw3xl@rkllblbmre4v>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-24
X-PR-Tracked-Commit-Id: d8bdc8daac1d1b0a4efb1ecc69bef4eb4fc5e050
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a4b30ea80d8cb5e8c4c62bb86201f4ea0d9b030
Message-Id: <174310853165.2212788.13300034262823916193.pr-tracker-bot@kernel.org>
Date: Thu, 27 Mar 2025 20:48:51 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 14:56:15 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a4b30ea80d8cb5e8c4c62bb86201f4ea0d9b030

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

