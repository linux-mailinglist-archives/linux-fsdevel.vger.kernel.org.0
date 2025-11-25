Return-Path: <linux-fsdevel+bounces-69738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB45C8422D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56653AAEA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E1A29DB61;
	Tue, 25 Nov 2025 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1bjT8d9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5E2DCBEB;
	Tue, 25 Nov 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061554; cv=none; b=J9mJB5RspwIrJAo8E0t9W4s3q+nC+T2XLsbONguzWsqIimqsrC+jc1lZcxzjCX5DqC81/had5Dv7NBWNXRGGeNW5svluJyWyTsxeqRjyeIcOQfnDI5qlakL6iI9ctTR4lPwDNrenUhzhWahuC53YUqiEBalccvn36CDUNR3P2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061554; c=relaxed/simple;
	bh=T0eV6VdZAmg+Yq8C0g2FmuAAEj30iQQqBbXs0jm1iu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeC4MEf0OyFz4pyI2hE3nEWNegfpVWj4obzwO0+avvblHjmO/FTuG1b/hzXV5IlDJapSqMswEdXbSOqjesopBL/B0muGkFQ5U/XJy6Xg9YjBlncI5Mf73Na/eSga/mL2XjJEirDZzF1k0YyPuFX7Ov/XSb/PllINuVV5JLkrHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1bjT8d9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28600C4CEF1;
	Tue, 25 Nov 2025 09:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764061554;
	bh=T0eV6VdZAmg+Yq8C0g2FmuAAEj30iQQqBbXs0jm1iu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1bjT8d9HREAamQzThaQuNUC9/tuWxRL2xoF0yW0X6D93tGFuXcLlbzo85orahryl
	 MWqVpHm1AZMGLm12TBqbi2nzj7JPdEWnReJpcQ38q3cSV9QRX7gv8VDUnqzXjbq8Z3
	 YfO0pJL9vOhWxIqcOYCcnXHWcZsP4HHJku8BfpUpgGyvChXGJF+tDpwuW2EOMFY8fs
	 gWuHSlgShUXHkwucUVtb+MhgP1e0T00Ldgg0oww6l4nKfpklep+ulH21e+cemvhYgJ
	 78X/wCDscLHiaL1w8H+ePROVh+0gQlaiehK+c749uHnhq+vgFa2akgF5lqZ0AcmiBw
	 UnOwHitVJgAxA==
Date: Tue, 25 Nov 2025 10:05:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: mark lookup_slow() as noinline
Message-ID: <20251125-punkten-jegliche-5aee8187381d@brauner>
References: <20251119144930.2911698-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119144930.2911698-1-mjguzik@gmail.com>

On Wed, Nov 19, 2025 at 03:49:30PM +0100, Mateusz Guzik wrote:
> Otherwise it gets inlined notably in walk_component(), which convinces
> the compiler to push/pop additional registers in the fast path to
> accomodate existence of the inlined version.
> 
> Shortens the fast path of that routine from 87 to 71 bytes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---

Fwiw, the biggest problem is that we need to end up with something
obvious so that we don't accidently destroy any potential performance
gain in say 2 years because everyone forgot why we did things this way.

> 
> The intent is to get to a point where I can inline walk_component and
> step_into. This is probably the last patch of the sort before I write a
> patchset + provide bench results.
> 
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 11295fcf877c..667360deef48 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1863,7 +1863,7 @@ static struct dentry *__lookup_slow(const struct qstr *name,
>  	return dentry;
>  }
>  
> -static struct dentry *lookup_slow(const struct qstr *name,
> +static noinline struct dentry *lookup_slow(const struct qstr *name,
>  				  struct dentry *dir,
>  				  unsigned int flags)
>  {
> -- 
> 2.48.1
> 

