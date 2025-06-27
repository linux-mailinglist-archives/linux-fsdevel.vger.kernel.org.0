Return-Path: <linux-fsdevel+bounces-53131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B8AEAD56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 05:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E14356299E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 03:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EBC1A257D;
	Fri, 27 Jun 2025 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7Bxk6Uo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622381A08A4;
	Fri, 27 Jun 2025 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995163; cv=none; b=r078zet2fR1IMwjrsFOse99cVc1tQyfA2V7WsUlSdXH6MWvCPWLZ3bJAyrafxRHwh/cIdXaMOZHE6H5qnqbS9j6EX+4TE9DHEsDN2KV8bf4uiNnmUVSrGrzfoPZk0aOXC00PS4KYkhEHZ6DrO12VPnF1QNd5zSk8NSUiGx0mO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995163; c=relaxed/simple;
	bh=hx2GwOmsQMhppzGU+YHohQwM540v/xJ+grXMc9ub/7k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N7cmmd8mAUVTkKO2cY2cOHtvGywHi7g0+hMuI5tihiA+YzJFadBkq6DJRDUoSI+QrcT6LXcpHrIqkrlF6mMuwkdRcUqsKDlF9Y8NJCwAEGNgiHgDvyasiyHXWxdbU7TUV4jk4U8AqX9uPyzk1Aa08qH1DxUlbHP8TUNQmoMHKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7Bxk6Uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FD8C4CEE3;
	Fri, 27 Jun 2025 03:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750995163;
	bh=hx2GwOmsQMhppzGU+YHohQwM540v/xJ+grXMc9ub/7k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O7Bxk6UoDhXbRqrrKsZnfk3UF3WJCpDdtKjDXfZodiKPVNoaz8k0keJzcN4wfcUlX
	 e6K89TSfM+xtv3N5gjEQ6lLxSsDiCE+7xlH/tBbh5N++UKqhrB51483M0N390xdaTV
	 ZG3jczpn1YI/cioFQ3Upl4siEiEmDHS3OgkBV1Fw6VoIWxRJ4WlhVpPURzuPG2ikQ0
	 VNXTkSxo3lSaa261wHI3lN3e9GGy1Zw8/20nvbadJRnYhzOeAqq6Kvm07zE0AEEWVP
	 f3LsgrMj2jjSPhRu/6rN3dhdH3s/zk8fEtBSmuS0YXi6woEq5apwFR0F9Nfnwe+k+X
	 EWBncN/4zRnGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDFB3A40FCB;
	Fri, 27 Jun 2025 03:33:10 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-06-26
X-PR-Tracked-Commit-Id: ef6fac0f9e5d0695cee1d820c727fe753eca52d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f2a71a99ebd5dfaa7948a2e9c59eae94b741bd8
Message-Id: <175099518936.1417711.15496967287571518216.pr-tracker-bot@kernel.org>
Date: Fri, 27 Jun 2025 03:33:09 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kerenl@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Jun 2025 22:22:52 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-06-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f2a71a99ebd5dfaa7948a2e9c59eae94b741bd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

