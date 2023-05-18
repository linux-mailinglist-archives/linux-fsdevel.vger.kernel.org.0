Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDA17089A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 22:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjERUiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 16:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjERUit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 16:38:49 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16241AB
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 13:38:46 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7576ecfa4e7so245123285a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 13:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684442326; x=1687034326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVJjM3dZpBhYfdGEBjBsaY6bzKlLzf09nB2ohjvenyQ=;
        b=KC7zVJFnzmuXe7Xk2yjmyLWy+hXYZY12nh9dr5q+Klm00Z8PULFOs9h7jquNULU94j
         RP9LceDzWnbdvq5glgB9cue3MEl9uHZBlbSLvQsIkuIsJUYJpxgatOkeKPvm5MVueo9X
         X64e8QhblAYabyyvk/XTwPqRwXZNnC/lCpaXEo2jDguMLoyYlAvltn5QQT1/78CNtmdZ
         3LfOVNLKlIHD0OWtJxk6dvlRLJaKL410nVxUdrN1tBrfNN2dFEcrSHP0ItVe09zB9vnt
         AcoR7ycs0H9WKt4wJxAP/6OZPWNS8XV/0sqPqcYyZcM2tFgTz5PzMhiNy3Bs2IpyGhuo
         HDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684442326; x=1687034326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVJjM3dZpBhYfdGEBjBsaY6bzKlLzf09nB2ohjvenyQ=;
        b=j1XJYmXya8Cxqn8H0Yj9gyPDjWXN2/M9Ml6tfxUAUoeVpzHVmjmIWRnvD85LfG6yn2
         JnCW2cRKYWVStZozNvisXW65hnyjrpRgIAa7pR1+TOuSJR+Rr+I9lq8jHV3yK2iuA9+O
         clX3VLbKL4qZlmJR7QQGwDRIB93DI52n42MdJ6sTWU/+7CMK1PM+Y7A6Om18H8JlMt7e
         T9aCFHRrnXvbM/TrLa0ZLVnNvPAPBlResW4TPIPnXOC2iWh2MQvmuPHNj1iIHjVlurNw
         L1i8vD1PVACiHr6hsttuFX1I0YaCF17PNhD28GajbJz10+5kVZF052uJumt/sN630ucu
         P2JA==
X-Gm-Message-State: AC+VfDwJjMahZrO7Ok24NyYiH2zxQoUEN/uF9IBELX3FUp0N9/C8HSAB
        yT22v9zQetDEQqLw+CQucO8mI09tCDARLHHlofnLAg==
X-Google-Smtp-Source: ACHHUZ5Qh/UxkjKvgP+YRldrEYd7/1rN5xFOnFYDtVx1M5nnlkgpk8xsm5tUVmt/LqR35coaGu/l5CblGt8MPq9NDLI=
X-Received: by 2002:a05:6214:202f:b0:61b:5b9f:f5fd with SMTP id
 15-20020a056214202f00b0061b5b9ff5fdmr571446qvf.41.1684442325664; Thu, 18 May
 2023 13:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n> <ZGVTMnVKNcQDM0x4@x1n> <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
 <CACw3F52MNOVv6KA5n7wRYDT2ujwYkco=aYngbo-zGA3zW1yq+w@mail.gmail.com> <ZGZMtK6PzoTuLZ1b@x1n>
In-Reply-To: <ZGZMtK6PzoTuLZ1b@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 18 May 2023 13:38:09 -0700
Message-ID: <CAJHvVcgcYPu-G3RDVrkrM_J48NUiUY0SH0G1sd+=X9BDgnQEuQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
To:     Peter Xu <peterx@redhat.com>
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        James Houghton <jthoughton@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anish Moorthy <amoorthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 9:05=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, May 17, 2023 at 05:43:53PM -0700, Jiaqi Yan wrote:
> > On Wed, May 17, 2023 at 3:29=E2=80=AFPM Axel Rasmussen <axelrasmussen@g=
oogle.com> wrote:
> > >
> > > On Wed, May 17, 2023 at 3:20=E2=80=AFPM Peter Xu <peterx@redhat.com> =
wrote:
> > > >
> > > > On Wed, May 17, 2023 at 06:12:33PM -0400, Peter Xu wrote:
> > > > > On Thu, May 11, 2023 at 03:00:09PM -0700, James Houghton wrote:
> > > > > > On Thu, May 11, 2023 at 11:24=E2=80=AFAM Axel Rasmussen
> > > > > > <axelrasmussen@google.com> wrote:
> > > > > > >
> > > > > > > So the basic way to use this new feature is:
> > > > > > >
> > > > > > > - On the new host, the guest's memory is registered with user=
faultfd, in
> > > > > > >   either MISSING or MINOR mode (doesn't really matter for thi=
s purpose).
> > > > > > > - On any first access, we get a userfaultfd event. At this po=
int we can
> > > > > > >   communicate with the old host to find out if the page was p=
oisoned.
> > > > > > > - If so, we can respond with a UFFDIO_SIGBUS - this places a =
swap marker
> > > > > > >   so any future accesses will SIGBUS. Because the pte is now =
"present",
> > > > > > >   future accesses won't generate more userfaultfd events, the=
y'll just
> > > > > > >   SIGBUS directly.
> > > > > >
> > > > > > I want to clarify the SIGBUS mechanism here when KVM is involve=
d,
> > > > > > keeping in mind that we need to be able to inject an MCE into t=
he
> > > > > > guest for this to be useful.
> > > > > >
> > > > > > 1. vCPU gets an EPT violation --> KVM attempts GUP.
> > > > > > 2. GUP finds a PTE_MARKER_UFFD_SIGBUS and returns VM_FAULT_SIGB=
US.
> > > > > > 3. KVM finds that GUP failed and returns -EFAULT.
> > > > > >
> > > > > > This is different than if GUP found poison, in which case KVM w=
ill
> > > > > > actually queue up a SIGBUS *containing the address of the fault=
*, and
> > > > > > userspace can use it to inject an appropriate MCE into the gues=
t. With
> > > > > > UFFDIO_SIGBUS, we are missing the address!
> > > > > >
> > > > > > I see three options:
> > > > > > 1. Make KVM_RUN queue up a signal for any VM_FAULT_SIGBUS. I th=
ink
> > > > > > this is pointless.
> > > > > > 2. Don't have UFFDIO_SIGBUS install a PTE entry, but instead ha=
ve a
> > > > > > UFFDIO_WAKE_MODE_SIGBUS, where upon waking, we return VM_FAULT_=
SIGBUS
> > > > > > instead of VM_FAULT_RETRY. We will keep getting userfaults on r=
epeated
> > > > > > accesses, just like how we get repeated signals for real poison=
.
> > > > > > 3. Use this in conjunction with the additional KVM EFAULT info =
that
> > > > > > Anish proposed (the first part of [1]).
> > > > > >
> > > > > > I think option 3 is fine. :)
> > > > >
> > > > > Or... option 4) just to use either MADV_HWPOISON or hwpoison-inje=
ct? :)
> > > >
> > > > I just remember Axel mentioned this in the commit message, and just=
 in case
> > > > this is why option 4) was ruled out:
> > > >
> > > >         They expect that once poisoned, pages can never become
> > > >         "un-poisoned". So, when we live migrate the VM, we need to =
preserve
> > > >         the poisoned status of these pages.
> > > >
> > > > Just to supplement on this point: we do have unpoison (echoing to
> > > > "debug/hwpoison/hwpoison_unpoison"), or am I wrong?
> >
> > If I read unpoison_memory() correctly, once there is a real hardware
> > memory corruption (hw_memory_failure will be set), unpoison will stop
> > working and return EOPNOTSUPP.
> >
> > I know some cloud providers evacuating VMs once a single memory error
> > happens, so not supporting unpoison is probably not a big deal for
> > them. BUT others do keep VM running until more errors show up later,
> > which could be long after the 1st error.
>
> We're talking about postcopy migrating a VM has poisoned page on src,
> rather than on dst host, am I right?  IOW, the dest hwpoison should be
> fake.
>
> If so, then I would assume that's the case where all the pages on the des=
t
> host is still all good (so hw_memory_failure not yet set, or I doubt the
> judgement of being a migration target after all)?
>
> The other thing is even if dest host has hw poisoned page, I'm not sure
> whether hw_memory_failure is the only way to solve this.
>
> I saw that this is something got worked on before from Zhenwei, David use=
d
> to have some reasoning on why it was suggested like using a global knob:
>
> https://lore.kernel.org/all/d7927214-e433-c26d-7a9c-a291ced81887@redhat.c=
om/
>
> Two major issues here afaics:
>
>   - Zhenwei's approach only considered x86 hwpoison - it relies on kpte
>     having !present in entries but that's x86 specific rather than generi=
c
>     to memory_failure.c.
>
>   - It is _assumed_ that hwpoison injection is for debugging only.
>
> I'm not sure whether you can fix 1) by some other ways, e.g., what if the
> host just remember all the hardware poisoned pfns (or remember
> soft-poisoned ones, but then here we need to be careful on removing them
> from the list when it's hwpoisoned for real)?  It sounds like there's
> opportunity on providing a generic solution rather than relying on
> !pte_present().
>
> For 2) IMHO that's not a big issue, you can declare it'll be used in !deb=
ug
> but production systems so as to boost the feature importance with a real
> use case.
>
> So far I'd say it'll be great to leverage what it's already there in linu=
x
> and make it as generic as possible. The only issue is probably
> CAP_ADMIN... not sure whether we can have some way to provide !ADMIN
> somehow, or you can simply work around this issue.

As you mention below I think the key distinction is the scope - I
think MADV_HWPOISON affects the whole system, including other
processes.

For our purposes, we really just want to "poison" this particular
virtual address (the HVA, from the VM's perspective), not even other
mappings of the same shared memory. I think that behavior is different
from MADV_HWPOISON, at least.

>
> >
> > > >
> > > > >
> > > > > Besides what James mentioned on "missing addr", I didn't quickly =
see what's
> > > > > the major difference comparing to the old hwpoison injection meth=
ods even
> > > > > without the addr requirement. If we want the addr for MCE then it=
's more of
> > > > > a question to ask.
> > > > >
> > > > > I also didn't quickly see why for whatever new way to inject a pt=
e error we
> > > > > need to have it registered with uffd.  Could it be something like
> > > > > MADV_PGERR (even if MADV_HWPOISON won't suffice) so you can injec=
t even
> > > > > without an userfault context (but still usable when uffd register=
ed)?
> > > > >
> > > > > And it'll be alawys nice to have a cover letter too (if there'll =
be a new
> > > > > version) explaining the bits.
> > >
> > > I do plan a v2, if for no other reason than to update the
> > > documentation. Happy to add a cover letter with it as well.
> > >
> > > +Jiaqi back to CC, this is one piece of a larger memory poisoning /
> > > recovery design Jiaqi is working on, so he may have some ideas why
> > > MADV_HWPOISON or MADV_PGER will or won't work.
> >
> > Per https://man7.org/linux/man-pages/man2/madvise.2.html,
> > MADV_HWPOISON "is available only for privileged (CAP_SYS_ADMIN)
> > processes." So for a non-root VMM, MADV_HWPOISON is out of option.
>
> It makes sense to me especially when the page can be shared with other
> tasks.
>
> >
> > Another issue with MADV_HWPOISON is, it requires to first successfully
> > get_user_pages_fast(). I don't think it will work if memory is not
> > mapped yet.
>
> Fair point, so probably current MADV_HWPOISON got ruled out.
> hwpoison-inject seems fine where only the PFN is needed rather than the
> pte. But same issue on CAP_ADMIN indeed.
>
> >
> > With the UFFDIO_SIGBUS feature introduced in this patchset, it may
> > even be possible to free the emulated-hwpoison page back to the kernel
> > so we don't lose a 4K page.
> >
> > I didn't find any ref/doc for MADV_PGERR. Is it something you suggest
> > to build, Peter?
>
> That's something I made up just to show my question on why such an
> interface (even if wanted) needs to be bound to userfaultfd, e.g. a
> madvise() seems working if someone sololy want to install a poisoned pte.

I look at it a bit differently...

Even existing UFFDIO_* operations could technically be separated from
userfaultfd. You could imagine a MADV_MAP_PAGE instead of
UFFDIO_CONTINUE. UFFDIO_COPY is a bit trickier since it takes an
argument, but it could be done with process_madvise(). (Granted, I'm
not sure this would be useful... But this is equally true for
UFFDIO_SIGBUS; it seems non-live-migration use cases could use
MADV_HWPOISON, and for live migration use cases we will be using
UFFD.)

We've sort of setup a convention with userfaultfd where at a high
level users are supposed to:

1. Receive events from the uffd
2. Resolve those events with UFFDIO_* ioctls
3. Wake up with UFFDIO_WAKE to retry the fault that generated the
original event (can be combined with step 2 of course)

So for me, even if MADV_PGERR or similar existed, I would be tempted
to add a UFFDIO_SIGBUS as well, even if it just calls the same
underlying function to do the same thing, if only for consistency
(with the idea "UFFD events are resolved by UFFD ioctls") from the
user's perspective.


>
> IIUC even with an madvise one may not need CAP_ADMIN since we can limit t=
he
> op to current mm only, I assume it's safe.
>
> Here you'd want to return VM_FAULT_HWPOISON for whatever swap pte you'd
> like to install (in do_swap_page) with whatever new interface (assuming
> still a new madvise). As James mentioned, I think KVM liked that to
> recognize -EHWPOISON from -EFAULT.  I'd say we can even consider reusing
> PTE_MARKER_SWAPIN_ERROR to let it just return VM_FAULT_HWPOISON directly =
if
> so.
>
> Thanks,
>
> --
> Peter Xu
>
