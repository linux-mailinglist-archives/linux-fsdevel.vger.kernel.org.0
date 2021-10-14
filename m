Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C0542D804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 13:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhJNLUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 07:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhJNLUt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:20:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA4AB610E7;
        Thu, 14 Oct 2021 11:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634210324;
        bh=SLr0/jv6gdtWNXdULnzwbvVH9uCEqgkqQDU4gwtod5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=H2VZuDdlLfkyAYzo2+JSrGx7SrkiaqN/r7ahAN5Xh2n3ZRiSbjcOIpHPHLrW/2wyk
         AoNAQmq0U2SY3XkeugiiY+My6cQkxwfXHae7NdcgwuN4eq64hL3S9DcgddO+h8O1x0
         V1LXHBKnZ1exGo0bmQKFHQLVIsdw3BU9PPK9QSh7dqSMptI3Z+tL0afEV0BkvgRfDQ
         Q/KJEgGnvcEYf7h0KA4n5musEP9BcYQ7j2rZoUIGqq1R2oDe7N3iMuyk4aK3y9ahgD
         jWOp7u5wGYBi+7L8jYpbhSsN7NTyODIn3E38VR7qEWWt1E969CL70Rk64AaY9hYsEO
         Yzncxab0+3R1A==
From:   SeongJae Park <sj@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        SeongJae Park <sj@kernel.org>
Subject: Re: mmotm 2021-10-13-19-52 uploaded (mm/damon/vaddr.c)
Date:   Thu, 14 Oct 2021 11:18:37 +0000
Message-Id: <20211014111837.5504-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <2232228f-573b-ac19-1cb0-88690fdf6177@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 13 Oct 2021 22:15:05 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> [-- Attachment #1: Type: text/plain, Size: 2271 bytes --]
> 
> On 10/13/21 7:52 PM, akpm@linux-foundation.org wrote:
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > https://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > https://ozlabs.org/~akpm/mmotm/series
> > 
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.
> 
> on i386:
> 
> In file included from ../include/linux/mm.h:33:0,
>                   from ../include/linux/kallsyms.h:13,
>                   from ../include/linux/bpf.h:20,
>                   from ../include/linux/bpf-cgroup.h:5,
>                   from ../include/linux/cgroup-defs.h:22,
>                   from ../include/linux/cgroup.h:28,
>                   from ../include/linux/hugetlb.h:9,
>                   from ../mm/damon/vaddr.c:11:
> ../mm/damon/vaddr.c: In function ‘damon_mkold_pmd_entry’:
> ../include/linux/pgtable.h:97:12: error: implicit declaration of function ‘kmap_atomic’; did you mean ‘mcopy_atomic’? [-Werror=implicit-function-declaration]
>    ((pte_t *)kmap_atomic(pmd_page(*(dir))) +  \
>              ^
> ../include/linux/mm.h:2376:17: note: in expansion of macro ‘pte_offset_map’
>    pte_t *__pte = pte_offset_map(pmd, address); \
>                   ^~~~~~~~~~~~~~
> ../mm/damon/vaddr.c:387:8: note: in expansion of macro ‘pte_offset_map_lock’
>    pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>          ^~~~~~~~~~~~~~~~~~~
> ../include/linux/pgtable.h:99:24: error: implicit declaration of function ‘kunmap_atomic’; did you mean ‘in_atomic’? [-Werror=implicit-function-declaration]
>   #define pte_unmap(pte) kunmap_atomic((pte))
>                          ^
> ../include/linux/mm.h:2384:2: note: in expansion of macro ‘pte_unmap’
>    pte_unmap(pte);     \
>    ^~~~~~~~~
> ../mm/damon/vaddr.c:392:2: note: in expansion of macro ‘pte_unmap_unlock’
>    pte_unmap_unlock(pte, ptl);
>    ^~~~~~~~~~~~~~~~
> 
> 
> Full randconfig file is attached.

Thank you for this report!

I sent a fix:
https://lore.kernel.org/linux-mm/20211014110848.5204-1-sj@kernel.org/

This was found and fixed by Andrew before, but I made this mistake again... :'(
To not repeat this again, I added a test for this case in DAMON correctness
tests: https://github.com/awslabs/damon-tests/commit/b3d1513ad16a


Thanks,
SJ

> 
> -- 
> ~Randy
