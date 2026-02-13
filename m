Return-Path: <linux-fsdevel+bounces-77132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGW+CosHj2maHQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:14:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4D3135987
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D133317CC89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC5235970E;
	Fri, 13 Feb 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="anFUloTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C2354AE2;
	Fri, 13 Feb 2026 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980573; cv=none; b=J6DyT5YwAHSzuO5F0wAJDQUDnL5i1J0EcYrhWFOe1AGrsEXoD9mGCxNQTuOUZlt49W94ku2F2bmIShIcjYGZH3lB8zZy0S3o+sdQD+Ou9Ry7LPrR/WsnsS/umtXT0VrFt3K18hiSU3emT31AbYMVOwuN4rVNvYwxTo5YtWIDyJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980573; c=relaxed/simple;
	bh=UaoXLDuKM7W4LVs2b+N6DWDNPZ7brGJ4dmoEN3+mt3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBVSxtlh7EPIWFMEP2l0XdgLvzgJ5cj3MqyBREs5OB67LNa2l37zOdQnlANXyd4QphS9kSXDgQcZWoK84Jh1vbfIQo3qb0cCFlB7o2I2bQ3lsKXyMVJ2dkHPQjBPGKrrh8daUu60i1KeETKaIa572jp5NtOaut24YSsh7pGIrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=anFUloTR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gGY9mjNmnYiEGqmmSKnj+anrGWP6cFH8GMKxfF8SvcI=; b=anFUloTR5e87QUrovEFgzRlF3N
	Bq0w6Vgz4WwzBvkH/RITWQQJGLciH8j9utNJjniRskXcA2/WRSaUphtk80EuMiQnft0qc/TqP7wrU
	NVgzxh34jK1COkrSmEcZmG4hNYDNie5hjbV5ppNHzCqajhg8yEMexyPS63MjfJ48wnR2txEYGyaWb
	R6UVmqfpGFTaQ857oPuRVhHc/ssfpkafSr/xecuIlZTYzVU0oEizM3epsnwIYSP4GdaP9rsLXZLOX
	cZqaBCdef/VRyTHXhRBjH4xtBCaMjreMqgv1pIKwKfyn6edQbH0oCjtYuOI9CIW0UH9+y/QN9pERM
	APfe3wEA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqqwX-0000000C7oQ-2xs7;
	Fri, 13 Feb 2026 11:02:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1DC173007B5; Fri, 13 Feb 2026 12:02:37 +0100 (CET)
Date: Fri, 13 Feb 2026 12:02:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Brauner <christian@brauner.io>,
	Shuah Khan <shuah@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
	seanjc@google.com
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <20260213110237.GC3031506@noisy.programming.kicks-ass.net>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>
 <20250501114235.GP4198@noisy.programming.kicks-ass.net>
 <20250501124646.GC4356@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501124646.GC4356@noisy.programming.kicks-ass.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77132-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linuxfoundation.org,brauner.io,kernel.org,google.com,suse.cz,gmail.com,vger.kernel.org,kvack.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,noisy.programming.kicks-ass.net:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 8D4D3135987
X-Rspamd-Action: no action

On Thu, May 01, 2025 at 02:46:46PM +0200, Peter Zijlstra wrote:
> On Thu, May 01, 2025 at 01:42:35PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 16, 2024 at 07:14:34PM -0700, John Hubbard wrote:
> > > On 10/16/24 3:06 PM, Lorenzo Stoakes wrote:
> > > > On Wed, Oct 16, 2024 at 02:00:27PM -0600, Shuah Khan wrote:
> > > > > On 10/16/24 04:20, Lorenzo Stoakes wrote:
> > > ...
> > > > > > diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> > > > > > index 88d6830ee004..1640b711889b 100644
> > > > > > --- a/tools/testing/selftests/pidfd/pidfd.h
> > > > > > +++ b/tools/testing/selftests/pidfd/pidfd.h
> > > > > > @@ -50,6 +50,14 @@
> > > > > >    #define PIDFD_NONBLOCK O_NONBLOCK
> > > > > >    #endif
> > > > > > +/* System header file may not have this available. */
> > > > > > +#ifndef PIDFD_SELF_THREAD
> > > > > > +#define PIDFD_SELF_THREAD -100
> > > > > > +#endif
> > > > > > +#ifndef PIDFD_SELF_THREAD_GROUP
> > > > > > +#define PIDFD_SELF_THREAD_GROUP -200
> > > > > > +#endif
> > > > > > +
> > > > > 
> > > > > As mentioned in my response to v1 patch:
> > > > > 
> > > > > kselftest has dependency on "make headers" and tests include
> > > > > headers from linux/ directory
> > > > 
> > > > Right but that assumes you install the kernel headers on the build system,
> > > > which is quite a painful thing to have to do when you are quickly iterating
> > > > on a qemu setup.
> > > > 
> > > > This is a use case I use all the time so not at all theoretical.
> > > > 
> > > 
> > > This is turning out to be a fairly typical reaction from kernel
> > > developers, when presented with the "you must first run make headers"
> > > requirement for kselftests.
> > > 
> > > Peter Zijlstra's "NAK NAK NAK" response [1] last year was the most
> > > colorful, so I'll helpfully cite it here. :)
> > 
> > Let me re-try this.
> > 
> > This is driving me insane. I've spend the past _TWO_ days trying to
> > build KVM selftests and I'm still failing.
> > 
> > This is absolute atrocious crap and is costing me valuable time.
> > 
> > Please fix this fucking selftests shit to just build. This is unusable
> > garbage.
> 
> So after spending more time trying to remember how to debug Makefiles (I
> hate my life), I found that not only do I need this headers shit, the
> kvm selftests Makefile is actively broken if you use: make O=foo
> 
> -INSTALL_HDR_PATH = $(top_srcdir)/usr
> +INSTALL_HDR_PATH = $(top_srcdir)/$(O)/usr
> 
> 
> And then finally, I can do:
> 
> make O=foo headers_install
> make O=foo -C tools/testing/selftests/kvm/
> 
> So yeah, thank you very much for wasting my time *AGAIN*.

And *AGAIN*.. this is still the state of things. Selftests are still
hopelessly broken and useless.

Maybe we should just delete the lot?

