Return-Path: <linux-fsdevel+bounces-75778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JYAC2dDemmr4wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:12:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D5DA6981
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E4D0307A7AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821732A3C5;
	Wed, 28 Jan 2026 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JS6heE0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD99322B8C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620030; cv=pass; b=ivOZRqAp7+VpqMMstna0gXWlLzHId4ABSGN6MXU8cvleN+bYkoNR2bE6VKP28sigsiCBlz0mEfwfvneKygJ69ViGKwucWD7EcqO60dM9UbLKDYCAW35oebJlz3A6EvtYPB0ovbRm35PmVz1hsmKCQOy7pHIdPl8WgBEkhRbJwaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620030; c=relaxed/simple;
	bh=gWij/TH8QPr+IwLvH0/2/fUh1RCAU2KJ3dVcD1USFIU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzc1w4wrrzCKzru4zsgGgBUX1nAeet1PiTowzRYdQ3XlrjCW56M/AScTsIwOgywopSr7zT1A/lSWf4GIoIJwckm2HFAJrK6xsF178GIt7ywh2YoMbNqsWsM8g0E191/xm+dUwRJx0TNUa7ds5x/EKzujgAtVPJoMp5PFjhpZSBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JS6heE0f; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5663724e4daso20101e0c.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 09:07:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769620026; cv=none;
        d=google.com; s=arc-20240605;
        b=kfBuCZ3E3kTW2Vqq9A3z+1WpxF2IF1xEwbdhzpZX6bETaI4JzWGV1/1xl24OPAv0JP
         iAQKO+FnQVvXA65euE0ZQh2AtRS2DsQvhlIXxP3u6D4GrS2UCqaBTHO5cqzJk8e9DzLV
         eg/bcl643A6auD1nZwDAASZJ9YGtn1Ef4PsY82IFkNVjEj9HyZzaTB/5FFbN77YD5jC/
         UbGrgNkcFJL6qkPxRcoV9IrGp0/RTALcKHrPvEQnv/u2hoGEnrj7OHKC71wVZgS63dlw
         DFEMlZIx847dVXAZD8tnfxU/bEojDE2jn/fvV2OYyiTX7tEJObnbRUrVnKzmffZTpXp1
         QOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=hQ2ByvmYGALpHjwu0udZOzYr4BMUegwRg7Tc5bSaMn8=;
        fh=t4DAATT5nHe9YbrSwstRmAy0ul4Ds5C0CJZBszok5kQ=;
        b=lPgf6FIzwUA9qLoUtfWsY3lY1PeEYj1bQ+YXfd1KPnoefvd4aiDXj7NLdLCX6iDd1y
         XZxMYIrc5P5qSU8M2j3D80q+5OId4JCRccuycQBfs3EWDjzCdkxOlaqQXG8L+OY35fs1
         z2X7AFU6HdRmxqPZ+AMdyx48Ex9qYN0PTiZeS+Dg70qa65RR1kwqseIK7OO1unwmKffX
         oLzQiIdquwoQi8bEnFsyZjMaMJU18WSUzYeqYoPzFY0/HwoK08hfKXZGVSwoCou91ifa
         y8HLHYk8cQJ+6w8+f52w0/TBmclhz9wdj/taHcjet9NoY5PTXgXNQAVzoHlKmtudh0aD
         aHmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769620026; x=1770224826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ2ByvmYGALpHjwu0udZOzYr4BMUegwRg7Tc5bSaMn8=;
        b=JS6heE0f4DJMjmBufL78cbbgFc3tXStJhNFZSB7w4D9RdPaRft+59kETp8NXqy5eUt
         yyFGbrPcnCIu3T8hdoXRzuOcfjZkVPjeFrWbcvcFDog9qna8n7ZOYof0xtFYSrPFoTXn
         E57qAMjQVF/kXr6sC18641QtVgsvERg7ITeS7cJEoCvRUbyfuyONLK5OEtiU/w5Z4/ji
         q5HHLFaqIXmT7ti9vqgri4WtDeIor8DY1O1Vb2NJ8rLb8RYbfhTAo1n4Y3g8gDMxQ1m3
         BU/xtpMdz0FfsuubtAJHCoPo+wFYo5VJ/FUR8l0E+RAot+qNqZKUOUEZni16PEhrbaYS
         EcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769620026; x=1770224826;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQ2ByvmYGALpHjwu0udZOzYr4BMUegwRg7Tc5bSaMn8=;
        b=p/S0Qz+9PodUHqf3GzM/I37CQHX1fk6vzkRs3dd3EBw9BpTNTO3GdVXNnP8a0F/uUr
         pesZBncYWOWGj1utmMLgIVAQdcm4WVu38flpzAqUiHUBVTw2car8G50Z/8hYG6aG3HYT
         6lUxyPBNdd5Z9DJ4AEhMRVSeFD5yTqTzvRtQIl1x6gNQucNx6nmb6T+FfNIAAJ+hc8Zt
         DrB0WDT8NNTLHqu4SA6DULzLPmcoVDONYh3dfjB3foTgDcmJl563OfmgRYqhyhFHZzVI
         Vf4wpi1Lho8JwZMgEczFZf4kupcxbqiLFN34gJHLHx5W1QNngeUWcEE/Uy2Vr+61sOVn
         G7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSenfGNrJGqPcMM/FrHPsha/66RPsWDSQmsN9ly5bEYu/xo9UEuUr1st48iUCI5I6pEXW0XeVMaxq1oN7s@vger.kernel.org
X-Gm-Message-State: AOJu0YzDEEg95Ka8GlC52mqQQ9GUtmvbTOJkpxNChhc6sdUTHFYIrhTH
	v20dJBc0XBlyqzZjN8m9A3l5zjALCCcpDW2zLIVWdmpZsPG+6xlXewf9mbIKdUsxTSOyFDZzD+i
	2rvIElvOS0OWeDXaJiQ6mtBEW9l/GJm+KBLp+tMMyf8PxiE4iIAIlAfrIQOA=
X-Gm-Gg: AZuq6aJ/uFD2fNI7RryJnjJMJOzvkJhezge93Ux9QTIBXQODBbQo5b/0aR4F9mZSaXX
	FRePcGHhn+rkfLiIbvp1S4MUUNfmX9XaSP46CZpVUI9NKdSkxxYvSFmyBs9FGBz2pDuqFUBxpfP
	JIoZlKVCm/2oKU++5uuCxQM/YkkZfS9T4c81QaLK3gis+WQg9B/1hoCf4x85/87bN8XBzERc5lO
	VuVOvxAQjqhlRx+YDtGJiGFnilnv2EmY+JmHwl8uUMl0Fjup4d/Bc55C6+mOWTiMZmep5JTblW0
	Hxe4mfLWI6Bc/kDjl0Yba8YIr7kMnFelBbVz
X-Received: by 2002:a05:6122:ca5:b0:54a:992c:815e with SMTP id
 71dfb90a1353d-56679502f80mr1751301e0c.8.1769620025275; Wed, 28 Jan 2026
 09:07:05 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 09:07:04 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 09:07:04 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ab3f297e-44d5-4f42-aa17-f2e7c135580e@linux.intel.com>
References: <cover.1760731772.git.ackerleytng@google.com> <638600e19c6e23959bad60cf61582f387dff6445.1760731772.git.ackerleytng@google.com>
 <ab3f297e-44d5-4f42-aa17-f2e7c135580e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Jan 2026 09:07:04 -0800
X-Gm-Features: AZwV_QhaOE_wJlLL_hX7tpT0otF_GVqIj23tN-vGGdhqYGAPjKuSGPxvod54AXo
Message-ID: <CAEvNRgEo2UZ63uv0F7Pv8VfeJipyu82b=Rgiz2gnttdRu9aEPQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/37] KVM: guest_memfd: Introduce per-gmem
 attributes, use to guard user mappings
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, akpm@linux-foundation.org, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, corbet@lwn.net, dave.hansen@intel.com, 
	dave.hansen@linux.intel.com, david@redhat.com, dmatlack@google.com, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, 
	hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,alien8.de,intel.com,lwn.net,linux.intel.com,redhat.com,google.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,ziepe.ca,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,amd.com,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75778-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[96];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 98D5DA6981
X-Rspamd-Action: no action

Binbin Wu <binbin.wu@linux.intel.com> writes:

> On 10/18/2025 4:11 AM, Ackerley Tng wrote:
> [...]
>>
>> +static int kvm_gmem_init_inode(struct inode *inode, loff_t size, u64 fl=
ags)
>> +{
>> +	struct gmem_inode *gi =3D GMEM_I(inode);
>> +	MA_STATE(mas, &gi->attributes, 0, (size >> PAGE_SHIFT) - 1);
>> +	u64 attrs;
>> +	int r;
>> +
>> +	inode->i_op =3D &kvm_gmem_iops;
>> +	inode->i_mapping->a_ops =3D &kvm_gmem_aops;
>> +	inode->i_mode |=3D S_IFREG;
>> +	inode->i_size =3D size;
>> +	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>> +	mapping_set_inaccessible(inode->i_mapping);
>> +	/* Unmovable mappings are supposed to be marked unevictable as well. *=
/
> AS_UNMOVABLE has been removed and got merged into AS_INACCESSIBLE, not su=
re if
> it's better to use "Inaccessible" instead of "Unmovable"
>

Thanks, will update comment as follows:

	/*
	 * guest_memfd memory is not migratable or swappable - set
         * inaccessible to gate off both.
	 */
	mapping_set_inaccessible(inode->i_mapping);
	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));

>> +	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>> +
>> +	gi->flags =3D flags;
>> +
>> +	mt_set_external_lock(&gi->attributes,
>> +			     &inode->i_mapping->invalidate_lock);
>> +
>> +	/*
>> +	 * Store default attributes for the entire gmem instance. Ensuring eve=
ry
>> +	 * index is represented in the maple tree at all times simplifies the
>> +	 * conversion and merging logic.
>> +	 */
>> +	attrs =3D gi->flags & GUEST_MEMFD_FLAG_INIT_SHARED ? 0 : KVM_MEMORY_AT=
TRIBUTE_PRIVATE;
>> +
>> +	/*
>> +	 * Acquire the invalidation lock purely to make lockdep happy. There
>> +	 * should be no races at this time since the inode hasn't yet been ful=
ly
>> +	 * created.
>> +	 */
>> +	filemap_invalidate_lock(inode->i_mapping);
>> +	r =3D mas_store_gfp(&mas, xa_mk_value(attrs), GFP_KERNEL);
>> +	filemap_invalidate_unlock(inode->i_mapping);
>> +
>> +	return r;
>> +}
>> +
> [...]
>> @@ -925,13 +986,39 @@ static struct inode *kvm_gmem_alloc_inode(struct s=
uper_block *sb)
>>
>>   	mpol_shared_policy_init(&gi->policy, NULL);
>>
>> +	/*
>> +	 * Memory attributes are protected the filemap invalidation lock, but
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 protected by

Thanks!

>> +	 * the lock structure isn't available at this time.  Immediately mark
>> +	 * maple tree as using external locking so that accessing the tree
>> +	 * before its fully initialized results in NULL pointer dereferences
>> +	 * and not more subtle bugs.
>> +	 */
>> +	mt_init_flags(&gi->attributes, MT_FLAGS_LOCK_EXTERN);
>> +
>>   	gi->flags =3D 0;
>>   	return &gi->vfs_inode;
>>   }
>>
>>   static void kvm_gmem_destroy_inode(struct inode *inode)
>>   {
>> -	mpol_free_shared_policy(&GMEM_I(inode)->policy);
>> +	struct gmem_inode *gi =3D GMEM_I(inode);
>> +
>> +	mpol_free_shared_policy(&gi->policy);
>> +
>> +	/*
>> +	 * Note!  Checking for an empty tree is functionally necessary to avoi=
d
>> +	 * explosions if the tree hasn't been initialized, i.e. if the inode i=
s
>
> It makes sense to skip __mt_destroy() when mtree is empty.
> But what explosions it could trigger if mtree is empty?
> It seems __mt_destroy() can handle the case if the external lock is not s=
et.
>
>

Hope this updated comment clarify the explosion:

	/*
	 * Note!  Checking for an empty tree is functionally necessary
	 * to avoid explosions if the tree hasn't been fully
	 * initialized, i.e. if the inode is being destroyed before
	 * guest_memfd can set the external lock, lockdep would find
	 * that the tree's internal ma_lock was not held.
	 */

>> +	 * being destroyed before guest_memfd can set the external lock.
>> +	 */
>> +	if (!mtree_empty(&gi->attributes)) {
>> +		/*
>> +		 * Acquire the invalidation lock purely to make lockdep happy,
>> +		 * the inode is unreachable at this point.
>> +		 */
>> +		filemap_invalidate_lock(inode->i_mapping);
>> +		__mt_destroy(&gi->attributes);
>> +		filemap_invalidate_unlock(inode->i_mapping);
>> +	}
>>   }
>>
>>   static void kvm_gmem_free_inode(struct inode *inode)
>> --
>> 2.51.0.858.gf9c4a03a3a-goog

