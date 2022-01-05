Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B44858F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 20:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbiAETNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 14:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243405AbiAETNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:13:51 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B74C061245
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jan 2022 11:13:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z9so342522edm.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 11:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSZJ6lOXxe1t+UE4RzgH09dpup0DIvKIanGw3pdRDu0=;
        b=LOQbagsAdCakbS9BqHLeR4QV4V4qMq4xIFEygeAnWmmSU11M1jK8usHrq8Lzs4XUvk
         zUO+dRpDe/bweElJ9jb+PMTqN3LgVkzcNPfGMMrZXmiRYYOK1TQ6tlyGi4Gi9kewBvvW
         SV2Zkd5JvGn5e05wPGXEjDQUbYeVmq5+SQeNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSZJ6lOXxe1t+UE4RzgH09dpup0DIvKIanGw3pdRDu0=;
        b=0RpZKr5i0Aw+g7Q7gaiKpkc3j9kaVgOfvr1XXjPOAXBFkXGzxbK/KxyOvB7B2/2wDU
         DmmrkVEqacaAlQllD51BN6zU4Tf1r4wPP4AkA6d9f4JV32Irw1dopXTUqPbraLG5Wt3m
         r0+S04kU38FMX+XzOr2/qZDV40TypUOXn/Fm9GrFBcS1uj/5IfNsEjd3pPU3A8MBSz10
         Faa7BBXQ68rxwNmRTPhH0CgWFh2zKPFgPfNeBj10HesN9k02vQGp3L7bZZJX3qQyth8+
         d7DiAT6e9Od8QIqsLju5PxvRxhFzF6dmc0QIMSgG9tlCRfBSxCNVAv2m9nmJGfNWsSFa
         lsUA==
X-Gm-Message-State: AOAM532G0e8ZID2BG/qcobWaGHaefoYgAuOnKwDNOKJdMBsWyUYhhfJX
        3MgUi0Syl5qco5GAnf7S+E2CZkzmzBbNby1og9s=
X-Google-Smtp-Source: ABdhPJwreaEA2b/tyvTmYXmRZ6N0tCYK9uN0ZS8vSK8SSxWM8zmKQJdzcmOvaIuVjDzoJAopuwBAuw==
X-Received: by 2002:a05:6402:2888:: with SMTP id eg8mr53157249edb.383.1641410028961;
        Wed, 05 Jan 2022 11:13:48 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id ho17sm12449225ejc.39.2022.01.05.11.13.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 11:13:47 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id m14-20020a7bcb8e000000b00346da381d59so1106475wmi.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 11:13:46 -0800 (PST)
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr4148156wmq.152.1641410026707;
 Wed, 05 Jan 2022 11:13:46 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e8f8f505d0e479a5@google.com> <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain> <YdW3WfHURBXRmn/6@sol.localdomain>
 <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com> <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
In-Reply-To: <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jan 2022 11:13:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com>
Message-ID: <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com>
Subject: Re: psi_trigger_poll() is completely broken
To:     Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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

On Wed, Jan 5, 2022 at 11:07 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Whoever came up with that stupid "replace existing trigger with a
> write()" model should feel bad. It's garbage, and it's actively buggy
> in multiple ways.

What are the users? Can we make the rule for -EBUSY simply be that you
can _install_ a trigger, but you can't replace an existing one (except
with NULL, when you close it).

That would fix the poll() lifetime issue, and would make the
psi_trigger_replace() races fairly easy to fix - just use

        if (cmpxchg(trigger_ptr, NULL, new) != NULL) {
                ... free 'new', return -EBUSY ..

to install the new one, instead of

        rcu_assign_pointer(*trigger_ptr, new);

or something like that. No locking necessary.

But I assume people actually end up re-writing triggers, because
people are perverse and have taken advantage of this completely broken
API.

               Linus
