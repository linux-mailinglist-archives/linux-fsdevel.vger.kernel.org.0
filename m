Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9329B24D892
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgHUP3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 11:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgHUP3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:29:01 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D62C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 08:29:00 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id v138so1013486vsv.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfNlVXRvcKj6Y0hPR3mdXqrOmf9uMfzMQoJ/2wwN28s=;
        b=TxXlzi+3Re0/Y9A0DJKuWYYfMbzRZqmxmjtsXj3fQuS4mqCgNSCPkMIQPvBngkmWlL
         l+2M8q+GXYbPRKVD+IckYVampaZtFXiHooayDG34TdBXVrx9JkAMywZrNoMj4nxurTbK
         hIEm/0LDDdzWPZXsTtvAUAku7YOeaXpfHpi8sX0O6l0dcRBbvZN7a84HeF1b02vhtebg
         9YXjlG+gLFSzi9twT8LENDCNB7E555n/NpyTP1TmCq4IocXeoibGF8U+WhgTSQO/Qf/1
         Dluhy83z8d9UtOK4Xcv0+yM9ul9o4AEHrED67jdkIUeyhJ3q18M4gxRHP/YJ7S+WD1Bl
         y9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfNlVXRvcKj6Y0hPR3mdXqrOmf9uMfzMQoJ/2wwN28s=;
        b=MsRDVisu0sZtrNxiKRnUYPGSQCIgfEqL+8yKZY8BB2yprV2QLkdGJofGOwdZB1v01Z
         JUa9TsGwQdN27Jg2EjV3k+npyNwIamWe62VyRNiInSwPtacTR1r7VcvbgboBSssJgod2
         Dtbi4Sq/I2rDbOyjsJqhVTYHH/FRtW/lR8x0n7CxhRdQfHJvZ+qONiVkUAtrt7MwNHBW
         a/vIyZa4J1aAD1Z+UbbI4zX2KEYLjm0gbDeMczmUc//6I7OOj4MJsAe3J+4I1VVJEWT6
         Fa1g3ddWED9K287sQQ29yN2mav4gLQuEl1zEm/kQ8SRX/BhYYjLSrMf/ZM6YOCORLflN
         cXQg==
X-Gm-Message-State: AOAM533I1Zdo8GWPd7VhUssFvM+56C/DSSL+BliI2TQAk25th/T2Ibfi
        LpTZdVzbSch6JGe/gFG/OHJBx1g5LZvPL39M/DVJiQ==
X-Google-Smtp-Source: ABdhPJzuHGDNNiJJ/NVWgNCFo1qYw+4Wfg2mv7fUfSmQoHgQcGFTX5WEJREfXbTaagyxn+o5RQxZ5jAycl8ogxstPMQ=
X-Received: by 2002:a67:f30e:: with SMTP id p14mr2165736vsf.119.1598023739293;
 Fri, 21 Aug 2020 08:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <87d03lxysr.fsf@x220.int.ebiederm.org> <20200820132631.GK5033@dhcp22.suse.cz>
 <20200820133454.ch24kewh42ax4ebl@wittgenstein> <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein> <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org> <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
 <20200820162645.GP5033@dhcp22.suse.cz> <87r1s0txxe.fsf@x220.int.ebiederm.org> <20200821111558.GG4546@redhat.com>
In-Reply-To: <20200821111558.GG4546@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 21 Aug 2020 08:28:48 -0700
Message-ID: <CAJuCfpF_GhTy5SCjxqyqTFUrJNaw3UGJzCi=WSCXfqPAcbThYg@mail.gmail.com>
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

On Fri, Aug 21, 2020 at 4:16 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 08/20, Eric W. Biederman wrote:
> >
> > That said if we are going for a small change why not:
> >
> >       /*
> >        * Make sure we will check other processes sharing the mm if this is
> >        * not vfrok which wants its own oom_score_adj.
> >        * pin the mm so it doesn't go away and get reused after task_unlock
> >        */
> >       if (!task->vfork_done) {
> >               struct task_struct *p = find_lock_task_mm(task);
> >
> >               if (p) {
> > -                     if (atomic_read(&p->mm->mm_users) > 1) {
> > +                     if (atomic_read(&p->mm->mm_users) > p->signal->nr_threads) {
>
> In theory this needs a barrier to avoid the race with do_exit(). And I'd
> suggest to use signal->live, I think signal->nr_threads should die...
> Something like
>
>         bool probably_has_other_mm_users(tsk)
>         {
>                 return  atomic_read_acquire(&tsk->mm->mm_users) >
>                         atomic_read(&tsk->signal->live);
>         }
>
> The barrier implied by _acquire ensures that if we race with the exiting
> task and see the result of exit_mm()->mmput(mm), then we must also see
> the result of atomic_dec_and_test(signal->live).
>
> Either way, if we want to fix the race with clone(CLONE_VM) we need other
> changes.

The way I understand this condition in __set_oom_adj() sync logic is
that we would be ok with false positives (when we loop unnecessarily)
but we can't tolerate false negatives (when oom_score_adj gets out of
sync). With the clone(CLONE_VM) race not addressed we are allowing
false negatives and IMHO that's not acceptable because it creates a
possibility for userspace to get an inconsistent picture. When
developing the patch I did think about using (p->mm->mm_users >
p->signal->nr_threads) condition and had to reject it due to that
reason.

>
> Oleg.
>
