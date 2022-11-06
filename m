Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74D61E388
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Nov 2022 17:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKFQwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 11:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiKFQwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:52:13 -0500
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC978C759;
        Sun,  6 Nov 2022 08:52:12 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 21A562B063E5;
        Sun,  6 Nov 2022 11:52:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 06 Nov 2022 11:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667753528; x=1667760728; bh=ML
        PScbiT/w3JaMANBBCz19l6qnUEijiodsNSPwsmFvA=; b=Rvl+sXfWlxBEW89l4i
        EWsJsiMNFACOwsfH87VIaAq1cWAAbzliMtdvQGSvVadVW2Qe9nCccio18LVhn6ds
        EfBqOKtSdRvhddLy7p8b+hhvLiHsV3jtvIVgr5QJHOXRvDfPHuE3BIikbsptqIBu
        hmt6Yf998GGXvngq2aM7u0PMcHjyGg+Ra9UKLqtOaS6Uq9d0wgCXEBWqPIHFvoH8
        LLzkUgL1AzPe+egCmvIWwnF/blrPT/GWVyEbm7PsR8COZ52yM+eIvrO0bog4qOd7
        jEzC9SqMgtywysSkT/n6UC/zvyki3goOoq4A8kKoF9XsWt/O2wzmU7t1493cIQ8d
        nnlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667753528; x=1667760728; bh=MLPScbiT/w3JaMANBBCz19l6qnUE
        ijiodsNSPwsmFvA=; b=h07AGaYuROhwH49JjCcdYVg+80f1ZOjXBDYzvRAYDFbO
        wR74v7wGdecSj6zlx4O+8Nqk2ynI/PsQPLplQOQtgpHb6igzOII4X0LTs3eeOmpj
        F7WYZb5OcynKVu/vkI/udT12Z3S0rx1ayvRpsZR1/u2QabaPzQH6gBIAJtOueU5S
        SeLqulavBuyYo91FdS0FRZFw+R4+Vo+Jg1sy+knrB32IOXGaVTbXaESppH1Bhcz+
        P9g8vzXpYXmsB2+UWpQhTh+WrsVEJ9aNxxfPktzeZ9jXRkvxMspaxyYf7OyTHTD+
        0fNk75syjMBFLWs+R9EUYTzOu2h4ZllGYRqhFxVzVQ==
X-ME-Sender: <xms:N-ZnY-VENFzdOTSFKoImnhRs11AgzUFjWGx-C8a4cxAjwgsP28nFbA>
    <xme:N-ZnY6kvOZlDF4M0yF-44IuEX_eG5ZRNDvISnfAEDb2-7K13bM89zVJLbdhVtWPds
    X74t2UsgZ2qPBE-t0M>
X-ME-Received: <xmr:N-ZnYyZ5VxOW0u3WbrsYDkGdXh-Hb_OiREfIWKMEC4NLAX5AAPynqnC3IT-zKxI5qR1Z9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:N-ZnY1UlArt7TMEZk6n5OsdgUyXI03nKKRxya_G9D7M8b5LsCFlrwg>
    <xmx:N-ZnY4kHFOrUUbwiGbHASIvVqAo4cKXQgWdsm7HwqYGiBi_uuV1JuA>
    <xmx:N-ZnY6fnfuqP-K6pKqhS_Mfgg9q7pHMOOwyV7m_nXX_WPUJ3RjP6Yg>
    <xmx:OOZnY-vNeenKS4MgyOwWeEOvQeZCqjeYuizeO63TPG9jNCKoA75seJpV3Gs>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Nov 2022 11:52:06 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3198E104149; Sun,  6 Nov 2022 19:52:04 +0300 (+03)
Date:   Sun, 6 Nov 2022 19:52:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, hughd@google.com,
        hannes@cmpxchg.org, david@redhat.com, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: anonymous shared memory naming
Message-ID: <20221106165204.odb7febmnykhna2h@box.shutemov.name>
References: <20221105025342.3130038-1-pasha.tatashin@soleen.com>
 <20221106133351.ukb5quoizkkzyrge@box.shutemov.name>
 <CA+CK2bDK=oUYM-HZsYfZoq_n5BQMGpysMq395WK78r+SwYk99A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDK=oUYM-HZsYfZoq_n5BQMGpysMq395WK78r+SwYk99A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 06, 2022 at 08:45:44AM -0500, Pasha Tatashin wrote:
> On Sun, Nov 6, 2022 at 8:34 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Sat, Nov 05, 2022 at 02:53:42AM +0000, Pasha Tatashin wrote:
> > > Since:
> > > commit 9a10064f5625 ("mm: add a field to store names for private anonymous
> > > memory")
> > >
> > > We can set names for private anonymous memory but not for shared
> > > anonymous memory. However, naming shared anonymous memory just as
> > > useful for tracking purposes.
> > >
> > > Extend the functionality to be able to set names for shared anon.
> > >
> > > / [anon_shmem:<name>]      an anonymous shared memory mapping that has
> > >                            been named by userspace
> > >
> > > Sample output:
> > >         share = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
> > >                      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > >         rv = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME,
> > >                    share, SIZE, "shared anon");
> > >
> > > /proc/<pid>/maps (and smaps):
> > > 7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024
> > > /dev/zero (deleted) [anon_shmem:shared anon]
> > >
> > > pmap $(pgrep a.out)
> > > 254:   pub/a.out
> > > 000056093fab2000      4K r---- a.out
> > > 000056093fab3000      4K r-x-- a.out
> > > 000056093fab4000      4K r---- a.out
> > > 000056093fab5000      4K r---- a.out
> > > 000056093fab6000      4K rw--- a.out
> > > 000056093fdeb000    132K rw---   [ anon ]
> > > 00007fc8e2b4c000 262144K rw-s- zero (deleted) [anon_shmem:shared anon]
> > >
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > ---
> > >  Documentation/filesystems/proc.rst |  4 +++-
> > >  fs/proc/task_mmu.c                 |  7 ++++---
> > >  include/linux/mm.h                 |  2 ++
> > >  include/linux/mm_types.h           | 27 +++++++++++++--------------
> > >  mm/madvise.c                       |  7 ++-----
> > >  mm/shmem.c                         | 13 +++++++++++--
> > >  6 files changed, 35 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > > index 898c99eae8e4..8f1e68460da5 100644
> > > --- a/Documentation/filesystems/proc.rst
> > > +++ b/Documentation/filesystems/proc.rst
> > > @@ -431,8 +431,10 @@ is not associated with a file:
> > >   [stack]                    the stack of the main process
> > >   [vdso]                     the "virtual dynamic shared object",
> > >                              the kernel system call handler
> > > - [anon:<name>]              an anonymous mapping that has been
> > > + [anon:<name>]              a private anonymous mapping that has been
> > >                              named by userspace
> > > + path [anon_shmem:<name>]   an anonymous shared memory mapping that has
> > > +                            been named by userspace
> >
> > I expect it to break existing parsers. If the field starts with '/' it is
> > reasonable to assume the rest of the string to be a path, but it is not
> > the case now.
> 
> This is actually exactly why I kept the "path" part. It stays the same
> as today for  anon-shared memory, but prevents pmap to change
> anon-shared memory from showing it as simply [anon].
> 
> Here is what we have today in /proc/<pid>/maps (and smaps):
> 7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024  /dev/zero (deleted)
> 
> So, the path points to /dev/zero but appended with (deleted) mark. The
> pmap shows the same thing, as it is looking for leading '/' to
> determine that this is a path.
> 
> With my change the above changes only when user specifically changed
> the name like this:
> 
> 7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024  /dev/zero
> (deleted) [USER-SPECIFIED-NAME]
> 
> So, the path stays, the (deleted) mark stays, and a name is added.

Okay, fair enough.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
