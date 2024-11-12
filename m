Return-Path: <linux-fsdevel+bounces-34374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04AF9C4CF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 04:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757F228A2B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 03:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C32205E37;
	Tue, 12 Nov 2024 03:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfG2EWvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C7E574;
	Tue, 12 Nov 2024 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380423; cv=none; b=XXukFjrp0MJXcY2pgNinDlMhof8bDDdgLgE9PDg7Vruln4xlU8WOu16Zhv9K6BJ267hNTVDtXAGNmvULOWvZ3P09EF1eR3Jyx7CL9PsfIh1wE8nd6VRlGyqwlvg0oR3I3pA4Xzq5kgF3LmNumB8SCHefV8vBCdz8uNTtgcMC6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380423; c=relaxed/simple;
	bh=5wk4mK60EoHVsMCvX1Li3jR8LsNWik4rErnD/bTn/LU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fw65HqTs5NoLcbrxug0Va0oXtthMAH36tPV5uzUaQ228OfFuEDq1R7+UgAbvtohRbHZtxT3pRrTaVOvqM0+O7b0mmUCPy/M90klbj0cr2nCtwcKbSlxTL4fMXnGpGcAb8bJYB3wYL/P4Sq0C7s8tSiWOXZ9e3pm97RcWPP4/PpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfG2EWvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5ADFC4CECF;
	Tue, 12 Nov 2024 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731380422;
	bh=5wk4mK60EoHVsMCvX1Li3jR8LsNWik4rErnD/bTn/LU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YfG2EWvNsFWWKrvzuehWMvYVI5NSsA9yfl9Mmw1poL3yT1T5Z98T/1UsZAvy88Q87
	 mgmweCLkvt/0tZLID1W4dZgyH+F8qxriU+QyzTMAH/4dJmOG7+12zuWLPd6OuL56vV
	 TaMP3XYWjwh3gRTQQnBqIqz5MvceYGUAOIUZ25ZxQ1h31GkR7+LejDQNZvl5hQZFlS
	 Xd/mXG1lMIa9fVZRu3grLBYy+GbB/SLa/dkHAf2bLWhJTe/VBJCvoWbXFh08kC/qqe
	 2BH/5qk0diSp/Qj6tUdjEl8UTui+udO52HKcUDVFMZx6ZFeH5aGBueoj7vN2PFshnn
	 yt1zAzaPPFMsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE563809A80;
	Tue, 12 Nov 2024 03:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/6] Suspend IRQs during application busy periods
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173138043276.62607.2860647577086593902.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 03:00:32 +0000
References: <20241109050245.191288-1-jdamato@fastly.com>
In-Reply-To: <20241109050245.191288-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
 bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
 edumazet@google.com, amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
 bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
 willemdebruijn.kernel@gmail.com, skhawaja@google.com, kuba@kernel.org,
 aleksander.lobakin@intel.com, viro@zeniv.linux.org.uk, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, brauner@kernel.org, danielj@nvidia.com,
 dsahern@kernel.org, davem@davemloft.net, donald.hunter@gmail.com,
 jack@suse.cz, hawk@kernel.org, jiri@resnulli.us, johannes.berg@intel.com,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 lorenzo@kernel.org, mkarsten@uwaterloo.ca, almasrymina@google.com,
 bigeasy@linutronix.de, shuah@kernel.org, horms@kernel.org,
 xuanzhuo@linux.alibaba.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  9 Nov 2024 05:02:30 +0000 you wrote:
> Greetings:
> 
> Welcome to v9, see changelog below.
> 
> This revision addresses feedback Willem gave on the selftests. No
> functional or code changes to the implementation were made and
> performance tests were not re-run.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/6] net: Add napi_struct parameter irq_suspend_timeout
    https://git.kernel.org/netdev/net-next/c/5dc51ec86df6
  - [net-next,v9,2/6] net: Add control functions for irq suspension
    https://git.kernel.org/netdev/net-next/c/3fcbecbdeb04
  - [net-next,v9,3/6] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
    https://git.kernel.org/netdev/net-next/c/ab5b28b007a7
  - [net-next,v9,4/6] eventpoll: Control irq suspension for prefer_busy_poll
    https://git.kernel.org/netdev/net-next/c/8a6de2627fd3
  - [net-next,v9,5/6] selftests: net: Add busy_poll_test
    (no matching commit)
  - [net-next,v9,6/6] docs: networking: Describe irq suspension
    https://git.kernel.org/netdev/net-next/c/a90a91e24b48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



