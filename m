Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97C24DDCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 19:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgHURXB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 13:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgHURWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:22:47 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BADC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 10:22:47 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id o184so1209354vsc.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDqVNDY5Q+RZDqESGD0TGY14TPQ/cJSVcY4W2ZTOurU=;
        b=fsv4g5/tYJjOZyeNAid6KP6IC/d+32IDs1B84c2++eXQf89w47tOGpLE8FXrjFv3/Y
         jnlLa9noNsJIa4Elln1YeI9aod0vrZLaR52LTJzo0JMk3SyylMuj93Kk0KjI7YAs+pnz
         RL/cnKuZ9cc9suLnmxGsHHPb9lBpp80bJcJI1TshbZV3bZKHYiyib1+xgGH3sIF6p027
         kcTzZXQWPS+rYqmCxqRyzoKXiqJJfRcBxzq5Lx96V6fIR2YgRaFbyP9e0hkDx4GijMAG
         qitSwMCHtXfcd4M4frAsJPIHOR6nLv2y9mJFaw4VrOy3QbWhfod2LsF52cyBWN1Flbtf
         vnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDqVNDY5Q+RZDqESGD0TGY14TPQ/cJSVcY4W2ZTOurU=;
        b=U8vUHJd9R8W0SiG405TUM2XuWGPC4UG2GrdQ6d+wZqnOncdGMJkLtfOvc+yBcgAvZ8
         th6JBJ2LBSB/ZpC5C0pLjX5M/CxnIvKq9/PRa1SxZ5adxcpiRtKQ3D+d++KJPmsaAxrR
         wDQcF3pcMCc4IPJv4kT8mJCdXwDVD0v1FVCAJQ+5TGc/l4h+BFhAbO89LOKSOG9wbUe9
         l4zVWNP/Jm9x7tWnOAMdMIXN7rsbySCF5/ho12ODULNeigWPjY9WLYpcLiTQHBppfdvu
         ZrXcqsBvtmlks3UFJrVvCrZuNlqf0ZaiJo/BW4bNO3PzSHNVnMEQn67H1AxwylJ7R7/H
         JnSQ==
X-Gm-Message-State: AOAM532bAGPa5djXjNMn8oIU2dWW8FHAZm6Y36uPWQn3BKp77FSeB1Dr
        fv+6U4oFkD6AFazaT1qUN9zGvq/qylOXzaXSs+Mk4Q==
X-Google-Smtp-Source: ABdhPJzA6appk8Xhd4tm4AjN6izo2oLrkOILpz+oGjpaon/Hiqu27vcPQ3jAQ/sCmSWKBd2jYGp5pyBMjq8/f5OPO+c=
X-Received: by 2002:a05:6102:189:: with SMTP id r9mr2590828vsq.239.1598030565992;
 Fri, 21 Aug 2020 10:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein> <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org> <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
 <20200820162645.GP5033@dhcp22.suse.cz> <87r1s0txxe.fsf@x220.int.ebiederm.org>
 <20200821111558.GG4546@redhat.com> <CAJuCfpF_GhTy5SCjxqyqTFUrJNaw3UGJzCi=WSCXfqPAcbThYg@mail.gmail.com>
 <CAJuCfpG06_KLhQyg9N84bRQOdvG27uAZ2oBDEQPR-OnZeNJd1w@mail.gmail.com> <20200821163724.GC19445@redhat.com>
In-Reply-To: <20200821163724.GC19445@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 21 Aug 2020 10:22:34 -0700
Message-ID: <CAJuCfpGcmSmMc2zEBR-0FgbeZVre+Tbqmu04y8deEwySasvD3Q@mail.gmail.com>
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

On Fri, Aug 21, 2020 at 9:37 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> again, don't really understand...
>
> On 08/21, Suren Baghdasaryan wrote:
> >
> > Actually, reviewing again and considering where list_add_tail_rcu is
> > happening, maybe the race with clone(CLONE_VM) does not introduce
> > false negatives.
>
> I think it does... Whatever we check, mm_users or MMF_PROC_SHARED,
> the task can do clone(CLONE_VM) right after the check.

Ah, yes of course. I missed this same just like in the original patch.

>
> > However a false negative I think will happen when a
> > task shares mm with another task and also has an additional thread.
> > Shared mm will increment mm_users without adding to signal->live
>
> Yes,
>
> > and
> > the additional thread will advance signal->live without adding to
> > mm_users.
>
> No, please note that CLONE_THREAD requires CLONE_VM.

My fault. Forgot that CLONE_VM means "share VM" and not "dup VM". Need
some coffee.
Thanks Oleg!

>
> Oleg.
>
