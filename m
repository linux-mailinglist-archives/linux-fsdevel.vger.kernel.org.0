Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD62776F8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 07:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjHJF3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 01:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjHJF3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:29:48 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB09F1704
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 22:29:47 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-583fe10bb3cso6972627b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Aug 2023 22:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691645387; x=1692250187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uoKPPUVJQJvxmsNX8HdKmHcwGoP8j8tE48dXRoXR/o=;
        b=mzZ96Ky/PAAf413iiveXZmgW90wIqSR/MJMOaUb3WJrDqIlkNWalvVdCinPsqCcpGd
         0N1W6RdHTOisjFF8yVEaAPEwSOgkyh9aVG7dS6/wPDY8VQ8k55dEOXkSBbxth1cdshKu
         KuVJ0xLBtzLhbi7oy8MQMA3diIYQtyKxWimeja88GgIhwf5/WDE353lXkehBDgzF7tPR
         0ET5tP0Fyxa6xJY8lp/20m98rMqh9YGqkgAVlnu1t4YxE0KLdchG6oCYJXCU2qcFrvWB
         LCI+109wtD8KzZ8uyZi8/qgjzatRXooagunLE+qL8AO9leSJ60WXDgnBjD780d3Rg+CN
         M4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691645387; x=1692250187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uoKPPUVJQJvxmsNX8HdKmHcwGoP8j8tE48dXRoXR/o=;
        b=dOf7Ore0TxrLqD6wGE2e6U64QNp5BwgKjyKj2xsf5xBvprSv5ynJjaA9yW6I+aTMve
         cqRzLaPEE15XNniVJsx1e5IysKjCD7xxiUSJLnQARJJmQTIMMP1gc9/mIeFojdSNf7cn
         UvdcCNcUBJoNX+CGgkZ06QqfQzhMHKHp/VEd7XXrxCRAypwvKqAWIxsfUh002MAdpARY
         5RBe/vzj1EDTFp6Un3jrSusONF2OrlWAZy+GoBjirMt11rzj5/aMHkHbEbL8oM+xDWgj
         kDar8io1fU93OxFbDc8VsKqHC5ORDxksWllXIyEf/Y7rbBQp5Pucu+q7aePpeHLp+4wV
         SNBw==
X-Gm-Message-State: AOJu0YxeUFn9fMCQNL1xwWm97sGAMOwa4mkm6YVEuhSHzU25UhShPRHM
        sUBF2SUNbzd3kbLG3Q/54bcNds+v8X1Ass/SDnh+rw==
X-Google-Smtp-Source: AGHT+IGzAcGbdmxpwXQwtenXA6IAHlZx6Spg93JJ19ndyf0aos6wu+/eP5nmq4DyCWY4KDBzCxs8VUzXGduln/PfdhE=
X-Received: by 2002:a0d:dd08:0:b0:573:30c8:6e1d with SMTP id
 g8-20020a0ddd08000000b0057330c86e1dmr1491956ywe.44.1691645386722; Wed, 09 Aug
 2023 22:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com> <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
 <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
 <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com>
 <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com> <CAJuCfpEs2k8mHM+9uq05vmcOYCfkNnOb4s3xPSoWheizPkcwLA@mail.gmail.com>
 <CAJuCfpERuCx6QvfejUkS-ysMxbzp3mFfhCbH=rDtt2UGzbwtyg@mail.gmail.com>
In-Reply-To: <CAJuCfpERuCx6QvfejUkS-ysMxbzp3mFfhCbH=rDtt2UGzbwtyg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 9 Aug 2023 22:29:34 -0700
Message-ID: <CAJuCfpH-drRnwqUqynTnvgqSjs=_Fwc0H_7h6nzsdztRef0oKw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, peterx@redhat.com, ying.huang@intel.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 9, 2023 at 11:31=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Aug 9, 2023 at 11:08=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Wed, Aug 9, 2023 at 11:04=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> > >
> > > >>>> Which ends up being
> > > >>>>
> > > >>>> VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> > > >>>>
> > > >>>> I did not check if this is also the case on mainline, and if thi=
s series is responsible.
> > > >>>
> > > >>> Thanks for reporting! I'm checking it now.
> > > >>
> > > >> Hmm. From the code it's not obvious how lock_mm_and_find_vma() end=
s up
> > > >> calling find_vma() without mmap_lock after successfully completing
> > > >> get_mmap_lock_carefully(). lock_mm_and_find_vma+0x3f/0x270 points =
to
> > > >> the first invocation of find_vma(), so this is not even the lock
> > > >> upgrade path... I'll try to reproduce this issue and dig up more b=
ut
> > > >> from the information I have so far this issue does not seem to be
> > > >> related to this series.
> > >
> > > I just checked on mainline and it does not fail there.
>
> Thanks. Just to eliminate the possibility, I'll try reverting my
> patchset in mm-unstable and will try the test again. Will do that in
> the evening once I'm home.
>
> > >
> > > >
> > > > This is really weird. I added mmap_assert_locked(mm) calls into
> > > > get_mmap_lock_carefully() right after we acquire mmap_lock read loc=
k
> > > > and one of them triggers right after successful
> > > > mmap_read_lock_killable(). Here is my modified version of
> > > > get_mmap_lock_carefully():
> > > >
> > > > static inline bool get_mmap_lock_carefully(struct mm_struct *mm,
> > > > struct pt_regs *regs) {
> > > >       /* Even if this succeeds, make it clear we might have slept *=
/
> > > >       if (likely(mmap_read_trylock(mm))) {
> > > >           might_sleep();
> > > >           mmap_assert_locked(mm);
> > > >           return true;
> > > >       }
> > > >       if (regs && !user_mode(regs)) {
> > > >           unsigned long ip =3D instruction_pointer(regs);
> > > >           if (!search_exception_tables(ip))
> > > >               return false;
> > > >       }
> > > >       if (!mmap_read_lock_killable(mm)) {
> > > >           mmap_assert_locked(mm);                     <---- generat=
es a BUG
> > > >           return true;
> > > >       }
> > > >       return false;
> > > > }
> > >
> > > Ehm, that's indeed weird.
> > >
> > > >
> > > > AFAIKT conditions for mmap_read_trylock() and
> > > > mmap_read_lock_killable() are checked correctly. Am I missing
> > > > something?
> > >
> > > Weirdly enough, it only triggers during that specific uffd test, righ=
t?
> >
> > Yes, uffd-unit-tests. I even ran it separately to ensure it's not some
> > fallback from a previous test and I'm able to reproduce this
> > consistently.

Yeah, it is somehow related to per-vma locking. Unfortunately I can't
reproduce the issue on my VM, so I have to use my host and bisection
is slow. I think I'll get to the bottom of this tomorrow.

> >
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
