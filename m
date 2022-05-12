Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1BB52541F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 19:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357318AbiELRvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 13:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357350AbiELRvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 13:51:04 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FE91C108
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 10:51:03 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id n8so5321651qke.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77kPa0c+8cBC1eoQnd+kLvCqS5u7Phv5Ax2B2pxQ5SQ=;
        b=BOQFvDrSfytPDFS9s4n09v1ewiL4bWt1ZCJe6d74P/yGhcPomIkToasbtaZOgHJ9E+
         pDW/qye+RGIreT/t4nv4ifydMxZ+JCfAllBgBSY8z+oN7ByxLXEhKvYYEJXQu0utAjW0
         9tiVtqi4Qv0c0C3IB9uR6NXxiKrCfWCa9CkIikFoh0fKN6o8EtB90XyZCu6/6jIbsj6q
         qVPDqvsoRTiTx8Gu/SzqTXhSejgzjhE0BepQ08aXcp0Oi8iNVz4O71eekPdNt5De/VQE
         LCUlaBvA6y0v1P3PQhU1d5yj8yPDTtlaYC1vr5tJiAxP7KYeE9aRnC3YfC1BL3lP5Mm+
         ncUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77kPa0c+8cBC1eoQnd+kLvCqS5u7Phv5Ax2B2pxQ5SQ=;
        b=wY3n7vRAMGg110BAy3KMpOHdrEA1pbMYHU1QOk6wKr+tf/2BBj0R7Cd0Q3jLQrK0mA
         fhXx8IAYra5+e8IjJJWdhsI4H0Fjf9d1UDSlj4POngxRqYKTFLlMAdA0onkq9znQvbyZ
         60JHR93qXGm/HOZbJvkpis5xKAgOY+8e0ia3XY/1l69qC2L5KecTQW7+6mWwmUQ1IkaO
         4gZTUJJmzpnJJPwLBURRBL/nThiC9HamoUiqvMYy4oROxI9FCf/LctEVuxEITi5dc5hd
         BzFOKhntVcfD4K0U3ZLaJlhs6cT6iSqqexlj6nU4gbUNHspBQyGtBp+xGJ2rq6EsHqvA
         zrMg==
X-Gm-Message-State: AOAM530tB8WDiiytwa9lsYBAoIo8OhWEJyDilMGfpuywtz2L4HeXaEME
        6sQkWIc5IKgodKnwboxiDhcQ13TZurC1Duu3epuCyHCEKmQ=
X-Google-Smtp-Source: ABdhPJwOAOuFZ+CpHqIKtVf8HrdSY28Ehq9Wz/bubJkbx3TJu6yWBpzbuYV0+YjSypXayCGy6Dp0hypv7ztFKs6l8PY=
X-Received: by 2002:a37:9cd8:0:b0:69f:b618:c7ab with SMTP id
 f207-20020a379cd8000000b0069fb618c7abmr867136qke.722.1652377862055; Thu, 12
 May 2022 10:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220511092914.731897-1-amir73il@gmail.com> <20220511092914.731897-2-amir73il@gmail.com>
 <20220511125440.5zsuzn7eemdvfksi@quack3.lan> <CAOQ4uxjjfaU4xefu1-qK5MzGq+m0EChB9mK6TZo1Lp6bmBviUQ@mail.gmail.com>
 <20220512172058.j2zyhpmyt4trlwvf@quack3.lan>
In-Reply-To: <20220512172058.j2zyhpmyt4trlwvf@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 12 May 2022 20:50:50 +0300
Message-ID: <CAOQ4uxitDOdh4mvY7JXN1hDuN3BmLg2AS=SJ+rW6Ex-K76NeXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsnotify: introduce mark type iterator
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
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

On Thu, May 12, 2022 at 8:20 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 11-05-22 21:26:16, Amir Goldstein wrote:
> > On Wed, May 11, 2022 at 3:54 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 11-05-22 12:29:13, Amir Goldstein wrote:
> > > > fsnotify_foreach_iter_mark_type() is used to reduce boilerplate code
> > > > of iteratating all marks of a specific group interested in an event
> > > > by consulting the iterator report_mask.
> > > >
> > > > Use an open coded version of that iterator in fsnotify_iter_next()
> > > > that collects all marks of the current iteration group without
> > > > consulting the iterator report_mask.
> > > >
> > > > At the moment, the two iterator variants are the same, but this
> > > > decoupling will allow us to exclude some of the group's marks from
> > > > reporting the event, for example for event on child and inode marks
> > > > on parent did not request to watch events on children.
> > > >
> > > > Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events on child and on dir")
> > > > Reported-by: Jan Kara <jack@suse.com>
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Mostly looks good. Two nits below.
> > >
> > > >  /*
> > > > - * Pop from iter_info multi head queue, the marks that were iterated in the
> > > > + * Pop from iter_info multi head queue, the marks that belong to the group of
> > > >   * current iteration step.
> > > >   */
> > > >  static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
> > > >  {
> > > > +     struct fsnotify_mark *mark;
> > > >       int type;
> > > >
> > > >       fsnotify_foreach_iter_type(type) {
> > > > -             if (fsnotify_iter_should_report_type(iter_info, type))
> > > > +             mark = iter_info->marks[type];
> > > > +             if (mark && mark->group == iter_info->current_group)
> > > >                       iter_info->marks[type] =
> > > >                               fsnotify_next_mark(iter_info->marks[type]);
> > >
> > > Wouldn't it be more natural here to use the new helper
> > > fsnotify_foreach_iter_mark_type()? In principle we want to advance mark
> > > types which were already reported...
> >
> > Took me an embarrassing amount of time to figure out why this would be wrong
> > and I must have known this a few weeks ago when I wrote the patch, so
> > a comment is in order:
> >
> >         /*
> >          * We cannot use fsnotify_foreach_iter_mark_type() here because we
> >          * may need to check if next group has a mark of type X even if current
> >          * group did not have a mark of type X.
> >          */
>
> Well, but this function is just advancing the lists for marks we have
> already processed. And processed marks are exactly those set in report_mask.
> So your code should be equivalent to the old one but using
> fsnotify_foreach_iter_mark_type() should work as well AFAICT.

Yes, you are right about that. But,
With the 2 patches applied, fanotify09 test gets into livelock here.
Fixing the livelock requires that fsnotify_iter_should_report_type()
condition is removed.

I am assuming that it is the next patch that introduces the livelock,
but I cannot figure out why the comment I have written above is not true
in the code in master.

Could it be that the livelock already exists but we do not have a test case
to trigger it and the test case in fanotify09 which checks the next patch
is just a private case?

In any case, even if the logic change here is not needed before the next
patch, it would make no sense to convert this function to
fsnotify_foreach_iter_mark_type() and change it back.
The most that could make sense is to add this comment and remove
fsnotify_iter_should_report_type() together with the next patch.

Can you wrap your head around this? Because I can't.

Thanks,
Amir.
