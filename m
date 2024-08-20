Return-Path: <linux-fsdevel+bounces-26330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08456957B35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 03:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE8E2858AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 01:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBD91A29A;
	Tue, 20 Aug 2024 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vW92ISXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E340617740
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118793; cv=none; b=S1bXwjjtsygsTq7C/Z3V5IWm9fzGwSkgWuot7gS2vyUa3b48l27NramEuafLwbYmC3Q7bDEQ11Fgvx/6Jns1RM9wxvNuPJ55gKPiD1ac7XC1udys1SIiNZe34lWqbRjOpxge5Priuue/IZgW5J6L+mMQYMVwLoOze7dIqdTb3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118793; c=relaxed/simple;
	bh=oV3uzE5c4BDYZYsUDzV5CDqePiikoERQUEN6n9fTCNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/KN7MLc8ajLZ1BUbX19BJGkGmjn+MQKtZnieKcwunP22uzuM1HkW6AMwnj3683E4+E3a2cJsYV5jnoJEO0mvM/eb9cL7pn2/Or0VbJZMfeA4Z/pEDxLCwhQEB2yh3SxrNUcyPzz95NX4LyOK1GuQcBws8/tXCr+Z4aMbb43Cg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vW92ISXf; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724118787; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GEiKYbZjFzwEQj0pOjafRGNcXKmIcsHDs/1h6ZWsLeI=;
	b=vW92ISXfqjTcWz3zbFRo0+owpOg5oIOGtS5lQYw7MFFzkJTWW2ibwynoC3eRVA7Qv4I4SFSK57EyDf+11XkjYiz4VfIP8673Hwyo76x1M0qlMFels+4Sjlo4psF58+ey8YE7NC/78/qhcV4jlg3tRqA4jBiRg+xEBs4mul7ghtw=
Received: from 30.221.146.21(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WDGX998_1724118786)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 09:53:07 +0800
Message-ID: <f93cde51-d2f9-40c9-9ebb-fea1fbbf56d8@linux.alibaba.com>
Date: Tue, 20 Aug 2024 09:53:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fuse: drop unused fuse_mount arg in
 fuse_writepage_finish
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, kernel-team@meta.com
References: <20240819182417.504672-1-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240819182417.504672-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/24 2:24 AM, Joanne Koong wrote:
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f39456c65ed7..63fd5fc6872e 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1769,8 +1769,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
>  	kfree(wpa);
>  }
>  
> -static void fuse_writepage_finish(struct fuse_mount *fm,
> -				  struct fuse_writepage_args *wpa)
> +static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
>  {
>  	struct fuse_args_pages *ap = &wpa->ia.ap;
>  	struct inode *inode = wpa->inode;
> @@ -1829,7 +1828,7 @@ __acquires(fi->lock)
>   out_free:
>  	fi->writectr--;
>  	rb_erase(&wpa->writepages_entry, &fi->writepages);
> -	fuse_writepage_finish(fm, wpa);
> +	fuse_writepage_finish(wpa);
>  	spin_unlock(&fi->lock);
>  
>  	/* After fuse_writepage_finish() aux request list is private */
> @@ -1959,7 +1958,7 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
>  		fuse_send_writepage(fm, next, inarg->offset + inarg->size);
>  	}
>  	fi->writectr--;
> -	fuse_writepage_finish(fm, wpa);
> +	fuse_writepage_finish(wpa);
>  	spin_unlock(&fi->lock);
>  	fuse_writepage_free(wpa);
>  }

I'm afraid an empty commit message will trigger a warning when running
checkpatch.  Otherwise LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo

