Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCABD77658
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 05:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfG0DmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 23:42:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51442 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfG0DmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 23:42:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so49474197wma.1;
        Fri, 26 Jul 2019 20:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GtjXx6dhxxQEndICY3GDSb8+k6lA9ea3LjN2zJWwnzw=;
        b=RfLhz37NwYURMNZm6MESuI2ly21oa335WCxlaJEWrFHbYc0IObYHRC+zVUlPL3Te85
         c1Hec55I65/nKVnJNmvqzHheAx41L9N4EVL7ZTXNQznol0E/Aw9fZOKKExDayHF04Dji
         P19z9PbxvvtV+PbOdAbDGowNLfw9z2J6anvsTegXymz5Mxi/uWLl/EMKjHW5uiDNUvF3
         Ug7n/NjwI16zia0RqdsoecdXvCe35FIRz7jNha1WBs52ICEF4kwLkaOKIPB/L7AZWbrj
         pJ2BEnRpmi9lh5FTaZvytr/nWVe3eiG2urR4oExRAfdalkkyByfZ+8VaVS+2mvGGsr2U
         NcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GtjXx6dhxxQEndICY3GDSb8+k6lA9ea3LjN2zJWwnzw=;
        b=ajr50UJJtCZEZaL+s2Ur1Zby0rEsZw7i7KvxrkN48Nhnuc16CAF8pqGlIg+MirHdPT
         pGU8ThZYBJgUZgJphyCpqILW/DyRDCc9SnTHPnAvTUs3RmI1q23K1RphgMPdIqjAZkRj
         T+RPppO9NDEsUelrAvJw9R2urfFimn0cCPwnF2rzCiMiltUiSJ3HkrTRGqrpq7jTDXA+
         /UjRR2jpWsXeyMRn8su08B8NzrwBshITGasgFnHvrVRowQoZaW/CZuAFpe1+tfU3uwVJ
         RXL8oWJ2z5OBr9DkXb8+jWbDhA2X2/WxQyQ4+3B0oNYsmZZp2Hamc9kxrtgvbtP1IJ4q
         mwTg==
X-Gm-Message-State: APjAAAWPq51dYtYgPjJ6VTbC+dMYmiLdb4tZNZQYwMbL1hq5wn6zGXqS
        OAgmdqjRzJnvA9ye20lNQQ4=
X-Google-Smtp-Source: APXvYqyz/Ub40MgewoA7607MxEBAulrgRZL1AzmGhSYaA5fhJQR+19oIcFOVwCyv2W9hcVfJuEBa/g==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr81602635wmc.110.1564198927977;
        Fri, 26 Jul 2019 20:42:07 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id a6sm40904454wmj.15.2019.07.26.20.42.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 20:42:07 -0700 (PDT)
Date:   Fri, 26 Jul 2019 20:42:05 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Chris Down <chris@chrisdown.name>
Subject: Re: mmotm 2019-07-24-21-39 uploaded (mm/memcontrol)
Message-ID: <20190727034205.GA10843@archlinux-threadripper>
References: <20190725044010.4tE0dhrji%akpm@linux-foundation.org>
 <4831a203-8853-27d7-1996-280d34ea824f@infradead.org>
 <20190725163959.3d759a7f37ba40bb7f75244e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725163959.3d759a7f37ba40bb7f75244e@linux-foundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 04:39:59PM -0700, Andrew Morton wrote:
> On Thu, 25 Jul 2019 15:02:59 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 7/24/19 9:40 PM, akpm@linux-foundation.org wrote:
> > > The mm-of-the-moment snapshot 2019-07-24-21-39 has been uploaded to
> > > 
> > >    http://www.ozlabs.org/~akpm/mmotm/
> > > 
> > > mmotm-readme.txt says
> > > 
> > > README for mm-of-the-moment:
> > > 
> > > http://www.ozlabs.org/~akpm/mmotm/
> > > 
> > > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > > more than once a week.
> > > 
> > > You will need quilt to apply these patches to the latest Linus release (5.x
> > > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > > http://ozlabs.org/~akpm/mmotm/series
> > > 
> > 
> > on i386:
> > 
> > ld: mm/memcontrol.o: in function `mem_cgroup_handle_over_high':
> > memcontrol.c:(.text+0x6235): undefined reference to `__udivdi3'
> 
> Thanks.  This?
> 
> --- a/mm/memcontrol.c~mm-throttle-allocators-when-failing-reclaim-over-memoryhigh-fix-fix
> +++ a/mm/memcontrol.c
> @@ -2414,8 +2414,9 @@ void mem_cgroup_handle_over_high(void)
>  	 */
>  	clamped_high = max(high, 1UL);
>  
> -	overage = ((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT)
> -		/ clamped_high;
> +	overage = (u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT;
> +	do_div(overage, clamped_high);
> +
>  	penalty_jiffies = ((u64)overage * overage * HZ)
>  		>> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHIFT);
>  
> _
> 

This causes a build error on arm:


In file included from ../arch/arm/include/asm/div64.h:127,
                 from ../include/linux/kernel.h:18,
                 from ../include/linux/page_counter.h:6,
                 from ../mm/memcontrol.c:25:
../mm/memcontrol.c: In function 'mem_cgroup_handle_over_high':
../include/asm-generic/div64.h:222:28: warning: comparison of distinct pointer types lacks a cast
  222 |  (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
      |                            ^~
../mm/memcontrol.c:2423:2: note: in expansion of macro 'do_div'
 2423 |  do_div(overage, clamped_high);
      |  ^~~~~~
In file included from ../arch/arm/include/asm/atomic.h:11,
                 from ../include/linux/atomic.h:7,
                 from ../include/linux/page_counter.h:5,
                 from ../mm/memcontrol.c:25:
../include/asm-generic/div64.h:235:25: warning: right shift count >= width of type [-Wshift-count-overflow]
  235 |  } else if (likely(((n) >> 32) == 0)) {  \
      |                         ^~
../include/linux/compiler.h:77:40: note: in definition of macro 'likely'
   77 | # define likely(x) __builtin_expect(!!(x), 1)
      |                                        ^
../mm/memcontrol.c:2423:2: note: in expansion of macro 'do_div'
 2423 |  do_div(overage, clamped_high);
      |  ^~~~~~
In file included from ../arch/arm/include/asm/div64.h:127,
                 from ../include/linux/kernel.h:18,
                 from ../include/linux/page_counter.h:6,
                 from ../mm/memcontrol.c:25:
../include/asm-generic/div64.h:239:22: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
  239 |   __rem = __div64_32(&(n), __base); \
      |                      ^~~~
      |                      |
      |                      long unsigned int *
../mm/memcontrol.c:2423:2: note: in expansion of macro 'do_div'
 2423 |  do_div(overage, clamped_high);
      |  ^~~~~~
In file included from ../include/linux/kernel.h:18,
                 from ../include/linux/page_counter.h:6,
                 from ../mm/memcontrol.c:25:
../arch/arm/include/asm/div64.h:33:45: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'long unsigned int *'
   33 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
      |                                   ~~~~~~~~~~^
cc1: some warnings being treated as errors
make[3]: *** [../scripts/Makefile.build:274: mm/memcontrol.o] Error 1
make[2]: *** [../Makefile:1768: mm/memcontrol.o] Error 2
make[1]: *** [/home/nathan/cbl/linux-next/Makefile:330: __build_one_by_one] Error 2
make: *** [Makefile:179: sub-make] Error 2


I fixed it up like so but no idea if that is the ideal function to use.


diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5c7b9facb0eb..04b621f1cb6b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2419,8 +2419,8 @@ void mem_cgroup_handle_over_high(void)
 	 */
 	clamped_high = max(high, 1UL);
 
-	overage = (u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT;
-	do_div(overage, clamped_high);
+	overage = div64_u64((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT,
+			    clamped_high);
 
 	penalty_jiffies = ((u64)overage * overage * HZ)
 		>> (MEMCG_DELAY_PRECISION_SHIFT + MEMCG_DELAY_SCALING_SHIFT);
