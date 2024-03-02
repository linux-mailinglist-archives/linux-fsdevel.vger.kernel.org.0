Return-Path: <linux-fsdevel+bounces-13378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196CF86F1D6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 19:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159981C212CE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 18:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3862BB12;
	Sat,  2 Mar 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYlwhA7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FEB33CFC;
	Sat,  2 Mar 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709403738; cv=none; b=Uy2zprY5U+8MguJR4KGl/L9W+bsZ5S9qFjRsxCyeJoCtMU/wD7nlm2pPYC13Jx7IUjvugaX4lQBjo0Os+uBP9EDLjXs/0xeu/OmaeBb3RYVyIUWUi1kLT8ZPm+MauRk5xGh4pUkCMpBEXJjup+yS2UMcNqFhBJRRicErv4sia7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709403738; c=relaxed/simple;
	bh=7JrmS/DZA6u/wovtmLWR4ct779cHclmnHOclp8AgMPI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ufFakSLf9kcjijCh5CPhzyc6LjwUWIXuav1IYA+TJmC3v0j+tHFCHc47x8N4YIQovMBUr+Q6eUCOM8qW0+YrHW8oLkOe8nwwJMMQg4Y33jj4KLFtU/ssAC1K+pYEdZAcqyBaYMYccTqQ+ZOuLeqgpR5GvbvFuW4vx+tB7PcsXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYlwhA7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE17FC433C7;
	Sat,  2 Mar 2024 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709403737;
	bh=7JrmS/DZA6u/wovtmLWR4ct779cHclmnHOclp8AgMPI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SYlwhA7o6bgMacHEeh57kwsGk/HtjL5yptqVxFU4xxcsOPkJQSMj7fByvs5iUtqc9
	 NfSA+w3G7CUYNLFeNPqrXAy8fks+CagI2pE4sI6h6sHutzMltpkOF4BGMEdKjZEwwj
	 PZib9MEwWnSM0qKGTiLL58PVM0dDShXtrJ4Q/jEBqGu/q6kf9TLL4f+i5xX/+vWYf3
	 F7JnahnpuzRIe/6TngnDB8Qsxw+fIeb3B6iXYC4A4W1EySYkMq5UN1fnH1xhNqcbBD
	 T5cGisLefq6/upEvIHYNraSfEkYbKK8ATJ9vPufOPAjFhdziP2EWH/WZUlxL1Uup3T
	 awhugkMSqR36Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBBB9C395F1;
	Sat,  2 Mar 2024 18:22:17 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: Code changes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <87sf184vwb.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87sf184vwb.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sf184vwb.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.8-fixes-4
X-PR-Tracked-Commit-Id: 27c86d43bcdb97d00359702713bfff6c006f0d90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4640e2be3920168f6b26512466562accb783423a
Message-Id: <170940373775.2799.4618368138305557070.pr-tracker-bot@kernel.org>
Date: Sat, 02 Mar 2024 18:22:17 +0000
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, chandanbabu@kernel.org, dan.j.williams@intel.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, ruansy.fnst@fujitsu.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 02 Mar 2024 18:27:36 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.8-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4640e2be3920168f6b26512466562accb783423a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

