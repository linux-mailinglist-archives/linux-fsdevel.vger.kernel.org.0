Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8180324D960
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHUQGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 12:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHUQG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:06:27 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331DBC061573
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 09:06:27 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id o184so1085504vsc.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b7LMvTJRCBEy3uOnWRZT0zK9P07GM4iF4nxCqVfim8k=;
        b=XM5WiqUM8GbZZWeaOuKkTmam3WvoxctYZV5DRa4dkgylCOr+Rseuisg062z5LgeG1P
         cJco8xFaQWvWV6H3T8sJ69chqVgjazfM6SdYNODrXvyRCEDvLw4btsIpd5YUgypTUdml
         RkmTqQ2iD7gVLxv/e3DZyo47BC2INp7QfIxaOytfUXR5OSBrGLA6OP+8fHfHPkbiUfgp
         pvjPpGCCaZ71NEql+Gt2TnaXEJwgpYPyKjP7H0voySET5Ym5fEno9kR2UG63FDovPsl/
         0neZla1O0l+BnfvPd39VsViQUkTk2cLtmnx38rn9B5h47bipQXkmULEYWC0iNy2DdzTw
         31Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b7LMvTJRCBEy3uOnWRZT0zK9P07GM4iF4nxCqVfim8k=;
        b=JTVxsXl9bO9bzN+6GY1aFVFCaKC+8amvnXt0nvaQtMIr54h5JAqL/BgqhoI1fNo8Dg
         VOxeMKeKxxGaWK+OoagnZLrGFgPrwc950RRM1Nf4J70eFezB8jMs8VKrMFb7R0TviidP
         FoU+CfeQHMuRKqQa4OITbsghVfPMlR2n61vlHunIjEEh7R93eeF4e3L6jhipOGTIwUTM
         u0zsomz7hsXzXBRnrpSIHIZ/O/GlTHS5n3QPq568aU0aGL8FNu3ARgEIDpbV48R8eVPT
         fswjG8UG1Z4kgOnZTbp71mdjPQupSrC3fQknSpyav3q/JN6mAIo29j8dtFmaYLbmavVs
         oGMw==
X-Gm-Message-State: AOAM532KMx4tkuuHPOdHbCCfVcTIXibj7Zu3U7eXZ/MmZkiPiOqc2ATC
        6lxGFwjNkzI/UnU/VGmxPe3oPKnSfQfQ5+xF9icHhA==
X-Google-Smtp-Source: ABdhPJwJp9Y7eAvqM2EcEoZSaYF8tzqoAMXUXqdQJN+Vexb2/46sXF/P38JLaCGmhGPvKT+DFFarr66O1p/K/nONX9o=
X-Received: by 2002:a67:ff92:: with SMTP id v18mr2543591vsq.221.1598025985891;
 Fri, 21 Aug 2020 09:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <87d03lxysr.fsf@x220.int.ebiederm.org> <20200820132631.GK5033@dhcp22.suse.cz>
 <20200820133454.ch24kewh42ax4ebl@wittgenstein> <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein> <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org> <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
 <20200820162645.GP5033@dhcp22.suse.cz> <87r1s0txxe.fsf@x220.int.ebiederm.org>
 <20200821111558.GG4546@redhat.com> <CAJuCfpF_GhTy5SCjxqyqTFUrJNaw3UGJzCi=WSCXfqPAcbThYg@mail.gmail.com>
In-Reply-To: <CAJuCfpF_GhTy5SCjxqyqTFUrJNaw3UGJzCi=WSCXfqPAcbThYg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 21 Aug 2020 09:06:14 -0700
Message-ID: <CAJuCfpG06_KLhQyg9N84bRQOdvG27uAZ2oBDEQPR-OnZeNJd1w@mail.gmail.com>
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

On Fri, Aug 21, 2020 at 8:28 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Aug 21, 2020 at 4:16 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 08/20, Eric W. Biederman wrote:
> > >
> > > That said if we are going for a small change why not:
> > >
> > >       /*
> > >        * Make sure we will check other processes sharing the mm if this is
> > >        * not vfrok which wants its own oom_score_adj.
> > >        * pin the mm so it doesn't go away and get reused after task_unlock
> > >        */
> > >       if (!task->vfork_done) {
> > >               struct task_struct *p = find_lock_task_mm(task);
> > >
> > >               if (p) {
> > > -                     if (atomic_read(&p->mm->mm_users) > 1) {
> > > +                     if (atomic_read(&p->mm->mm_users) > p->signal->nr_threads) {
> >
> > In theory this needs a barrier to avoid the race with do_exit(). And I'd
> > suggest to use signal->live, I think signal->nr_threads should die...
> > Something like
> >
> >         bool probably_has_other_mm_users(tsk)
> >         {
> >                 return  atomic_read_acquire(&tsk->mm->mm_users) >
> >                         atomic_read(&tsk->signal->live);
> >         }
> >
> > The barrier implied by _acquire ensures that if we race with the exiting
> > task and see the result of exit_mm()->mmput(mm), then we must also see
> > the result of atomic_dec_and_test(signal->live).
> >
> > Either way, if we want to fix the race with clone(CLONE_VM) we need other
> > changes.
>
> The way I understand this condition in __set_oom_adj() sync logic is
> that we would be ok with false positives (when we loop unnecessarily)
> but we can't tolerate false negatives (when oom_score_adj gets out of
> sync). With the clone(CLONE_VM) race not addressed we are allowing
> false negatives and IMHO that's not acceptable because it creates a
> possibility for userspace to get an inconsistent picture. When
> developing the patch I did think about using (p->mm->mm_users >
> p->signal->nr_threads) condition and had to reject it due to that
> reason.
>

Actually, reviewing again and considering where list_add_tail_rcu is
happening, maybe the race with clone(CLONE_VM) does not introduce
false negatives. However a false negative I think will happen when a
task shares mm with another task and also has an additional thread.
Shared mm will increment mm_users without adding to signal->live and
the additional thread will advance signal->live without adding to
mm_users. As a result these increments will balance themselves and
(mm->mm_users > signal->live) condition will yield false negative.

> >
> > Oleg.
> >
