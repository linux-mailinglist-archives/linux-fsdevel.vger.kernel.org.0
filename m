Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F36489F0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 19:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiAJSTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 13:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiAJSTN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:19:13 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB217C061748
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 10:19:13 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id m6so30035211ybc.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ozjIGPdXpEGjhtrg7M9VDsi92b2yheJb0XVg1R0oCbg=;
        b=fGaKbNq7gW4Ltg3I9MP05btVJ6khCEq4ydjLMoCyQ1T6LAiTW5HyVlirDB1nTJxqkK
         CfkP3LlUCKOcCJQsUkVvhmBsfmyVbp4aJ55ti58tzyWVAL34R3Y4vsHdBy0Hj44hEZmR
         f+V8kKf3bl1hHVTV8s8K+oNZty1euOaZobUa2bBroTP6JD8r0rU0MET/MnOifuNMjHr6
         Q/umUsqZv3b320YCrj8og3k7n850WCE89aIEFeFXrM1czElniv0Go3sDUAkq7DCy+g2f
         PkclGpD3DAXUcEHqa0NGndTEbmlZ3RpjJ1cCT7K4mz9CKrDe5Swpz0FNjY+0mFDK8YjN
         flGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ozjIGPdXpEGjhtrg7M9VDsi92b2yheJb0XVg1R0oCbg=;
        b=r+7sW4PMg9FlhjaXGlIAMpBY+qkTmYZL8rG6JFr6LysnShp1wk+5F/pRvoMTAOmQvA
         9i8tSMu6JrV6CBoz4FGbPMkVW4GDt40wkVo3ceyc282O/WeGdYh/qQ9CVtSj6tSfOTgi
         RZy5EasvJzz6l5Qd8oO034V5DhAItHNNg4dkhnotmWx7YHaXKttaHoNf020f6BQgogSV
         HFn/Q8Nd+LhHP6J9pZi9VBIkmAZ82DnzGXzp5f0ed//U2CtCGv+KgphO/oaN1tPssE5V
         wubdx801IPSA4TlLpOCR7dXXeKYqw6YWi9e4t7ukd/p31ZytMLmID33BIfUZwqWZFhmR
         wdyg==
X-Gm-Message-State: AOAM532cH6oRUkqDQd9sCno/wo9ciMDBBW4MjpK7H1LGrbMRoVmbUkxu
        AwZzbxeh4Z1h0ugpbnOwvJTWs3Lg+7K7OPRmhoGZQw==
X-Google-Smtp-Source: ABdhPJw5558XhgRjCcRfT/CqFjcX6F4tW6g3+lEt8isEvNJmqNNK9qXJpBoekCCbDpCmlDJ7K9OUxCe3STiF/6nmwSo=
X-Received: by 2002:a05:6902:703:: with SMTP id k3mr1066936ybt.225.1641838752718;
 Mon, 10 Jan 2022 10:19:12 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e8f8f505d0e479a5@google.com> <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain> <YdW3WfHURBXRmn/6@sol.localdomain>
 <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
 <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
 <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com>
 <Ydw4hWCRjAhGfCAv@cmpxchg.org> <CAJuCfpHg=SPzx7SGUL75DVpMy0BDEwVj4o-SM0UKGmEJrOSdvg@mail.gmail.com>
 <CAHk-=wiZ=oic3UfejGzy_31RYggtZWUeF1gE82_NHAA=ENY6Kw@mail.gmail.com>
In-Reply-To: <CAHk-=wiZ=oic3UfejGzy_31RYggtZWUeF1gE82_NHAA=ENY6Kw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 10 Jan 2022 10:19:01 -0800
Message-ID: <CAJuCfpFFQx525=d8odiiAyi6w5M6KKx-1726zvuV=eADPB8wKg@mail.gmail.com>
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

On Mon, Jan 10, 2022 at 9:42 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jan 10, 2022 at 9:25 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > About the issue of serializing concurrent writes for
> > cgroup_pressure_write() similar to how psi_write() does. Doesn't
> > of->mutex inside kernfs_fop_write_iter() serialize the writes to the
> > same file?
>
> Ahh, yes, it looks like that does solve the serialization issue.
> Sorry, I missed that because I'm not actually all that familiar with
> the kernfs 'of' code.
>
> So the only issue is the trigger lifetime one, and if a single trigger
> is sufficient and returning -EBUSY for trying to replace an existing
> one is good, then I think that's the proper fix.
>
> I'm very busy with the merge window (and some upcoming travel and
> family events), so I'm hoping somebody will write and test such a
> patch. Please?

Yes, definitely. I'm on it. Will try posting it later today or
tomorrow morning if testing reveals something unexpected.
Thanks!

>
>                    Linus
