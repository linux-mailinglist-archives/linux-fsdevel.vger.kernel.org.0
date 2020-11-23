Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941CB2C0777
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 13:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbgKWMlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 07:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgKWMlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:41:19 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B58FC061A4E
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 04:41:19 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id bj5so7966531plb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 04:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/P5N+aOgL+Wbp5LDW9WUHH3BDfKq+6QZULV8RGl/RI=;
        b=BlokZ/Pz5XeHpSjC+MSruML4P8RkddSgJRa8c6tIXeWoh16b9Wj6x87Q9DtCPdMwzV
         15wElAT5ukt5h5AZbTm433f/zV+j1s42ItZqY+ezTxmefPyn+cDUFO+938Y5fNBm6stH
         Y7PCY3iuT3vDa+XurhzV5FRb96TjlAX4yW/Y+L8PuG41s/L4qs6rhCsi2F7u7XmSzFG6
         RCTbIlXQYthfLHcvJ/vghfpwJJf2qQ3brYryXbJA7dVOUZQ/ColzuRCb9K1wZY+Rj88B
         2noNhzOhd4CjBMGVd5OyV/uudyuj5lq5gXHufcTlQPJr3TJ2ZqpGlY7hMLHOTUYbwb29
         IAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/P5N+aOgL+Wbp5LDW9WUHH3BDfKq+6QZULV8RGl/RI=;
        b=hSDTkWeMmPyem+0nOhEoHkR5B3HdEq/E3ErCmzibzugtPskeOQZ2lLO44jaH7b4CWy
         ASXe3xw1RCUt1K4hUjmZ9VbOTdr7pAkSCpPdq8HvfOjKubCrVUB0peWBFXidK3/HK5pH
         WMMYOj+4H3QA23qDsIHwUqIx3hlmkDlyRA2RCM/DRFBlzEjpfHAj+sdbiocaNLiQHOGJ
         tbjXzO/xl+ULka7RaIkaEzXTYpDIUWsmi1aWG9NeJbp3uDKpKmepR1HYgyEAz/DYSVRO
         rYIBxvlwyJKbdJgglbA+of4yH7sE06QzpjiFak+pDzu4w/HNzmIbh8NpbFz9DAu1Wg6L
         ZHfA==
X-Gm-Message-State: AOAM530uYLzVvS7FynjHvWdF/x7OsAbLajJaPzB2iYzrymj+fQ0qe/ff
        mQI0+ZEv+KmAVweige/Yulpvar53MCkFYaY+TUBcbg==
X-Google-Smtp-Source: ABdhPJz9qr7a0zkKVT9IfcMthloG1hw4ZSqZsLVrN/ctqcHYcVJjOjMVeC/6+5Fwvq+i7o9PgEnq9csgleUeS3Fpk10=
X-Received: by 2002:a17:902:76c8:b029:d9:d6c3:357d with SMTP id
 j8-20020a17090276c8b02900d9d6c3357dmr18683104plt.34.1606135278722; Mon, 23
 Nov 2020 04:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20201120131129.GO3200@dhcp22.suse.cz> <CAMZfGtWNDJWWTtpUDtngtgNiOoSd6sJpdAB6MnJW8KH0gePfYA@mail.gmail.com>
 <20201123074046.GB27488@dhcp22.suse.cz> <CAMZfGtV9WBu0OVi0fw4ab=t4zzY-uVn3amsa5ZHQhZBy88exFw@mail.gmail.com>
 <20201123094344.GG27488@dhcp22.suse.cz> <CAMZfGtUjsAKuQ_2NijKGPZYX7OBO_himtBDMKNkYb_0_o5CJGA@mail.gmail.com>
 <20201123104258.GJ27488@dhcp22.suse.cz> <CAMZfGtVzv0qPaK8GALaf8CiaPf2Z9+js24gFtFv5_RfhAyXaRA@mail.gmail.com>
 <20201123113208.GL27488@dhcp22.suse.cz> <CAMZfGtXUNXdqse-tsCFyqePJ65L-1EgkYW416+Hu+_6OVu7FjA@mail.gmail.com>
 <20201123121842.GM27488@dhcp22.suse.cz>
In-Reply-To: <20201123121842.GM27488@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 23 Nov 2020 20:40:40 +0800
Message-ID: <CAMZfGtVboaBuP_jYHeaQHwQ4gJoXuJC47g1UwTa+aUL4bqo=zw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 00/21] Free some vmemmap pages of
 hugetlb page
To:     Michal Hocko <mhocko@suse.com>
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
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 8:18 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 23-11-20 20:07:23, Muchun Song wrote:
> > On Mon, Nov 23, 2020 at 7:32 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > > > > > No I really mean that pfn_to_page will give you a struct page pointer
> > > > > > > from pages which you release from the vmemmap page tables. Those pages
> > > > > > > might get reused as soon sa they are freed to the page allocator.
> > > > > >
> > > > > > We will remap vmemmap pages 2-7 (virtual addresses) to page
> > > > > > frame 1. And then we free page frame 2-7 to the buddy allocator.
> > > > >
> > > > > And this doesn't really happen in an atomic fashion from the pfn walker
> > > > > POV, right? So it is very well possible that
> > > >
> > > > Yeah, you are right. But it may not be a problem for HugeTLB pages.
> > > > Because in most cases, we only read the tail struct page and get the
> > > > head struct page through compound_head() when the pfn is within
> > > > a HugeTLB range. Right?
> > >
> > > Many pfn walkers would encounter the head page first and then skip over
> > > the rest. Those should be reasonably safe. But there is no guarantee and
> > > the fact that you need a valid page->compound_head which might get
> > > scribbled over once you have the struct page makes this extremely
> > > subtle.
> >
> > In this patch series, we can guarantee that the page->compound_head
> > is always valid. Because we reuse the first tail page. Maybe you need to
> > look closer at this series. Thanks.
>
> I must be really terrible exaplaining my concern. Let me try one last
> time. It is really _irrelevant_ what you do with tail pages. The
> underlying problem is that you are changing struct pages under users
> without any synchronization. What used to be a valid struct page will
> turn into garbage as soon as you remap vmemmap page tables.

Thank you very much for your patient explanation. So if the pfn walkers
always try get the head struct page through compound_head() when it
encounter a tail struct page. There will be no concerns. Do you agree?

> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
