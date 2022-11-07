Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3731D61F81A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 16:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiKGP7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 10:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiKGP7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:59:47 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6473F12A88
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Nov 2022 07:59:46 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id f27so31394098eje.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Nov 2022 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IITd8EQrY06zpsnvdK0dLKdgj3UcdcbIn9cavEKCvvE=;
        b=Zyh+TFztkylFfIJjhF7e3ln1pqKsHjlcPRTlwDPW040eSVRHTt0unIS2z0vhwrpwlR
         gMP2vb8ln3hscKXDKYkmMnQ3/qm/hIdHKiLQoJCZuasZgekNVu57Prdtuk6LnIq0MqzT
         +fz1ya4IIIMn4+c5F640/fuxSsWS8PjcHvyVyhjL72Fxxl36TdXJrwBW1ZP7cnZENFHS
         zLmY+Ta1T+fdWDBBKIvf92W8VN/gKQ5/8PebZRqH8GSJBwusRTFXJl4UV/jSMmL9Muk+
         wzdu8GwFLpVkPfuEA2Ra1EVIiwqIwHqvGWB1OoJVr72DmJB3xNUS/1WayxPrN6MAqY05
         nQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IITd8EQrY06zpsnvdK0dLKdgj3UcdcbIn9cavEKCvvE=;
        b=dhCI6B2QOe6BIn4qVPQk/tHsQ0Eq4z2d0HI+fQrwyvyrSN6CgzaCVxxYfDbakvZvOQ
         WgNJ3D5mnsHi87XCr1fn5fOwMXk3yELjFqCejZ9/v0mjKU5lWyujQS2f89uSuOXQhO5B
         RYbH9uWWcAWMGKWR2+uQkbQVjQI4RHfB1P6qt99A0XX6LRV42/VEkkaOSMe0aG8c1zRk
         CJsBGPAcxFNDzhPy2oxRZKoNC3VhVUK/yy8oULYXjCGgg5IJ9yoMsJeEkCkX74lRlsi4
         9nWFvQZ7SjmwDJwMFhrhyG14lAU6ZQBFW3zxc8R9erlEsTiCR9DGlWSKGignyRVxA2Hb
         FT8w==
X-Gm-Message-State: ACrzQf1Mu4SORBoWDg/J1AsWm/buGIrCUHRnczmI39qqb8+3yML/vt+u
        xf0z6q/FNQ2r2TYBUrznZ9ZQ0Bvpi3sOb5iMJIq7Hw==
X-Google-Smtp-Source: AMsMyM6eF24oy4Q00nqEXNLtxRfg2QD7eeW1/AHtxkxp9g4K556Ph5XLWbzIFR8X3u4YTP0rNgLgqHrCfId/TXUbV0U=
X-Received: by 2002:a17:907:c26:b0:7ad:f6c8:d6c with SMTP id
 ga38-20020a1709070c2600b007adf6c80d6cmr31255335ejc.640.1667836784893; Mon, 07
 Nov 2022 07:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20221105025342.3130038-1-pasha.tatashin@soleen.com>
 <20221106133351.ukb5quoizkkzyrge@box.shutemov.name> <CA+CK2bDK=oUYM-HZsYfZoq_n5BQMGpysMq395WK78r+SwYk99A@mail.gmail.com>
 <20221106165204.odb7febmnykhna2h@box.shutemov.name>
In-Reply-To: <20221106165204.odb7febmnykhna2h@box.shutemov.name>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 7 Nov 2022 10:59:08 -0500
Message-ID: <CA+CK2bBQik_=a5vuaXs+=Zrnod5bn8XcKHdz=aqsudhcS=PijA@mail.gmail.com>
Subject: Re: [PATCH] mm: anonymous shared memory naming
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, hughd@google.com,
        hannes@cmpxchg.org, david@redhat.com, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 6, 2022 at 11:52 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Sun, Nov 06, 2022 at 08:45:44AM -0500, Pasha Tatashin wrote:
> > On Sun, Nov 6, 2022 at 8:34 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Sat, Nov 05, 2022 at 02:53:42AM +0000, Pasha Tatashin wrote:
> > > > Since:
> > > > commit 9a10064f5625 ("mm: add a field to store names for private anonymous
> > > > memory")
> > > >
> > > > We can set names for private anonymous memory but not for shared
> > > > anonymous memory. However, naming shared anonymous memory just as
> > > > useful for tracking purposes.
> > > >
> > > > Extend the functionality to be able to set names for shared anon.
> > > >
> > > > / [anon_shmem:<name>]      an anonymous shared memory mapping that has
> > > >                            been named by userspace
> > > >
> > > > Sample output:
> > > >         share = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
> > > >                      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > > >         rv = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME,
> > > >                    share, SIZE, "shared anon");
> > > >
> > > > /proc/<pid>/maps (and smaps):
> > > > 7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024
> > > > /dev/zero (deleted) [anon_shmem:shared anon]
> > > >
> > > > pmap $(pgrep a.out)
> > > > 254:   pub/a.out
> > > > 000056093fab2000      4K r---- a.out
> > > > 000056093fab3000      4K r-x-- a.out
> > > > 000056093fab4000      4K r---- a.out
> > > > 000056093fab5000      4K r---- a.out
> > > > 000056093fab6000      4K rw--- a.out
> > > > 000056093fdeb000    132K rw---   [ anon ]
> > > > 00007fc8e2b4c000 262144K rw-s- zero (deleted) [anon_shmem:shared anon]
> > > >
> > > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > > ---
> > > >  Documentation/filesystems/proc.rst |  4 +++-
> > > >  fs/proc/task_mmu.c                 |  7 ++++---
> > > >  include/linux/mm.h                 |  2 ++
> > > >  include/linux/mm_types.h           | 27 +++++++++++++--------------
> > > >  mm/madvise.c                       |  7 ++-----
> > > >  mm/shmem.c                         | 13 +++++++++++--
> > > >  6 files changed, 35 insertions(+), 25 deletions(-)
> > > >
> > > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > > > index 898c99eae8e4..8f1e68460da5 100644
> > > > --- a/Documentation/filesystems/proc.rst
> > > > +++ b/Documentation/filesystems/proc.rst
> > > > @@ -431,8 +431,10 @@ is not associated with a file:
> > > >   [stack]                    the stack of the main process
> > > >   [vdso]                     the "virtual dynamic shared object",
> > > >                              the kernel system call handler
> > > > - [anon:<name>]              an anonymous mapping that has been
> > > > + [anon:<name>]              a private anonymous mapping that has been
> > > >                              named by userspace
> > > > + path [anon_shmem:<name>]   an anonymous shared memory mapping that has
> > > > +                            been named by userspace
> > >
> > > I expect it to break existing parsers. If the field starts with '/' it is
> > > reasonable to assume the rest of the string to be a path, but it is not
> > > the case now.
> >
> > This is actually exactly why I kept the "path" part. It stays the same
> > as today for  anon-shared memory, but prevents pmap to change
> > anon-shared memory from showing it as simply [anon].
> >
> > Here is what we have today in /proc/<pid>/maps (and smaps):
> > 7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024  /dev/zero (deleted)
> >
> > So, the path points to /dev/zero but appended with (deleted) mark. The
> > pmap shows the same thing, as it is looking for leading '/' to
> > determine that this is a path.
> >
> > With my change the above changes only when user specifically changed
> > the name like this:
> >
> > 7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024  /dev/zero
> > (deleted) [USER-SPECIFIED-NAME]
> >
> > So, the path stays, the (deleted) mark stays, and a name is added.
>
> Okay, fair enough.

After thinking about this, it makes sense to remove "path" entirely.
The pmap without arguments will show the user named segment as
"[anon]", but with -X argument it will show the full name:

pmap -X
7fa84fcef000 rw-s 00000000  00:01      1024 262144    0   0         0
        0         0        0              0             0
0               0    0       0      0           0 [anon_shmem:named
shared anon]
7fa85fcef000 rw-p 00000000  00:00         0 262144    0   0         0
        0         0        0              0             0
0               0    0       0      0           0 [anon:named anon]

In my opinion this is better to stay consistent with regular anon
memory, and also to minimize the chance to surprise the existing
scripts.

Pasha

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
