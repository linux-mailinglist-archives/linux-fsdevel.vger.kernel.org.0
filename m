Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C10C37AF75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 21:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhEKTkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 15:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhEKTkL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 15:40:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60BBC061574;
        Tue, 11 May 2021 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=eNRIlQQZWCazYaxWhuouwitveyTw50B3VUes/EwHhZ4=; b=LiM+e93c7yw8r/CqMs2gl1vsos
        FdVU4ovs1ULs8DQN1XWcVtufZq+x54QB1kFCIFh6epSB3XjGfHIfbqmKbeqa1nKFnaAidCg93bW0v
        6MmN8neM8XMb13hF23AqHPw3PVxiavFLIeMsbOtZK4/gOtztq5H6yqumzFKoWk4hm9eLNw7Py6oom
        IWTpVXy+Q1DP6C6NmdfdGZp2rNaqBVjzSkZmhCcLNsAUDk8Qw/9dpWBZQInxVY0RULsWYqJ6eK6Ug
        rtyjiKE6D6Gbz1LhRugEgAHGRTqk1Bg/+87hPtf1mmM1SJ/1NCsIQ0BvvIEfay4nEHjaS6scmwAcf
        UfBHHgsw==;
Received: from [2601:1c0:6280:3f0:d7c4:8ab4:31d7:f0ba]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgYDf-009sZV-4j; Tue, 11 May 2021 19:39:03 +0000
Subject: Re: mmotm 2021-05-10-21-46 uploaded (mm/*)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
References: <20210511044719.tWGZA2U3A%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e50de603-ab1d-72f7-63f5-c1fc92c5c7be@infradead.org>
Date:   Tue, 11 May 2021 12:39:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210511044719.tWGZA2U3A%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/10/21 9:47 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-05-10-21-46 has been uploaded to
> 
>    https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.
> 
> 
> A full copy of the full kernel tree with the linux-next and mmotm patches
> already applied is available through git within an hour of the mmotm
> release.  Individual mmotm releases are tagged.  The master branch always
> points to the latest release, so it's constantly rebasing.
> 
> 	https://github.com/hnaz/linux-mm
> 
> The directory https://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
> contains daily snapshots of the -mm tree.  It is updated more frequently
> than mmotm, and is untested.
> 
> A git copy of this tree is also available at
> 
> 	https://github.com/hnaz/linux-mm


Lots of various mm/ build errors:

Many of:
In file included from ../arch/x86/kvm/../../../virt/kvm/kvm_main.c:47:0:
../include/linux/hugetlb.h:340:30: error: parameter 6 (‘mode’) has incomplete type
       enum mcopy_atomic_mode mode,
                              ^~~~
../include/linux/hugetlb.h:335:19: error: function declaration isn’t a prototype [-Werror=strict-prototypes]
 static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
                   ^~~~~~~~~~~~~~~~~~~~~~~~


Many of:
../mm/slab_common.c:754:8: error: array index in initializer exceeds array bounds
  .name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #__short_size, \
        ^
../mm/slab_common.c:766:2: note: in expansion of macro ‘INIT_KMALLOC_INFO’
  INIT_KMALLOC_INFO(0, 0),
  ^~~~~~~~~~~~~~~~~
../mm/slab_common.c:754:8: note: (near initialization for ‘kmalloc_info[0].name’)
  .name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #__short_size, \
        ^
../mm/slab_common.c:766:2: note: in expansion of macro ‘INIT_KMALLOC_INFO’
  INIT_KMALLOC_INFO(0, 0),
  ^~~~~~~~~~~~~~~~~

One of:
In file included from <command-line>:0:0:
In function ‘__mm_zero_struct_page.isra.96’,
    inlined from ‘__init_single_page.isra.97’ at ../mm/page_alloc.c:1494:2,
    inlined from ‘init_unavailable_range.isra.98’ at ../mm/page_alloc.c:6496:3:
./../include/linux/compiler_types.h:328:38: error: call to ‘__compiletime_assert_253’ declared with attribute error: BUILD_BUG_ON failed: sizeof(struct page) > 80
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
./../include/linux/compiler_types.h:309:4: note: in definition of macro ‘__compiletime_assert’
    prefix ## suffix();    \
    ^~~~~~
./../include/linux/compiler_types.h:328:2: note: in expansion of macro ‘_compiletime_assert’
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^~~~~~~~~~~~~~~~
../include/linux/mm.h:169:2: note: in expansion of macro ‘BUILD_BUG_ON’
  BUILD_BUG_ON(sizeof(struct page) > 80);
  ^~~~~~~~~~~~


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

