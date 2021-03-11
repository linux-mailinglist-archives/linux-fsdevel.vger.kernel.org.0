Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567ED336E21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 09:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhCKIqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 03:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhCKIq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:46:29 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1348C061762
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Mar 2021 00:46:28 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id x29so13242733pgk.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Mar 2021 00:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cQx/Zk70+m6LOsndOKLwPgVvEXoFZWWNDN7Tc+66h78=;
        b=d5ZOzK0nHfiuWFgsYpozB26n2SNLgu+yC+cyMbLJskAa4uat6g2X7ZqzHq3MPzJkqT
         e2EeCNXm48n2JGpBerR8kVEVlvjHVLj2cIpMFh2z9BIC+yQpRZzFcWfa5p5RF+Coj8z3
         AdKrqpImJC5chGGGPbL0t4QjWFC13Y27lJvZ3x107SX7Uq6cE7Ao0/WkX5EjePrutbnD
         HRvbrEiVa5H4a2RLFhQ0SPgGj02m2BvYCSW1GdfChG78rbnzWdwpmOpUbjQMvbja7gTy
         NNTD6eQ6jEKoYCjDzGXv3JAQas4n8S7WxpjA5BPhKvy4EUFsH6oCrU4VsIfvVty8/8wt
         M43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQx/Zk70+m6LOsndOKLwPgVvEXoFZWWNDN7Tc+66h78=;
        b=Yl3Idk8pk7zK43ztNDegk+cm5LRfrixBNEZdjgmiNwJb7PBHDAtzHiWoPNo2uKWP5F
         p1cLAx0OCR9S1i+b+V3S8GXKjcDZOS7JVkJtuTs/j67N6xlRbG4DAwLphT1gZNGT5fgp
         2HDtCytATaRDcjN7bM1YpVlIGlBNsM8s9A8fNEIA7VGyGv+JndrwgO4lInpMvmMPye+a
         ybTrW2MlOKNitK90NEkMQ6fi38oQRYqBc+06zJs3+xfTlKfpnlMJhJldSksDasNxtLMi
         DYjPwh4mxfM+i2J2bpudsKnulsbf4C832HAvp+IV55LWEb/pt8smYa/48n7OzR4ri3LP
         DyGQ==
X-Gm-Message-State: AOAM531e5vA9W3vc2rwBvIHUoCf06AedKP5nOG9hiNXBLv/MFTyxxSfN
        kiTyjCaP92p+KliW6fZ4ssYXIHWA3tbPWz3t2Mg8+A==
X-Google-Smtp-Source: ABdhPJx8xoUZld8Sv1xB5EcygOS8Cx3xevOUQo1rIS2UOdYOWKLXng+0qazdq2+zuAO7Wv4IQBY5jVo18AZxOgHgpOo=
X-Received: by 2002:aa7:9614:0:b029:1fa:e77b:722 with SMTP id
 q20-20020aa796140000b02901fae77b0722mr6837612pfg.2.1615452388283; Thu, 11 Mar
 2021 00:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-2-songmuchun@bytedance.com> <YEjUYOIJb2kYoQIA@dhcp22.suse.cz>
 <CAMZfGtUj9vcVrSjT8Tk12jfkVE127Vkdkx6Js1JXzL+=rmu7Qw@mail.gmail.com>
In-Reply-To: <CAMZfGtUj9vcVrSjT8Tk12jfkVE127Vkdkx6Js1JXzL+=rmu7Qw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 16:45:51 +0800
Message-ID: <CAMZfGtX37yBkKJjmBBSBeDeVAM6XywAJuEXjTSm7apOmQ-FOxA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v18 1/9] mm: memory_hotplug: factor out
 bootmem core functions to bootmem_info.c
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:58 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Wed, Mar 10, 2021 at 10:14 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > [I am sorry for a late review]
>
> Thanks for your review.
>
> >
> > On Mon 08-03-21 18:27:59, Muchun Song wrote:
> > > Move bootmem info registration common API to individual bootmem_info.c.
> > > And we will use {get,put}_page_bootmem() to initialize the page for the
> > > vmemmap pages or free the vmemmap pages to buddy in the later patch.
> > > So move them out of CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code
> > > movement without any functional change.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> > > Tested-by: Chen Huang <chenhuang5@huawei.com>
> > > Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
> >
> > Separation from memory_hotplug.c is definitely a right step. I am
> > wondering about the config dependency though
> > [...]
> > > diff --git a/mm/Makefile b/mm/Makefile
> > > index 72227b24a616..daabf86d7da8 100644
> > > --- a/mm/Makefile
> > > +++ b/mm/Makefile
> > > @@ -83,6 +83,7 @@ obj-$(CONFIG_SLUB) += slub.o
> > >  obj-$(CONFIG_KASAN)  += kasan/
> > >  obj-$(CONFIG_KFENCE) += kfence/
> > >  obj-$(CONFIG_FAILSLAB) += failslab.o
> > > +obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
> >
> > I would have expected this would depend on CONFIG_SPARSE.
> > BOOTMEM_INFO_NODE is really an odd thing to depend on here. There is
> > some functionality which requires the node info but that can be gated
> > specifically. Or what is the thinking behind?

I have tried this. And I find that it is better to depend on
BOOTMEM_INFO_NODE instead of SPARSEMEM.

If we enable SPARSEMEM but disable HAVE_BOOTMEM_INFO_NODE,
the bootmem_info.c also is compiled. Actually, we do not
need those functions on other architectures. And these
functions are also related to bootmem info. So it may be
more reasonable to depend on BOOTMEM_INFO_NODE.
Just my thoughts.

Thanks.


>
> At first my idea was to free vmemmap pages through the bootmem
> interface. My first instinct is to rely on BOOTMEM_INFO_NODE.
> It makes sense to me to depend on CONFIG_SPARSE. I will
> update this in the next version.
>
> Thanks.
>
> >
> > This doesn't matter right now because it seems that the *_page_bootmem
> > is only used by x86 outside of the memory hotplug.
> >
> > Other than that looks good to me.
> > --
> > Michal Hocko
> > SUSE Labs
