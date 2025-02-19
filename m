Return-Path: <linux-fsdevel+bounces-42073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7520A3C0E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 15:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FA87A7203
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983891EEA2C;
	Wed, 19 Feb 2025 14:00:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182781E1A3B;
	Wed, 19 Feb 2025 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973636; cv=none; b=fN60iAVogz15l9nFLg04/CIrRDOsYUBd/WGEQMCHL5csu9tRYg1baJ1iUxDD+nkOUnNMVZ5eMmcnSqhH8k/0P0CiESqsLM3JpkSS52WxMEBHa1RHZRsWu8rO1QyjYnQXOACZbiyZ0NBF4077yabm+G9vXB7Uo3tW4oPQJsW3xGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973636; c=relaxed/simple;
	bh=X+M3x8vareZ1kGwEPWZ3GJcEu+0g9qcC+YP820OHeSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdJnZu0djCyCsV5qbTbTWtyRNZyTcjcbyL1VAOyaF9nbvBSXaKoFJOE1aSDFzJqQIx6r3ew/RNZFm7CGUFBqrp4HFmtIu0z7ZasToxsXB6X+b9oWV8AlSgX5ICdZkR+MZDHl/A4r/bbmZVSDcaJ02r0USR4DSL30JhvOJqNUD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8DAC4CED1;
	Wed, 19 Feb 2025 14:00:30 +0000 (UTC)
Date: Wed, 19 Feb 2025 14:00:27 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
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
Message-ID: <Z7Xj-zIe-Sa1syG7@arm.com>
References: <20250206155234.095034647@linuxfoundation.org>
 <CA+G9fYvKzV=jo9AmKH2tJeLr0W8xyjxuVO-P+ZEBdou6C=mKUw@mail.gmail.com>
 <CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com>

On Mon, Feb 17, 2025 at 05:00:43PM +0530, Naresh Kamboju wrote:
> On Sat, 8 Feb 2025 at 16:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
[...]
> We observed a kernel warning on QEMU-ARM64 and FVP while running the
> newly added selftest: arm64: check_hugetlb_options. This issue appears
> on 6.6.76 onward and 6.12.13 onward, as reported in the stable review [1].
> However, the test case passes successfully on stable 6.13.
> 
> The selftests: arm64: check_hugetlb_options test was introduced following
> the recent upgrade of kselftest test sources to the stable 6.13 branch.
> As you are aware, LKFT runs the latest kselftest sources (from stable
> 6.13.x) on 6.12.x, 6.6.x, and older kernels for validation purposes.
> 
> From Anders' bisection results, we identified that the missing patch on
> 6.12 is likely causing this regression:
> 
> First fixed commit:
> [25c17c4b55def92a01e3eecc9c775a6ee25ca20f]
> hugetlb: arm64: add MTE support

I wouldn't backport this and it's definitely not a fix for the problem
reported.

> Could you confirm whether this patch is eligible for backporting to
> 6.12 and 6.6 kernels?
> If backporting is not an option, we will need to skip running this
> test case on older kernels.
> 
> > 1)
> > Regression on qemu-arm64 and FVP noticed this kernel warning running
> > selftests: arm64: check_hugetlb_options test case on 6.6.76-rc1 and
> > 6.6.76-rc2.
> >
> > Test regression: WARNING-arch-arm64-mm-copypage-copy_highpage
> >
> > ------------[ cut here ]------------
> > [   96.920028] WARNING: CPU: 1 PID: 3611 at
> > arch/arm64/mm/copypage.c:29 copy_highpage
> > (arch/arm64/include/asm/mte.h:87)
> > [   96.922100] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
> > sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
> > [   96.925603] CPU: 1 PID: 3611 Comm: check_hugetlb_o Not tainted 6.6.76-rc2 #1
> > [   96.926956] Hardware name: linux,dummy-virt (DT)
> > [   96.927695] pstate: 43402009 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> > [   96.928687] pc : copy_highpage (arch/arm64/include/asm/mte.h:87)
> > [   96.929037] lr : copy_highpage
> > (arch/arm64/include/asm/alternative-macros.h:232
> > arch/arm64/include/asm/cpufeature.h:443
> > arch/arm64/include/asm/cpufeature.h:504
> > arch/arm64/include/asm/cpufeature.h:814 arch/arm64/mm/copypage.c:27)
> > [   96.929399] sp : ffff800088aa3ab0
> > [   96.930232] x29: ffff800088aa3ab0 x28: 00000000000001ff x27: 0000000000000000
> > [   96.930784] x26: 0000000000000000 x25: 0000ffff9b800000 x24: 0000ffff9b9ff000
> > [   96.931402] x23: fffffc0003257fc0 x22: ffff0000c95ff000 x21: ffff0000c93ff000
> > [   96.932054] x20: fffffc0003257fc0 x19: fffffc000324ffc0 x18: 0000ffff9b800000
> > [   96.933357] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > [   96.934091] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > [   96.935095] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> > [   96.935982] x8 : 0bfffc0001800000 x7 : 0000000000000000 x6 : 0000000000000000
> > [   96.936536] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > [   96.937089] x2 : 0000000000000000 x1 : ffff0000c9600000 x0 : ffff0000c9400080
> > [   96.939431] Call trace:
> > [   96.939920] copy_highpage (arch/arm64/include/asm/mte.h:87)
> > [   96.940443] copy_user_highpage (arch/arm64/mm/copypage.c:40)
> > [   96.940963] copy_user_large_folio (mm/memory.c:5977 mm/memory.c:6109)
> > [   96.941535] hugetlb_wp (mm/hugetlb.c:5701)
> > [   96.941948] hugetlb_fault (mm/hugetlb.c:6237)
> > [   96.942344] handle_mm_fault (mm/memory.c:5330)
> > [   96.942794] do_page_fault (arch/arm64/mm/fault.c:513
> > arch/arm64/mm/fault.c:626)
> > [   96.943341] do_mem_abort (arch/arm64/mm/fault.c:846)
> > [   96.943797] el0_da (arch/arm64/kernel/entry-common.c:133
> > arch/arm64/kernel/entry-common.c:144
> > arch/arm64/kernel/entry-common.c:547)
> > [   96.944229] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:0)
> > [   96.944765] el0t_64_sync (arch/arm64/kernel/entry.S:599)
> > [   96.945383] ---[ end trace 0000000000000000 ]---

Prior to commit 25c17c4b55de ("hugetlb: arm64: add mte support"), there
was no hugetlb support with MTE, so the above code path should not
happen - it seems to get a PROT_MTE hugetlb page which should have been
prevented by arch_validate_flags(). Or something else corrupts the page
flags and we end up with some random PG_mte_tagged set.

Does this happen with vanilla 6.6? I wonder whether we always had this
issue, only that we haven't noticed until the hugetlb MTE kselftest.
There were some backports in this area but I don't see how they would
have caused this.

-- 
Catalin

