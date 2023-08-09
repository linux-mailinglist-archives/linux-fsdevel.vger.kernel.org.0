Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351157766F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 20:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjHISIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 14:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjHISIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:08:38 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D271982
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 11:08:37 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d4b74a4a6daso54348276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Aug 2023 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691604516; x=1692209316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJzClEoz6IMsRxIOF5gI29NCybcSus5ECJlvXn3OVwQ=;
        b=4V9m2O3VSW4giKGWZXkYqXUEfZ+ya+2PaBk+wpZ3LaTiq70AzqAVcqqq9Xot4dPyFR
         XUCFXNcDUNrAn/yp8yfK4n6/O1J5O8AmwMr6VJhdcrcHZrGGcShjk8X2cIUQcXyuogmu
         x7ZABjYw6lmSK/4PBnyzhQx0wfwH6HiCWW3Hpj/4DcZkayi+2k9et5vnSKuij4o7+O4o
         2fCHjcNa06DY2WB8QnJTI2UfHKuQNPQXgPjjsJntyv1xH2QdzReGorxvfU9So9RGy1hl
         a1U+Rl2qx1gkoe1sTYNs5RprdJcA/yXcgshkYJ7dofL2RATv76vF8Uw0p0rGrdC1Wafr
         YhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691604516; x=1692209316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJzClEoz6IMsRxIOF5gI29NCybcSus5ECJlvXn3OVwQ=;
        b=b+UhkFpss2z8j2Ihvf1zlXEj+tZT4lCZfg2CEsfRtrHmPZVTboSk9Dlniu0hekNH7f
         SRiyORRrwb2mkWlaZ8IhJFQrc7OZBiAaRtio/rD3AzCcXLQx6hyciUlf9u17mTjJv6po
         uAht9PMbqYckAsvHoazS2NhsoKXlcXu8hmdu2MWXHwj6LEzMt4lPpDZMWsewenxZ74aW
         hn7e4elJnqYlo5kiCtD8aFkBhg0zvlIlZ9pyomzay2RfIezqT0OyDHzBUL9SanqJXluS
         Q+VKzX32AUe4p9dvGbJgZ6tEVVpc34++9oO7O8liLgQgQlTP4Y63R4qAWu0PVUYlXQ0Z
         kJ9g==
X-Gm-Message-State: AOJu0Yy0OF/ySOP+nw/vpX6SJ7UhMjJEjrmqILo3NCYv2hoth8ME/uFj
        UKmg1oCYojaXfUcUWVPTkxWMb93yOhtCXeDowu2Y+g==
X-Google-Smtp-Source: AGHT+IFwckYOOmT9AcClWHBNhiA8LoX6mDtqZnfW0TFz/V19ZZ3p3H3RQZcJf+Q66RNjX4BmzPPohsVY0tPM+d0txnc=
X-Received: by 2002:a25:dbc8:0:b0:d63:645:1991 with SMTP id
 g191-20020a25dbc8000000b00d6306451991mr156266ybf.58.1691604516400; Wed, 09
 Aug 2023 11:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com> <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
 <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
 <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com> <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com>
In-Reply-To: <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 9 Aug 2023 11:08:23 -0700
Message-ID: <CAJuCfpEs2k8mHM+9uq05vmcOYCfkNnOb4s3xPSoWheizPkcwLA@mail.gmail.com>
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

On Wed, Aug 9, 2023 at 11:04=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >>>> Which ends up being
> >>>>
> >>>> VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> >>>>
> >>>> I did not check if this is also the case on mainline, and if this se=
ries is responsible.
> >>>
> >>> Thanks for reporting! I'm checking it now.
> >>
> >> Hmm. From the code it's not obvious how lock_mm_and_find_vma() ends up
> >> calling find_vma() without mmap_lock after successfully completing
> >> get_mmap_lock_carefully(). lock_mm_and_find_vma+0x3f/0x270 points to
> >> the first invocation of find_vma(), so this is not even the lock
> >> upgrade path... I'll try to reproduce this issue and dig up more but
> >> from the information I have so far this issue does not seem to be
> >> related to this series.
>
> I just checked on mainline and it does not fail there.
>
> >
> > This is really weird. I added mmap_assert_locked(mm) calls into
> > get_mmap_lock_carefully() right after we acquire mmap_lock read lock
> > and one of them triggers right after successful
> > mmap_read_lock_killable(). Here is my modified version of
> > get_mmap_lock_carefully():
> >
> > static inline bool get_mmap_lock_carefully(struct mm_struct *mm,
> > struct pt_regs *regs) {
> >       /* Even if this succeeds, make it clear we might have slept */
> >       if (likely(mmap_read_trylock(mm))) {
> >           might_sleep();
> >           mmap_assert_locked(mm);
> >           return true;
> >       }
> >       if (regs && !user_mode(regs)) {
> >           unsigned long ip =3D instruction_pointer(regs);
> >           if (!search_exception_tables(ip))
> >               return false;
> >       }
> >       if (!mmap_read_lock_killable(mm)) {
> >           mmap_assert_locked(mm);                     <---- generates a=
 BUG
> >           return true;
> >       }
> >       return false;
> > }
>
> Ehm, that's indeed weird.
>
> >
> > AFAIKT conditions for mmap_read_trylock() and
> > mmap_read_lock_killable() are checked correctly. Am I missing
> > something?
>
> Weirdly enough, it only triggers during that specific uffd test, right?

Yes, uffd-unit-tests. I even ran it separately to ensure it's not some
fallback from a previous test and I'm able to reproduce this
consistently.

>
> --
> Cheers,
>
> David / dhildenb
>
