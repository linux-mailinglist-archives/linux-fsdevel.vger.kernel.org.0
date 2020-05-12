Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B741CF8A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 17:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgELPMG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 11:12:06 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34124 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgELPMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 11:12:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id c12so17511131oic.1;
        Tue, 12 May 2020 08:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HzlyqNlSRCN2hpflyNPf3oc5CNOSPNV0Q0m7tMpCbzI=;
        b=fJcbu0BQuzEcnOtdzNiBYbyA4sWDft1nEIwiaXzlbnSJ4VGxRIi6UjcCr02OXTPSTa
         IwhPsUCkF7ZBd9/lP1vUYadDjo1RvcGz7lvrh0i57UjzLSLJppNCa0mH2kMv8pP5w+6s
         ZHkg/w45zAYGLfTWu2pg+cxgNq0Q4L5e66WhF+ClnGRqnRwWT78RjUBxWC5j1pa4e/CT
         jpl+5R8/c9MjghWeqTmMbYvWeIf9UHQADnMiPXWSPCcZPuh5wsjqpgHtPce5/uPU/Nru
         1guwi3z5kVMhZZwcULjzCppIBk9ldIcIdoggm6OyKJDEE3yfn/wsxzN2HWQnCO4oUW6f
         gvbw==
X-Gm-Message-State: AGi0PuZeHGSVnYQiamPJGuND8jVkICTAtNAEud1vT5W89TeQkFV4mzs1
        KaS4rmzdP4H1cVFa7BVOrIKvUFm8spH2CstmxEA=
X-Google-Smtp-Source: APiQypI8wlhO/mByPRRQWUkC2gMabCbPzFePjOCfbVR2cRo00ZIARfxutyIyWa6LKjtHIoxcreDrSMCgGeitz8vBDRI=
X-Received: by 2002:aca:895:: with SMTP id 143mr22811576oii.153.1589296324268;
 Tue, 12 May 2020 08:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200511224430.HDJjRC68z%akpm@linux-foundation.org> <3b612c3e-ce52-ba92-eb02-0fa7fd38819f@infradead.org>
In-Reply-To: <3b612c3e-ce52-ba92-eb02-0fa7fd38819f@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 May 2020 17:11:53 +0200
Message-ID: <CAMuHMdVuKaFW+0XXXSDCJHGpXNjirCTqzGbpiA5pP51OqtJN9A@mail.gmail.com>
Subject: Re: mmotm 2020-05-11-15-43 uploaded (mm/memcontrol.c, huge pages)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 6:44 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 5/11/20 3:44 PM, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2020-05-11-15-43 has been uploaded to
> >
> >    http://www.ozlabs.org/~akpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > http://www.ozlabs.org/~akpm/mmotm/
> >
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> >
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.
> >
> > This tree is partially included in linux-next.  To see which patches are
> > included in linux-next, consult the `series' file.  Only the patches
> > within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> > linux-next.
> >
> >
> > A full copy of the full kernel tree with the linux-next and mmotm patches
> > already applied is available through git within an hour of the mmotm
> > release.  Individual mmotm releases are tagged.  The master branch always
> > points to the latest release, so it's constantly rebasing.
> >
> >       https://github.com/hnaz/linux-mm
> >
> > The directory http://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
> > contains daily snapshots of the -mm tree.  It is updated more frequently
> > than mmotm, and is untested.
> >
> > A git copy of this tree is also available at
> >
> >       https://github.com/hnaz/linux-mm
>
> on x86_64:
>
> In file included from ../arch/x86/include/asm/atomic.h:5:0,
>                  from ../include/linux/atomic.h:7,
>                  from ../include/linux/page_counter.h:5,
>                  from ../mm/memcontrol.c:25:
> ../mm/memcontrol.c: In function ‘memcg_stat_show’:
> ../include/linux/compiler.h:394:38: error: call to ‘__compiletime_assert_383’ declared with attribute error: BUILD_BUG failed
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^
> ../include/linux/compiler.h:375:4: note: in definition of macro ‘__compiletime_assert’
>     prefix ## suffix();    \
>     ^~~~~~
> ../include/linux/compiler.h:394:2: note: in expansion of macro ‘_compiletime_assert’
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ^~~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                      ^~~~~~~~~~~~~~~~
> ../include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
>  #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>                             ^~~~~~~~~
> ../include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>  #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>                           ^~~~~~~~~~~~~~~
> ../include/linux/huge_mm.h:116:26: note: in expansion of macro ‘HPAGE_PMD_ORDER’
>  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>                           ^~~~~~~~~~~~~~~
> ../mm/memcontrol.c:3746:10: note: in expansion of macro ‘HPAGE_PMD_NR’
>     nr *= HPAGE_PMD_NR;
>           ^~~~~~~~~~~~
>   CC      arch/x86/kernel/jump_label.o
> ../mm/memcontrol.c: In function ‘memory_stat_format’:
> ../include/linux/compiler.h:394:38: error: call to ‘__compiletime_assert_356’ declared with attribute error: BUILD_BUG failed
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^
> ../include/linux/compiler.h:375:4: note: in definition of macro ‘__compiletime_assert’
>     prefix ## suffix();    \
>     ^~~~~~
> ../include/linux/compiler.h:394:2: note: in expansion of macro ‘_compiletime_assert’
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ^~~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                      ^~~~~~~~~~~~~~~~
> ../include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
>  #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>                             ^~~~~~~~~
> ../include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
>  #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>                           ^~~~~~~~~~~~~~~
> ../include/linux/huge_mm.h:116:26: note: in expansion of macro ‘HPAGE_PMD_ORDER’
>  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>                           ^~~~~~~~~~~~~~~
> ../mm/memcontrol.c:1405:10: note: in expansion of macro ‘HPAGE_PMD_NR’
>           HPAGE_PMD_NR * PAGE_SIZE);
>           ^~~~~~~~~~~~
>
>
>
> Full randconfig file is attached.
>
> This might be relevant to mm-memcontrol-switch-to-native-nr_anon_thps-counter.patch

noreply@ellerman.id.au pointed me to a similar failure for m68k/allmodconfig:
http://kisskb.ellerman.id.au/kisskb/buildresult/14236262/

I've bisected it to 157f1f1385447604 ("mm: memcontrol: switch to native
NR_ANON_THPS counter").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
