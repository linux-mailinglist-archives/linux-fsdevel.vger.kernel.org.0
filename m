Return-Path: <linux-fsdevel+bounces-79367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL2PCTU3qGm+pQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:44:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A37200A40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3CA230D0B0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1E73976AF;
	Wed,  4 Mar 2026 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmVfd74f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE534CFC6;
	Wed,  4 Mar 2026 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631593; cv=none; b=JUaF3Kso1jiah5dchVVjOp1YTfxX2sHzpcf47vzjDDiSfv4TJ2bRBK3BQPPs4beYetn1hJJlxSATTxccNlTGTB+q+p6rFODDDuXOEYqTC0IeKI1EZge46e/c9/Ew1wgJFfrNUPYYCmDq7aPPPfiy4PPlIAcCFKhamN7qiQHhOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631593; c=relaxed/simple;
	bh=tBg/hfXGbB8kC2UwsbFj4SllrfktIr46ew/BFF078eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zs7bPPk2+sYrwRE0CGuJlZn48Pf83OIu0vr0KAWbBTeGZL04QRvaXXDxyKLSL4tjDY07Mp6w5IxV2C/uf/3CJYkitmTq1fssAlG+Afc5vFOPOAb3keHckHzRrTq1kLUWL8F+9vt2EZo64nBzw/Xj/ngEC+fFQM4VT4MK8cXB41g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmVfd74f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ECAC19423;
	Wed,  4 Mar 2026 13:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772631593;
	bh=tBg/hfXGbB8kC2UwsbFj4SllrfktIr46ew/BFF078eA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OmVfd74fEjgnoLPP+YJzeIx2IjGp7V0GPXUHue1QkmLdIDIJNgfvesZsuVutlPBPW
	 +yQiwp2wzAl2OLloNNG3I2H2o37SlIBQSx1Rsr77wESVy6yIsEI0BXcjm757AwgLvk
	 cCNHhAxwddyuzkM8oL9xzu7pls0y/+yGaISktJWKXtdvuanO2ssGqIDXLs1BXwxqMR
	 mh5dRFdKmFHHrG7CGzHxpkANcEmqQ5quTPgCDxT9g7elPNd+JeTHPAMdILHfdhzBi+
	 ryjJRBLNPlFp77s7IDc7SvOxX9exg6SGTVH4daWRSbgz7J/oiu3Qby6/Q4O3Xy10qU
	 +7EkbTJUJjvqQ==
Message-ID: <925a916a-6dfb-48c0-985c-0bdfb96ebd26@kernel.org>
Date: Wed, 4 Mar 2026 14:39:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Qing Wang <wangqing7171@gmail.com>,
 syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org, chao@kernel.org,
 jaegeuk@kernel.org, jannh@google.com, linkinjeon@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, pfalcato@suse.de, sj1557.seo@samsung.com,
 syzkaller-bugs@googlegroups.com, vbabka@suse.cz, Hao Li <hao.li@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
 <20260302034102.3145719-1-wangqing7171@gmail.com>
 <20df8dd1-a32c-489d-8345-085d424a2f12@kernel.org> <aaeLT8mnMMj_kPJc@hyeyoo>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <aaeLT8mnMMj_kPJc@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B3A37200A40
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79367-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,oracle.com,linux-foundation.org,kernel.org,google.com,lists.sourceforge.net,vger.kernel.org,kvack.org,suse.de,samsung.com,googlegroups.com,suse.cz,linux.dev,arm.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,cae7809e9dc1459e4e63];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On 3/4/26 2:30 AM, Harry Yoo wrote:
> [+Cc adding Catalin for kmemleak bits]
> 
> On Mon, Mar 02, 2026 at 09:39:48AM +0100, Vlastimil Babka (SUSE) wrote:
>> On 3/2/26 04:41, Qing Wang wrote:
>>> #syz test
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index cdc1e652ec52..387979b89120 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -6307,15 +6307,21 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>>>  			goto fail;
>>>  
>>>  		if (!local_trylock(&s->cpu_sheaves->lock)) {
>>> -			barn_put_empty_sheaf(barn, empty);
>>> +			if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES)
>>> +				barn_put_empty_sheaf(barn, empty);
>>> +			else
>>> +				free_empty_sheaf(s, empty);
>>>  			goto fail;
>>>  		}
>>>  
>>>  		pcs = this_cpu_ptr(s->cpu_sheaves);
>>>  
>>> -		if (unlikely(pcs->rcu_free))
>>> -			barn_put_empty_sheaf(barn, empty);
>>> -		else
>>> +		if (unlikely(pcs->rcu_free)) {
>>> +			if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES)
>>> +				barn_put_empty_sheaf(barn, empty);
>>> +			else
>>> +				free_empty_sheaf(s, empty);
>>> +		} else
>>>  			pcs->rcu_free = empty;
>>>  	}
>>
>> I don't think this would fix any leak, and syzbot agrees. It would limit the
>> empty sheaves in barn more strictly, but they are not leaked.
>> Hm I don't see any leak in __kfree_rcu_sheaf() or rcu_free_sheaf(). Wonder
>> if kmemleak lacks visibility into barns or pcs's as roots for searching what
>> objects are considered referenced, or something?
> 
> Objects that are allocated from slab and percpu allocator should be
> properly tracked by kmemleak. But those allocated with
> gfpflags_allow_spinning() == false are not tracked by kmemleak.
> 
> When barns and sheaves are allocated early (!gfpflags_allow_spinning()
> due to gfp_allowed_mask) and it skips kmemleak_alloc_recursive(), 
> it could produce false positives because from kmemleak's point of view,
> the objects are not reachable from the root set (data section, stack,
> etc.).

Good point.

> To me it seems kmemleak should gain allow_spin == false support
> sooner or later.

Or we figure out how to deal with the false allow_spin == false during
boot. Here I'm a bit confused how exactly it happens because AFAICS in
slub we apply gfp_allowed_mask only when allocating a new slab, and in
slab_post_alloc_hook() we apply it to init_mask. That is indeed passed
to kmemleak_alloc_recursive() but not used for the
gfpflags_allow_spinning() decision. kmemleak_alloc_recursive() should
succeed because nobody should be holding any locks that would require
spinning.

Unless it's some interaction with deferred pages like the one fixed by
commit fd3634312a04f33?



