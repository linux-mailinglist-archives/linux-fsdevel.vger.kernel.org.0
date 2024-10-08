Return-Path: <linux-fsdevel+bounces-31361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A1C995698
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 20:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50C31C225C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 18:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C61213ECE;
	Tue,  8 Oct 2024 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETyZQm4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F76213EC4;
	Tue,  8 Oct 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412373; cv=none; b=ZktDaJo8UexHAIl+SU9zpoKgrUR/6UEMu8JNj6qbuJi0UImHoiue3b0Do6DvUQEmSjqdstPHgykyXDSX/gCRVaTi2NXfvNu/DlgubNnvgVyPcAMJn8+3pj0aHehv359mXRqHN3QK4BKmJDLOvnVLVEt0WdFSkuY/cQJ1wN3qrGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412373; c=relaxed/simple;
	bh=Hjb1+BeAE9xuDkPbt0cC3SuHpN9twhafpNuaPpdLT24=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IjD8aKcEkTrNl2bsGG32AcJZZe5K1oE1uh+YU2TZkDqWFyJpX//QywheXRQYF7gEGDCVFd/rCPC9enjzBiJvDNZtVzkNlRDgmJAA+8QaRgleQc5lSbSCWJIpxZ8BJvZuHg8Q8zMwRNXL8M/ypvljVU5eg6o9g9e0zi7MkMtlqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETyZQm4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC169C4CEC7;
	Tue,  8 Oct 2024 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728412372;
	bh=Hjb1+BeAE9xuDkPbt0cC3SuHpN9twhafpNuaPpdLT24=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ETyZQm4dCtt3qrmiFTK4cP1fvsk4v+gHXSq0y5nmIQwjJ0wNNvXx+2YsZAzJrDosr
	 a3Y4Ad+NULms9qd2RV0IKXs7GRP7z9Qg3Rz/N4pIRx+ZF0XUju5X0m4YJ0CvCmvG3a
	 FRDXowbx48LN08fu0x5CIPfc+4nrnEhDm26p4Ka17i42U0CXH4rA+szpFciduhzjcb
	 LeNdRo8iZVAkMfiJ8gSb8ScYtuG+hol1VrFWugoY/6B2ziZXpq7OmhrLCLzVvrRa2I
	 2F/WNBG9WhfToVu4KkWmQxjhYEXDKO5n/TXnVMgibHlzK25U8FJIAOfMb9rwTAlLoc
	 AMmPIm62F27Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D183810938;
	Tue,  8 Oct 2024 18:32:58 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241008150247.6972-1-almaz.alexandrovich@paragon-software.com>
References: <20241008150247.6972-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241008150247.6972-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.12
X-PR-Tracked-Commit-Id: 48dbc127836a6f311414bc03eae386023d05ed30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b7c893ed5ed0fc1cbe28c0e3296a6fb45698486
Message-Id: <172841237676.640621.11629920171530544260.pr-tracker-bot@kernel.org>
Date: Tue, 08 Oct 2024 18:32:56 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 8 Oct 2024 18:02:47 +0300:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b7c893ed5ed0fc1cbe28c0e3296a6fb45698486

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

