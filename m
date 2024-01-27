Return-Path: <linux-fsdevel+bounces-9215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0F883EEFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 18:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA581C21407
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0652E630;
	Sat, 27 Jan 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvBxtSMi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE322DF73;
	Sat, 27 Jan 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376071; cv=none; b=ot+uS7rIKSaHrm1MNwLJ7cPTMoNadLdvRrEtb2z9ifrg2/9wEv+SpijOGmKQVuEZogPBki149dZENIM10luVJkhbg3IvmxZ7b4Qgg4DI/bMaTyDFevF+7RU2idDiiDJ7PfVUg007GIvTbYwjuS6q/n6+Ls+AuEgzQmNw8z3eB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376071; c=relaxed/simple;
	bh=mpcliEd1Xl7aJHVb91hMYA3GXu+LIZ+iAD4MYJF/uKU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zp573EiX2b8N5opsGIDHvAhK98kCXXLo7EybPHhGWjDFmOA7VpbzdpQjwA+ySJ2OmME6aiYqBLeVus3DL6Dw/7ZJr1scG6mDmHsLO5g9ijwp5S2JOzEjc/l2HvfymQRbnkpwLNhJ95R6MEGJt8i5UDylJBm3PwY19qQ6SuADL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvBxtSMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59DD7C43394;
	Sat, 27 Jan 2024 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706376071;
	bh=mpcliEd1Xl7aJHVb91hMYA3GXu+LIZ+iAD4MYJF/uKU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SvBxtSMi6YgS/mnm9ifbJJDFdOHr7svgfq87v1vibE4XgDBVQEEjH+sDmW+nz44OA
	 I3LVGzXIzc8xnmqC/kXt6WS+NHKDtX85whasAP7bCO0RYPVKisv7OPGsNuXk6iK0nF
	 1zOJ0mcOTDiv20nI2wCOMhHjkf7rkcuRTaYUF4TVUMg0pemZsuLgy3Iq+OS+oscNe7
	 YNndPwuiCz0ZOgI1kjKxmSqf4SCZNepQTGx6oXFkSDfn/yrcJa3i8fpv+9RqF6yFl3
	 pkf2bvdsG+yzG8ILYvUN3++L1OPHWYYK5920Wdswh/VGyOqjgmh4JdWSth9BNGdjsh
	 YOP28g8hpmD8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41EA4DFF760;
	Sat, 27 Jan 2024 17:21:11 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <87sf2j2f2t.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87sf2j2f2t.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sf2j2f2t.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.8-fixes-1
X-PR-Tracked-Commit-Id: d8d222e09dab84a17bb65dda4b94d01c565f5327
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd2286fc577526f0a6798f68977a95eb85fe3d52
Message-Id: <170637607126.5716.14398821845245455202.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jan 2024 17:21:11 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jan 2024 16:52:58 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.8-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd2286fc577526f0a6798f68977a95eb85fe3d52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

