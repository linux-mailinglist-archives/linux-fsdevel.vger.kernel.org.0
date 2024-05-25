Return-Path: <linux-fsdevel+bounces-20159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12C98CF170
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 23:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 458B4B20E6C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2039A129A7F;
	Sat, 25 May 2024 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvHtLOwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B686657;
	Sat, 25 May 2024 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716672726; cv=none; b=SgdF3bz6Iz0pazfn1B1H8bjjM7N1jEy4WVYTqACCFRfEia3Yyi9IiFG1s8Im+5W0WMlf1wlTxlmSbljfmVpHf/CKdaHjhMsSuyPRKs18P+qwbf/jqyVujIn6DyWelcp+r7Ap2k7X/J2MsNs2KnZQnsP2mizft5lKLcXWyCdph8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716672726; c=relaxed/simple;
	bh=0YoIU2CxkYXQGHWJ2ObuRPffBkj65jdiZiN/ruhkRg8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GkVa9n3YJGkkThzuUb2RPxXHBJrkYuYIKQV1jBX0srdYaaPteSq0KCEmWLh8pFAd/1JMPxMc9apPrhUM4lwnlX/pBwECPD2meNQEV+n2beYZX87hMbWVjIhQUy/wDqCnYQisOtccoUiu9v/ZDJv8glJmOg7OV1zgIndsBKeBrNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvHtLOwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16BB7C2BD11;
	Sat, 25 May 2024 21:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716672726;
	bh=0YoIU2CxkYXQGHWJ2ObuRPffBkj65jdiZiN/ruhkRg8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WvHtLOwEPpy6uSpFJ7vZKk4bYZsrvAPw5CuSQUdfMoMsppsOwRSn5U6QgM1SR1YU7
	 2SH0os28PRqX1xUt0GM1zdtTWDzMcsHKCEgUvMfogF/otlByzb7yZxgx+S9AFx9lLy
	 0bKMayd0oTe1NYMXCa585x9miusjkevK7bpu1rB7s/cg6vBMHG846lvupeuUflT/Or
	 u0LIX9+6SPpog+Wa7YGXvHJk6sU1FoCn+fd8Lez8B7DL8DsubuIr2jT6tHCyoGTHE0
	 95Q6vjzOa6rejz5kz/2d5KIr782krm5ATq8iwI2j36oHxJoS8PJhQivgCfCvIt66BA
	 pQCYqwtJO2ObA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1051BC43333;
	Sat, 25 May 2024 21:32:06 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240525070323.6106-1-almaz.alexandrovich@paragon-software.com>
References: <20240525070323.6106-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <ntfs3.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240525070323.6106-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.10
X-PR-Tracked-Commit-Id: 302e9dca8428979c9c99f2dbb44dc1783f5011c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89b61ca478dcb66625fb36f3b47ef4e0eae2e461
Message-Id: <171667272605.25058.17510278012662418052.pr-tracker-bot@kernel.org>
Date: Sat, 25 May 2024 21:32:06 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 25 May 2024 10:03:23 +0300:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89b61ca478dcb66625fb36f3b47ef4e0eae2e461

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

