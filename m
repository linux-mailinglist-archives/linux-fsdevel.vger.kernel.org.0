Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A3F30492F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbhAZFab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732421AbhAZCqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:46:47 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4972EC06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 18:46:07 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p18so10490405pgm.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 18:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWGZswVflRpHTssK7VvTt7HKTpyszr8rzXo8cgMjsjA=;
        b=UhhxZJLv7oppd27QQQf7NmOdXXi/dtkkLvnyAZonNWeNR4BFCWJVnaN2I1jqFVdYPu
         +AKS5xYuMabNbOKh7OtTfUvr3YiOEmUsh8Q8XCwhUrxvwlv8cKnKTiUafwD1IOwrGE9b
         fSOJUxUVXSlDk8rIPcuKFrDwxsNICU6fuFQFwueejxSwIu48+/VELScVP+lHUGRyTo4C
         mhpu9rx18gQCr5iN1kZH24PA/xEDgJPNjUh3TmO73YKZjCv4o0NLJFZIrlAFsypF4FlY
         KFMaDVnD4R3srQhVo7Sujov8VSBcnOBkVc0lCcrKjqB2Q7nNgwX+DOicMk/J2FzHUBJC
         rTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWGZswVflRpHTssK7VvTt7HKTpyszr8rzXo8cgMjsjA=;
        b=CgCMKoBaJAidUeoLwK9iZQgO9XGKNOLX1B4G+ychVoahhd82xa3AvvfuBdZMchyW5y
         4KRmQLA4oyaI+DhAhvnTr2kKtwruz0ZkLGo0azOuhANawyTNyXB4ShXGnVO/boSov2q2
         dEqrU3OcCdLJmSG7h1QWbSz8lPvAK6vqwjM7xFPcf11sgyKKYCS/exFTfa/gg4jmReTO
         eDbp1TaNSK/Jzq1B5NFsdbpNL3iB791a033xCG1uf1YRmLO8MTUmdwwARNED1aPmE4ew
         /3QExwajIERsP8mw2brLcnQYkzOFLijHs+W+1uTWrr2Frdec1A91f22sfXAcLZ61MDS5
         fa5Q==
X-Gm-Message-State: AOAM53026rncBL0NVZl+Wg65l8vgrLRgGlzt3ru8uAwq8RYbY4L5Lesb
        0W3y7dnmTgYszPm7Ui19793g0U79cvZGFrL0xEMCRw==
X-Google-Smtp-Source: ABdhPJzJw/g9vq/ezd6LGNCYqQY7xJY3b/k9Wogea+ntQG37KA2GV//3WD/k9+DNv/VVGlGj2BQCiYKLx5n/xWQfUHc=
X-Received: by 2002:aa7:8ed2:0:b029:1b9:7c87:8f44 with SMTP id
 b18-20020aa78ed20000b02901b97c878f44mr3290964pfr.49.1611629166691; Mon, 25
 Jan 2021 18:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-3-songmuchun@bytedance.com> <472a58b9-12cb-3c3-d132-13dbae5174f0@google.com>
 <CAMZfGtUGT6UP3aBEGmMvahOu5akvqoVoiXQqQvAdY82P6VGiTg@mail.gmail.com>
 <eef4ff8b-f3e3-6ae0-bae8-243bd0c8add0@infradead.org> <CAMZfGtV5rcCq6EGFAG4joRfWht0=1WE6Oik7LgNUPr-_iNX4Xg@mail.gmail.com>
 <2d9bfd8d-a77f-6470-807c-1a71ffeac3ff@google.com>
In-Reply-To: <2d9bfd8d-a77f-6470-807c-1a71ffeac3ff@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 26 Jan 2021 10:45:30 +0800
Message-ID: <CAMZfGtWCy-krzL1ejOOq2rZQ3mPbBUSNqmQd-svABMKxE0FcsA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 02/12] mm: hugetlb: introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
To:     David Rientjes <rientjes@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 2:47 AM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 25 Jan 2021, Muchun Song wrote:
>
> > > >> I'm not sure I understand the rationale for providing this help text if
> > > >> this is def_bool depending on CONFIG_HUGETLB_PAGE.  Are you intending that
> > > >> this is actually configurable and we want to provide guidance to the admin
> > > >> on when to disable it (which it currently doesn't)?  If not, why have the
> > > >> help text?
> > > >
> > > > This is __not__ configurable. Seems like a comment to help others
> > > > understand this option. Like Randy said.
> > >
> > > Yes, it could be written with '#' (or "comment") comment syntax instead of as help text.
> >
> > Got it. I will update in the next version. Thanks.
> >
>
> I'm not sure that Kconfig is the right place to document functional
> behavior of the kernel, especially for non-configurable options.  Seems
> like this is already served by existing comments added by this patch
> series in the files where the description is helpful.

OK. So do you mean just remove the help text here?

Thanks.
