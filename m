Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5955FFD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 05:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfGEDpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 23:45:09 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:62601 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfGEDpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 23:45:09 -0400
X-Greylist: delayed 2301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jul 2019 23:45:06 EDT
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x653iqR6004354;
        Fri, 5 Jul 2019 12:44:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x653iqR6004354
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562298293;
        bh=gyzrOPyoHJn8yznucnkE9+HI+d/Euv7RRhUiRYloNpg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=weixmT2patvlVhyovm39f0moKzyl4KG1VA2BcgJkRwWJ15tUvC1Bp9y+wuMKOQeNj
         z+bkPo0OFREsK8gH74aSeihmevwMZRIfyN4rnydecjpp1cxAWls7GvHg2+kpI9KpYA
         zWbGOI/yuEbLDPBCln1ZdnD7IRoTWX2ytx+511B2VvbXXlRbqYTkmVqq34rYBU+B3n
         v+KfUbB2zTQuYq/do43ZrIac8mJbHfz1/hEIdtuoCyOmf9YM7rEHzfgm8nV0dE3ru2
         INzwKpsiSmlwPXheEoDogwnCczk9zvWrgSQRSQWdvT72RLf9Bb63pIcRxH5hRvB3Iq
         WJZw8mnQFO0mA==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id u124so2997692vsu.2;
        Thu, 04 Jul 2019 20:44:53 -0700 (PDT)
X-Gm-Message-State: APjAAAUGCyNFiKv1sEPk1tJiNgEkmoN7IihHck92ksAkqdpwu+Hc4qKG
        MRAgVXU0AfQRDE1LKd7z+8ScSPIXtcOYHi9nTJI=
X-Google-Smtp-Source: APXvYqxpP4MuQ7iqZIGkn/RtCeCHMzmWWGqt03RSBHVaQVqjSTFcyWuQuXXPfKQ8wISEjVRnZH9+UpCfJDH9DCoRV8I=
X-Received: by 2002:a67:d46:: with SMTP id 67mr791736vsn.181.1562298292360;
 Thu, 04 Jul 2019 20:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org>
 <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org> <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com>
 <CAK7LNASLfyreDPvNuL1svvHPC0woKnXO_bsNku4DMK6UNn4oHw@mail.gmail.com> <5e5353e2-bfab-5360-26b2-bf8c72ac7e70@infradead.org>
In-Reply-To: <5e5353e2-bfab-5360-26b2-bf8c72ac7e70@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 5 Jul 2019 12:44:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNATF+D5TgTZijG3EPBVON5NmN+JcwmCBvnvkMFyR+3wF2A@mail.gmail.com>
Message-ID: <CAK7LNATF+D5TgTZijG3EPBVON5NmN+JcwmCBvnvkMFyR+3wF2A@mail.gmail.com>
Subject: Re: mmotm 2019-07-04-15-01 uploaded (gpu/drm/i915/oa/)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 5, 2019 at 12:23 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 7/4/19 8:09 PM, Masahiro Yamada wrote:
> > On Fri, Jul 5, 2019 at 12:05 PM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >>
> >> On Fri, Jul 5, 2019 at 10:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>>
> >>> On 7/4/19 3:01 PM, akpm@linux-foundation.org wrote:
> >>>> The mm-of-the-moment snapshot 2019-07-04-15-01 has been uploaded to
> >>>>
> >>>>    http://www.ozlabs.org/~akpm/mmotm/
> >>>>
> >>>> mmotm-readme.txt says
> >>>>
> >>>> README for mm-of-the-moment:
> >>>>
> >>>> http://www.ozlabs.org/~akpm/mmotm/
> >>>
> >>> I get a lot of these but don't see/know what causes them:
> >>>
> >>> ../scripts/Makefile.build:42: ../drivers/gpu/drm/i915/oa/Makefile: No such file or directory
> >>> make[6]: *** No rule to make target '../drivers/gpu/drm/i915/oa/Makefile'.  Stop.
> >>> ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915/oa' failed
> >>> make[5]: *** [drivers/gpu/drm/i915/oa] Error 2
> >>> ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915' failed
> >>>
> >>
> >> I checked next-20190704 tag.
> >>
> >> I see the empty file
> >> drivers/gpu/drm/i915/oa/Makefile
> >>
> >> Did someone delete it?
> >>
> >
> >
> > I think "obj-y += oa/"
> > in drivers/gpu/drm/i915/Makefile
> > is redundant.
>
> Thanks.  It seems to be working after deleting that line.


Could you check whether or not
drivers/gpu/drm/i915/oa/Makefile exists in your source tree?

Your build log says it was missing.

But, commit 5ed7a0cf3394 ("drm/i915: Move OA files to separate folder")
added it.  (It is just an empty file)

I am just wondering why.


-- 
Best Regards
Masahiro Yamada
