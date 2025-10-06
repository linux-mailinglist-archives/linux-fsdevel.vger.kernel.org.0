Return-Path: <linux-fsdevel+bounces-63512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAC4BBEDEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 20:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9134AB72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 18:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A123816A;
	Mon,  6 Oct 2025 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2yuGutB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA1C846F;
	Mon,  6 Oct 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773617; cv=none; b=bJDq8kK9Mf/A6phMO4xeSSX1CJQPjmHi0zxpRG4D/1wDzcZwGtvtQCuTEiEBWRCEubI3zDTawHSeBSfWsag6rzMQVwB2PuYFB8OiLI2aoy04Oq3NP3JfUDv8gFzptYyUsuP4eNbSoTweku1SbsFxeY8bTKFBwRmPWV4EGB54W5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773617; c=relaxed/simple;
	bh=4oQM312+pd6+1kpC4XhmpsurK9XSGqTTsWN0CjZ8lq4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ppcXr+BgxK2qXT0+zZUpwAMjBPPf3cFbjEpNjIz8AKDLXdqxpamD9uHVO/Pba6y9UZePS9JwQffrWy2m0d/eVP4U59N/Xsnz+EwBLg6Sf3k5WJWsL7qUyd43gHLL/5xaHh9LPf1ubcTrfYKVczl9M3TYiPZ4JClExBnAaIoy/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2yuGutB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D087FC4CEF5;
	Mon,  6 Oct 2025 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759773616;
	bh=4oQM312+pd6+1kpC4XhmpsurK9XSGqTTsWN0CjZ8lq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O2yuGutB4qL5lsb4SdXQAtzJxblp7OLs5ozdOvhZYN3EEd27ojLWaNCTVyYL4eo7X
	 NRX8fL7Yvj6ODvFH3L+keK20OWxGZEIasa2yEcp7qpsm2iJc+omRu4PEznFN0Wieo4
	 dbDgNz0D2x3kIJq/foX2Zlht8KGTkYklOft0mekxFdKV0hb5fUWZQsJDtCcoQaEFL4
	 /MK1omnuizEJm3aanHWZ26UllzGSAok1o0oGINyA0XcpO+KVpP8MMlvASsGqb7/Zrl
	 egY2pfpFi8Xbm1GYBJSjK8/12SgnStNjcdaWr6ltXlnwYaY/vewT44dmjNrcaZOwGX
	 HLQte2R/SgXlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE17839D0C1A;
	Mon,  6 Oct 2025 18:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't call iput() from f2fs_drop_inode()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175977360652.1498132.2436692293138075252.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 18:00:06 +0000
References: <20250930232957.14361-1-mjguzik@gmail.com>
In-Reply-To: <20250930232957.14361-1-mjguzik@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 ltp@lists.linux.it

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  1 Oct 2025 01:29:57 +0200 you wrote:
> iput() calls the problematic routine, which does a ->i_count inc/dec
> cycle. Undoing it with iput() recurses into the problem.
> 
> Note f2fs should not be playing games with the refcount to begin with,
> but that will be handled later. Right now solve the immediate
> regression.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: don't call iput() from f2fs_drop_inode()
    https://git.kernel.org/jaegeuk/f2fs/c/8ec5fc1ff77e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



