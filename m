Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF551EE3D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 14:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgFDMAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 08:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgFDMAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:00:02 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7734FC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2020 05:00:00 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a68so3342368vsd.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2020 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DMjslBjEBERxtatQhlSIiUhzA2KXK0/Y8TnVtILLkmY=;
        b=adnHoZp39ynF5T96eE3g+mFFfIxDxnxEmBjFoHuIXaeW/FzCb0vSP/xWr/de6QsCqA
         FwI3RGJvzZfMMLw8+nBdoswtmMAtvqAQDeOTBVSzpxqUcfnp+hj8gzOWJEqTJ7WcnHXh
         5sVxtyBUgUx9uesTVCtK7b/LYYM8o3FwVt6opTw0yVRj9U2o7TqXpBd09ZMKbfwDYUCo
         TuD+sMROMxlc1XhCMBfZJu2fvtqPfzLk7Kog/1soFsC9TN1fOFX3mj34hfacKq1eMmYi
         KheCpa4afVK2CQGwGHS60azeW/SZlRYcO3drndif3isSIOySjpBNeCH2HU6/XNtKx4yK
         sgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DMjslBjEBERxtatQhlSIiUhzA2KXK0/Y8TnVtILLkmY=;
        b=pWANsTJmirsUxAESMSuegOMKG5ZPtCIyiddwT64vqVkowaJSU9twVjss6Q8tHmgzTH
         jmirPJ4L1rhsYIkYKqnPe1G2n/NxoT96GRnUMmt02oXHolBL5Q/RBNt1yqMs84TINFkN
         nH5G0NzSN6ty2EX2KY1IMm/wnE25o8J3eoc/WJdqizP+lSxwCb3tMiP95UHsjwHst6ls
         Y9tcQ2hdrQ5s09nPndMpf3d756s7gkLBt/KHRV3fHD7dhvHxSXvII+kIbXm7KyJ1ObOn
         aPVw68Hgg7/Ecn/I8SiIy8n5pkPWqk9MbH0s/Hj2x0oCDPSP3S2iaL31oI+Yd6qSFGX9
         JQkA==
X-Gm-Message-State: AOAM533NEQD4kJSid7s/Y78d3HwoBScQimVyJODflGAcyfzc7mF1HBHW
        B0MeWnJ1i7mOFTWA39zq1mlVSY/aEeMtQBLAGHGna1aC
X-Google-Smtp-Source: ABdhPJy53yij9hLVZQInjDMggnHCY+ZoIl+RK9fVuU0aDUMo54S9IKMKjuYwTe3P4sismwEwI7SXg2hZFH7caykkc+Q=
X-Received: by 2002:a67:b42:: with SMTP id 63mr2998773vsl.182.1591271999245;
 Thu, 04 Jun 2020 04:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200504110344.17560-1-eesposit@redhat.com> <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 4 Jun 2020 17:29:36 +0530
Message-ID: <CAHLCerM5Fcyyo2p-3_4X=4EYZmjsWxfbD64Pu+1GcsKmaa+nKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To:     David Rientjes <rientjes@google.com>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Jonathan Adams <jwadams@google.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 5, 2020 at 3:07 AM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 4 May 2020, Emanuele Giuseppe Esposito wrote:
>
> > There is currently no common way for Linux kernel subsystems to expose
> > statistics to userspace shared throughout the Linux kernel; subsystems
> > have to take care of gathering and displaying statistics by themselves,
> > for example in the form of files in debugfs. For example KVM has its ow=
n
> > code section that takes care of this in virt/kvm/kvm_main.c, where it s=
ets
> > up debugfs handlers for displaying values and aggregating them from
> > various subfolders to obtain information about the system state (i.e.
> > displaying the total number of exits, calculated by summing all exits o=
f
> > all cpus of all running virtual machines).
> >
> > Allowing each section of the kernel to do so has two disadvantages. Fir=
st,
> > it will introduce redundant code. Second, debugfs is anyway not the rig=
ht
> > place for statistics (for example it is affected by lockdown)
> >
> > In this patch series I introduce statsfs, a synthetic ram-based virtual
> > filesystem that takes care of gathering and displaying statistics for t=
he
> > Linux kernel subsystems.
> >
>
> This is exciting, we have been looking in the same area recently.  Adding
> Jonathan Adams <jwadams@google.com>.
>
> In your diffstat, one thing I notice that is omitted: an update to
> Documentation/* :)  Any chance of getting some proposed Documentation/
> updates with structure of the fs, the per subsystem breakdown, and best
> practices for managing the stats from the kernel level?
>
> > The file system is mounted on /sys/kernel/stats and would be already us=
ed
> > by kvm. Statsfs was initially introduced by Paolo Bonzini [1].
> >
> > Statsfs offers a generic and stable API, allowing any kind of
> > directory/file organization and supporting multiple kind of aggregation=
s
> > (not only sum, but also average, max, min and count_zero) and data type=
s
> > (all unsigned and signed types plus boolean). The implementation, which=
 is
> > a generalization of KVM=E2=80=99s debugfs statistics code, takes care o=
f gathering
> > and displaying information at run time; users only need to specify the
> > values to be included in each source.
> >
> > Statsfs would also be a different mountpoint from debugfs, and would no=
t
> > suffer from limited access due to the security lock down patches. Its m=
ain
> > function is to display each statistics as a file in the desired folder
> > hierarchy defined through the API. Statsfs files can be read, and possi=
bly
> > cleared if their file mode allows it.
> >
> > Statsfs has two main components: the public API defined by
> > include/linux/statsfs.h, and the virtual file system which should end u=
p
> > in /sys/kernel/stats.
> >
> > The API has two main elements, values and sources. Kernel subsystems li=
ke
> > KVM can use the API to create a source, add child
> > sources/values/aggregates and register it to the root source (that on t=
he
> > virtual fs would be /sys/kernel/statsfs).
> >
> > Sources are created via statsfs_source_create(), and each source become=
s a
> > directory in the file system. Sources form a parent-child relationship;
> > root sources are added to the file system via statsfs_source_register()=
.
> > Every other source is added to or removed from a parent through the
> > statsfs_source_add_subordinate and statsfs_source_remote_subordinate AP=
Is.
> > Once a source is created and added to the tree (via add_subordinate), i=
t
> > will be used to compute aggregate values in the parent source.
> >
> > Values represent quantites that are gathered by the statsfs user. Examp=
les
> > of values include the number of vm exits of a given kind, the amount of
> > memory used by some data structure, the length of the longest hash tabl=
e
> > chain, or anything like that. Values are defined with the
> > statsfs_source_add_values function. Each value is defined by a struct
> > statsfs_value; the same statsfs_value can be added to many different
> > sources. A value can be considered "simple" if it fetches data from a
> > user-provided location, or "aggregate" if it groups all values in the
> > subordinates sources that include the same statsfs_value.
> >
>
> This seems like it could have a lot of overhead if we wanted to
> periodically track the totality of subsystem stats as a form of telemetry
> gathering from userspace.  To collect telemetry for 1,000 different stats=
,
> do we need to issue lseek()+read() syscalls for each of them individually
> (or, worse, open()+read()+close())?
>
> Any thoughts on how that can be optimized?  A couple of ideas:
>
>  - an interface that allows gathering of all stats for a particular
>    interface through a single file that would likely be encoded in binary
>    and the responsibility of userspace to disseminate, or
>
>  - an interface that extends beyond this proposal and allows the reader t=
o
>    specify which stats they are interested in collecting and then the
>    kernel will only provide these stats in a well formed structure and
>    also be binary encoded.

Something akin to how ftrace allows you specify the list of functions
in /sys/kernel/debug/tracing/set_ftrace_filter would make this a lot
easier to use than the one-file-per-stat interface.

That would be useful, e.g. in capturing correlated stats periodically
e.g. scheduler, power and thermal stats

> We've found that the one-file-per-stat method is pretty much a show
> stopper from the performance view and we always must execute at least two
> syscalls to obtain a single stat.
>
> Since this is becoming a generic API (good!!), maybe we can discuss
> possible ways to optimize gathering of stats in mass?
>
> > For more information, please consult the kerneldoc documentation in pat=
ch
> > 2 and the sample uses in the kunit tests and in KVM.
> >
> > This series of patches is based on my previous series "libfs: group and
> > simplify linux fs code" and the single patch sent to kvm "kvm_host: uni=
fy
> > VM_STAT and VCPU_STAT definitions in a single place". The former
> > simplifies code duplicated in debugfs and tracefs (from which statsfs i=
s
> > based on), the latter groups all macros definition for statistics in kv=
m
> > in a single common file shared by all architectures.
> >
> > Patch 1 adds a new refcount and kref destructor wrappers that take a
> > semaphore, as those are used later by statsfs. Patch 2 introduces the
> > statsfs API, patch 3 provides extensive tests that can also be used as
> > example on how to use the API and patch 4 adds the file system support.
> > Finally, patch 5 provides a real-life example of statsfs usage in KVM.
> >
> > [1] https://lore.kernel.org/kvm/5d6cdcb1-d8ad-7ae6-7351-3544e2fa366d@re=
dhat.com/?fbclid=3DIwAR18LHJ0PBcXcDaLzILFhHsl3qpT3z2vlG60RnqgbpGYhDv7L43n0Z=
XJY8M
> >
> > Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> >
> > v1->v2 remove unnecessary list_foreach_safe loops, fix wrong indentatio=
n,
> > change statsfs in stats_fs
> >
> > Emanuele Giuseppe Esposito (5):
> >   refcount, kref: add dec-and-test wrappers for rw_semaphores
> >   stats_fs API: create, add and remove stats_fs sources and values
> >   kunit: tests for stats_fs API
> >   stats_fs fs: virtual fs to show stats to the end-user
> >   kvm_main: replace debugfs with stats_fs
> >
> >  MAINTAINERS                     |    7 +
> >  arch/arm64/kvm/Kconfig          |    1 +
> >  arch/arm64/kvm/guest.c          |    2 +-
> >  arch/mips/kvm/Kconfig           |    1 +
> >  arch/mips/kvm/mips.c            |    2 +-
> >  arch/powerpc/kvm/Kconfig        |    1 +
> >  arch/powerpc/kvm/book3s.c       |    6 +-
> >  arch/powerpc/kvm/booke.c        |    8 +-
> >  arch/s390/kvm/Kconfig           |    1 +
> >  arch/s390/kvm/kvm-s390.c        |   16 +-
> >  arch/x86/include/asm/kvm_host.h |    2 +-
> >  arch/x86/kvm/Kconfig            |    1 +
> >  arch/x86/kvm/Makefile           |    2 +-
> >  arch/x86/kvm/debugfs.c          |   64 --
> >  arch/x86/kvm/stats_fs.c         |   56 ++
> >  arch/x86/kvm/x86.c              |    6 +-
> >  fs/Kconfig                      |   12 +
> >  fs/Makefile                     |    1 +
> >  fs/stats_fs/Makefile            |    6 +
> >  fs/stats_fs/inode.c             |  337 ++++++++++
> >  fs/stats_fs/internal.h          |   35 +
> >  fs/stats_fs/stats_fs-tests.c    | 1088 +++++++++++++++++++++++++++++++
> >  fs/stats_fs/stats_fs.c          |  773 ++++++++++++++++++++++
> >  include/linux/kref.h            |   11 +
> >  include/linux/kvm_host.h        |   39 +-
> >  include/linux/refcount.h        |    2 +
> >  include/linux/stats_fs.h        |  304 +++++++++
> >  include/uapi/linux/magic.h      |    1 +
> >  lib/refcount.c                  |   32 +
> >  tools/lib/api/fs/fs.c           |   21 +
> >  virt/kvm/arm/arm.c              |    2 +-
> >  virt/kvm/kvm_main.c             |  314 ++-------
> >  32 files changed, 2772 insertions(+), 382 deletions(-)
> >  delete mode 100644 arch/x86/kvm/debugfs.c
> >  create mode 100644 arch/x86/kvm/stats_fs.c
> >  create mode 100644 fs/stats_fs/Makefile
> >  create mode 100644 fs/stats_fs/inode.c
> >  create mode 100644 fs/stats_fs/internal.h
> >  create mode 100644 fs/stats_fs/stats_fs-tests.c
> >  create mode 100644 fs/stats_fs/stats_fs.c
> >  create mode 100644 include/linux/stats_fs.h
> >
> > --
> > 2.25.2
> >
> >
