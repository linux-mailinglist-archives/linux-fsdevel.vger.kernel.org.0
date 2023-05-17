Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F2870756F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 00:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjEQW3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 18:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEQW3P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 18:29:15 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA7B59FD
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 15:29:13 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6237faa8677so6216916d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 15:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684362552; x=1686954552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2BAYWqQjLBVkE55QBWk4MFNy2EEFsBkFqfU0qi3jzc=;
        b=M+WlNWdcv9Cj8/VGWAKAsYqCgExA/M4rLKGdFF8/npUX4+QKU2Jdh4rGJInziOkc06
         osc5shbKCWK2/zUsItJLjJLF8OQs4gZTwJ3KwQ/awo9F5wliR92evQJxQTr/s8VATbPn
         V1ciBuxnbdZYpX+lFYfWTbZ7MJoA/YCHRf7ZaRq/UZwEF3OywvlaAHY+WaapyLNudmAQ
         8szFUz+2/21OEWWQPzpATMbuH+QcBzzCqGTjOG2KmIzine92NOWjNXZu0H9U/qE3Gy1R
         uZtzj3xFn+Y9FLGGPappEm7s5I5/dozIXeJNSS8So42TNY4NElzX9HRJyZ9BVcWNTNq5
         rEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684362552; x=1686954552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2BAYWqQjLBVkE55QBWk4MFNy2EEFsBkFqfU0qi3jzc=;
        b=H9rr7W5fvyxd907Zo600Ie4huQYRl00sm6PFtyfAyg9+VoxQGvAFOS9F0RdbuitGgi
         koFOhKnqSqa/HaZ4yKjdSbLFO8Qz/e69S33Fe1AbcEgUIiHK6P9UIy8lyJ7or6aKQBHY
         9hA3E+IKXd9vsm8qgPX4mNFhspAmX+7NXfQDhyZwte3xeHtobH/XPnsmxnabZwfX+wed
         5RVs65T6HKGp8sRMLnBeVO/vgIlmPuMlkOI7fr7tviKwoLwVFlM5LvjQF97VjzPZvfyM
         QSkFmpJFrTYd25Ei/o51pRD39o37j4S360TPSEW7fNS3HHY58R910X2qrVUP0fIIKNGb
         EeCw==
X-Gm-Message-State: AC+VfDy9LHzBkN2XJup6NnWDeTV6zDe9CpA2KC8+wNePF/hDlJ4c8Cd4
        0W3gTXhD2fzut7Celp8GYIJ1zCOqLk9vPOsl8fFZcw==
X-Google-Smtp-Source: ACHHUZ7Guasa0/glqZ3dMmdq/YN/vt/4W8KhAwxFkhzCAtGjBDLBN6DpJintMitaajo2c9Cb/otlw/043fECueJm72c=
X-Received: by 2002:a05:6214:518b:b0:621:64c7:235f with SMTP id
 kl11-20020a056214518b00b0062164c7235fmr2158490qvb.27.1684362552551; Wed, 17
 May 2023 15:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n> <ZGVTMnVKNcQDM0x4@x1n>
In-Reply-To: <ZGVTMnVKNcQDM0x4@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 17 May 2023 15:28:36 -0700
Message-ID: <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
To:     Peter Xu <peterx@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
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
        Anish Moorthy <amoorthy@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>
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

On Wed, May 17, 2023 at 3:20=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, May 17, 2023 at 06:12:33PM -0400, Peter Xu wrote:
> > On Thu, May 11, 2023 at 03:00:09PM -0700, James Houghton wrote:
> > > On Thu, May 11, 2023 at 11:24=E2=80=AFAM Axel Rasmussen
> > > <axelrasmussen@google.com> wrote:
> > > >
> > > > So the basic way to use this new feature is:
> > > >
> > > > - On the new host, the guest's memory is registered with userfaultf=
d, in
> > > >   either MISSING or MINOR mode (doesn't really matter for this purp=
ose).
> > > > - On any first access, we get a userfaultfd event. At this point we=
 can
> > > >   communicate with the old host to find out if the page was poisone=
d.
> > > > - If so, we can respond with a UFFDIO_SIGBUS - this places a swap m=
arker
> > > >   so any future accesses will SIGBUS. Because the pte is now "prese=
nt",
> > > >   future accesses won't generate more userfaultfd events, they'll j=
ust
> > > >   SIGBUS directly.
> > >
> > > I want to clarify the SIGBUS mechanism here when KVM is involved,
> > > keeping in mind that we need to be able to inject an MCE into the
> > > guest for this to be useful.
> > >
> > > 1. vCPU gets an EPT violation --> KVM attempts GUP.
> > > 2. GUP finds a PTE_MARKER_UFFD_SIGBUS and returns VM_FAULT_SIGBUS.
> > > 3. KVM finds that GUP failed and returns -EFAULT.
> > >
> > > This is different than if GUP found poison, in which case KVM will
> > > actually queue up a SIGBUS *containing the address of the fault*, and
> > > userspace can use it to inject an appropriate MCE into the guest. Wit=
h
> > > UFFDIO_SIGBUS, we are missing the address!
> > >
> > > I see three options:
> > > 1. Make KVM_RUN queue up a signal for any VM_FAULT_SIGBUS. I think
> > > this is pointless.
> > > 2. Don't have UFFDIO_SIGBUS install a PTE entry, but instead have a
> > > UFFDIO_WAKE_MODE_SIGBUS, where upon waking, we return VM_FAULT_SIGBUS
> > > instead of VM_FAULT_RETRY. We will keep getting userfaults on repeate=
d
> > > accesses, just like how we get repeated signals for real poison.
> > > 3. Use this in conjunction with the additional KVM EFAULT info that
> > > Anish proposed (the first part of [1]).
> > >
> > > I think option 3 is fine. :)
> >
> > Or... option 4) just to use either MADV_HWPOISON or hwpoison-inject? :)
>
> I just remember Axel mentioned this in the commit message, and just in ca=
se
> this is why option 4) was ruled out:
>
>         They expect that once poisoned, pages can never become
>         "un-poisoned". So, when we live migrate the VM, we need to preser=
ve
>         the poisoned status of these pages.
>
> Just to supplement on this point: we do have unpoison (echoing to
> "debug/hwpoison/hwpoison_unpoison"), or am I wrong?
>
> >
> > Besides what James mentioned on "missing addr", I didn't quickly see wh=
at's
> > the major difference comparing to the old hwpoison injection methods ev=
en
> > without the addr requirement. If we want the addr for MCE then it's mor=
e of
> > a question to ask.
> >
> > I also didn't quickly see why for whatever new way to inject a pte erro=
r we
> > need to have it registered with uffd.  Could it be something like
> > MADV_PGERR (even if MADV_HWPOISON won't suffice) so you can inject even
> > without an userfault context (but still usable when uffd registered)?
> >
> > And it'll be alawys nice to have a cover letter too (if there'll be a n=
ew
> > version) explaining the bits.

I do plan a v2, if for no other reason than to update the
documentation. Happy to add a cover letter with it as well.

+Jiaqi back to CC, this is one piece of a larger memory poisoning /
recovery design Jiaqi is working on, so he may have some ideas why
MADV_HWPOISON or MADV_PGER will or won't work.

One idea is, at least for our use case, we have to have the range be
userfaultfd registered, because we need to intercept the first access
and check at that point whether or not it should be poisoned. But, I
think in principle a scheme like this could work:

1. Intercept first access with UFFD
2. Issue MADV_HWPOISON or MADV_PGERR or etc to put a pte denoting the
poisoned page in place
3. UFFDIO_WAKE to have the faulting thread retry, see the new entry, and SI=
GBUS

It's arguably slightly weird, since normally UFFD events are resolved
with UFFDIO_* operations, but I don't see why it *couldn't* work.

Then again I am not super familiar with MADV_HWPOISON, I will have to
do a bit of reading to understand if its semantics are the same
(future accesses to this address get SIGBUS).


> >
> > Thanks,
> >
> > --
> > Peter Xu
>
> --
> Peter Xu
>
