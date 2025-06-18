Return-Path: <linux-fsdevel+bounces-51993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF497ADDFFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 02:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5945D3ACA3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 00:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3D5FBF0;
	Wed, 18 Jun 2025 00:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loBvEK4Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015CA2F5339;
	Wed, 18 Jun 2025 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750206600; cv=none; b=fPRAIaVIPFid5Jtv5F9YLelTFw9ysKOIRynvVsGY25+g0B7fEcxnSOGHlRktOTjoa2VDTNVjwhfVB+tKN92V2QVjdkAEd9n8ZmYm6bePGZiE4+ZjNOrU6W37Y2yj39j2VCJ/wsEiqpQbsqPeDfcdzq3/TMXXoBgx0F2nZSR1RF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750206600; c=relaxed/simple;
	bh=SOfeXHKofJZbipWgKVljnpSPJTJiRZUlwnU6giGJEKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hAq590Lnpa0g5vHMYx2jOjDoNHPmhQuN+5BVcDkzvcS38pFH8FsFb/rpnB4YrrDBGWPk4VygGds7ddS49pVod/uC645l0pwmHWu4SjAWu++axyQtNrGqrzUlfxuPHYhxREaFDBrveKReE03UxVqbzixDqOovKklNxJwbpRfAdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loBvEK4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE6CC4CEE3;
	Wed, 18 Jun 2025 00:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750206599;
	bh=SOfeXHKofJZbipWgKVljnpSPJTJiRZUlwnU6giGJEKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=loBvEK4YyYuUkg+EeA4nXA0zQarquyklOfh6hn+/HWvlmiUpoAAFBrQp7MzR94/9q
	 2JEH9AfoyihG4zNuzK5BPL1gKtj5XCXQYj26Z0qjiD0DaHgjvL8QrgbUqLLe8/YEe4
	 4pTWdN4sT8nqI2urfnM7WmCvD5gDgTxPdKc/lFEJpPpKHfwYmEYYcSX7gNq4hDZRQ/
	 oEipMvZ0JHk90qJdnqB0MBi6Gj8QvhNrOcrcZARuclK3u0ltvRzpzAZW8/PKhf0rqd
	 fP2fBfmmaUDJKJZvO0YcZ87ozmGmIXySnCuB3YJTK3UIau0mNCw3OYCt+3oW/RZLRz
	 SGFVvhL67iQ4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B3738111DD;
	Wed, 18 Jun 2025 00:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf_iter] get rid of redundant 3rd argument of
 prepare_seq_file()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020662801.3747728.8721498196778802849.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 00:30:28 +0000
References: <20250615004719.GE3011112@ZenIV>
In-Reply-To: <20250615004719.GE3011112@ZenIV>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 15 Jun 2025 01:47:19 +0100 you wrote:
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
> always equal to __get_seq_info(2nd argument)
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> [...]

Here is the summary with links:
  - [bpf_iter] get rid of redundant 3rd argument of prepare_seq_file()
    https://git.kernel.org/bpf/bpf-next/c/f5527f0171f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



