Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0367B31C16E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 19:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhBOSUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 13:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhBOSUi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:20:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB51C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 10:19:58 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id a9so2033890plh.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 10:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=USwR3sUAh3X/IQIe8yfKo61p7LMNkKqO4NUHOz8c8WU=;
        b=jyMGqHpGp1yPvi1APhdJZWbix/DfwuVSfSYSpVglMTqJ2ePgxDrDjxZantLX5K5tp9
         n7ZUC8D5N4xr1g3Mb5W+idJIfbZdmDnv9HC/eFjwlzHzN9A5DSjix6uCPcNJv8PjrwG+
         yLNqluW5wWq6fOIJFpBPFssdSRXJoD5bcidRkT2q8i6j7KrYu9pnJPo+T7oDX/zvATF6
         UVoIf8f1xGPUIvjYjzmpTGKAOmFzixi8lNF8bPLGwc2TDGHOWxWo4Ye3+FGNHu/+aBDg
         n1o7CTOEuUyFRXrOoRTr7DO/yUEjrwekxD8doXyuN3Kn/zyO0EZZuc7xLoIriak3o6oj
         2iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=USwR3sUAh3X/IQIe8yfKo61p7LMNkKqO4NUHOz8c8WU=;
        b=WvXqJfDEkNdGPNPmxaan/2KsIW95pTXE3g2odKrBe8FgfW0ZZ5Qy9OgV6QDyRJFEC6
         P0zt3rYHh2HWHAPVRXIr2ya4/9cS9cptOKlToI0YMk8IWmDME4EkYo3CKlt+xWq7kDrZ
         upbkHhBx8m2HDlFfiOC3DnFyRdE1Dxp0Mq06DY/DHzKrJ473jRhMqDgh2o6i6Vle8Kxd
         xp2q9c2lXwW5o9Jw+eMDMwvJSnkSocuJY92qEqHY8XhNTfOkcnJNNDbUbO92cQGePMDB
         qOTg1teDtxS9g9KVlmqq5UYrlLyyt6SPTlZDaDiS6t+DFTnaeeY9acb4OG3WA4qPDof8
         1MFA==
X-Gm-Message-State: AOAM532CM6T0Z6jR+/PS+APGHaLBGQsLu6obnz5EheF2WSneAp1EwIqL
        A8TrZqw+Em27nqDwoXBUtaVXM1Dcr/FNZ2U8FzCNJA==
X-Google-Smtp-Source: ABdhPJy/NfIbAZY8/WKidLiAfmiqQ4UOgwQAs69wL7Uen0KC9xCwXgsZkScddOlYw0iSM1IFQFbdq/LfWOFFCVgTyfY=
X-Received: by 2002:a17:90b:1096:: with SMTP id gj22mr109592pjb.229.1613413196531;
 Mon, 15 Feb 2021 10:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20210208085013.89436-5-songmuchun@bytedance.com>
 <YCafit5ruRJ+SL8I@dhcp22.suse.cz> <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
 <YCpN38i75olgispI@dhcp22.suse.cz> <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz> <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz> <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
 <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz> <CAMZfGtW6n_YUbZOPFbivzn-HP4Q2yi0DrUoQ3JAjSYy5m17VWw@mail.gmail.com>
In-Reply-To: <CAMZfGtW6n_YUbZOPFbivzn-HP4Q2yi0DrUoQ3JAjSYy5m17VWw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 16 Feb 2021 02:19:20 +0800
Message-ID: <CAMZfGtWVwEdBfiof3=wW2-FUN4PU-N5J=HfiAETVbwbEzdvAGQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
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
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 1:48 AM Muchun Song <songmuchun@bytedance.com> wrot=
e:
>
> On Tue, Feb 16, 2021 at 12:28 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 15-02-21 23:36:49, Muchun Song wrote:
> > [...]
> > > > There shouldn't be any real reason why the memory allocation for
> > > > vmemmaps, or handling vmemmap in general, has to be done from withi=
n the
> > > > hugetlb lock and therefore requiring a non-sleeping semantic. All t=
hat
> > > > can be deferred to a more relaxed context. If you want to make a
> > >
> > > Yeah, you are right. We can put the freeing hugetlb routine to a
> > > workqueue. Just like I do in the previous version (before v13) patch.
> > > I will pick up these patches.
> >
> > I haven't seen your v13 and I will unlikely have time to revisit that
> > version. I just wanted to point out that the actual allocation doesn't
> > have to happen from under the spinlock. There are multiple ways to go
> > around that. Dropping the lock would be one of them. Preallocation
> > before the spin lock is taken is another. WQ is certainly an option but
> > I would take it as the last resort when other paths are not feasible.
> >
>
> "Dropping the lock" and "Preallocation before the spin lock" can limit
> the context of put_page to non-atomic context. I am not sure if there
> is a page puted somewhere under an atomic context. e.g. compaction.
> I am not an expert on this.

Using GFP_KERNEL will also use the current task cpuset to allocate
memory. Do we have an interface to ignore current task cpuset=EF=BC=9FIf no=
t,
WQ may be the only option and it also will not limit the context of
put_page. Right?

>
> > --
> > Michal Hocko
> > SUSE Labs
