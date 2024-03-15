Return-Path: <linux-fsdevel+bounces-14514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFFE87D2A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE3E1C21125
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F4C548E5;
	Fri, 15 Mar 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH3BhFk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558B482D7;
	Fri, 15 Mar 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523218; cv=none; b=TajJZWVI3oWHjhLPnuzsoJ0Opr2GZoxWY2B7zI2TOa8+CxzTkNHSki6wwxz4W07QilesQPX8ufS+1B3nRSuZTO/3NVWhl7cppK1bzFpj8A5QETC03qiSVZ4OffHWFdJ2/tZGj2+QooZ7RS/r3FKYvvwP7ETSitddcqXr94YPPFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523218; c=relaxed/simple;
	bh=sADi7pZsp3HAiF6g3cFS3ZdeizzbbwQxdsOUsyIkAEA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EpHUF/SOp70LW4e3f/lSpFrBtyweuz5iuSQuEFAyYZAm/y72GMvGOkn1COQdexSbqLcM8r0QQI5fXEgPs/SyiVnz0SRM2af7To8i53NWOkpM104c6hq45Js/DH6YKgiWrsmoT/978l0L+iKUN42GRSJfFCJRMhkhcZ0aEEMn8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH3BhFk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD19CC433C7;
	Fri, 15 Mar 2024 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710523217;
	bh=sADi7pZsp3HAiF6g3cFS3ZdeizzbbwQxdsOUsyIkAEA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CH3BhFk8XIkJmaJWLt7jUvePg0Slwv9SBLzgOp/RptaMLz2c6s1ZSizoymU+liPae
	 vVaKvBO713IMavFYFJ6Zg4SE6o/cNKENHg70rHztmFwMebvq4Jym4WYDmbNSPHW/el
	 3gIrSg0K214cP7+GqdQoO9DqzHWWnkOHf12fHLktUCFjIe5EaYYoFLkfKwzz8qrCQw
	 m/LDFZi3IfBnwtZiv0anSMgOpkpRaTHvCTE1LUJpt6sQqaCqywk3CSjDpxnBT1XCDJ
	 mZaQPnR4mjYlg+vjE5OOxR+KXwGaZU8HrBlmNddgrkFB2ElCnB7MGQrNQMNcAyfVjT
	 QBcAtZX6ybylA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CEE1CD84BA8;
	Fri, 15 Mar 2024 17:20:17 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs 6.9 updates v2
From: pr-tracker-bot@kernel.org
In-Reply-To: <b2cm5vuqgiel2gwdzaxvs7hfjnvio3lu6zcu24wwmzt3xsofow@6zdd466oh7jj>
References: <b2cm5vuqgiel2gwdzaxvs7hfjnvio3lu6zcu24wwmzt3xsofow@6zdd466oh7jj>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b2cm5vuqgiel2gwdzaxvs7hfjnvio3lu6zcu24wwmzt3xsofow@6zdd466oh7jj>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-03-13
X-PR-Tracked-Commit-Id: be28368b2ccb328b207c9f66c35bb088d91e6a03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32a50540c3d26341698505998dfca5b0e8fb4fd4
Message-Id: <171052321784.31681.13791255712293785122.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 17:20:17 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 23:37:15 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-03-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32a50540c3d26341698505998dfca5b0e8fb4fd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

