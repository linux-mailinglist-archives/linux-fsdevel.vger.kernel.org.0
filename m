Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC70707710
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 02:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjERAoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 20:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjERAoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 20:44:06 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020E83A9C
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 17:44:05 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-561b43fc896so13652587b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 17:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684370644; x=1686962644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXKMOzqC/UtqsX5IYZEI7ZxYrpvsnXCXl/LYrRajGXI=;
        b=hTiqWTp2Vbh4DYbynTTuVhSnOKuJ+ybN0yY8fDHNfQZ0Kpooe2O9U2QOat9axli8+E
         IRILo5iXuDLZMsc0Yxnqz2eG+3Bar9+xuR+DlYraB6e3F8k9+kr3TPEJsxEfQNZGmy9x
         BllTdLin9RAI6H3BHokLJYGVzBbe85vmfzjbyQF3F1PLf/gDGm4EYVUy61RWUmm1LItq
         qB25bUthFrAneMvx9f9RCeTY0/2TB1UAh7Ki48NE1UcQ7d+L+R3gcS82jZJ17fWf4Why
         i4EDqnHdimZpkDj27A+nwDuY8AoeJaikYp7XT+Z+xtHKxA6ETMiHE7ezR6BKhS2Yycjb
         xpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684370644; x=1686962644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXKMOzqC/UtqsX5IYZEI7ZxYrpvsnXCXl/LYrRajGXI=;
        b=UTQgLJTXViRZ5mi+ghPld1XIPdNLWc4K91mkgXWEI4TG5LvRhiZuaEjJ2JcyMAc3+U
         i9Y7rM853ezVacJLz1CXUzXwd6AGtDXmHZKCb/iQhs5I+bAk9Mr7iRwNazssB+PoWDEd
         VvgCp+fzVCXxql33fhByqpMqmjQwyQQXtMftHC9ZmEiZW3VCyC8XNx+hmMj/WW/RBSlF
         TbZ4PLLvo2P8IHONkDBYM+30o7LO3h6Issu0DgOdp18OcCqyaJ4xfiwpsOfABPR8E86H
         CzHDlcB1hHsjbEOgoG/xBXgoNad+jCBOFYVwksI2MI+91Ae+dqGhJ0LqX3QToym4jwoG
         EF/g==
X-Gm-Message-State: AC+VfDxAOehnGjXSUp0SqLfnP7nEJ6dUruozgvnMUTCxm4cCvhjbXMp2
        tMg/khaFN+9Pwdg2aTmt6dQRx1P10MwMuKaEEYOnmg==
X-Google-Smtp-Source: ACHHUZ6B0Jo5j3y6tRqThQCA05429gGG0JHEdt0NDntdUD9hG2VL1i0ANB8FRTNz2T9txPnkqsAnd5ReopjfsnFvS6k=
X-Received: by 2002:a81:5257:0:b0:561:beec:89d3 with SMTP id
 g84-20020a815257000000b00561beec89d3mr40844ywb.6.1684370644059; Wed, 17 May
 2023 17:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n> <ZGVTMnVKNcQDM0x4@x1n> <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
In-Reply-To: <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Wed, 17 May 2023 17:43:53 -0700
Message-ID: <CACw3F52MNOVv6KA5n7wRYDT2ujwYkco=aYngbo-zGA3zW1yq+w@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        James Houghton <jthoughton@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 3:29=E2=80=AFPM Axel Rasmussen <axelrasmussen@googl=
e.com> wrote:
>
> On Wed, May 17, 2023 at 3:20=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Wed, May 17, 2023 at 06:12:33PM -0400, Peter Xu wrote:
> > > On Thu, May 11, 2023 at 03:00:09PM -0700, James Houghton wrote:
> > > > On Thu, May 11, 2023 at 11:24=E2=80=AFAM Axel Rasmussen
> > > > <axelrasmussen@google.com> wrote:
> > > > >
> > > > > So the basic way to use this new feature is:
> > > > >
> > > > > - On the new host, the guest's memory is registered with userfaul=
tfd, in
> > > > >   either MISSING or MINOR mode (doesn't really matter for this pu=
rpose).
> > > > > - On any first access, we get a userfaultfd event. At this point =
we can
> > > > >   communicate with the old host to find out if the page was poiso=
ned.
> > > > > - If so, we can respond with a UFFDIO_SIGBUS - this places a swap=
 marker
> > > > >   so any future accesses will SIGBUS. Because the pte is now "pre=
sent",
> > > > >   future accesses won't generate more userfaultfd events, they'll=
 just
> > > > >   SIGBUS directly.
> > > >
> > > > I want to clarify the SIGBUS mechanism here when KVM is involved,
> > > > keeping in mind that we need to be able to inject an MCE into the
> > > > guest for this to be useful.
> > > >
> > > > 1. vCPU gets an EPT violation --> KVM attempts GUP.
> > > > 2. GUP finds a PTE_MARKER_UFFD_SIGBUS and returns VM_FAULT_SIGBUS.
> > > > 3. KVM finds that GUP failed and returns -EFAULT.
> > > >
> > > > This is different than if GUP found poison, in which case KVM will
> > > > actually queue up a SIGBUS *containing the address of the fault*, a=
nd
> > > > userspace can use it to inject an appropriate MCE into the guest. W=
ith
> > > > UFFDIO_SIGBUS, we are missing the address!
> > > >
> > > > I see three options:
> > > > 1. Make KVM_RUN queue up a signal for any VM_FAULT_SIGBUS. I think
> > > > this is pointless.
> > > > 2. Don't have UFFDIO_SIGBUS install a PTE entry, but instead have a
> > > > UFFDIO_WAKE_MODE_SIGBUS, where upon waking, we return VM_FAULT_SIGB=
US
> > > > instead of VM_FAULT_RETRY. We will keep getting userfaults on repea=
ted
> > > > accesses, just like how we get repeated signals for real poison.
> > > > 3. Use this in conjunction with the additional KVM EFAULT info that
> > > > Anish proposed (the first part of [1]).
> > > >
> > > > I think option 3 is fine. :)
> > >
> > > Or... option 4) just to use either MADV_HWPOISON or hwpoison-inject? =
:)
> >
> > I just remember Axel mentioned this in the commit message, and just in =
case
> > this is why option 4) was ruled out:
> >
> >         They expect that once poisoned, pages can never become
> >         "un-poisoned". So, when we live migrate the VM, we need to pres=
erve
> >         the poisoned status of these pages.
> >
> > Just to supplement on this point: we do have unpoison (echoing to
> > "debug/hwpoison/hwpoison_unpoison"), or am I wrong?

If I read unpoison_memory() correctly, once there is a real hardware
memory corruption (hw_memory_failure will be set), unpoison will stop
working and return EOPNOTSUPP.

I know some cloud providers evacuating VMs once a single memory error
happens, so not supporting unpoison is probably not a big deal for
them. BUT others do keep VM running until more errors show up later,
which could be long after the 1st error.

> >
> > >
> > > Besides what James mentioned on "missing addr", I didn't quickly see =
what's
> > > the major difference comparing to the old hwpoison injection methods =
even
> > > without the addr requirement. If we want the addr for MCE then it's m=
ore of
> > > a question to ask.
> > >
> > > I also didn't quickly see why for whatever new way to inject a pte er=
ror we
> > > need to have it registered with uffd.  Could it be something like
> > > MADV_PGERR (even if MADV_HWPOISON won't suffice) so you can inject ev=
en
> > > without an userfault context (but still usable when uffd registered)?
> > >
> > > And it'll be alawys nice to have a cover letter too (if there'll be a=
 new
> > > version) explaining the bits.
>
> I do plan a v2, if for no other reason than to update the
> documentation. Happy to add a cover letter with it as well.
>
> +Jiaqi back to CC, this is one piece of a larger memory poisoning /
> recovery design Jiaqi is working on, so he may have some ideas why
> MADV_HWPOISON or MADV_PGER will or won't work.

Per https://man7.org/linux/man-pages/man2/madvise.2.html,
MADV_HWPOISON "is available only for privileged (CAP_SYS_ADMIN)
processes." So for a non-root VMM, MADV_HWPOISON is out of option.

Another issue with MADV_HWPOISON is, it requires to first successfully
get_user_pages_fast(). I don't think it will work if memory is not
mapped yet.

With the UFFDIO_SIGBUS feature introduced in this patchset, it may
even be possible to free the emulated-hwpoison page back to the kernel
so we don't lose a 4K page.

I didn't find any ref/doc for MADV_PGERR. Is it something you suggest
to build, Peter?


>
> One idea is, at least for our use case, we have to have the range be
> userfaultfd registered, because we need to intercept the first access
> and check at that point whether or not it should be poisoned. But, I
> think in principle a scheme like this could work:
>
> 1. Intercept first access with UFFD
> 2. Issue MADV_HWPOISON or MADV_PGERR or etc to put a pte denoting the
> poisoned page in place
> 3. UFFDIO_WAKE to have the faulting thread retry, see the new entry, and =
SIGBUS
>
> It's arguably slightly weird, since normally UFFD events are resolved
> with UFFDIO_* operations, but I don't see why it *couldn't* work.
>
> Then again I am not super familiar with MADV_HWPOISON, I will have to
> do a bit of reading to understand if its semantics are the same
> (future accesses to this address get SIGBUS).
>
>
> > >
> > > Thanks,
> > >
> > > --
> > > Peter Xu
> >
> > --
> > Peter Xu
> >
