Return-Path: <linux-fsdevel+bounces-15925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8917E895D7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2892D1F22A1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA1C15D5C1;
	Tue,  2 Apr 2024 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gTy0/Pbl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489959B41;
	Tue,  2 Apr 2024 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089459; cv=none; b=KwXeMzgBkpVww9DT4WU5lePSWxW1uAclFc/kIdhc7iY3Ps5SVU1I/xK8E5xvVtXHOfAMnZJmPZlHNp2jjO4FS3ssf/Q4AMwYztx4JEiJIfi3QDIAY231VVvOdeT3080vajVnvmQRyDckWfsjkXGkNO9nObZck+w40JpVNRh4tn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089459; c=relaxed/simple;
	bh=xq9nXcZUAlc/GPdDT7gIdvCuYenRSDa751P5udpzDxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La9NZCBTRFctrG+MG18dbIaDVFskO3mNffwY2zH//eEbDRo9V4NT/Ytvo30NMKhFw+Uai7E10UohmL91PDTHCx5i4j07L7u2m/5ZtSbhWhKIWlF47GXYmZDmla0Ky7i4gV0G+u/mHOg/1iXoBwkxrC5A69jiGWZtFZ8z7p3i3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gTy0/Pbl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xnB1avgX5oYhv/BobRLvwdRAm589Rywg1Qy6e6rT4pk=; b=gTy0/Pbl0z04lfQPU5hkNC/rgi
	O60r72iJdqYy0sOpkpuWK8/MPG5vtGAnBX10ll9wLHJJ9kkkwDUmUSit0fHsdXX9CXkQhiqoqHaC7
	YAN4oKhDpt89mm/wazbUJGexk3PE+1ym0tH4mUCzcKCG18F93Km6a+OzVrvCOwiPg4dYiPalXet/7
	NlRPu1Dogbcuwo9NRyw7TEJCDDgYIYF3FYF7GmKltkEjyt8xDCW2HQ47uLvu8GbbfG/MVAGvpggAx
	X2EkOFj5FpdiKbFIjMWrYEWe6fARVwTkvOLgYIsPwCqR5eqfRKoP9GR5/1IeeTJkpZJ7pzvUIqE8+
	Y6y11YLA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rrkg1-004OzJ-1L;
	Tue, 02 Apr 2024 20:24:13 +0000
Date: Tue, 2 Apr 2024 21:24:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:misc.cmpxchg 4/8]
 arch/sparc/include/asm/cmpxchg_32.h:51:61: sparse: sparse: cast truncates
 bits from constant value (eb9f becomes 9f)
Message-ID: <20240402202413.GH538574@ZenIV>
References: <202404030332.d8MKrNbM-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404030332.d8MKrNbM-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 03, 2024 at 03:40:22AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git misc.cmpxchg
> head:   9e2f22ef1ae21b949a3903727d7e7cd5eb48810f
> commit: 1b2857f7277164d8bed4e831e3c3696572a51f0b [4/8] sparc32: add __cmpxchg_u{8,16}() and teach __cmpxchg() to handle those sizes
> config: sparc-randconfig-r132-20240403 (https://download.01.org/0day-ci/archive/20240403/202404030332.d8MKrNbM-lkp@intel.com/config)
> compiler: sparc-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20240403/202404030332.d8MKrNbM-lkp@intel.com/reproduce)


> sparse warnings: (new ones prefixed by >>)
>    kernel/bpf/helpers.c:2157:18: sparse: sparse: symbol 'bpf_task_release_dtor' was not declared. Should it be static?
>    kernel/bpf/helpers.c:2187:18: sparse: sparse: symbol 'bpf_cgroup_release_dtor' was not declared. Should it be static?
>    kernel/bpf/helpers.c: note: in included file (through arch/sparc/include/asm/cmpxchg.h, arch/sparc/include/asm/atomic_32.h, arch/sparc/include/asm/atomic.h, ...):
> >> arch/sparc/include/asm/cmpxchg_32.h:51:61: sparse: sparse: cast truncates bits from constant value (eb9f becomes 9f)
>    kernel/bpf/helpers.c: note: in included file (through include/linux/timer.h, include/linux/workqueue.h, include/linux/bpf.h):
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
>    kernel/bpf/helpers.c: note: in included file (through arch/sparc/include/asm/cmpxchg.h, arch/sparc/include/asm/atomic_32.h, arch/sparc/include/asm/atomic.h, ...):
> >> arch/sparc/include/asm/cmpxchg_32.h:51:61: sparse: sparse: cast truncates bits from constant value (eb9f becomes 9f)
>    kernel/bpf/helpers.c:2495:18: sparse: sparse: context imbalance in 'bpf_rcu_read_lock' - wrong count at exit
>    kernel/bpf/helpers.c:2500:18: sparse: sparse: context imbalance in 'bpf_rcu_read_unlock' - unexpected unlock
> 
> vim +51 arch/sparc/include/asm/cmpxchg_32.h
> 
>     44	
>     45	/* don't worry...optimizer will get rid of most of this */
>     46	static inline unsigned long
>     47	__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
>     48	{
>     49		switch (size) {
>     50		case 1:
>   > 51			return __cmpxchg_u8((u8 *)ptr, (u8)old, (u8)new_);
>     52		case 2:
>     53			return __cmpxchg_u16((u16 *)ptr, (u16)old, (u16)new_);
>     54		case 4:
>     55			return __cmpxchg_u32((u32 *)ptr, (u32)old, (u32)new_);
>     56		default:
>     57			__cmpxchg_called_with_bad_pointer();
>     58			break;
>     59		}
>     60		return old;
>     61	}

... and calls are cmpxchg(&node->owner, NULL, BPF_PTR_POISON).  IOW, that's
a false positive - size will be 4, not 1.

IMO it's a sparse bug; one way to work around that would've been

        return
                size == 1 ? __cmpxchg_u8(ptr, old, new_) :
                size == 2 ? __cmpxchg_u16(ptr, old, new_) :
                size == 4 ? __cmpxchg_u32(ptr, old, new_) :
                        (__cmpxchg_called_with_bad_pointer(), old);

instead of that switch - elimination of dead subexpressions *does* suppress
such warnings.  Elimination of dead branches doesn't...

