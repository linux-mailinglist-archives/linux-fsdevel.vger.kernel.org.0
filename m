Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC2E30FF0E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 22:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhBDVFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 16:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBDVFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:05:34 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D1FC061786
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Feb 2021 13:04:53 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id u20so4746808iot.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Feb 2021 13:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HV+XckACfIcg3AK8XMs4swxtJ4AOxuPntHPHEvQgCec=;
        b=MRyhbRM6BU3AS77iFkkM43ylujCLaUJw7P7Il4VpjWeXXFUAJlm1LlFOu+t8CIGDGW
         G9P+eZSb5AI5yesfmEtwXRkw37EX0TKqEnzJzyl2LG9UvqGyZoNwvpnxSp6RgfPJIVbu
         BGA696hiUIDHMfVSW3eFB492IUilDk41lwBCoLUbvUSIqE4DTHfNXcw08SpRGHebvpA3
         hNXNMw58fLGXk9SoWkurBKIWsIHHlH5A+jJvarPl2NmG10IdcZzdc9//uDeAFeI8cTAb
         3O8cSpz0J33qqvSd9tUBVkygCavLLArgZpSaX0gBSdzsuTBHrHLdUogRqAuDrq/msYN/
         PNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HV+XckACfIcg3AK8XMs4swxtJ4AOxuPntHPHEvQgCec=;
        b=m03mjrerNJszKmrWzLb08tq2hC0hoKrjS97CeznHWNeti268M0cr45CNGJ2qI6ddvG
         buQqGnFA23mhK8SZjCKGv1j3D3SZrvpP2O6iLbdRx5Dwqt0txJhnTv7XYUv2tmR/JZpL
         /5au3rEcoV7JECun9j9crBWXaOMYMTkJjpAEHSKw2mgniiHeKb5DVM9lJNXJvUet7yRC
         ERXIt/A51l48xXv/Wx1FvsjjeT8CNLGQeR7S+UysVJ2SqhqPli5YoQ3dHY3h9wrQ56gR
         uqDTCztGCCnWcY33SHduqZrCCG541gEfxV3qWGOPlEmpsli9rGyugfiq7cpA9F9DpW7f
         lIUg==
X-Gm-Message-State: AOAM531yP7V7oPu034nXbQDXFHuGQnd8ZAbOtTKNzPp4EeGlmytIanOC
        X55Ua9Bnzh4DgL1VzeiFrT1U1Q2crtEauDKZyz+yDQ==
X-Google-Smtp-Source: ABdhPJxobCaJMSVb4mOk5tvF3638jDck4qqF0l7JL/v+chy0r20HrFhvx/rYSTy2Zd33xcyWGup/NLsfDeE/wWYQ/lM=
X-Received: by 2002:a05:6638:164f:: with SMTP id a15mr1446296jat.75.1612472693282;
 Thu, 04 Feb 2021 13:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20210204183433.1431202-1-axelrasmussen@google.com>
 <20210204183433.1431202-10-axelrasmussen@google.com> <bb81e2b1-eb6b-0dfb-c2d6-82843d3750e7@infradead.org>
In-Reply-To: <bb81e2b1-eb6b-0dfb-c2d6-82843d3750e7@infradead.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 4 Feb 2021 13:04:16 -0800
Message-ID: <CAJHvVchiABBitTRkr4boSj7pkBN3_y7-1kLVxyhCo5w4m=PEEA@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] userfaultfd: update documentation to describe
 minor fault handling
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 4, 2021 at 11:57 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi Axel-
>
> one typo found:
>
> On 2/4/21 10:34 AM, Axel Rasmussen wrote:
> > Reword / reorganize things a little bit into "lists", so new features /
> > modes / ioctls can sort of just be appended.
>
> Good plan.
>
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  Documentation/admin-guide/mm/userfaultfd.rst | 107 ++++++++++++-------
> >  1 file changed, 66 insertions(+), 41 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> > index 65eefa66c0ba..cfd3daf59d0e 100644
> > --- a/Documentation/admin-guide/mm/userfaultfd.rst
> > +++ b/Documentation/admin-guide/mm/userfaultfd.rst
>
> [snip]
>
> > -
> > -Once the ``userfaultfd`` has been enabled the ``UFFDIO_REGISTER`` ioctl should
> > -be invoked (if present in the returned ``uffdio_api.ioctls`` bitmask) to
> > -register a memory range in the ``userfaultfd`` by setting the
> > +events, except page fault notifications, may be generated:
> > +
> > +- The ``UFFD_FEATURE_EVENT_*`` flags indicate that various other events
> > +  other than page faults are supported. These events are described in more
> > +  detail below in the `Non-cooperative userfaultfd`_ section.
> > +
> > +- ``UFFD_FEATURE_MISSING_HUGETLBFS`` and ``UFFD_FEATURE_MISSING_SHMEM``
> > +  indicate that the kernel supports ``UFFDIO_REGISTER_MODE_MISSING``
> > +  registrations for hugetlbfs and shared memory (covering all shmem APIs,
> > +  i.e. tmpfs, ``IPCSHM``, ``/dev/zero``, ``MAP_SHARED``, ``memfd_create``,
> > +  etc) virtual memory areas, respectively.
> > +
> > +- ``UFFD_FEATURE_MINOR_HUGETLBFS`` indicates that the kernel supports
> > +  ``UFFDIO_REGISTER_MODE_MINOR`` registration for hugetlbfs virtual memory
> > +  areas.
> > +
> > +The userland application should set the feature flags it intends to use
>
> (ah, userspace has moved to userland temporarily. :)

For better or worse, other parts of the document I'm not touching also
use this wording. Maybe we should s/userland/userspace/g, but perhaps
better done as a separate commit to keep this diff focused?
Anecdotally, the use of "userland" doesn't seem to be completely
unprecedented (e.g. grep -r "userland" | wc -l yields 566 matches in
the kernel tree).

I don't have strong feelings, and I was amused by picturing some
Shire-esque countryside with a friendly sign that reads: ~userland
welcomes you~. :)

>
> > +when envoking the ``UFFDIO_API`` ioctl, to request that those features be
>
>         invoking

Whoops! Will send a new version with this fix. Thanks!

>
> > +enabled if supported.
>
>
> thanks.
> --
> ~Randy
>
