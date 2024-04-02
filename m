Return-Path: <linux-fsdevel+bounces-15918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C7C895D40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D4328B020
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9550615CD53;
	Tue,  2 Apr 2024 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D24TCWwZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53915CD4D;
	Tue,  2 Apr 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088373; cv=none; b=sC0K/+SGUAr23wUOc5C91edlaaeIymTAdrtwzcckKBYcZVUGePqf1Es8CbiyNbAUefU8HT5PjHEf5yzvoGmJJrVI+cK4DLIVdJasWEwKuBR2Lw9Ce7SfoEPJI5lrcilDEWWW3GyF7Uc+3yg+Veet5ZRrPCHIjNE2FfZVg5jycIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088373; c=relaxed/simple;
	bh=AH+u9yD1jlJSCwTFHBY22iNrtcc4kJBqM95CmEZNxsY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZArPl5d6uc1hoEiF1pU5Ifb/mAQayjcjaw8homZpgXIZw6phLtS33pbCN5ZQ3BxvSEWHv+WiuqRGVIWsyTmLkFBf8ncMcuzJNh7mc9iip7viYyEByz0hKjF70+uC2d8v9KnsPaJ91SNuclhqsy7+K4bT93EoGvxpINp8p2vVdcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D24TCWwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7039DC433F1;
	Tue,  2 Apr 2024 20:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712088373;
	bh=AH+u9yD1jlJSCwTFHBY22iNrtcc4kJBqM95CmEZNxsY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D24TCWwZ/VlQFqz/RYnybaursMP7ag22EyiqOi86ORsMsFef9dky7Q88YULfXo1nV
	 TksziVXp2dSh2cCJ6cuGDdLBPPLFVDUArwbaAEUXDCiJNTaVQTb7EkLEZwrsJDMWxY
	 ADOJ6kH0QG8imlKt1fetCm+6EafCB5AnrRpmZRL+QH8/6uVE0dkloe2Rpruor+rFSK
	 eAH/XSq5BO/KooRUahuU5fv20PSqaQ3uJHpShSaOe6SOnlwqzlZ1sljcr0o8ojOYTx
	 2tkAEe12ikZY5o8qJGntrmIkiTQof15Rs5ozyLntFH1SsXkM12GZFJpPb9CvgOxfi/
	 QBLIajJNnIZ3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66653D9A155;
	Tue,  2 Apr 2024 20:06:13 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <wwkqc7ugdewzde6gdej5bi6kb3bsvoqzqkexxejcl64d5r3pow@46qmmqq5wx4y>
References: <wwkqc7ugdewzde6gdej5bi6kb3bsvoqzqkexxejcl64d5r3pow@46qmmqq5wx4y>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <wwkqc7ugdewzde6gdej5bi6kb3bsvoqzqkexxejcl64d5r3pow@46qmmqq5wx4y>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-01
X-PR-Tracked-Commit-Id: b3c7fd35c03c17a950737fb56a06b730a7962d28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67199a47ddb9e265d1a83bb23bb06c752ffa1f4b
Message-Id: <171208837341.25987.15931523598662864079.pr-tracker-bot@kernel.org>
Date: Tue, 02 Apr 2024 20:06:13 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 1 Apr 2024 18:14:33 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67199a47ddb9e265d1a83bb23bb06c752ffa1f4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

