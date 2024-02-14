Return-Path: <linux-fsdevel+bounces-11539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A69248547C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 12:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475AD1F23349
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830DB19474;
	Wed, 14 Feb 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E05J9c6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA718B14;
	Wed, 14 Feb 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909027; cv=none; b=h+LOgeECfT/S/RdudhvH4HqCQ2pXuTGrlBR1wgMw1XpWCZl2uERVrZPpPxP34yM+7ad8JhS/q03Vong6e8nUTbVhh/q/jF3xmhcKyUE7n+6aXGYvvgVMHbJrNpaAKNnUPmllWaUUUBUcIgXinKizfVef78yb/TTEylhLEmIbnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909027; c=relaxed/simple;
	bh=/N+Tr5D1cCwdzGyVTjVobKhxOLKQhp7GUjHGGqZReHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KsHRzbf/oHXiwiHqDhBYnc0jcfgQyRyWjUKDPq6+lC9CKoO1gWA1kAenwRas7srcnvMDwSE8wATRQRbPDW/AwL6UIMOlmuS5ZcsDHYf7ZI7kKMAFw3W3QnXu892+IKpAQdG5CDrTmuZvWSU5NSAfl5+BcU8S20TkSqs2Qv30fTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E05J9c6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D530C433F1;
	Wed, 14 Feb 2024 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707909026;
	bh=/N+Tr5D1cCwdzGyVTjVobKhxOLKQhp7GUjHGGqZReHw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E05J9c6zjy/3kPry6R6UbtObeLdt6ciRvZaRUE8FGcM7/dCIRGfvgNEgLfQLk1+SA
	 Z9F+GkB8OF2iKgwKw8hZhxz0+yOMMnjlJQMmlQRhOfsX3NbuntBYlM+JgdkuGm7p1F
	 OVLnLUIPS55eHtpvWmoOotBxPgdfp4zbAiWvHBLeH4AUHspG8QzuQTy9isQpt0YuP/
	 pBJwRQpoqnz9WlH3bcG8BXtZEkVNu2E0z8beEEAM9YOMc391H1xCeXHhIvfUe0FBWk
	 OlfVs88mbDMzWkCkklwO3NHFsqAiPp+8e16jw0vKVTQYqX75Dng77y3Oqzybu/3J6W
	 LOXJQqhj0ICIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C735D84BCE;
	Wed, 14 Feb 2024 11:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/4] Per epoll context busy poll support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170790902610.17376.12972731965636317765.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 11:10:26 +0000
References: <20240213061652.6342-1-jdamato@fastly.com>
In-Reply-To: <20240213061652.6342-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org,
 brauner@kernel.org, edumazet@google.com, davem@davemloft.net,
 alexander.duyck@gmail.com, sridhar.samudrala@intel.com, kuba@kernel.org,
 willemdebruijn.kernel@gmail.com, weiwan@google.com, David.Laight@ACULAB.COM,
 arnd@arndb.de, sdf@google.com, amritha.nambiar@intel.com,
 viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, deller@gmx.de,
 jack@suse.cz, jirislaby@kernel.org, corbet@lwn.net, jpanis@baylibre.com,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, mpe@ellerman.id.au,
 nathanl@linux.ibm.com, palmer@dabbelt.com, stfrench@microsoft.com,
 thuth@redhat.com, tzimmermann@suse.de

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 13 Feb 2024 06:16:41 +0000 you wrote:
> Greetings:
> 
> Welcome to v8.
> 
> TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
> epoll with socket fds.") by allowing user applications to enable
> epoll-based busy polling, set a busy poll packet budget, and enable or
> disable prefer busy poll on a per epoll context basis.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/4] eventpoll: support busy poll per epoll instance
    https://git.kernel.org/netdev/net-next/c/85455c795c07
  - [net-next,v8,2/4] eventpoll: Add per-epoll busy poll packet budget
    https://git.kernel.org/netdev/net-next/c/c6aa2a7778d8
  - [net-next,v8,3/4] eventpoll: Add per-epoll prefer busy poll option
    https://git.kernel.org/netdev/net-next/c/de57a2510822
  - [net-next,v8,4/4] eventpoll: Add epoll ioctl for epoll_params
    https://git.kernel.org/netdev/net-next/c/18e2bf0edf4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



