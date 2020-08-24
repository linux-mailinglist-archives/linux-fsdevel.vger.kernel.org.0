Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4318F2509C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 22:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHXUDZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 16:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:03:24 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B289C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 13:03:23 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a127so5128842vsd.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vKTPF0uHpttGBu3pAc6JTpBwBjvTc+sERWwIFnvQkY=;
        b=jMH23Rky+9ZGR3nFYu9CFT6JRFiIc0SeF66JZUOqwJmSjNVjYQrPipTi14kzsVb1lT
         qhC6225zBEEie82bxWl/Us2jC++G0QccmOWrJzDnwBVLjL0HV/Lk6TBjkKKpG8PvGTK9
         aw4/XQR9qBRESqvoQhR99DAp/8leP+jC3cj1y35TNwPKXkG3hkRKvurf+XJOTiA8sxR1
         aTfc+1xXDtLwiPTBNoTgBVkrCi505jvR15rv8zBrPtPrabsEZA6mTzT1dAIRojlYrSDr
         tt2qXhM7bsJ8ZXr0gGFRdNafDVZ6NeQ7rW0VnbrC06XR8LDp8pMEq4Y5nyk7cXn4vgy9
         KS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vKTPF0uHpttGBu3pAc6JTpBwBjvTc+sERWwIFnvQkY=;
        b=RmmJlLb/5F6AS60cjPwYJ9YQTxWhkR1HnmlebWfTe7FlRZzerR8tIj6S1hecbX+SDJ
         RmK81o6RCLviO/w7HXBKFq/z20O2HafJgofIyN+kMr2RhIIzhH6dk5mheGOZXWXtLDwY
         C844Rp3+myiBGbLEr4soZDwhBOu8g/9FrJHWDJ0qJbpeOzcbv6Xca7/kLi+ZRFGoDzJW
         JPCr7n2DkUIGhDvtaCQmSq0wHqvbFnZgtFUQfjUdPuHnswD1uQZgzwMSQ+mww8RUOSQb
         U4TLUd0y3i9J5w376/oa+GrnoRz8JMEJyGF4o5MoNWy7cL+4mXRbweY5qg5RpxZIbHQG
         cpPg==
X-Gm-Message-State: AOAM533S/vbn2Z79FQbTs/sNv1nFlPsmSCvjSWe3lkpAcfXG6Z70S2N/
        vR+xo3ld4fxHro59onixiCYIxVaMR1KyH3BUUQ3CTA==
X-Google-Smtp-Source: ABdhPJwzBKahra2vHYJC7E4/5M3RHv1PQklZpzoKSjitonSnT18aJ4g97pkIJnnamelNSLFrflkn/bSNaDL5hjsz1zI=
X-Received: by 2002:a67:e110:: with SMTP id d16mr3901391vsl.239.1598299401026;
 Mon, 24 Aug 2020 13:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein> <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org> <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
 <20200820162645.GP5033@dhcp22.suse.cz> <87r1s0txxe.fsf@x220.int.ebiederm.org>
 <20200821111558.GG4546@redhat.com> <CAJuCfpF_GhTy5SCjxqyqTFUrJNaw3UGJzCi=WSCXfqPAcbThYg@mail.gmail.com>
 <20200821163300.GB19445@redhat.com> <20200821175943.GD19445@redhat.com> <CAJuCfpGn+7gtpUVv_T3ZvT7WEwP8z-c1z1Qu2qe1jq8RSxbHMA@mail.gmail.com>
In-Reply-To: <CAJuCfpGn+7gtpUVv_T3ZvT7WEwP8z-c1z1Qu2qe1jq8RSxbHMA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 24 Aug 2020 13:03:09 -0700
Message-ID: <CAJuCfpHvE46jchSk_yFO8+=mGbru54OSne=jHf-KGqkZYAV1iA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tim Murray <timmurray@google.com>, mingo@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com,
        Shakeel Butt <shakeelb@google.com>, cyphar@cyphar.com,
        adobriyan@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        gladkov.alexey@gmail.com, Michel Lespinasse <walken@google.com>,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de,
        John Johansen <john.johansen@canonical.com>,
        laoar.shao@gmail.com, Minchan Kim <minchan@kernel.org>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:53 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Aug 21, 2020 at 11:00 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 08/21, Oleg Nesterov wrote:
> > >
> > > On 08/21, Suren Baghdasaryan wrote:
> > > >
> > > > On Fri, Aug 21, 2020 at 4:16 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > >
> > > > >         bool probably_has_other_mm_users(tsk)
> > > > >         {
> > > > >                 return  atomic_read_acquire(&tsk->mm->mm_users) >
> > > > >                         atomic_read(&tsk->signal->live);
> > > > >         }
> > > > >
> > > > > The barrier implied by _acquire ensures that if we race with the exiting
> > > > > task and see the result of exit_mm()->mmput(mm), then we must also see
> > > > > the result of atomic_dec_and_test(signal->live).
> > > > >
> > > > > Either way, if we want to fix the race with clone(CLONE_VM) we need other
> > > > > changes.
> > > >
> > > > The way I understand this condition in __set_oom_adj() sync logic is
> > > > that we would be ok with false positives (when we loop unnecessarily)
> > > > but we can't tolerate false negatives (when oom_score_adj gets out of
> > > > sync).
> > >
> > > Yes,
> > >
> > > > With the clone(CLONE_VM) race not addressed we are allowing
> > > > false negatives and IMHO that's not acceptable because it creates a
> > > > possibility for userspace to get an inconsistent picture. When
> > > > developing the patch I did think about using (p->mm->mm_users >
> > > > p->signal->nr_threads) condition and had to reject it due to that
> > > > reason.
> > >
> > > Not sure I understand... I mean, the test_bit(MMF_PROC_SHARED) you propose
> > > is equally racy and we need copy_oom_score() at the end of copy_process()
> > > either way?
> >
> > On a second thought I agree that probably_has_other_mm_users() above can't
> > work ;) Compared to the test_bit(MMF_PROC_SHARED) check it is not _equally_
> > racy, it adds _another_ race with clone(CLONE_VM).
> >
> > Suppose a single-threaded process P does
> >
> >         clone(CLONE_VM); // creates the child C
> >
> >         // mm_users == 2; P->signal->live == 1;
> >
> >         clone(CLONE_THREAD | CLONE_VM);
> >
> >         // mm_users == 3; P->signal->live == 2;
> >
> > the problem is that in theory clone(CLONE_THREAD | CLONE_VM) can increment
> > _both_ counters between atomic_read_acquire(mm_users) and atomic_read(live)
> > in probably_has_other_mm_users() so it can observe mm_users == live == 2.
>
> I see. So even though live is incremented after mm_users, the observer
> from __set_oom_adj still can see them becoming equal because it reads
> mm_users first.
>
> Do you see any such races if I incorporate the changes proposed by
> Michal in http://lkml.kernel.org/r/20200820124109.GI5033@dhcp22.suse.cz
> ? I have the new patch and I'm testing it right now. So far it behaves
> well but maybe I'm missing some rare race here that won't show up in
> my testing?
>

FYI: v2 of this patch with proposed changes is posted at:
https://lore.kernel.org/patchwork/patch/1294520/

>
> >
> > Oleg.
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
