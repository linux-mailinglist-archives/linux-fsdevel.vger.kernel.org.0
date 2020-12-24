Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C10B2E23D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Dec 2020 03:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgLXC5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 21:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgLXC5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 21:57:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF03C061794;
        Wed, 23 Dec 2020 18:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=dIwQE4jQabyjhn/YM3aRqfkeyXVYvLKSfSErZjaHO9Q=; b=eK6XaMoLi8imlzynTKzs8Brnip
        WMUL/CIkIj8vLY7ecKwEyV8amR56BkGGkCQS3ZwnwfNhSv2X0leRp8kqwP4ZDEkUSiQqvhFoGeyWl
        XyVus6TmzK77WIlS5rk2xBYXA2BWvoNJJiF9ols3bF+4YynJ/snMu4bLf3yzAUTfWZwObxOK4Ou2R
        Poi1zZj8ZmCiC7XvyyF+3K8QOarfugQ6mBtG41fzWm6Uauu/l+bVamU/8Hep6TqGOL44sN7pIaxwN
        wOdFxaaLmWs2plTw+DvrilDbiPNSrPwtM2DnWvivqv3qrjPaHqG/k9rAKVDekWB0DqYSL/dsNzczJ
        ILMQKWUA==;
Received: from [2601:1c0:6280:3f0::64ea]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ksGoH-0004tD-Gd; Thu, 24 Dec 2020 02:57:02 +0000
Subject: Re: mmotm 2020-12-23-16-15 uploaded (mm/vmstat.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Muchun Song <songmuchun@bytedance.com>
References: <20201224001635.5H0RjpkF_%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a7b46040-2980-c2f4-45ea-1fa38f36d351@infradead.org>
Date:   Wed, 23 Dec 2020 18:56:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201224001635.5H0RjpkF_%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/23/20 4:16 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-12-23-16-15 has been uploaded to
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

on i386 or UML on i386 or x86_64:
(and probably on x86_64, but my builds haven't got there yet)

when CONFIG_TRANSPARENT_HUGEPAGE is not set/enabled:

../mm/vmstat.c: In function ‘zoneinfo_show_print’:
./../include/linux/compiler_types.h:320:38: error: call to ‘__compiletime_assert_269’ declared with attribute error: BUILD_BUG failed
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
./../include/linux/compiler_types.h:301:4: note: in definition of macro ‘__compiletime_assert’
    prefix ## suffix();    \
    ^~~~~~
./../include/linux/compiler_types.h:320:2: note: in expansion of macro ‘_compiletime_assert’
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                     ^~~~~~~~~~~~~~~~
../include/linux/huge_mm.h:325:28: note: in expansion of macro ‘BUILD_BUG’
 #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
                            ^~~~~~~~~
../include/linux/huge_mm.h:106:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
 #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                          ^~~~~~~~~~~~~~~
../include/linux/huge_mm.h:107:26: note: in expansion of macro ‘HPAGE_PMD_ORDER’
 #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
                          ^~~~~~~~~~~~~~~
../mm/vmstat.c:1630:14: note: in expansion of macro ‘HPAGE_PMD_NR’
     pages /= HPAGE_PMD_NR;
              ^~~~~~~~~~~~
../mm/vmstat.c: In function ‘vmstat_start’:
./../include/linux/compiler_types.h:320:38: error: call to ‘__compiletime_assert_271’ declared with attribute error: BUILD_BUG failed
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
./../include/linux/compiler_types.h:301:4: note: in definition of macro ‘__compiletime_assert’
    prefix ## suffix();    \
    ^~~~~~
./../include/linux/compiler_types.h:320:2: note: in expansion of macro ‘_compiletime_assert’
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                     ^~~~~~~~~~~~~~~~
../include/linux/huge_mm.h:325:28: note: in expansion of macro ‘BUILD_BUG’
 #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
                            ^~~~~~~~~
../include/linux/huge_mm.h:106:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
 #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
                          ^~~~~~~~~~~~~~~
../include/linux/huge_mm.h:107:26: note: in expansion of macro ‘HPAGE_PMD_ORDER’
 #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
                          ^~~~~~~~~~~~~~~
../mm/vmstat.c:1755:12: note: in expansion of macro ‘HPAGE_PMD_NR’
    v[i] /= HPAGE_PMD_NR;
            ^~~~~~~~~~~~

due to <linux/huge_mm.h>:

#else /* CONFIG_TRANSPARENT_HUGEPAGE */
#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
#define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
#define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })

#define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
#define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
#define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })



>> mm-memcontrol-convert-nr_anon_thps-account-to-pages.patch

-- 
~Randy

