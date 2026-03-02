Return-Path: <linux-fsdevel+bounces-78870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGnLJuVMpWmt8AUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 09:40:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2633C1D4BB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 09:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B17E7300AB3B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1006038CFF2;
	Mon,  2 Mar 2026 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rR6hqX6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0C38CFEE;
	Mon,  2 Mar 2026 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440795; cv=none; b=U9uxERHCoLG+lpDTXkKhyIy/SI7N4ax1Ui19NjePiRxfD+9xb+Y0vB/QtQncwBQY6L8OxItajjnVHSDP/RrO1HraHfbsGQ3OaYLYzIsGGoLW1t4ywv2P/kfHEop611EjdIq0grLCdzRiRtUBSlb/q0w+sdbzqv9mzO30fPm2uio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440795; c=relaxed/simple;
	bh=IK6yz5KkVHkPj52iCRrJqonMHigRB4kCqBYdPevwYOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSLqorcEJBY4z7rnrmfWR1y9KmCvKmAe77f4RyDIwz4zJWIUDm9obKQuLCeZx78t+n1nLsCee62Mwe4DzQFqW/zl+XLl3mf+IHAEjpQu47pQu6CT7fHcaUuPaTxzJhZdpIpYblFsoFigQ8PuL1juS1WGFlFd1vxG5cY0q8Zpe0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rR6hqX6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE99C19423;
	Mon,  2 Mar 2026 08:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772440794;
	bh=IK6yz5KkVHkPj52iCRrJqonMHigRB4kCqBYdPevwYOQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rR6hqX6k7Jy2Fsq/qNTQTzsicRzKK5XKCMn38lSUnx79QM1kS0YTg+FZdrPkMHhAM
	 xRPvlxsCD6cQ7hnoBGUd8fKi6lPHVSYnu198wRmEaOO7qtN1DTs/uXwmUi3YCIDUCs
	 HvW95YTyPNv5VrWq0kLVxiuE+I2fMO7oWMOuu/Z8PHG5PLDCFmzza5g4Mq6FdMwfwk
	 5pLAmKlWAb3GNqbbp7VGzgnzcjHDwEoI65qHQk4nXNMC4EzvWhOKLaQEKojCQX++Fo
	 Nmwq8cQ95fgGX+Bpr/QA7y3zMbx0y7W8w9wHiIFn0XBXFaFsSr6yHrEcGQ7Vrx/Iul
	 d2CRZOgiHQyCQ==
Message-ID: <20df8dd1-a32c-489d-8345-085d424a2f12@kernel.org>
Date: Mon, 2 Mar 2026 09:39:48 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
Content-Language: en-US
To: Qing Wang <wangqing7171@gmail.com>,
 syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, chao@kernel.org,
 jaegeuk@kernel.org, jannh@google.com, linkinjeon@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, pfalcato@suse.de, sj1557.seo@samsung.com,
 syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
 Harry Yoo <harry.yoo@oracle.com>, Hao Li <hao.li@linux.dev>
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
 <20260302034102.3145719-1-wangqing7171@gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260302034102.3145719-1-wangqing7171@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78870-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,syzkaller.appspotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[linux-fsdevel,cae7809e9dc1459e4e63];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 2633C1D4BB5
X-Rspamd-Action: no action

On 3/2/26 04:41, Qing Wang wrote:
> #syz test
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index cdc1e652ec52..387979b89120 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6307,15 +6307,21 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  			goto fail;
>  
>  		if (!local_trylock(&s->cpu_sheaves->lock)) {
> -			barn_put_empty_sheaf(barn, empty);
> +			if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES)
> +				barn_put_empty_sheaf(barn, empty);
> +			else
> +				free_empty_sheaf(s, empty);
>  			goto fail;
>  		}
>  
>  		pcs = this_cpu_ptr(s->cpu_sheaves);
>  
> -		if (unlikely(pcs->rcu_free))
> -			barn_put_empty_sheaf(barn, empty);
> -		else
> +		if (unlikely(pcs->rcu_free)) {
> +			if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES)
> +				barn_put_empty_sheaf(barn, empty);
> +			else
> +				free_empty_sheaf(s, empty);
> +		} else
>  			pcs->rcu_free = empty;
>  	}

I don't think this would fix any leak, and syzbot agrees. It would limit the
empty sheaves in barn more strictly, but they are not leaked.
Hm I don't see any leak in __kfree_rcu_sheaf() or rcu_free_sheaf(). Wonder
if kmemleak lacks visibility into barns or pcs's as roots for searching what
objects are considered referenced, or something?

