Return-Path: <linux-fsdevel+bounces-46269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BDFA86056
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18FB9A42E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75001F584C;
	Fri, 11 Apr 2025 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqWrMieo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E032367B5;
	Fri, 11 Apr 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380973; cv=none; b=nrYK5MFdAy8ZV9EvoCf0w/yc8l34delY3YV8xGcm2nCVo2bPf0I0YBzKih/yeflYqwbei0K41/h6wenle3GZ4uMDf+d1JE8us1S3kRB+uYneT7Cm0alBZG2OjVdqNSTcP6A3IfnBZUhbqmfLL+dEYtp5gZMere96QiD0s/Ip7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380973; c=relaxed/simple;
	bh=H8RzE3WJETWRwWdp+SHT2/+zpdflJRvn9iyvD2AGQKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsTeDDwcK9v0NjiBW/dPeql8NiE7RlLtYJ1u8dAsXbkJJrG4GHxbuzBQJvS7OxJ4GISWVnB86Yrg2dNiLDzYYRrfac5bgnstUEQ6TFTRa0frUcyOFObeQfki/Fq8oYpPdFcO5weZJTTU9t963kQ6IlGUMrp1PTdfWvwiR92rFuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqWrMieo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C8AC4CEE2;
	Fri, 11 Apr 2025 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744380972;
	bh=H8RzE3WJETWRwWdp+SHT2/+zpdflJRvn9iyvD2AGQKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tqWrMieo/FRdy8F2ZjgIjntNtmXjSvKkOFi1Lxghc6nQXbAslXGFXfYJjuZg7XQfU
	 IRqbuTRGB9nNfDbiyFI+WfAKE1KBQzMnz2uR0q1hKV3P4joegHdoBmgLX7GWUcaMp2
	 pZOl2BQQUWgJtY4UyBf9Tc4zwFYmi0cuYWHl2oGL4kZWaesZ50VARO3Mb56GFkE1eo
	 hTOyBCjIx6dubtr/ut40Eeh+JYl2yuZpmo5UA2KTSJOq7Ce4z8LHIFTeLaxzre/1Do
	 GwmsIv7hN293XFFvg3iS/cdNODWm1fvYKfkyffcuzEcNXBqZ2XOsAtgIPc04l670xH
	 w9ZHKUxu6PwOw==
Date: Fri, 11 Apr 2025 16:16:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Make file-nr output the total allocated file handles
Message-ID: <20250411-gejagt-gelistet-88c56be455d1@brauner>
References: <20250410112117.2851-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410112117.2851-1-lirongqing@baidu.com>

On Thu, Apr 10, 2025 at 07:21:17PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Make file-nr output the total allocated file handles, not per-cpu
> cache number, it's more precise, and not in hot path
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---

That means grabbing a lock suddenly. Is there an actual use-case
behind this?

>  fs/file_table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index c04ed94..138114d 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -102,7 +102,7 @@ EXPORT_SYMBOL_GPL(get_max_files);
>  static int proc_nr_files(const struct ctl_table *table, int write, void *buffer,
>  			 size_t *lenp, loff_t *ppos)
>  {
> -	files_stat.nr_files = get_nr_files();
> +	files_stat.nr_files = percpu_counter_sum_positive(&nr_files);
>  	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>  }
>  
> -- 
> 2.9.4
> 

