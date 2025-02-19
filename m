Return-Path: <linux-fsdevel+bounces-42115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6063FA3C85E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 20:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F9F1893CC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3007022A4E3;
	Wed, 19 Feb 2025 19:16:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40D22A4D0;
	Wed, 19 Feb 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992605; cv=none; b=nzjX7nfMGFb4E534XNZJrtMVV8MmWfWGQAKnnIpxY0WN2ohbf8ZWqltBM+YJA3cHuP2ENfivb/D5w6zPYfJbqGDEPPCbC/BVvQixf1fU3FYiYI+H3P6vFvSoI+t0z+nMZO89bsiSK4IPIURJ4JzxuXbD+SQL73G+sc9uqCaLd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992605; c=relaxed/simple;
	bh=Di8GzAOMyu209K+QXDGkxaslNjVdI8X3eZQ3Pss+aTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg4qQFgcAe40QzU0TotsH1oto+1n3wYm7Fo3VUxT4vrxZiYNEGBM3xCsOyg+CEYjaYLLBQN9xz7XPOvjHgq9Z8TeJ3IGyqEB6cvK5ZuZYZTWqNLAtIWUjLo5pUEDhrenuqJ9L6NHPXyaWeEME+GYvM9pqjlt7BllV7UWd/UY3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B914C4CED1;
	Wed, 19 Feb 2025 19:16:37 +0000 (UTC)
Date: Wed, 19 Feb 2025 19:16:35 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Herbert Xu <herbert@gondor.apana.org.au>, willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
Message-ID: <Z7YuE2rO5ikSeONy@arm.com>
References: <20250206155234.095034647@linuxfoundation.org>
 <CA+G9fYvKzV=jo9AmKH2tJeLr0W8xyjxuVO-P+ZEBdou6C=mKUw@mail.gmail.com>
 <CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com>
 <Z7Xj-zIe-Sa1syG7@arm.com>
 <Z7YSYArXkRFEy6FO@arm.com>
 <2025021959-koala-flypaper-1ad5@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025021959-koala-flypaper-1ad5@gregkh>

On Wed, Feb 19, 2025 at 07:09:26PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 19, 2025 at 05:18:24PM +0000, Catalin Marinas wrote:
> > The problem is in the arm64 arch_calc_vm_flag_bits() as it returns
> > VM_MTE_ALLOWED for any MAP_ANONYMOUS ignoring MAP_HUGETLB (it's been
> > doing this since day 1 of MTE). The implementation does handle the
> > hugetlb file mmap() correctly but not the MAP_ANONYMOUS case.
> > 
> > The fix would be something like below:
> > 
> > -----------------8<--------------------------
> > diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> > index 5966ee4a6154..8ff5d88c9f12 100644
> > --- a/arch/arm64/include/asm/mman.h
> > +++ b/arch/arm64/include/asm/mman.h
> > @@ -28,7 +28,8 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
> >  	 * backed by tags-capable memory. The vm_flags may be overridden by a
> >  	 * filesystem supporting MTE (RAM-based).
> >  	 */
> > -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
> > +	if (system_supports_mte() &&
> > +	    ((flags & MAP_ANONYMOUS) && !(flags & MAP_HUGETLB)))
> >  		return VM_MTE_ALLOWED;
> > 
> >  	return 0;
> > -------------------8<-----------------------
> > 
> > This fix won't make sense for mainline since it supports MAP_HUGETLB
> > already.
> > 
> > Greg, are you ok with a stable-only fix as above or you'd rather see the
> > full 25c17c4b55de ("hugetlb: arm64: add mte support") backported?
> 
> A stable-only fix for this is fine, thanks!  Can you send it with a
> changelog and I'll queue it up.  Does it also need to go to older
> kernels as well?

5.10, that's when we got MTE support in. There may be some slight
variations depending on how far 5baf8b037deb ("mm: refactor
arch_calc_vm_flag_bits() and arm64 MTE handling") got backported. This
goes together with deb0f6562884 ("mm/mmap: undo ->mmap() when
arch_validate_flags() fails"), so they may actually go all the way to
5.10.

I'll prepare the patches tomorrow, give them a try and send to stable.

Thanks.

-- 
Catalin

