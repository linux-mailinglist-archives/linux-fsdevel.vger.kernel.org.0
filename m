Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30783451D98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 01:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbhKPAbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 19:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345685AbhKOT3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:03 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C35C06BCF4
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:33 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id s186so49904145yba.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j9isATshRpNCp9M9I/oxCqB/tiXTLxAbh8WEspOg7HA=;
        b=qtzEXtgjPMCcvYNyLawsdtSgDfbTOrXWIye07d/cOumHTbZQ/0YQ7IfvtQCEzWNrw7
         ZgGvgzbIkSJmwNGdUmWAKWQGQiFf0V7yUVlpQyYU3cFffJ2yi4QWmRBlp94nrhCqbXUo
         pbyNyRmu75Gy2dbSfYbcCeDACqy84MWea44WEoSdGfI8xT4k6Qzx24IjB5HHnT1HBPcN
         mcuHhd1CXF2ZP/aS61+qnrHhEtnzjUKqVFQyirBIXaY5x5KwBb3B9+zRHCNXHIG81jMr
         yHXSQL+6Gi6ZOX7+Jg5pQF/prN5kjebVxQ9pZPsMk01hkYAAzL/On8WkK/jhtAZ9ajvZ
         jNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j9isATshRpNCp9M9I/oxCqB/tiXTLxAbh8WEspOg7HA=;
        b=EM16HOpoRDYgJdcCb+QlvvVuSAsxFuvZKBBtJ/Fx0OIHJZ22/Ab+lnGNFof1zUgKcD
         xpvEk9u1RmERpO9gLBoJbX0bvyppV9i+ZqiQYnWoYkrkEM8/uvpNQ3Z3KXoKrEb6dm0e
         Hq/Koha3uWQlfVUHflQip5xAl+lglc9UBtVzf8kmb8Olo+REjAG7wjtUPQhdzfAhvjhe
         x8dBR6wxjifoJiTjQeL283ik3vbWq8E8cTpCUwGVNezzWZo+gKZEI65QTKMdIGbNDAdK
         XDYZVBZioui1H3lSelOoQ4RYnt+M0wz7wZq8DEmzPSsd10IVVLLVhPBTZ1ISoShMbEwp
         622A==
X-Gm-Message-State: AOAM530ifVSwFb+Aj6Xt9/NmmgfObA33TLTh9OtkPMyTE8dxqEyhFI87
        39CAczcU3MI7Lbcded09N+bhzj6cR8EcGAMnhElVtA==
X-Google-Smtp-Source: ABdhPJwORjkE+Oy2pssuHDx7dD8a047R6Yq50CV0Ct2mHGQfqJVDqJfkC62iPCNh9yCdfFkzRQjRxFHI4npCcZKI0EY=
X-Received: by 2002:a25:6645:: with SMTP id z5mr1370689ybm.127.1637002771688;
 Mon, 15 Nov 2021 10:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20211019215511.3771969-1-surenb@google.com> <20211019215511.3771969-2-surenb@google.com>
 <89664270-4B9F-45E0-AC0B-8A185ED1F531@google.com> <CAJuCfpE-fR+M_funJ4Kd+gMK9q0QHyOUD7YK0ES6En4y7E1tjg@mail.gmail.com>
 <CAJuCfpHfnG8b4_RkkGhu+HveF-K_7o9UVGdToVuUCf-qD05Q4Q@mail.gmail.com>
In-Reply-To: <CAJuCfpHfnG8b4_RkkGhu+HveF-K_7o9UVGdToVuUCf-qD05Q4Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 15 Nov 2021 10:59:20 -0800
Message-ID: <CAJuCfpEJuVyRfjEE-NTsVkdCZyd6P09gHu7c+tbZcipk+73rLA@mail.gmail.com>
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

On Thu, Oct 28, 2021 at 3:08 PM Suren Baghdasaryan <surenb@google.com> wrot=
e:
>
> On Wed, Oct 27, 2021 at 1:01 PM Suren Baghdasaryan <surenb@google.com> wr=
ote:
> >
> > On Wed, Oct 27, 2021 at 11:35 AM Alexey Alexandrov <aalexand@google.com=
> wrote:
> > >
> > > > On Oct 19, 2021, at 2:55 PM, Suren Baghdasaryan <surenb@google.com>=
 wrote:
> > > >
> > > > From: Colin Cross <ccross@google.com>
> > > >
> > > > In many userspace applications, and especially in VM based applicat=
ions
> > > > like Android uses heavily, there are multiple different allocators =
in use.
> > > > At a minimum there is libc malloc and the stack, and in many cases =
there
> > > > are libc malloc, the stack, direct syscalls to mmap anonymous memor=
y, and
> > > > multiple VM heaps (one for small objects, one for big objects, etc.=
).
> > > > Each of these layers usually has its own tools to inspect its usage=
;
> > > > malloc by compiling a debug version, the VM through heap inspection=
 tools,
> > > > and for direct syscalls there is usually no way to track them.
> > > >
> > > > On Android we heavily use a set of tools that use an extended versi=
on of
> > > > the logic covered in Documentation/vm/pagemap.txt to walk all pages=
 mapped
> > > > in userspace and slice their usage by process, shared (COW) vs.  un=
ique
> > > > mappings, backing, etc.  This can account for real physical memory =
usage
> > > > even in cases like fork without exec (which Android uses heavily to=
 share
> > > > as many private COW pages as possible between processes), Kernel Sa=
mePage
> > > > Merging, and clean zero pages.  It produces a measurement of the pa=
ges
> > > > that only exist in that process (USS, for unique), and a measuremen=
t of
> > > > the physical memory usage of that process with the cost of shared p=
ages
> > > > being evenly split between processes that share them (PSS).
> > > >
> > > > If all anonymous memory is indistinguishable then figuring out the =
real
> > > > physical memory usage (PSS) of each heap requires either a pagemap =
walking
> > > > tool that can understand the heap debugging of every layer, or for =
every
> > > > layer's heap debugging tools to implement the pagemap walking logic=
, in
> > > > which case it is hard to get a consistent view of memory across the=
 whole
> > > > system.
> > > >
> > > > Tracking the information in userspace leads to all sorts of problem=
s.
> > > > It either needs to be stored inside the process, which means every
> > > > process has to have an API to export its current heap information u=
pon
> > > > request, or it has to be stored externally in a filesystem that
> > > > somebody needs to clean up on crashes.  It needs to be readable whi=
le
> > > > the process is still running, so it has to have some sort of
> > > > synchronization with every layer of userspace.  Efficiently trackin=
g
> > > > the ranges requires reimplementing something like the kernel vma
> > > > trees, and linking to it from every layer of userspace.  It require=
s
> > > > more memory, more syscalls, more runtime cost, and more complexity =
to
> > > > separately track regions that the kernel is already tracking.
> > > >
> > > > This patch adds a field to /proc/pid/maps and /proc/pid/smaps to sh=
ow a
> > > > userspace-provided name for anonymous vmas.  The names of named ano=
nymous
> > > > vmas are shown in /proc/pid/maps and /proc/pid/smaps as [anon:<name=
>].
> > > >
> > > > Userspace can set the name for a region of memory by calling
> > > > prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, start, len, (unsigned long)=
name);
> > > > Setting the name to NULL clears it. The name length limit is 80 byt=
es
> > > > including NUL-terminator and is checked to contain only printable a=
scii
> > > > characters (including space), except '[',']','\','$' and '`'. Ascii
> > > > strings are being used to have a descriptive identifiers for vmas, =
which
> > > > can be understood by the users reading /proc/pid/maps or /proc/pid/=
smaps.
> > > > Names can be standardized for a given system and they can include s=
ome
> > > > variable parts such as the name of the allocator or a library, tid =
of
> > > > the thread using it, etc.
> > > >
> > > > The name is stored in a pointer in the shared union in vm_area_stru=
ct
> > > > that points to a null terminated string. Anonymous vmas with the sa=
me
> > > > name (equivalent strings) and are otherwise mergeable will be merge=
d.
> > > > The name pointers are not shared between vmas even if they contain =
the
> > > > same name. The name pointer is stored in a union with fields that a=
re
> > > > only used on file-backed mappings, so it does not increase memory u=
sage.
> > > >
> > > > CONFIG_ANON_VMA_NAME kernel configuration is introduced to enable t=
his
> > > > feature. It keeps the feature disabled by default to prevent any
> > > > additional memory overhead and to avoid confusing procfs parsers on
> > > > systems which are not ready to support named anonymous vmas.
> > > >
> > > > The patch is based on the original patch developed by Colin Cross, =
more
> > > > specifically on its latest version [1] posted upstream by Sumit Sem=
wal.
> > > > It used a userspace pointer to store vma names. In that design, nam=
e
> > > > pointers could be shared between vmas. However during the last upst=
reaming
> > > > attempt, Kees Cook raised concerns [2] about this approach and sugg=
ested
> > > > to copy the name into kernel memory space, perform validity checks =
[3]
> > > > and store as a string referenced from vm_area_struct.
> > > > One big concern is about fork() performance which would need to str=
dup
> > > > anonymous vma names. Dave Hansen suggested experimenting with worst=
-case
> > > > scenario of forking a process with 64k vmas having longest possible=
 names
> > > > [4]. I ran this experiment on an ARM64 Android device and recorded =
a
> > > > worst-case regression of almost 40% when forking such a process. Th=
is
> > > > regression is addressed in the followup patch which replaces the po=
inter
> > > > to a name with a refcounted structure that allows sharing the name =
pointer
> > > > between vmas of the same name. Instead of duplicating the string du=
ring
> > > > fork() or when splitting a vma it increments the refcount.
> > > >
> > > > [1] https://lore.kernel.org/linux-mm/20200901161459.11772-4-sumit.s=
emwal@linaro.org/
> > > > [2] https://lore.kernel.org/linux-mm/202009031031.D32EF57ED@keescoo=
k/
> > > > [3] https://lore.kernel.org/linux-mm/202009031022.3834F692@keescook=
/
> > > > [4] https://lore.kernel.org/linux-mm/5d0358ab-8c47-2f5f-8e43-23b89d=
6a8e95@intel.com/
> > > >
> > > > Changes for prctl(2) manual page (in the options section):
> > > >
> > > > PR_SET_VMA
> > > >       Sets an attribute specified in arg2 for virtual memory areas
> > > >       starting from the address specified in arg3 and spanning the
> > > >       size specified  in arg4. arg5 specifies the value of the attr=
ibute
> > > >       to be set. Note that assigning an attribute to a virtual memo=
ry
> > > >       area might prevent it from being merged with adjacent virtual
> > > >       memory areas due to the difference in that attribute's value.
> > > >
> > > >       Currently, arg2 must be one of:
> > > >
> > > >       PR_SET_VMA_ANON_NAME
> > > >               Set a name for anonymous virtual memory areas. arg5 s=
hould
> > > >               be a pointer to a null-terminated string containing t=
he
> > > >               name. The name length including null byte cannot exce=
ed
> > > >               80 bytes. If arg5 is NULL, the name of the appropriat=
e
> > > >               anonymous virtual memory areas will be reset. The nam=
e
> > > >               can contain only printable ascii characters (includin=
g
> > > >                space), except '[',']','\','$' and '`'.
> > > >
> > > >                This feature is available only if the kernel is buil=
t with
> > > >                the CONFIG_ANON_VMA_NAME option enabled.
> > >
> > > For what it=E2=80=99s worth, it=E2=80=99s definitely interesting to s=
ee this going upstream.
> > > In particular, we would use it for high-level grouping of the data in
> > > production profiling when proper symbolization is not available:
> > >
> > > * JVM could associate a name with the memory regions it uses for the =
JIT
> > >   code so that Linux perf data are associated with a high level name =
like
> > >   "Java JIT" even if the proper Java JIT profiling is not enabled.
> > > * Similar for other JIT engines like v8 - they could annotate the mem=
ory
> > >   regions they manage and use as well.
> > > * Traditional memory allocators like tcmalloc can use this as well so
> > >   that the associated name is used in data access profiling via Linux=
 perf.
> >
> > Hi Alexey,
> > Thanks for providing your feedback! Nice to hear that this can be
> > useful outside of Android.
>
> Folks, it has been almost two weeks since I posted this v11 patchset.
> Is there anything else I can do to advance it towards merging?

Hi Andrew,
I haven't seen any feedback on my patchset for some time now. I think
I addressed all the questions and comments (please correct me if I
missed anything). Can it be accepted as is or is there something I
should address further?
From the feedback, I see that there are several interested parties in
this patchset (albeit all from different teams at Google) but maybe
when it's merged more users will start using it. I believe I've done
everything I could to ensure no/minimal impact on the users who don't
use this feature. Please advise.
Thanks,
Suren.
