Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B27D43F25C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 00:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhJ1WLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 18:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhJ1WLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:11:15 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CADC061745
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 15:08:48 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v138so13521986ybb.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 15:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qm6KqyCh6s0Db7a+T/+DuLHBM+rJYYR5RLGGVD59fuY=;
        b=Sh1Bd5kKhILHTCResq1388lC+BE5pcYLn/0MBWKRorH6mH/iK/R2oaPQiH0wjMExNp
         AEBNHWOAUBaVrblPzJIAVBI7vr7gibYD8zCRjc4SI4KHrPbgyzefkoRYBjkAMZZ3CUvA
         sFLoW+kusBtkBXNLGHyGRnhxGvoj7cOqm8f/xYpwjzEjizNFe9HWEmoQU9YDuDD548k9
         a86nKDOHeXSnGs3zIk5XMvI0PvDQ6KXa9etHeOo0Uy/BCTY0o7EQ++RetJDrbVtM9TpS
         DZ+EXkqW2XIsfPD/xMpFNTsFiM7OwOG8+4VX3Gx15WigpJKi7iglw2dzp1uz9F7Jp8BB
         Vxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qm6KqyCh6s0Db7a+T/+DuLHBM+rJYYR5RLGGVD59fuY=;
        b=mhf/bWWuUV5nd273ylHTCXtpyyDEmwZkA/+yyRFXlzuXxOfKkRQ4dCv2k5JlYmmO3F
         SizCbkErFrEzrq3OsaIXGmffVsUzaRmPQ2I/Kguh7lUgLtOfmmwxRFDpIyT26AsyiWIc
         rNTQaI6MqrlIC55DidbwviMce/HaPkZpTAS54E/rLdRm6xnGoQ1hry+ZlpXOiCfp75bc
         A43f8ezHoajVIPACX0VpNAgjEtonFZqyOEflSrV/Zo3uWfGeQMPhGcCxOyXiG0dHt8m/
         +zpYreb5CS6O5omnQugpj5Eq3EFLpmwZQfinjv5TIeTJM5w3P/ZiuHqkHdbeHiScMRQ6
         Hzyg==
X-Gm-Message-State: AOAM531YGOXBgYIyFwMjmzw0VD9QFWCud9TA0I/HnD+shvZp3Sld+ArT
        NnapiofEwDcgymmzWKn854dJVKlBet+u31+VErmUew==
X-Google-Smtp-Source: ABdhPJwnzzRsTfPkuWSzHHEmlmQjZFJywGAm5qnIBvHY0JL+ekjndbfCBQf9A6OEYyQnwYuRhybTQm05z08xfsNjZ80=
X-Received: by 2002:a25:2f58:: with SMTP id v85mr341366ybv.487.1635458927369;
 Thu, 28 Oct 2021 15:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211019215511.3771969-1-surenb@google.com> <20211019215511.3771969-2-surenb@google.com>
 <89664270-4B9F-45E0-AC0B-8A185ED1F531@google.com> <CAJuCfpE-fR+M_funJ4Kd+gMK9q0QHyOUD7YK0ES6En4y7E1tjg@mail.gmail.com>
In-Reply-To: <CAJuCfpE-fR+M_funJ4Kd+gMK9q0QHyOUD7YK0ES6En4y7E1tjg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 28 Oct 2021 15:08:36 -0700
Message-ID: <CAJuCfpHfnG8b4_RkkGhu+HveF-K_7o9UVGdToVuUCf-qD05Q4Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] mm: add a field to store names for private
 anonymous memory
To:     akpm@linux-foundation.org
Cc:     Alexey Alexandrov <aalexand@google.com>, ccross@google.com,
        sumit.semwal@linaro.org, mhocko@suse.com, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com, pavel@ucw.cz,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 1:01 PM Suren Baghdasaryan <surenb@google.com> wrot=
e:
>
> On Wed, Oct 27, 2021 at 11:35 AM Alexey Alexandrov <aalexand@google.com> =
wrote:
> >
> > > On Oct 19, 2021, at 2:55 PM, Suren Baghdasaryan <surenb@google.com> w=
rote:
> > >
> > > From: Colin Cross <ccross@google.com>
> > >
> > > In many userspace applications, and especially in VM based applicatio=
ns
> > > like Android uses heavily, there are multiple different allocators in=
 use.
> > > At a minimum there is libc malloc and the stack, and in many cases th=
ere
> > > are libc malloc, the stack, direct syscalls to mmap anonymous memory,=
 and
> > > multiple VM heaps (one for small objects, one for big objects, etc.).
> > > Each of these layers usually has its own tools to inspect its usage;
> > > malloc by compiling a debug version, the VM through heap inspection t=
ools,
> > > and for direct syscalls there is usually no way to track them.
> > >
> > > On Android we heavily use a set of tools that use an extended version=
 of
> > > the logic covered in Documentation/vm/pagemap.txt to walk all pages m=
apped
> > > in userspace and slice their usage by process, shared (COW) vs.  uniq=
ue
> > > mappings, backing, etc.  This can account for real physical memory us=
age
> > > even in cases like fork without exec (which Android uses heavily to s=
hare
> > > as many private COW pages as possible between processes), Kernel Same=
Page
> > > Merging, and clean zero pages.  It produces a measurement of the page=
s
> > > that only exist in that process (USS, for unique), and a measurement =
of
> > > the physical memory usage of that process with the cost of shared pag=
es
> > > being evenly split between processes that share them (PSS).
> > >
> > > If all anonymous memory is indistinguishable then figuring out the re=
al
> > > physical memory usage (PSS) of each heap requires either a pagemap wa=
lking
> > > tool that can understand the heap debugging of every layer, or for ev=
ery
> > > layer's heap debugging tools to implement the pagemap walking logic, =
in
> > > which case it is hard to get a consistent view of memory across the w=
hole
> > > system.
> > >
> > > Tracking the information in userspace leads to all sorts of problems.
> > > It either needs to be stored inside the process, which means every
> > > process has to have an API to export its current heap information upo=
n
> > > request, or it has to be stored externally in a filesystem that
> > > somebody needs to clean up on crashes.  It needs to be readable while
> > > the process is still running, so it has to have some sort of
> > > synchronization with every layer of userspace.  Efficiently tracking
> > > the ranges requires reimplementing something like the kernel vma
> > > trees, and linking to it from every layer of userspace.  It requires
> > > more memory, more syscalls, more runtime cost, and more complexity to
> > > separately track regions that the kernel is already tracking.
> > >
> > > This patch adds a field to /proc/pid/maps and /proc/pid/smaps to show=
 a
> > > userspace-provided name for anonymous vmas.  The names of named anony=
mous
> > > vmas are shown in /proc/pid/maps and /proc/pid/smaps as [anon:<name>]=
.
> > >
> > > Userspace can set the name for a region of memory by calling
> > > prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, start, len, (unsigned long)na=
me);
> > > Setting the name to NULL clears it. The name length limit is 80 bytes
> > > including NUL-terminator and is checked to contain only printable asc=
ii
> > > characters (including space), except '[',']','\','$' and '`'. Ascii
> > > strings are being used to have a descriptive identifiers for vmas, wh=
ich
> > > can be understood by the users reading /proc/pid/maps or /proc/pid/sm=
aps.
> > > Names can be standardized for a given system and they can include som=
e
> > > variable parts such as the name of the allocator or a library, tid of
> > > the thread using it, etc.
> > >
> > > The name is stored in a pointer in the shared union in vm_area_struct
> > > that points to a null terminated string. Anonymous vmas with the same
> > > name (equivalent strings) and are otherwise mergeable will be merged.
> > > The name pointers are not shared between vmas even if they contain th=
e
> > > same name. The name pointer is stored in a union with fields that are
> > > only used on file-backed mappings, so it does not increase memory usa=
ge.
> > >
> > > CONFIG_ANON_VMA_NAME kernel configuration is introduced to enable thi=
s
> > > feature. It keeps the feature disabled by default to prevent any
> > > additional memory overhead and to avoid confusing procfs parsers on
> > > systems which are not ready to support named anonymous vmas.
> > >
> > > The patch is based on the original patch developed by Colin Cross, mo=
re
> > > specifically on its latest version [1] posted upstream by Sumit Semwa=
l.
> > > It used a userspace pointer to store vma names. In that design, name
> > > pointers could be shared between vmas. However during the last upstre=
aming
> > > attempt, Kees Cook raised concerns [2] about this approach and sugges=
ted
> > > to copy the name into kernel memory space, perform validity checks [3=
]
> > > and store as a string referenced from vm_area_struct.
> > > One big concern is about fork() performance which would need to strdu=
p
> > > anonymous vma names. Dave Hansen suggested experimenting with worst-c=
ase
> > > scenario of forking a process with 64k vmas having longest possible n=
ames
> > > [4]. I ran this experiment on an ARM64 Android device and recorded a
> > > worst-case regression of almost 40% when forking such a process. This
> > > regression is addressed in the followup patch which replaces the poin=
ter
> > > to a name with a refcounted structure that allows sharing the name po=
inter
> > > between vmas of the same name. Instead of duplicating the string duri=
ng
> > > fork() or when splitting a vma it increments the refcount.
> > >
> > > [1] https://lore.kernel.org/linux-mm/20200901161459.11772-4-sumit.sem=
wal@linaro.org/
> > > [2] https://lore.kernel.org/linux-mm/202009031031.D32EF57ED@keescook/
> > > [3] https://lore.kernel.org/linux-mm/202009031022.3834F692@keescook/
> > > [4] https://lore.kernel.org/linux-mm/5d0358ab-8c47-2f5f-8e43-23b89d6a=
8e95@intel.com/
> > >
> > > Changes for prctl(2) manual page (in the options section):
> > >
> > > PR_SET_VMA
> > >       Sets an attribute specified in arg2 for virtual memory areas
> > >       starting from the address specified in arg3 and spanning the
> > >       size specified  in arg4. arg5 specifies the value of the attrib=
ute
> > >       to be set. Note that assigning an attribute to a virtual memory
> > >       area might prevent it from being merged with adjacent virtual
> > >       memory areas due to the difference in that attribute's value.
> > >
> > >       Currently, arg2 must be one of:
> > >
> > >       PR_SET_VMA_ANON_NAME
> > >               Set a name for anonymous virtual memory areas. arg5 sho=
uld
> > >               be a pointer to a null-terminated string containing the
> > >               name. The name length including null byte cannot exceed
> > >               80 bytes. If arg5 is NULL, the name of the appropriate
> > >               anonymous virtual memory areas will be reset. The name
> > >               can contain only printable ascii characters (including
> > >                space), except '[',']','\','$' and '`'.
> > >
> > >                This feature is available only if the kernel is built =
with
> > >                the CONFIG_ANON_VMA_NAME option enabled.
> >
> > For what it=E2=80=99s worth, it=E2=80=99s definitely interesting to see=
 this going upstream.
> > In particular, we would use it for high-level grouping of the data in
> > production profiling when proper symbolization is not available:
> >
> > * JVM could associate a name with the memory regions it uses for the JI=
T
> >   code so that Linux perf data are associated with a high level name li=
ke
> >   "Java JIT" even if the proper Java JIT profiling is not enabled.
> > * Similar for other JIT engines like v8 - they could annotate the memor=
y
> >   regions they manage and use as well.
> > * Traditional memory allocators like tcmalloc can use this as well so
> >   that the associated name is used in data access profiling via Linux p=
erf.
>
> Hi Alexey,
> Thanks for providing your feedback! Nice to hear that this can be
> useful outside of Android.

Folks, it has been almost two weeks since I posted this v11 patchset.
Is there anything else I can do to advance it towards merging?
