Return-Path: <linux-fsdevel+bounces-75110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOBaC9lacmkpiwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:14:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D12366AF4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 205A330F4DA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593D344D82;
	Thu, 22 Jan 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c0phBEsG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F26E36654A;
	Thu, 22 Jan 2026 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099556; cv=none; b=Ba+IeCWNYk1rZik0h98uLt2IUenxh2PyQ1pudrfqoeMa8WvN7IJlnGH7Z8kskddvq2QPAGj82OopFA6uoeZStoWkt9VwCUXwBhuv8+48k5+Q4gnXpeBDyR1Vfj/a08ozd580nLVr6njeROjo8y/QLqfXfkbZEOw6ydjsKZUTjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099556; c=relaxed/simple;
	bh=e7AjUAucN6U23gMBxe2IxS4+C/05b74rVPOMzl7InN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDP91GmA+Ef8RCgseFXivtl8LswjWBN8+XzpAShaUCWoRDYATDgI1UniktfsQ3c4THPKfEDHkSABr+kngOksdZ/m9VbOj5AnhqvQ71gb9XjzQQO6Yb9ZRE78Sxa6NnifVUbcWmLVFFEPthNRVYgtqpMTu26UoPgf1XLGuMMbaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c0phBEsG; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769099544; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WgGjCmtUlQAzHkuWKEX+aFWP3mMdaRSo1WEnDLfhUl4=;
	b=c0phBEsGv3g55lvXOBoqiQiPVv7D6Eop3CTzcfluU6kLFF9boKUZR5rNGQVmasyS5iq7pMT74/ClFkfO0aLNIvKPiZRgCzPLSTc9oCjFbGZ65G9Yn6kHCxxVhFzBg6SPAuU36vM7GVg9clwO7VtQtO8mKT7W8DphhLSQBMg9FFM=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxctV1L_1769099542 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 00:32:23 +0800
Message-ID: <ce900b69-edac-4d1a-8ba2-5d5dbad9ec02@linux.alibaba.com>
Date: Fri, 23 Jan 2026 00:32:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 05/10] erofs: using domain_id in the safer way
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hch@lst.de, djwong@kernel.org, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>, brauner@kernel.org
References: <20260122153406.660073-1-lihongbo22@huawei.com>
 <20260122153406.660073-6-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260122153406.660073-6-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75110-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: D12366AF4E
X-Rspamd-Action: no action



On 2026/1/22 23:34, Hongbo Li wrote:
> Either the existing fscache usecase or the upcoming page
> cache sharing case, the `domain_id` should be protected as
> sensitive information, so we use the safer helpers to allocate,
> free and display domain_id.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   Documentation/filesystems/erofs.rst | 5 +++--
>   fs/erofs/fscache.c                  | 6 +++---
>   fs/erofs/super.c                    | 8 ++++----
>   3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 08194f194b94..40dbf3b6a35f 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -126,8 +126,9 @@ dax={always,never}     Use direct access (no page cache).  See
>   dax                    A legacy option which is an alias for ``dax=always``.
>   device=%s              Specify a path to an extra device to be used together.
>   fsid=%s                Specify a filesystem image ID for Fscache back-end.
> -domain_id=%s           Specify a domain ID in fscache mode so that different images
> -                       with the same blobs under a given domain ID can share storage.
> +domain_id=%s           Specify a trusted domain ID for fscache mode so that
> +                       different images with the same blobs, identified by blob IDs,
> +                       can share storage within the same trusted domain.
>   fsoffset=%llu          Specify block-aligned filesystem offset for the primary device.
>   ===================    =========================================================
>   
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index f4937b025038..cd7847fd2670 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -379,7 +379,7 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
>   		}
>   		fscache_relinquish_volume(domain->volume, NULL, false);
>   		mutex_unlock(&erofs_domain_list_lock);
> -		kfree(domain->domain_id);
> +		kfree_sensitive(domain->domain_id);
>   		kfree(domain);
>   		return;
>   	}
> @@ -407,7 +407,7 @@ static int erofs_fscache_register_volume(struct super_block *sb)
>   	}
>   
>   	sbi->volume = volume;
> -	kfree(name);
> +	domain_id ? kfree_sensitive(name) : kfree(name);

I really don't want to touch fscache anymore, and this line
should just use if else instead, but I can live with that.

>   	return ret;
>   }
>   
> @@ -446,7 +446,7 @@ static int erofs_fscache_init_domain(struct super_block *sb)
>   	sbi->domain = domain;
>   	return 0;
>   out:
> -	kfree(domain->domain_id);
> +	kfree_sensitive(domain->domain_id);
>   	kfree(domain);
>   	return err;
>   }
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index dca1445f6c92..6fbe9220303a 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -525,8 +525,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   			return -ENOMEM;
>   		break;
>   	case Opt_domain_id:
> -		kfree(sbi->domain_id);
> -		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
> +		kfree_sensitive(sbi->domain_id);
> +		sbi->domain_id = no_free_ptr(param->string);
>   		if (!sbi->domain_id)
>   			return -ENOMEM;

I don't think
```
		if (!sbi->domain_id)
			return -ENOMEM;
```
is needed anymore if no_free_ptr is used.

Otherwise it looks good to me:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

