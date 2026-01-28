Return-Path: <linux-fsdevel+bounces-75783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIUpJKhNemkp5AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:55:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FACCA7519
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0698530686FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DEB36F43D;
	Wed, 28 Jan 2026 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHT6jDVr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8334F48C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622650; cv=pass; b=MQ8fVQ/tVYUmxwXEw2NP9BublF5Tkcfc+BL4NMY+U6eJATWxatZDYqX+Ls9ccXUt3CIWGE66hsAfOXO8wU73bzYUeZtYKkw4m6vDn8l+llMlCOECkAYcfzj2BZU6z8csU3hVVH/JgL5AyI9BACsLO2tF86JD/ebzK+4jow4SwcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622650; c=relaxed/simple;
	bh=CNqWkOyueD1v7WuaKUDdc+x4jRQ5s6ulmoL4RqUerEM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDn5tv+6NurGcqU1EOqvYb7QTSZTlN7/3JrLOQIWsDYqF2tQEi9X1PYKUCEZIBv8bnO717L2SkkNqdX8RGqIE/lnWCaJ8y/NuwbKNbDIatkhAZ8cbTKh9dTNliBUmTYrN+REw/z7+VbM90K0Wfsil+tz/1UaJVjHSdg9pp+jB4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHT6jDVr; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5eeaae0289bso90625137.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 09:50:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769622648; cv=none;
        d=google.com; s=arc-20240605;
        b=T13RI14+8NlHu22BWAuFk6S4IdCp8bbsLW3WaYSaPq52uf1PydHfAN7CAUTEx+xCSr
         RGE4fNOdmlgQpbdYwf/OErzXT6K8dp2EPvwKgRe2BMBVfRXZu4PrLaaCR6MasVhyMMzd
         dFmDm7Jtk752GS7ZcWgLdu4LmYHIOXXHGp0ToNlzFVfu3Fg115Fn6SaWU6y0dw6DQEp3
         zI5YJhY8R8GbofnzNW1CRdyB+BVt7z7O1TpS5T/2Pnwl6JELHMRPMijV8pJxkvA2OTg7
         XYfP1U2rnlEJaOrb8SFcppmhAHYVjAphQumvrnGHYMW+KzG/TCKdDK8/G/lhMgcu3pwp
         PicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CNqWkOyueD1v7WuaKUDdc+x4jRQ5s6ulmoL4RqUerEM=;
        fh=z8g95NxwF1huUnlikAMABsWstbRgPGi2o9I0iS7Dg0s=;
        b=cOt9ugMQEdI6hyew/ApILm48LnkDMiKZAnfwG4ZHtcBHKWPzE9MtfeCpNwgy34Iiqi
         xAW3iXHBviDaaY12hb7hpZgEj4bmYybrf5uEk+rszH4jP49+uH4RiWWi4QYtvyWuu1qb
         AmETXd/eM3RHx038ntzT2YGls560okPxnLfPCftrx0Q76U0kuQFYJO6xxzURq/Vc5p1N
         Bvq+3k8J6eDFqTSPJFHObnwvdul2GObwZXEX+bm8Ns5D38xgAP/J6HPzcxrEt/o2pXt9
         QGg7DoXz+mb60qTuNryeeQMemyC3goDpMw0zbdQ1mXWd/2RKuHkCcV+3Awxr9+i1htOJ
         LdYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769622648; x=1770227448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNqWkOyueD1v7WuaKUDdc+x4jRQ5s6ulmoL4RqUerEM=;
        b=bHT6jDVrWJ3mgE3zOdEbPbOXVylCYhJBKidSCHid9ahabufnkQjUDopdWEfUqt8bcF
         lg0R+SYljdK33OM6QbmD4IhWOpcBNORKLrkG/r3rwpBjibP+7XSbTyhpPWf/Fn5tZoXG
         8iXgSC9hofYXikgaLaloBdRIqBSk7PoXv8JMfHLccDyPyNZL1MmlvTj9jVtKoXD1qDdr
         wGJ+WPgGFHT1cBh2DDqw7vc9Y6e98IyTzsVBo90UqQBLxExjeR3YeBxx4KvuntNjJPy/
         oooOPZS5Ffb5yQ3ok1gMnfZO5miSxDmK11nKDNg0N79NN8NPBkqtA39yLQ4KYC7ZycF7
         5tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769622648; x=1770227448;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNqWkOyueD1v7WuaKUDdc+x4jRQ5s6ulmoL4RqUerEM=;
        b=KSqg9RiM9BWGLMgQNWlh0LAsOpnnrR1iJJ1CKkUFI5/ri009hnYP/l49U3rIgvA1Xp
         ef9VygT9y5De26kfTnK1IyIDevaS0OQZrm1KR/9P6fCTgOM0RtL/cIf7Ey1DKnnfTwNb
         GbBtyIhFuY3plguSdnyP949JwUsufXHmxjFPJPrraLlcqHpLZhZMgInyWilocP4EbMQ+
         OiWu8fDe5kicp2Y5lNOUGntJegX9XSXeIkGOKxyZwMctIaHQNmfo5EEdjTfXp329cqOv
         DlmS81ZTVqw3rVaUM0Eiqg1dntPC8yFP8NzGotKJU5IFIo0gtKgHuzbsCmlgE9cPAxoo
         Z6EQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+DgM3UqVDKIF8ksCL7h8F/tyx1R1UXT/mEpVh8LSGAARifhj/TV6uffGEOH+mWQcOGcW2yuqVZZ4XQ0Uw@vger.kernel.org
X-Gm-Message-State: AOJu0YwWR6dndsf9waivawTY83vHAKP++pYOb5CphlMaJzLWnXI3cbCU
	REhPwY+niJk6+caVbyg98XMiLyI/ROuvsPz7pA6r2cUz+FCdO45IGuhwvTm+zTAKWqh2qniZyoo
	stf/oAHm5b7SCDsUkRhh17NwUKa0Bukin0wLFKw1q
X-Gm-Gg: AZuq6aIGRujXfNHwbjINf6wUZwAOY9+kiNq3yL+9qnh1DFAho+YdiGODyIcbR5eJX9R
	ym8x893wZDULfpANenl3L6FOkI6GTGEVVzwHkPWYLjrdJNdpqPSH1NHL3RJpQud2GehyITrKbXl
	LusjurlHMdsmz3H9MMMOmJe5lduLft8js+TRv0QvkE+Opq0CnwhfOdoS+SQDCsrJ/r0E4KxeZBe
	NnIQo50+KqFug5Eazb4Gx5ZiC+nuoV0setYWadD/pNbu0PEnwIZtZ4/lY36Jz20icsHLcU4gaMY
	xFijkhFkcZvnJWSKOf3UXTkZrg==
X-Received: by 2002:a05:6102:390c:b0:5db:e2c2:81a1 with SMTP id
 ada2fe7eead31-5f723765badmr2717805137.14.1769622647325; Wed, 28 Jan 2026
 09:50:47 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 09:50:46 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 09:50:46 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aW3kOgKL7TjpW4AT@yzhao56-desk.sh.intel.com>
References: <cover.1760731772.git.ackerleytng@google.com> <638600e19c6e23959bad60cf61582f387dff6445.1760731772.git.ackerleytng@google.com>
 <aW3kOgKL7TjpW4AT@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Jan 2026 09:50:46 -0800
X-Gm-Features: AZwV_QifG6FXcq-qNYCcE_MoQgt6DAo9uPq6fzN3xKHneI_AD0mm_Yxu6BjCe84
Message-ID: <CAEvNRgEjo5idG7OtMqHt+kCRCQnWjzWzQN7nwNGDExwmf4fyvA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/37] KVM: guest_memfd: Introduce per-gmem
 attributes, use to guard user mappings
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
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
	xiaoyao.li@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,linux.intel.com,alien8.de,intel.com,lwn.net,redhat.com,google.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,ziepe.ca,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,amd.com,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75783-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[96];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0FACCA7519
X-Rspamd-Action: no action

Yan Zhao <yan.y.zhao@intel.com> writes:

>
> [...snip...]
>
>
> So, it's possible for kvm_mem_is_private() to access invalid mtree data and hit
> the WARN_ON_ONCE() in kvm_gmem_get_attributes().
>
> I reported a similar error in [*].
>
> [*] https://lore.kernel.org/all/aIwD5kGbMibV7ksk@yzhao56-desk.sh.intel.com
>

Will add locking in the next revision. Thanks!

