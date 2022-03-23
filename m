Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3F94E559F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 16:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245222AbiCWPsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbiCWPsi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:48:38 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D9170F70
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 08:47:08 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id j83so2025058oih.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0ZfOEGucAEYJU64kilp/BJv2UxyExEyaxEs/s4tJVc=;
        b=McfOI6NVTS79eqz5CyeXfr9SBfkIqJhEa0udr5opLjk61INr3bGTaUeTPo+G1Txkxk
         2jkpvhuxb+AwfrOb4IMMq+QTijC/1N2jeGMRVJx6eg7U8/PrpFrRY1NoUBAAVzSVjAmr
         FUWmjVkZnaViCt/6RTg1+omM7HqaeT2mquSC5HZ9EeOEw22Dif2bn2ukj1IkIU7jF5mi
         sRzoUsFzLvshNdKCfviPmwmWK6+lhE01X6dSfhA2wbn7fSWxGhJwe5W8g0jHEzLeXOvc
         ust5mKhKAryQqaabg93eQVUepbgPQytLijANRgPi9T156n8UaRweOHU5LOUq9mPscv7q
         BRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0ZfOEGucAEYJU64kilp/BJv2UxyExEyaxEs/s4tJVc=;
        b=KtWdyy/k5u04DIt1AZW1416bDI0KGxItSXp1Bkyt0XmOjO+HLPcMJVLuJQkKCbevWN
         j196OEhs39GhDNtOqwuzZv7tt8699e3S0iRF53dQZvzCVCwoUOr9t25bFyFoiCvYPaXc
         jeWZtjUmW6qLLFJbZwgQ4880yvgdmOkYDjHJy/tXPMy0xrNOKCEv8lvI6uLgQ6FctuXk
         F+Eac20TO6zIjtwfBgBdkrZN3Ks3syeFOQUcHvqpWszKXSU4I6iY7sUomdhrv846We47
         4Ao9EoEa1Xm97GD6G0xGNTjBv31lEp3vn/8liWR0DurbM+BQejECL1XCT0sVNc+50l/U
         F8TA==
X-Gm-Message-State: AOAM531yZ0wlQSMqGKP3Vkp92j+se1wK+sMiHJpRCtndIRocddPVFH6f
        JOW9eaj+Iqki1e+AKehyxE+JzCQuMG7lksALiRCB4/bamn0=
X-Google-Smtp-Source: ABdhPJxEOLGEqeY4vJj2jFkOckWeF8KjTYyMs+8a3W7Gk4rdAtpuroIGtzMOGiJB4PpJhd7zdCvE0dC6Zc3CZxckckI=
X-Received: by 2002:a05:6808:23c1:b0:2da:30fd:34d9 with SMTP id
 bq1-20020a05680823c100b002da30fd34d9mr4899106oib.203.1648050427956; Wed, 23
 Mar 2022 08:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
 <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
 <20220321112310.vpr7oxro2xkz5llh@quack3.lan> <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
 <20220321145111.qz3bngofoi5r5cmh@quack3.lan> <CAOQ4uxgOpfezQ4ydjP4SPA8-7x9xSXjTmTyZOYQE3d24c2Zf7Q@mail.gmail.com>
 <20220323104129.k4djfxtjwdgoz3ci@quack3.lan> <CAOQ4uxgH3aCKnXfUFuyC7JXGtuprzWr6U9Y2T1rTQT3COoZtzw@mail.gmail.com>
 <20220323134851.px6s4i6iiaj4zlju@quack3.lan> <CAOQ4uxhBH_0UqEmOdcUaV0E8oGTGF7arr+Q_EZPuQ=KWfvJWoQ@mail.gmail.com>
 <20220323142835.epitipiq7zc55vgb@quack3.lan>
In-Reply-To: <20220323142835.epitipiq7zc55vgb@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Mar 2022 17:46:56 +0200
Message-ID: <CAOQ4uxjEj4FWsd87cuYHR+vKb0ogb=zqrKHJLapqaPovUhgfFQ@mail.gmail.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
To:     Jan Kara <jack@suse.cz>
Cc:     "khazhy@google.com" <khazhy@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 4:28 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 23-03-22 16:00:30, Amir Goldstein wrote:
> > > Well, but reclaim from kswapd is always the main and preferred source of
> > > memory reclaim. And we will kick kswapd to do work if we are running out of
> > > memory. Doing direct filesystem slab reclaim from mark allocation is useful
> > > only to throttle possibly aggressive mark allocations to the speed of
> > > reclaim (instead of getting ENOMEM). So I'm still not convinced this is a
> > > big issue but I certainly won't stop you from implementing more fine
> > > grained GFP mode selection and lockdep annotations if you want to go that
> > > way :).
> >
> > Well it was just two lines of code to annotate the fanotify mutex as its own
> > class, so I just did that:
> >
> > https://github.com/amir73il/linux/commit/7b4b6e2c0bd1942cd130e9202c4b187a8fb468c6
>
> But this implicitely assumes there isn't any allocation under mark_mutex
> anywhere else where it is held. Which is likely true (I didn't check) but
> it is kind of fragile. So I was rather imagining we would have per-group
> "NOFS" flag and fsnotify_group_lock/unlock() would call
> memalloc_nofs_save() based on the flag. And we would use
> fsnotify_group_lock/unlock() uniformly across the whole fsnotify codebase.
>

I see what you mean, but looking at the code it seems quite a bit of churn to go
over all the old backends and convert the locks to use wrappers where we "know"
those backends are fs reclaim safe (because we did not get reports of deadlocks
over the decades they existed).

I think I will sleep better with a conversion to three flavors:

1. pflags = fsnotify_group_nofs_lock(fanotify_group);
2. fsnotify_group_lock(dnotify_group) =>
    WARN_ON_ONCE(group->flags & FSNOTIFY_NOFS)
    mutex_lock(&group->mark_mutex)
3. fsnotify_group_lock_nested(group) =>
    mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING)

Thoughts?

One more UAPI question.
Do you think we should require user to opt-in to NOFS and evictable marks with
FAN_SHRINKABLE? If we don't, it will be harder to fix regressions in legacy
fanotify workloads if those are reported without breaking the evictable marks
UAPI.

Thanks,
Amir.
