Return-Path: <linux-fsdevel+bounces-2616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A067E70C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785221F21907
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3383065D;
	Thu,  9 Nov 2023 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXl1HJST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B06225CE;
	Thu,  9 Nov 2023 17:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B508C433C7;
	Thu,  9 Nov 2023 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699552230;
	bh=NC2wQNcDNMRuGv9g3+/8bxt26yBhotbPBQ9TPyur8Io=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fXl1HJSTyAdNusFocUwf48YPEjKuv8vRm9YMPQIXaIoIWAoKmIy1wvVVtFS+ycZko
	 z08nO6cxn9XrUQmMfVtGSx6G7oPrdzaKoJc7lbzjbzXkPN6/sDdUi09XCJFTG9hYuY
	 wlXRypddOjgIhSYk+ArKvQ+SSKQPzBIPdhQR+MVjIxFn3GwuuJNWWLpiXSX+Wvaz+z
	 vVIuxDRbGIPQ+Lx6oifYUKSySr/BgdnzLelrnzK5J4/piupOkogqWyf+USUyBy8p8t
	 2Haryc2T7CD6pU5KchTK888SYjBsg1+JB3c63zMTbDidWpb6y2Hx9+wonpD51ULaP+
	 Br1NjCEZ2Ot8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39B33C43158;
	Thu,  9 Nov 2023 17:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 02/41] rxrpc: Fix two connection reaping bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169955223023.20616.10876118854212671303.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 17:50:30 +0000
References: <20231109154004.3317227-3-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-3-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: marc.dionne@auristor.com, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Nov 2023 15:39:25 +0000 you wrote:
> Fix two connection reaping bugs:
> 
>  (1) rxrpc_connection_expiry is in units of seconds, so
>      rxrpc_disconnect_call() needs to multiply it by HZ when adding it to
>      jiffies.
> 
>  (2) rxrpc_client_conn_reap_timeout() should set RXRPC_CLIENT_REAP_TIMER if
>      local->kill_all_client_conns is clear, not if it is set (in which case
>      we don't need the timer).  Without this, old client connections don't
>      get cleaned up until the local endpoint is cleaned up.
> 
> [...]

Here is the summary with links:
  - [02/41] rxrpc: Fix two connection reaping bugs
    https://git.kernel.org/bpf/bpf/c/61e4a8660002

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



