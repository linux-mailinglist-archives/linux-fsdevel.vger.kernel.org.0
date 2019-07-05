Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5B55FFAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 05:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfGEDOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 23:14:22 -0400
Received: from condef-02.nifty.com ([202.248.20.67]:54465 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGEDOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 23:14:22 -0400
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-02.nifty.com with ESMTP id x6536lQT007502;
        Fri, 5 Jul 2019 12:06:47 +0900
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x6536QDq030981;
        Fri, 5 Jul 2019 12:06:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x6536QDq030981
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562295987;
        bh=PUF8lDa4vdReIoKmN9yFODRcREJp8yLKeKn0eH+L6bE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hc5L71DyP571OH1ILbrgsHHQpZxhkuz18yBJhiWyhTAww3ze+ztOro/wGz1TDYFUE
         /Si8hBWyn/V+Wg7PcYBWYxq1n2b2lpdpZvozLTunEj/uzkQ6RFOunckU0TuUzz9m2O
         RXMPcf27hMNI6zqtIhJMXDYJTJ3SOPQKOXPt5xrHNYe/6sLud/g+w7+4NbpxrT/Grd
         8MDTyD1iqfPBs9CuK/ynHGls1pUT/6NeGMZXtHG9zbpUfsfYbzST09seR6N/R3uVix
         7kKWqrwbGRnDtZYlfOtqiGntTGk7sXKjNMyFI00Ibkod/cTVCg9158ANjrjUuw9/GO
         cblKP9Jp4wGZg==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id m17so928117vkl.2;
        Thu, 04 Jul 2019 20:06:26 -0700 (PDT)
X-Gm-Message-State: APjAAAU17ju3mm7hjXpDiz3pGo9cKFRt36qoDYtim3S0HzvvYNMhJO2a
        Bpgq0CHDmEABnC9r364BJ/FJekSY1Fu+MN8PelU=
X-Google-Smtp-Source: APXvYqx1fdfrytc0sWZZM6lY9Xdz+SAPqK6SCnajdY9dWkz6Qp9Uyw0DqKq3G8QmllDHQmgVXa6JS9tx5ersEEn+inM=
X-Received: by 2002:a1f:728b:: with SMTP id n133mr313496vkc.84.1562295985842;
 Thu, 04 Jul 2019 20:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org> <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org>
In-Reply-To: <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 5 Jul 2019 12:05:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com>
Message-ID: <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com>
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

On Fri, Jul 5, 2019 at 10:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 7/4/19 3:01 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2019-07-04-15-01 has been uploaded to
> >
> >    http://www.ozlabs.org/~akpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > http://www.ozlabs.org/~akpm/mmotm/
>
> I get a lot of these but don't see/know what causes them:
>
> ../scripts/Makefile.build:42: ../drivers/gpu/drm/i915/oa/Makefile: No such file or directory
> make[6]: *** No rule to make target '../drivers/gpu/drm/i915/oa/Makefile'.  Stop.
> ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915/oa' failed
> make[5]: *** [drivers/gpu/drm/i915/oa] Error 2
> ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915' failed
>

I checked next-20190704 tag.

I see the empty file
drivers/gpu/drm/i915/oa/Makefile

Did someone delete it?


-- 
Best Regards
Masahiro Yamada
