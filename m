Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BDC48A604
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 04:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiAKDCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 22:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbiAKDCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:02:13 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95725C06173F
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 19:02:13 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id c6so41472879ybk.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 19:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UsWqKCbZLBuzi7usjCmtz/JjjGQctwwjiuVxBcWGtdk=;
        b=COAmUaQw1ztu/k34hHssrqxJ5Ru3MzmDhsKdPPt76mfpNYxw3av7/WBjz3CxjQpK0P
         c8WaHCZoGcMflm4zxQj3xt3AExLTuuwAVwPzhm4wAGd4WDQZaMoE+QsfRvxHm/xC30MC
         tMQdBzZ94m+7iRWM+StA7HvVqsD/xsw5/b+Moc0mT/nllajjOGKBVi/v+hNlKHcklW6l
         4rwBvGjPvnV8z4NjMehPSrJzkRalwtqGA/k/j1xwnSe+wOWIL96dXFP1QRAkn4Jr7Pfl
         0v/kHVgCFYj7OTUm+rO3SJ3JCOqgZPJPd2yy+Nr9ldppnJPpYqNXQGP2oCANCXR6J6gc
         fyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsWqKCbZLBuzi7usjCmtz/JjjGQctwwjiuVxBcWGtdk=;
        b=WxRgDqw39rpPgaotWA2rYAxVGuMzhTmjFfLFFYCHb2g2BLPDhLRxpfHO3CPRDTNKtJ
         6n4fYmiCqdvLL3fvZtuOan2Wf9PRCwhkF9wBkUrgpnYQ3v185BMfTx0fusagQ7f9xyFy
         moezcw//uGNQZKO2xbaFGm6DwRRiMmoLEQNOkKk56qck3I+7azbQ6mkI8mUNkebCwfFh
         iOKrA+sY05uIHuoHJTOKizQeSSefgm38PxXAmUm+4/g4SUoCWU5Epr81JXGXq+5lh0/G
         mHj5yxFIQR2ZBLxiqBv/mpTftY8Px/LSpLVtU7T/qq5HFi2pH5BHSvpZTp9kI+tU0jg9
         7GzQ==
X-Gm-Message-State: AOAM533aijI6B2jv+fiGlUpjomkAMn6Qf+5Emp/l0oSSEapRaMrXivuD
        vt8SjaOPOQEXkmbZ4ZlqZp6JKCxikhG9fYoopQA0NA==
X-Google-Smtp-Source: ABdhPJzDqMdEbnslQ3eNG6BEi4iBJgsxYWS/6DXV0gipP6o4EahWyajWmuxQEoDLns7m53UXcNmtAhCtWktzOBb64gk=
X-Received: by 2002:a25:6942:: with SMTP id e63mr3568929ybc.602.1641870132644;
 Mon, 10 Jan 2022 19:02:12 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e8f8f505d0e479a5@google.com> <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain> <YdW3WfHURBXRmn/6@sol.localdomain>
 <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
 <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
 <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com>
 <Ydw4hWCRjAhGfCAv@cmpxchg.org> <CAJuCfpHg=SPzx7SGUL75DVpMy0BDEwVj4o-SM0UKGmEJrOSdvg@mail.gmail.com>
 <CAHk-=wiZ=oic3UfejGzy_31RYggtZWUeF1gE82_NHAA=ENY6Kw@mail.gmail.com> <CAJuCfpFFQx525=d8odiiAyi6w5M6KKx-1726zvuV=eADPB8wKg@mail.gmail.com>
In-Reply-To: <CAJuCfpFFQx525=d8odiiAyi6w5M6KKx-1726zvuV=eADPB8wKg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 10 Jan 2022 19:02:01 -0800
Message-ID: <CAJuCfpEoDOCR--=xshfR+8kPrCN1zSx9Ku7rQS2D+q8WOPee0Q@mail.gmail.com>
Subject: Re: psi_trigger_poll() is completely broken
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 10, 2022 at 10:19 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, Jan 10, 2022 at 9:42 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Jan 10, 2022 at 9:25 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > About the issue of serializing concurrent writes for
> > > cgroup_pressure_write() similar to how psi_write() does. Doesn't
> > > of->mutex inside kernfs_fop_write_iter() serialize the writes to the
> > > same file?
> >
> > Ahh, yes, it looks like that does solve the serialization issue.
> > Sorry, I missed that because I'm not actually all that familiar with
> > the kernfs 'of' code.
> >
> > So the only issue is the trigger lifetime one, and if a single trigger
> > is sufficient and returning -EBUSY for trying to replace an existing
> > one is good, then I think that's the proper fix.
> >
> > I'm very busy with the merge window (and some upcoming travel and
> > family events), so I'm hoping somebody will write and test such a
> > patch. Please?
>
> Yes, definitely. I'm on it. Will try posting it later today or
> tomorrow morning if testing reveals something unexpected.

My first attempt to fix this issue is posted at:
https://lore.kernel.org/all/20220111025138.1071848-1-surenb@google.com/
Couple notes:
- I don't think we need psi_trigger::refcount anymore, therefore it's removed.
- synchronize_rcu is kept to ensure we do not free group->poll_task
while psi_schedule_poll_work is using it.
- Documentation needed minimal changes because it did not clearly
specify how trigger overwrite should work. Now it does.

I ran as many test cases as I could find/create. I'll work on adding
some kselftests for psi triggers to test different usage patterns.
Thanks,
Suren.

> Thanks!
>
> >
> >                    Linus
