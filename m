Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42AB2D5BD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 14:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389230AbgLJNbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 08:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389212AbgLJNbJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:31:09 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162E0C06179C
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 05:30:29 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id y8so2764430plp.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 05:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlXbD+UEW4Nv5CZk4BO09R9ymA6io2nhExNKSLuSREQ=;
        b=XEetfo9+rdFZ5g2HSecX62Vb83yVOQ4YXuxvIr2WX+3p4DuQGaZU6eU8CUT1vg6+Mb
         m8jJJFkKTc7U0a/C0aZOxg5CoEh0eW3IEEMZyEdgKcdjNbMiWqS9tUO75mojAmglH13G
         xs6aqo8pMw6GyO36bz7qI1tSyUk6f49dHEVlQqqgZqxUPHX9MUWx+16CR8r36dhWyKvS
         IuPCk7YP6uXuQf6dWn59o73V2Sn7TMRIE6Vzd5YLhVTUknu6cvsJWwTU1l8JEOfybJqs
         JNdvkSIfHvqtGEHpXNKiwgSHVJdxvRk7Uoz7m04WOmHXVpcm5mwqAOX6J5BTRjpP6wvE
         A3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlXbD+UEW4Nv5CZk4BO09R9ymA6io2nhExNKSLuSREQ=;
        b=TliMVXdJ7e1mzEdjVSkSCS49SVxMHIBLFONYYbfDG59oNImUQdvzdbsDTalgySt8Zi
         2NpUlpBGxd62iL/38mOZd6Lpra5iCmVwRZ7FtKvih1dE6gA3QAwOPVzXZd3HL7rMyFLl
         Wcb7fkWqZuJW0MzHplpNsp1ZINQhE4kU8jxrQUuAmqwde1emynKDc0wLhfHTnb1ZDWyF
         Kr03Pwzamrw+P3qZXGYcCauP6Wyvpc5WdIGgop2A40qJiQzz8PqDn6cNGIsMmogCR/J7
         u0Rh2wzuZnosrL1GI3bvCJoswCxNhVb7qvV8BhdecjqkBMO+cR3W6Bw8mIDXQd3D0r49
         0s+w==
X-Gm-Message-State: AOAM531qmTchucFmezkwFsc0lqZXlRMSkyUP3dhAPuW7mEof2bf8ueJi
        Ld3Of6/3DsFMs7B1ON+I6iVuihG9BmWvhqeSn14N4g==
X-Google-Smtp-Source: ABdhPJyIxJlJPOzma7jwGPoMV3ur6Fu8hZQ/SgquqvsnBCzV9+EcBlQ5INuf2+vkcKklIzEA1H5DJlf1FTH47OaC8BE=
X-Received: by 2002:a17:902:ed0d:b029:da:c83b:5f40 with SMTP id
 b13-20020a170902ed0db02900dac83b5f40mr6598545pld.20.1607607028567; Thu, 10
 Dec 2020 05:30:28 -0800 (PST)
MIME-Version: 1.0
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-13-songmuchun@bytedance.com> <375d6bad6bb37e3626f71bfabc20b384@suse.de>
 <CAMZfGtUQOXmuRumv48MYGCYh_JZn4bMPPz8HW2ExgTPCfFMMnw@mail.gmail.com> <20201210131608.GA7811@localhost.localdomain>
In-Reply-To: <20201210131608.GA7811@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Dec 2020 21:29:51 +0800
Message-ID: <CAMZfGtX842XJC+C_OeptH4Ru_Q-qV1=5vCq_PgPJmuyTGKO_rg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 12/12] mm/hugetlb: Optimize the code
 with the help of the compiler
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 9:16 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 10, 2020 at 08:14:18PM +0800, Muchun Song wrote:
> > Yeah, you are right. But if we do this check can make the code simple.
> >
> > For example, here is a code snippet.
> >
> > void func(void)
> > {
> >         if (free_vmemmap_pages_per_hpage())
> >                 return;
> >         /* Do something */
> > }
> >
> > With this patch, the func will be optimized to null when is_power_of_2
> > returns false.
> >
> > void func(void)
> > {
> > }
> >
> > Without this patch, the compiler cannot do this optimization.
>
> Ok, I misread the changelog.
>
> So, then is_hugetlb_free_vmemmap_enabled, free_huge_page_vmemmap,
> free_vmemmap_pages_per_hpage and hugetlb_vmemmap_init are optimized
> out, right?

Yes, that's right. I have disassembled to make sure of this. Thanks.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
