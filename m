Return-Path: <linux-fsdevel+bounces-32616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A729AB6DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 21:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251051C233D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 19:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4BB1CEAB7;
	Tue, 22 Oct 2024 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsGAjcGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6121CB503;
	Tue, 22 Oct 2024 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625494; cv=none; b=elNPqoqkChSktBICuA4tHB53ChFoBZbzTZ3Ab0Xq5wrUAMV1PDEmAbfGFfqt21mDuvRIt6JBsbEvzdyybM3hVrDrywk7H3P21xkUKnKyoxpGNDE7wZOzTlASNC+GeOWlxu/FnkeKJTWC2WGtiYe0820zNeS3AFOJsdSu3bdMHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625494; c=relaxed/simple;
	bh=GGNhwfUzomB5c7pGZnSajU+DPtArbMMXDbU2WQFJAPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/WSr4xfpieAsZdGzil6SSY737onxaNnkkIK1mIsn6bopIE9eTxIbqotJ+8O6AhBgbDUU8xS4oci2fev90FQWqQXlkzwjqBpIxP3SJAhhOlFU1AjKoA1PIb4NwdX2lJZbxrMg3dBEh0I4Vc2QKJx0rjHIHANTq9/GxthzRuEfNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsGAjcGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802D1C4CECD;
	Tue, 22 Oct 2024 19:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729625493;
	bh=GGNhwfUzomB5c7pGZnSajU+DPtArbMMXDbU2WQFJAPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsGAjcGEWjVmbDuPRLTGWixM/V+AZwp2sRPkU6TqCPHVSD3TlpNU0UCY2JrLnKwQc
	 Y8Zd8KXmpd/J+B1iB00ohZSWU3O0iFIaXAsd8nceOd0B8umiAoA/1ihl39uG4qYTYr
	 q484G3EGV55gso3g4Q7ooU4UD2XfUHGI3Kj7kK3LXS3TpjiorOf46Vbkd4hPB9v0mF
	 qaT6lFd0UKbTQRh7+s4MFE6EAmI8WS438bz3EpC1CddM6AgYPThqrDTo/iEYTDim4d
	 B2/ImIUiKrIlj6PH5t4WIhMMRZbpvV/cIqGfLxQFjX+ewrPBUQ6EKvkob35bUwDwz/
	 qFEiVTnLF8vyQ==
Date: Tue, 22 Oct 2024 21:31:11 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Luis Chamberlain <mcgrof@kernel.org>, kernel-janitors@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/35] sysctl: Reorganize kerneldoc parameter names
Message-ID: <nnbmui2ix23wjmfvxo2t3zd3tgymk77h765kyoc3pxu6wkhqxx@6qis4yyszkec>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
 <20240930112121.95324-10-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930112121.95324-10-Julia.Lawall@inria.fr>

On Mon, Sep 30, 2024 at 01:20:55PM +0200, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  kernel/sysctl.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 79e6cb1d5c48..5c9202cb8f59 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1305,7 +1305,6 @@ int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
>   * @write: %TRUE if this is a write to the sysctl file
>   * @buffer: the user buffer
>   * @lenp: the size of the user buffer
> - * @ppos: file position
>   * @ppos: the current position in the file
>   *
>   * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
> 
This looks good to me. Is it going to go into main line together with
the other 35 or should I take this one through sysctl subsystem?

Best

Signed-off-by: Joel Granados <joel.granados@kernel.com>

-- 

Joel Granados

