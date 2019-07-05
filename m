Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D305FFA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 05:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfGEDJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 23:09:56 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:40556 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGEDJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 23:09:55 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x6539lW1011775;
        Fri, 5 Jul 2019 12:09:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x6539lW1011775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562296188;
        bh=wWYGFUb+P+k+0keFxKdK3YKZmXuC4tWs7ONW753LY34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GExcANG0Z97hoM5QYgPCfde3YccjeMehq5mCWvt/5h4kJNxx+OjGc61n7hj8dd2hg
         q87bAV+yWBT6/zOxz2WaYYAd53hzVNTHHnDjnWJzq5ZWDM8cAOwp/8HA+bDpjTiY0r
         VDumQ8H5Npn76tylIUohWQ01JaAgemwrwhpCVFcDQc4tKi4BWUSYjoBI0l93jza4F3
         HkViyfsUL8AxqBFNPOGmcy03qX+vI005RHQke68u/LaZpclB3KHq7DJKiWqTXOmsnM
         p543YvXKEKzyfH9KSIbWGLE9UVppdiHdRIu35XrHbhBD9eTwAafhzmU1c5ufWtaqQy
         KD+AOv6OL4WwQ==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id m8so2970945vsj.0;
        Thu, 04 Jul 2019 20:09:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWbxvOXeLxHlo+RSZzS+jPNj+/yHhV/dR/n/U50BzuaUhdYyw67
        1W3tkrAEN+nnFDqZfzewwsS6738dv2LEHZuBiG4=
X-Google-Smtp-Source: APXvYqw5G5WuXtiZ+BxbjorgiCdXG7sWfLwHDfJHFK2DwoaScCECOi9EMClzttvllquxBbPayOf6C0yRlBt7hXWgkXI=
X-Received: by 2002:a67:f495:: with SMTP id o21mr774753vsn.54.1562296187154;
 Thu, 04 Jul 2019 20:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org>
 <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org> <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com>
In-Reply-To: <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 5 Jul 2019 12:09:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNASLfyreDPvNuL1svvHPC0woKnXO_bsNku4DMK6UNn4oHw@mail.gmail.com>
Message-ID: <CAK7LNASLfyreDPvNuL1svvHPC0woKnXO_bsNku4DMK6UNn4oHw@mail.gmail.com>
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

On Fri, Jul 5, 2019 at 12:05 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Jul 5, 2019 at 10:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 7/4/19 3:01 PM, akpm@linux-foundation.org wrote:
> > > The mm-of-the-moment snapshot 2019-07-04-15-01 has been uploaded to
> > >
> > >    http://www.ozlabs.org/~akpm/mmotm/
> > >
> > > mmotm-readme.txt says
> > >
> > > README for mm-of-the-moment:
> > >
> > > http://www.ozlabs.org/~akpm/mmotm/
> >
> > I get a lot of these but don't see/know what causes them:
> >
> > ../scripts/Makefile.build:42: ../drivers/gpu/drm/i915/oa/Makefile: No such file or directory
> > make[6]: *** No rule to make target '../drivers/gpu/drm/i915/oa/Makefile'.  Stop.
> > ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915/oa' failed
> > make[5]: *** [drivers/gpu/drm/i915/oa] Error 2
> > ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915' failed
> >
>
> I checked next-20190704 tag.
>
> I see the empty file
> drivers/gpu/drm/i915/oa/Makefile
>
> Did someone delete it?
>


I think "obj-y += oa/"
in drivers/gpu/drm/i915/Makefile
is redundant.



-- 
Best Regards
Masahiro Yamada
