Return-Path: <linux-fsdevel+bounces-53585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9431DAF054C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 23:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3805E4469EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 20:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF1330206B;
	Tue,  1 Jul 2025 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2nPHEoj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEBC2FEE29;
	Tue,  1 Jul 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751403583; cv=none; b=p6KDhPDfc9QghteNBydv/MQKc6xsMbi5aS6z5VhBVHx76AigkPGV4w73Dvgr9pnKDAnHv37Zp+se+Pmho3C6ZCTOcfFGOHwfP5zQ57sCm5/IhGwVy/XnFwNXKBc7yWFtCl+sdiTYYSBrvWJS8xkIgnjLyiHde/1K7X2p1O8IuOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751403583; c=relaxed/simple;
	bh=LdFKXc5zIIFbkF6UTCMWqKAWCcBGTFsXoiLEfjtzXHo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i4NQafJ4jRvB8+M5T15JAzP1L9XFcm2s0mPGQAgQQSo1IVnNScsawQhXaOjHgApYK9q0Iqaaz/CXjBcBYEPjMbFmwuZ1TfcRCD9VXyAzm8jcdm024mZsEgD/99Bst4ABvwA+58wonXgBUB0Gek4XM2CLp8QF2SLjhvJi5FODr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2nPHEoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F51C4CEEB;
	Tue,  1 Jul 2025 20:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751403582;
	bh=LdFKXc5zIIFbkF6UTCMWqKAWCcBGTFsXoiLEfjtzXHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z2nPHEojQXwfwmA0KzYM9JkdBM/1gIys9m39NasT6EhWLuizYi1BUGm1BCuYEpz9x
	 hBK+Qg/XGY82eXc/A8dRYMhUewbO1Xz8usDydaK0ZtZY9anTWLu0c/79vnShCUvag6
	 VV0bjyPCP4m9MoHwD9wFHhr9x9xJ942ARSKNe0jSp4+CYtXPIj09mzqk/B3+mO4TFS
	 bolrVmZPW4msfAglG/WXTqNAzMLg+0sbc3xkYa+Q6BjWahBvVeiRrShCxQvGSV+v2l
	 hufPmmV8/q//wkcuQXgimLhVnaekeGfQTAxpwMISP5lmaNyZOxD7i+oTcykXifDkOm
	 zEjsBm+KQtv4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD5383B273;
	Tue,  1 Jul 2025 21:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: don't call fsopen() as privileged
 user
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175140360726.116693.10341336783596879643.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 21:00:07 +0000
References: <20250701183123.31781-1-technoboy85@gmail.com>
In-Reply-To: <20250701183123.31781-1-technoboy85@gmail.com>
To: Matteo Croce <technoboy85@gmail.com>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, andrii@kernel.org,
 brauner@kernel.org, song@kernel.org, linux-kernel@vger.kernel.org,
 teknoraver@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  1 Jul 2025 20:31:23 +0200 you wrote:
> From: Matteo Croce <teknoraver@meta.com>
> 
> In the BPF token example, the fsopen() syscall is called as privileged
> user. This is unneeded because fsopen() can be called also as
> unprivileged user from the user namespace.
> As the `fs_fd` file descriptor which was sent back and fort is still the
> same, keep it open instead of cloning and closing it twice via SCM_RIGHTS.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: don't call fsopen() as privileged user
    https://git.kernel.org/bpf/bpf-next/c/212ec9229567

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



