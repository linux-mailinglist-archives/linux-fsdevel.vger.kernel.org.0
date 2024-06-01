Return-Path: <linux-fsdevel+bounces-20710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53B58D7127
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 18:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39857B21684
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3593C153510;
	Sat,  1 Jun 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9SI5aRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE0D1DFF7;
	Sat,  1 Jun 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717259895; cv=none; b=C0BX8B9tylLtOuoDy5RCBRTpWXUpY5UrUknTWCZdODV9eYLlEkjKqtFvXisL6I6blVMtmvEDFzSuu3mjcUDWUeD5oKbMOkQL2zYnDXs+nYYB/lgK21aJ2yZnmiI3fCyp+KhE7O7ePpOzg6hMHDcBOXTPFWs1fQlKGla7w6QZRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717259895; c=relaxed/simple;
	bh=W8+jxO6G76MominI8zsNPO8j8xSei1yHhYUE7q4B1zQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CigmVZ8wpeF1YGjOcJG0MhrArqF9hgNDwosS2QBEXbqwb2d5bbnhDH7pd+s+iB2VwBNok15lu1RPTFNDR9/4T8tBlk8SJW1SLNSX35fdNC3rhug0zncDFXLHjDINI//lGfe4i4qFQeLUIj55aivFasoxInaJc8+/eGnkmLMbymA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9SI5aRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69CD8C3277B;
	Sat,  1 Jun 2024 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717259895;
	bh=W8+jxO6G76MominI8zsNPO8j8xSei1yHhYUE7q4B1zQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y9SI5aRpmALvIVoigKdDVL/aYfdD93rysHPPCWCmP/imV+dqEdPpsno6XChDemb/f
	 BdAZID1TMh5LGDkbCw0YgrMhN0fzhTOd+fxt4NwiH/f2T3GnO/zUyarrmEbXTAO0Gn
	 9mqDDaD2XbDFXY/p9+KnSnxf4tfzuUS9S3w5U75ikgH8SMQCuxcQZZ778652H+ly7+
	 lGDBgQNU5lBHIGOlFAU8l5Z7n78LcTsTpVKDnST7K80+lBpBJwt+I6ZR97/BozMpdw
	 Ay8Qr8cRr3OkYSxKxi7OUOjWm9HlgAjr5rKsdB/+tkRPBT7xzqbKHwy6uAfdILvOsn
	 EE94ablK3cD5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 574B8C4361B;
	Sat,  1 Jun 2024 16:38:15 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <87cyp0wypl.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87cyp0wypl.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <87cyp0wypl.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-fixes-1
X-PR-Tracked-Commit-Id: b0c6bcd58d44b1b843d1b7218db5a1efe917d27e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbeb1219eeeeab7ef302fdaedee71b08e413a04c
Message-Id: <171725989534.19745.13968001433259230259.pr-tracker-bot@kernel.org>
Date: Sat, 01 Jun 2024 16:38:15 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 01 Jun 2024 19:25:29 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbeb1219eeeeab7ef302fdaedee71b08e413a04c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

