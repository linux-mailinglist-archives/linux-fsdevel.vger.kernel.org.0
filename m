Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AB124DFFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 20:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHUSxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUSxN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:53:13 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39CFC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:12 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id u15so822777uau.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ykL1MaQAjReQJ2aQ56GZWudKyZ/kETzd1mJIShvlqg=;
        b=lOO5KcjensU81n90JpwVdSdGl5pnw5AlKyiczE4LcmppuBoUTaiEO8XtuFPn4c4PaQ
         qddvy17JKDmJleSHaIO/Ogew7cBYeFm0pULTnsX65QMgLAMSSyAoynE5HSP5hFg9UVvt
         fxCxcmgFeMk1I/1MRqOX80fFINtH8/xQu3EChS11kj/UfRKA3Np5FtlLQ8ARBPO1T2Lx
         Zjzodc2A6qbv2G4od4J2JjvFlfj4FNrM2jL7fEbsJ3kZTUj3qtKjZNIVYJn61lbTGFmW
         C8cpfqZSURM8+r8V7HOyTGK2UyRXJVTntF7jXg3HKsBdF2j/xvTvOAWXA7k1st3Q/JBC
         FHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ykL1MaQAjReQJ2aQ56GZWudKyZ/kETzd1mJIShvlqg=;
        b=L+cCbI4it7lR5L6a3rh21NkFpm6p7RMvs2g3T5lgNWFnlnkRyIW9gc3F2mEVsj1zhd
         xsvm7akTCx9ClSbxDAXPmoY3tkaFxqASRs8VxzHPl0kzcV5V1IajpQrbkXdM6kaPAgPr
         gQBvMPIHV/jp1S/Ly+jfXc9Q6aLymXL8GfvKRahEa2QgDFni3I/TmtaLHvAmXSEo/wnm
         j8A16TNpGAlkjOk6p67jhNYZybdFfQuqI1vJOyePOJHQjVi2u7ta9vLizUfqZDWkcfPm
         PsMtIHdSZtoRKeDIg+vvhSCdvFa9bBuCkh+SLdKDRt2MTOPg4bjlYjbyqebDrNcm+r5F
         NMiQ==
X-Gm-Message-State: AOAM5319QkUtX635o4FyUdpWWl9tccPFDOOMf8K6+e9FFA1XWj86rG2u
        2xY4xf+IE+8hT/FiSucr4KNXpj/AW6HKViOALBl9fg==
X-Google-Smtp-Source: ABdhPJwLGWowOiHwq4OtK9k4dIWPuKAtxD38z1jFWXA2gU6Jz5vFAR5L9E8i2RsRzeGBQZ0cRDBXAVroDaZuRzdsANs=
X-Received: by 2002:a9f:2265:: with SMTP id 92mr2464321uad.86.1598035991532;
 Fri, 21 Aug 2020 11:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein> <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org> <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
 <20200820162645.GP5033@dhcp22.suse.cz> <87r1s0txxe.fsf@x220.int.ebiederm.org>
 <20200821111558.GG4546@redhat.com> <CAJuCfpF_GhTy5SCjxqyqTFUrJNaw3UGJzCi=WSCXfqPAcbThYg@mail.gmail.com>
 <20200821163300.GB19445@redhat.com> <20200821175943.GD19445@redhat.com>
In-Reply-To: <20200821175943.GD19445@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 21 Aug 2020 11:53:00 -0700
Message-ID: <CAJuCfpGn+7gtpUVv_T3ZvT7WEwP8z-c1z1Qu2qe1jq8RSxbHMA@mail.gmail.com>
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

On Fri, Aug 21, 2020 at 11:00 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 08/21, Oleg Nesterov wrote:
> >
> > On 08/21, Suren Baghdasaryan wrote:
> > >
> > > On Fri, Aug 21, 2020 at 4:16 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > >         bool probably_has_other_mm_users(tsk)
> > > >         {
> > > >                 return  atomic_read_acquire(&tsk->mm->mm_users) >
> > > >                         atomic_read(&tsk->signal->live);
> > > >         }
> > > >
> > > > The barrier implied by _acquire ensures that if we race with the exiting
> > > > task and see the result of exit_mm()->mmput(mm), then we must also see
> > > > the result of atomic_dec_and_test(signal->live).
> > > >
> > > > Either way, if we want to fix the race with clone(CLONE_VM) we need other
> > > > changes.
> > >
> > > The way I understand this condition in __set_oom_adj() sync logic is
> > > that we would be ok with false positives (when we loop unnecessarily)
> > > but we can't tolerate false negatives (when oom_score_adj gets out of
> > > sync).
> >
> > Yes,
> >
> > > With the clone(CLONE_VM) race not addressed we are allowing
> > > false negatives and IMHO that's not acceptable because it creates a
> > > possibility for userspace to get an inconsistent picture. When
> > > developing the patch I did think about using (p->mm->mm_users >
> > > p->signal->nr_threads) condition and had to reject it due to that
> > > reason.
> >
> > Not sure I understand... I mean, the test_bit(MMF_PROC_SHARED) you propose
> > is equally racy and we need copy_oom_score() at the end of copy_process()
> > either way?
>
> On a second thought I agree that probably_has_other_mm_users() above can't
> work ;) Compared to the test_bit(MMF_PROC_SHARED) check it is not _equally_
> racy, it adds _another_ race with clone(CLONE_VM).
>
> Suppose a single-threaded process P does
>
>         clone(CLONE_VM); // creates the child C
>
>         // mm_users == 2; P->signal->live == 1;
>
>         clone(CLONE_THREAD | CLONE_VM);
>
>         // mm_users == 3; P->signal->live == 2;
>
> the problem is that in theory clone(CLONE_THREAD | CLONE_VM) can increment
> _both_ counters between atomic_read_acquire(mm_users) and atomic_read(live)
> in probably_has_other_mm_users() so it can observe mm_users == live == 2.

I see. So even though live is incremented after mm_users, the observer
from __set_oom_adj still can see them becoming equal because it reads
mm_users first.

Do you see any such races if I incorporate the changes proposed by
Michal in http://lkml.kernel.org/r/20200820124109.GI5033@dhcp22.suse.cz
? I have the new patch and I'm testing it right now. So far it behaves
well but maybe I'm missing some rare race here that won't show up in
my testing?


>
> Oleg.
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
