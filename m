Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DCA4E592F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 20:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344164AbiCWTdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 15:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiCWTdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:33:17 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B68B888FB
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 12:31:47 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-de3ca1efbaso2743519fac.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5QA6R5Vp1/7pQd2+LM4nVzPODADzSfXGXUCR/crfDs=;
        b=DQijtSd1P+RlfRhyUJOM8nTAujPJdxtPXumS0EYbA5QIW5fSA4kgirVpXNSHKmeu51
         cmcU3UX+H5RAiC3kiOWMezzIKF6yyQ5b9ZqB0LI/4Q2XujWDJY2tutFaaJ5yzHr5UUU2
         X75EZVw2ZtV84q+cgg2uH6CjYAUvuCtsxCQSSFO7O69QquUS8zh1IAeTmWGxzC0Wl4Tq
         THMONIuPnMyIjoYl02pixGGsI6fN1ZnmUgFmAEpdfyACIo92MtupmSaMTveKkapeAquj
         fvVZLfF1JOGrSZDdNiDj9DiODRFRZ+FjV9v+wx2xNxq8lo9/Wr3ul4GJ+n1OSQaPMu6q
         FT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5QA6R5Vp1/7pQd2+LM4nVzPODADzSfXGXUCR/crfDs=;
        b=ZjnlutBmIDSKbyQAUUup1e8Bbm2uCK+g0prcin3H+uUDEbiNEls7b8C9q8CUsyqfLN
         wG7EPFKo8vuItDrHySDy4yet9rV7CQuRIvLDpCd2rswhNnoAtbE0/TP3SACyJn5SgAcT
         WzE0PU5fCZl2bmK08BYPZEg/4CkldR0XvGLT7O+WQ9x1aFcQHiwgbPuNv7y/qzAHFMQA
         0dfhP7SvprK8CPrOGKPaYivCDukyrK4+z1na9jZESv3CPu+A5ei52PyVBPYIGYqoZsKB
         ZjGk0TTi4NGktmEz+3aUstMxJv9yQMAe7pkIrse474VIFNlw9ZkONhfOYgcBStjLUvK9
         q3jA==
X-Gm-Message-State: AOAM5327SAZZWMrZFbYyZ/O/dj9cSS3+iwO5Yh22zJa4v+U3E4GvKKLW
        DtJssNiJZ/1ZOaInmoSb1BXWcGWPHuPEU+yVs+ThdsiRikE=
X-Google-Smtp-Source: ABdhPJxHnfo/ohAxQUdiLUCJJkGiLOmGbzG4rbRiCYaHSekLSWNv6NNPPrHRCnTQGsxYccSKfx+OQ1RctRNaUurBHg4=
X-Received: by 2002:a05:6870:2103:b0:de:29de:12c4 with SMTP id
 f3-20020a056870210300b000de29de12c4mr4999453oae.203.1648063906809; Wed, 23
 Mar 2022 12:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
 <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
 <20220321112310.vpr7oxro2xkz5llh@quack3.lan> <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
 <20220321145111.qz3bngofoi5r5cmh@quack3.lan> <CAOQ4uxgOpfezQ4ydjP4SPA8-7x9xSXjTmTyZOYQE3d24c2Zf7Q@mail.gmail.com>
 <20220323104129.k4djfxtjwdgoz3ci@quack3.lan> <CAOQ4uxgH3aCKnXfUFuyC7JXGtuprzWr6U9Y2T1rTQT3COoZtzw@mail.gmail.com>
 <20220323134851.px6s4i6iiaj4zlju@quack3.lan> <CAOQ4uxhBH_0UqEmOdcUaV0E8oGTGF7arr+Q_EZPuQ=KWfvJWoQ@mail.gmail.com>
 <20220323142835.epitipiq7zc55vgb@quack3.lan> <CAOQ4uxjEj4FWsd87cuYHR+vKb0ogb=zqrKHJLapqaPovUhgfFQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjEj4FWsd87cuYHR+vKb0ogb=zqrKHJLapqaPovUhgfFQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Mar 2022 21:31:35 +0200
Message-ID: <CAOQ4uxiqHWi6b2NAMrwXpYi0qQzwTDOBzuj+=Kta8z1UXFf_hQ@mail.gmail.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
To:     Jan Kara <jack@suse.cz>
Cc:     "khazhy@google.com" <khazhy@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 5:46 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Mar 23, 2022 at 4:28 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 23-03-22 16:00:30, Amir Goldstein wrote:
> > > > Well, but reclaim from kswapd is always the main and preferred source of
> > > > memory reclaim. And we will kick kswapd to do work if we are running out of
> > > > memory. Doing direct filesystem slab reclaim from mark allocation is useful
> > > > only to throttle possibly aggressive mark allocations to the speed of
> > > > reclaim (instead of getting ENOMEM). So I'm still not convinced this is a
> > > > big issue but I certainly won't stop you from implementing more fine
> > > > grained GFP mode selection and lockdep annotations if you want to go that
> > > > way :).
> > >
> > > Well it was just two lines of code to annotate the fanotify mutex as its own
> > > class, so I just did that:
> > >
> > > https://github.com/amir73il/linux/commit/7b4b6e2c0bd1942cd130e9202c4b187a8fb468c6
> >
> > But this implicitely assumes there isn't any allocation under mark_mutex
> > anywhere else where it is held. Which is likely true (I didn't check) but
> > it is kind of fragile. So I was rather imagining we would have per-group
> > "NOFS" flag and fsnotify_group_lock/unlock() would call
> > memalloc_nofs_save() based on the flag. And we would use
> > fsnotify_group_lock/unlock() uniformly across the whole fsnotify codebase.
> >
>
> I see what you mean, but looking at the code it seems quite a bit of churn to go
> over all the old backends and convert the locks to use wrappers where we "know"
> those backends are fs reclaim safe (because we did not get reports of deadlocks
> over the decades they existed).
>
> I think I will sleep better with a conversion to three flavors:
>
> 1. pflags = fsnotify_group_nofs_lock(fanotify_group);
> 2. fsnotify_group_lock(dnotify_group) =>
>     WARN_ON_ONCE(group->flags & FSNOTIFY_NOFS)
>     mutex_lock(&group->mark_mutex)
> 3. fsnotify_group_lock_nested(group) =>
>     mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING)
>

Converted common code:
https://github.com/amir73il/linux/commit/a21677eaf6b45445b6eb3f0befcd7525c932b9da
and fanotify:
https://github.com/amir73il/linux/commit/b25f22b37c488b0898de8cd7a551892eacec0dae

I can convert the rest of the backends cleanup patches later.

Thanks,
Amir.
