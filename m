Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517812BC463
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 08:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgKVHaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 02:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgKVHaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 02:30:20 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD9C0613D2
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2020 23:30:19 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so11268107pgg.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2020 23:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KYx1eNdrI2dF7Hg46yl8EzwrSDaEmC+lVYIEoOmHAZg=;
        b=MFWHJNoutPM2IP/2KjbFlh07dajFWsb4OR5iaq7tTrbrBiv1J9ipJHp7s2T+9CIqUs
         G4Q2B02f6N6HpHvCZmvqQtAhRbHzDe2c2HX8d6nn6lyr7MFldRlwe3VFc76kEzpEFnr3
         mR2UY7qxIURkaNtpi7Fe7OARFhB0wpuXwb9VXc6H0bou1ALOkYZ/uQGHUrupS9WLoMXf
         5M6BxjInvATYW4fpAAuOvy+LXdyMt/KH+73/AFs47qzgS0SKPax1Ibz9IUB95OlHmniq
         wWFiOvlDmmTkmoTGp/+lBpNToNGrirR0vKxUY6lW3s8vwZFHA4iDBaE97V8tnAi2klQb
         mBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KYx1eNdrI2dF7Hg46yl8EzwrSDaEmC+lVYIEoOmHAZg=;
        b=rpb1067GoZHmUdXxpWQy+tt6jmn1CdLLKcwV1fUd9CnCQ65jcArRrJOS4hesu1EqoJ
         SrTmmt6YCF6bOiHGRfU4FDqZRnKsGcrZkNxYpUNuZei16l71tcuIgJwskcDWjCekYeAe
         KxRCJ0oAdLmd++gqsqz1mZgI37vtGHg3Yz6ZfQjhpIkNhf7occkYogNmd4sTBrRFSxZJ
         FsxP17xR1uLUgcQGjCR+pXjrCngZyhJvAkWWhdzh4t1ZzVHa9HbsA5G3OjzDIPoB76/w
         vEFWaP7VJE2VN6DR2FgkD5Hd8DXIHz7IQhRD6ZfC324GiNmv7LJw7izYMLLCr9PP/CL0
         dWHw==
X-Gm-Message-State: AOAM531hC6YjC0098nw14i7CIMwSSOwQ0XZ8PrMyvvQ4zSpMdagHJC75
        qD0RfHiGt3PhqVY8Ka1GwO9/uYvSYxvNxuyseU9xfg==
X-Google-Smtp-Source: ABdhPJzwOPZM4fxIMmlJL214kfq5JIf5rNiHXammfFM4uFN7bttIzKgBVBMoHgWIZEjM9tTva2o+eVDdjfOFUivMjxk=
X-Received: by 2002:a17:90a:ae14:: with SMTP id t20mr19309393pjq.13.1606030219110;
 Sat, 21 Nov 2020 23:30:19 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz> <6b1533f7-69c6-6f19-fc93-c69750caaecc@redhat.com>
 <20201120093912.GM3200@dhcp22.suse.cz> <eda50930-05b5-0ad9-2985-8b6328f92cec@redhat.com>
 <55e53264-a07a-a3ec-4253-e72c718b4ee6@oracle.com>
In-Reply-To: <55e53264-a07a-a3ec-4253-e72c718b4ee6@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 22 Nov 2020 15:29:40 +0800
Message-ID: <CAMZfGtUSc6QNTy34U5GQgFMzJ6_pcYJUFZwy4hNexrGN0f0hKA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 00/21] Free some vmemmap pages of
 hugetlb page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 21, 2020 at 1:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrot=
e:
>
> On 11/20/20 1:43 AM, David Hildenbrand wrote:
> > On 20.11.20 10:39, Michal Hocko wrote:
> >> On Fri 20-11-20 10:27:05, David Hildenbrand wrote:
> >>> On 20.11.20 09:42, Michal Hocko wrote:
> >>>> On Fri 20-11-20 14:43:04, Muchun Song wrote:
> >>>> [...]
> >>>>
> >>>> Thanks for improving the cover letter and providing some numbers. I =
have
> >>>> only glanced through the patchset because I didn't really have more =
time
> >>>> to dive depply into them.
> >>>>
> >>>> Overall it looks promissing. To summarize. I would prefer to not hav=
e
> >>>> the feature enablement controlled by compile time option and the ker=
nel
> >>>> command line option should be opt-in. I also do not like that freein=
g
> >>>> the pool can trigger the oom killer or even shut the system down if =
no
> >>>> oom victim is eligible.
> >>>>
> >>>> One thing that I didn't really get to think hard about is what is th=
e
> >>>> effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
> >>>> invalid when racing with the split. How do we enforce that this won'=
t
> >>>> blow up?
> >>>
> >>> I have the same concerns - the sections are online the whole time and
> >>> anybody with pfn_to_online_page() can grab them
> >>>
> >>> I think we have similar issues with memory offlining when removing th=
e
> >>> vmemmap, it's just very hard to trigger and we can easily protect by
> >>> grabbing the memhotplug lock.
> >>
> >> I am not sure we can/want to span memory hotplug locking out to all pf=
n
> >> walkers. But you are right that the underlying problem is similar but
> >> much harder to trigger because vmemmaps are only removed when the
> >> physical memory is hotremoved and that happens very seldom. Maybe it
> >> will happen more with virtualization usecases. But this work makes it
> >> even more tricky. If a pfn walker races with a hotremove then it would
> >> just blow up when accessing the unmapped physical address space. For
> >> this feature a pfn walker would just grab a real struct page re-used f=
or
> >> some unpredictable use under its feet. Any failure would be silent and
> >> hard to debug.
> >
> > Right, we don't want the memory hotplug locking, thus discussions regar=
ding rcu. Luckily, for now I never saw a BUG report regarding this - maybe =
because the time between memory offlining (offline_pages()) and memory/vmem=
map getting removed (try_remove_memory()) is just too long. Someone would h=
ave to sleep after pfn_to_online_page() for quite a while to trigger it.
> >
> >>
> >> [...]
> >>> To keep things easy, maybe simply never allow to free these hugetlb p=
ages
> >>> again for now? If they were reserved during boot and the vmemmap cond=
ensed,
> >>> then just let them stick around for all eternity.
> >>
> >> Not sure I understand. Do you propose to only free those vmemmap pages
> >> when the pool is initialized during boot time and never allow to free
> >> them up? That would certainly make it safer and maybe even simpler wrt
> >> implementation.
> >
> > Exactly, let's keep it simple for now. I guess most use cases of this (=
virtualization, databases, ...) will allocate hugepages during boot and nev=
er free them.
>
> Not sure if I agree with that last statement.  Database and virtualizatio=
n
> use cases from my employer allocate allocate hugetlb pages after boot.  I=
t
> is shortly after boot, but still not from boot/kernel command line.
>
> Somewhat related, but not exactly addressing this issue ...
>
> One idea discussed in a previous patch set was to disable PMD/huge page
> mapping of vmemmap if this feature was enabled.  This would eliminate a b=
unch
> of the complex code doing page table manipulation.  It does not address
> the issue of struct page pages going away which is being discussed here,
> but it could be a way to simply the first version of this code.  If this
> is going to be an 'opt in' feature as previously suggested, then eliminat=
ing
> the  PMD/huge page vmemmap mapping may be acceptable.  My guess is that
> sysadmins would only 'opt in' if they expect most of system memory to be =
used
> by hugetlb pages.  We certainly have database and virtualization use case=
s
> where this is true.

Hi Mike,

Yeah, I agree with you that the first version of this feature should be
simply. I can do that (disable PMD/huge page mapping of vmemmap)
in the next version patch. But I have another question: what the
problem is when struct page pages go away? I have not understood
the issues discussed here, hope you can answer for me. Thanks.

> --
> Mike Kravetz



--=20
Yours,
Muchun
