Return-Path: <linux-fsdevel+bounces-16446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E46B89DC5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 16:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22E01F23D33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C38F249ED;
	Tue,  9 Apr 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4k85Gty"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AF98827;
	Tue,  9 Apr 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673172; cv=none; b=SK+ecJ0NUMyT/4IRAivkNTDiyfWyH/uMXKwrPMW4nWlTmXLlFAAgVZIZJCXSXD54Pz/vr6MMvjDX/3ijrpHf74roKYWHm2OvRQUejgpDbiSDY3ayhilIMw03Oqrnmg61L8H56zPcqjSNjCXd2EfCqDrxhF6WlIJhCe1A8wz5jUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673172; c=relaxed/simple;
	bh=mnNgwDpLpF4zuKoVup/A5j2R8jVIaXOak4b/gsWDzNg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DawpC59TG1EGTTNUCFmvQJvA8ODy/GWbAL4zUABSAxNUqdqJ2bu1fpkyL6cjHYw6MEg8xI+ztEBe6pZHPK5THMKeF9FQd+/NdDYs3Ti1F4IAa3ndVmw7x5b8qj2tY8YD73v6uPcCDIkHQ4PcV3O0EfOjgLb4Hh+O6ygVg6NLMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4k85Gty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B97AC433C7;
	Tue,  9 Apr 2024 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712673172;
	bh=mnNgwDpLpF4zuKoVup/A5j2R8jVIaXOak4b/gsWDzNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j4k85GtySK1Zp3EkaCaF430Qx3TgwxJ1iC6ZiH2Oqntmke0f5rny9KQBjI2j/b3oZ
	 t/QW50JWg+pcJgXvPTeuBEq01AbJbETfDxpPsvy7+YzSLojcmuoWtrhwdcaqakEwe0
	 UpigMziU63Gqsq2sbyXnGE2bGlg9sM/xwiaEiXiIPNnTiA/H6lxvZkGS/A9YqJ4JUt
	 R8aZVtLfSVrHQJ1yRxlrIiJ5Lbkrvd4B/cXsfIn3UNEzykd8V4f/qffS81y/IsNT0m
	 IvlFb0aDjVFRteFUq5TSYJtaPkIcKEgfN4oUdnM1H+ltxZfdZcUxpB2/ltcCagB8JM
	 j/sWzlpuJB7JA==
Date: Tue, 9 Apr 2024 23:32:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 fs/proc/bootconfig 0/2] remove redundant comments
 from /proc/bootconfig
Message-Id: <20240409233248.ca2e8ba75f125f4dd01b273d@kernel.org>
In-Reply-To: <b1ab4893-46cb-4611-80d8-e05f32305d61@paulmck-laptop>
References: <f036c5b0-20cc-40c1-85f9-69fa9edd0c95@paulmck-laptop>
	<b1ab4893-46cb-4611-80d8-e05f32305d61@paulmck-laptop>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Paul,

Thanks, both looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Let me update bootconfig/fixes.

On Mon, 8 Apr 2024 21:42:49 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Hello!
> 
> This series removes redundant comments from /proc/bootconfig:
> 
> 1.	fs/proc: remove redundant comments from /proc/bootconfig,
> 	courtesy of Zhenhua Huang.
> 
> 2.	fs/proc: Skip bootloader comment if no embedded kernel parameters,
> 	courtesy of Masami Hiramatsu.
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/fs/proc/bootconfig.c       |   12 ++++++------
>  b/include/linux/bootconfig.h |    1 +
>  b/init/main.c                |    5 +++++
>  fs/proc/bootconfig.c         |    2 +-
>  4 files changed, 13 insertions(+), 7 deletions(-)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

