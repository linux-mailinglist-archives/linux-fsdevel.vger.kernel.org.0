Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FAD43D0D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 20:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbhJ0Shn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 14:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243584AbhJ0Shb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:37:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FBBC061348
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 11:35:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so5879595pje.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rvh0EfGrQmW1r7d8yfLYvcYsHPaGB41pg5VPXziGDYo=;
        b=mcIlhDlKNNVhsI3D11EqXFFOBJLpTqvRWp6AWb0fxJ6W+yrs2mhu0YGjYnG7dYdK8C
         dRhFNNDMXwTLOwq5kZSyzwSMFNoLcvrN/OsTS29YjHwGDS3DWmUlqnas0j+1T4HPC+4U
         peab8ZskljC4X5cQqT5w751US6OOaaGgcm9lBF7t7NL6ZoG1MtAnpsLdSPNuidMGkdat
         dujqy+1Gse1/MjIzYS5rDhSMxxv5j+AihpQcHdVkVxa08i3bNL5jbez0koecn93Dt63s
         S84GJ0G8ihDX4RgsMn0m5Zzk3i5nYZWd4kj9kP06/CxaEacWkjroJU5TTCQ9Hfwg0o88
         YilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rvh0EfGrQmW1r7d8yfLYvcYsHPaGB41pg5VPXziGDYo=;
        b=rkC388b1hnWRjWh5rbHCFbEIaJnaLyUt3a5w9arFAiNx24U1J9KcZntF1sOwy2ZXlA
         vAUzpVynToQCz5HcDBLgLQXnnpbPHMy0xzAY6WJ0SVp+w8ufKWXY87rG1iyBL+7nbWpB
         m1jDZE9xg8SNBcM+O2u85g7HrawpNeUvHS3jVfEviBFgfSFrA64tY8ji0aCCDKJZ6W7W
         D9bCbvbdXMJiBEXQl0CQSQg5fRWLq6Fsl32zR+0cKlQAz0vx7bEcBa1MTTxBiUScqzOl
         vYHkanLXmX3J5PhmiSakRNPgDb/nTKLvjoo8tfFFdMWSu+W7+kmjb8NaHzvMu0N/VBxA
         BWew==
X-Gm-Message-State: AOAM532AQuJNGb3khSnsx7Wkcf1Gim3Ns8ku9nSTWODRCbpGVVT5QRHc
        5zSpIjYUD0IkWZ2n6hqsZOlB+w==
X-Google-Smtp-Source: ABdhPJwZWsIcYifaWP+5OfBV53sifeG91pW4+UCHb+frPcCBx5HU6CGv1sbVu2jRKwv377aoJ360Yw==
X-Received: by 2002:a17:90b:1c81:: with SMTP id oo1mr7469688pjb.97.1635359704826;
        Wed, 27 Oct 2021 11:35:04 -0700 (PDT)
Received: from smtpclient.apple (c-71-198-45-217.hsd1.ca.comcast.net. [71.198.45.217])
        by smtp.gmail.com with ESMTPSA id c4sm683417pfl.53.2021.10.27.11.35.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Oct 2021 11:35:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v11 2/3] mm: add a field to store names for private
 anonymous memory
From:   Alexey Alexandrov <aalexand@google.com>
In-Reply-To: <20211019215511.3771969-2-surenb@google.com>
Date:   Wed, 27 Oct 2021 11:35:01 -0700
Cc:     akpm@linux-foundation.org, ccross@google.com,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <89664270-4B9F-45E0-AC0B-8A185ED1F531@google.com>
References: <20211019215511.3771969-1-surenb@google.com>
 <20211019215511.3771969-2-surenb@google.com>
To:     Suren Baghdasaryan <surenb@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Oct 19, 2021, at 2:55 PM, Suren Baghdasaryan <surenb@google.com> =
wrote:
>=20
> From: Colin Cross <ccross@google.com>
>=20
> In many userspace applications, and especially in VM based =
applications
> like Android uses heavily, there are multiple different allocators in =
use.
> At a minimum there is libc malloc and the stack, and in many cases =
there
> are libc malloc, the stack, direct syscalls to mmap anonymous memory, =
and
> multiple VM heaps (one for small objects, one for big objects, etc.).
> Each of these layers usually has its own tools to inspect its usage;
> malloc by compiling a debug version, the VM through heap inspection =
tools,
> and for direct syscalls there is usually no way to track them.
>=20
> On Android we heavily use a set of tools that use an extended version =
of
> the logic covered in Documentation/vm/pagemap.txt to walk all pages =
mapped
> in userspace and slice their usage by process, shared (COW) vs.  =
unique
> mappings, backing, etc.  This can account for real physical memory =
usage
> even in cases like fork without exec (which Android uses heavily to =
share
> as many private COW pages as possible between processes), Kernel =
SamePage
> Merging, and clean zero pages.  It produces a measurement of the pages
> that only exist in that process (USS, for unique), and a measurement =
of
> the physical memory usage of that process with the cost of shared =
pages
> being evenly split between processes that share them (PSS).
>=20
> If all anonymous memory is indistinguishable then figuring out the =
real
> physical memory usage (PSS) of each heap requires either a pagemap =
walking
> tool that can understand the heap debugging of every layer, or for =
every
> layer's heap debugging tools to implement the pagemap walking logic, =
in
> which case it is hard to get a consistent view of memory across the =
whole
> system.
>=20
> Tracking the information in userspace leads to all sorts of problems.
> It either needs to be stored inside the process, which means every
> process has to have an API to export its current heap information upon
> request, or it has to be stored externally in a filesystem that
> somebody needs to clean up on crashes.  It needs to be readable while
> the process is still running, so it has to have some sort of
> synchronization with every layer of userspace.  Efficiently tracking
> the ranges requires reimplementing something like the kernel vma
> trees, and linking to it from every layer of userspace.  It requires
> more memory, more syscalls, more runtime cost, and more complexity to
> separately track regions that the kernel is already tracking.
>=20
> This patch adds a field to /proc/pid/maps and /proc/pid/smaps to show =
a
> userspace-provided name for anonymous vmas.  The names of named =
anonymous
> vmas are shown in /proc/pid/maps and /proc/pid/smaps as [anon:<name>].
>=20
> Userspace can set the name for a region of memory by calling
> prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, start, len, (unsigned =
long)name);
> Setting the name to NULL clears it. The name length limit is 80 bytes
> including NUL-terminator and is checked to contain only printable =
ascii
> characters (including space), except '[',']','\','$' and '`'. Ascii
> strings are being used to have a descriptive identifiers for vmas, =
which
> can be understood by the users reading /proc/pid/maps or =
/proc/pid/smaps.
> Names can be standardized for a given system and they can include some
> variable parts such as the name of the allocator or a library, tid of
> the thread using it, etc.
>=20
> The name is stored in a pointer in the shared union in vm_area_struct
> that points to a null terminated string. Anonymous vmas with the same
> name (equivalent strings) and are otherwise mergeable will be merged.
> The name pointers are not shared between vmas even if they contain the
> same name. The name pointer is stored in a union with fields that are
> only used on file-backed mappings, so it does not increase memory =
usage.
>=20
> CONFIG_ANON_VMA_NAME kernel configuration is introduced to enable this
> feature. It keeps the feature disabled by default to prevent any
> additional memory overhead and to avoid confusing procfs parsers on
> systems which are not ready to support named anonymous vmas.
>=20
> The patch is based on the original patch developed by Colin Cross, =
more
> specifically on its latest version [1] posted upstream by Sumit =
Semwal.
> It used a userspace pointer to store vma names. In that design, name
> pointers could be shared between vmas. However during the last =
upstreaming
> attempt, Kees Cook raised concerns [2] about this approach and =
suggested
> to copy the name into kernel memory space, perform validity checks [3]
> and store as a string referenced from vm_area_struct.
> One big concern is about fork() performance which would need to strdup
> anonymous vma names. Dave Hansen suggested experimenting with =
worst-case
> scenario of forking a process with 64k vmas having longest possible =
names
> [4]. I ran this experiment on an ARM64 Android device and recorded a
> worst-case regression of almost 40% when forking such a process. This
> regression is addressed in the followup patch which replaces the =
pointer
> to a name with a refcounted structure that allows sharing the name =
pointer
> between vmas of the same name. Instead of duplicating the string =
during
> fork() or when splitting a vma it increments the refcount.
>=20
> [1] =
https://lore.kernel.org/linux-mm/20200901161459.11772-4-sumit.semwal@linar=
o.org/
> [2] https://lore.kernel.org/linux-mm/202009031031.D32EF57ED@keescook/
> [3] https://lore.kernel.org/linux-mm/202009031022.3834F692@keescook/
> [4] =
https://lore.kernel.org/linux-mm/5d0358ab-8c47-2f5f-8e43-23b89d6a8e95@inte=
l.com/
>=20
> Changes for prctl(2) manual page (in the options section):
>=20
> PR_SET_VMA
> 	Sets an attribute specified in arg2 for virtual memory areas
> 	starting from the address specified in arg3 and spanning the
> 	size specified	in arg4. arg5 specifies the value of the =
attribute
> 	to be set. Note that assigning an attribute to a virtual memory
> 	area might prevent it from being merged with adjacent virtual
> 	memory areas due to the difference in that attribute's value.
>=20
> 	Currently, arg2 must be one of:
>=20
> 	PR_SET_VMA_ANON_NAME
> 		Set a name for anonymous virtual memory areas. arg5 =
should
> 		be a pointer to a null-terminated string containing the
> 		name. The name length including null byte cannot exceed
> 		80 bytes. If arg5 is NULL, the name of the appropriate
> 		anonymous virtual memory areas will be reset. The name
> 		can contain only printable ascii characters (including
>                space), except '[',']','\','$' and '`'.
>=20
>                This feature is available only if the kernel is built =
with
>                the CONFIG_ANON_VMA_NAME option enabled.

For what it=E2=80=99s worth, it=E2=80=99s definitely interesting to see =
this going upstream.
In particular, we would use it for high-level grouping of the data in
production profiling when proper symbolization is not available:

* JVM could associate a name with the memory regions it uses for the JIT
  code so that Linux perf data are associated with a high level name =
like
  "Java JIT" even if the proper Java JIT profiling is not enabled.
* Similar for other JIT engines like v8 - they could annotate the memory
  regions they manage and use as well.
* Traditional memory allocators like tcmalloc can use this as well so
  that the associated name is used in data access profiling via Linux =
perf.

