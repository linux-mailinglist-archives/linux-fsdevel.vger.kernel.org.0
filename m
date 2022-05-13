Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87105259EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 05:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376683AbiEMDHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 23:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356735AbiEMDHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 23:07:43 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C356D18C
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 20:07:41 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id kj8so5817682qvb.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 20:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrZByhrhOaJ4Z61OCWx+9vdEu735XTwBbnp3gG60fL0=;
        b=RmkIXRjnswHh7Ve8jS9xVEevvXhwbdOcNAwPTl2dtJY1oW9nSMn9slCKConv62929L
         YFVL1ZLIczgGI9JUc43bypi+zEigwht5iI2f/KccsdKl2a0JOzr8MqYayZdYnvQ4bpp0
         HM0ZookUShIPJy2e8rg62FZ1aUTuckC3c9gz5RayhBMFgzibX+ztb2eJX5Uw6uggeUrv
         WAOpH8mkrmVfc+u+X8gi9O4KFjyPgGQbUb+ev7X2BbaJreVCEz0gKeP8zPHvWE6Tr4GZ
         nUUlw3Wh6AOgat/Qd81u8ybBEjbLLi9iixyFz1CIiCIXebTPz5OuCC9elvwp7BZtzaKT
         IvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrZByhrhOaJ4Z61OCWx+9vdEu735XTwBbnp3gG60fL0=;
        b=ohqv0+L8pxLZFNimxfPNoLbRKS0V/kI53w0BXk0yEY+2VE3XZNGjTeJ7dq52CK1+dT
         NhJ4bIjkSxKWQb4mwoJFvkxHnKIqMZvCQUrBONIF/yquNEbS3ot2wiYXv41rTaugOcaE
         vPfaqJw4TV8a/wnYzojMtZ1chuGqlq+FBFBP08KKTd5zmt67kOfmD83jzyyEtRHnnbVh
         e4L70qoKmheOswP9wjz4aVwQaivmL37VcKxn5cj2nm8x3Kh+MDWnuFccuJ4hPoAz8SVO
         FO9YwyD6XOKCrgAI7ckzdNCR6vU/oClkrQaiJKb3JDrspGdJkqq70X3o1UFv1sT79Tyl
         cP3g==
X-Gm-Message-State: AOAM530uckuhCqgVnh3yrUg19EEs3mUaJZUhPBlLN0cQxnZEcJvBD92R
        XfsxdORAx3RdoVwIFMvOBPJLtovWT8CcSTMs7eYtGoUW
X-Google-Smtp-Source: ABdhPJxylNs2dKzDXwv8hl7WjQ2CzU+tvywudegY/Y5FuzzYGtp+z2rmorXunfUOQydD0tTvAiJFJRSrgFvUF+o3ZOY=
X-Received: by 2002:a05:6214:29e9:b0:45a:c341:baaf with SMTP id
 jv9-20020a05621429e900b0045ac341baafmr2597520qvb.77.1652411260465; Thu, 12
 May 2022 20:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220511092914.731897-1-amir73il@gmail.com> <20220511092914.731897-2-amir73il@gmail.com>
 <20220511125440.5zsuzn7eemdvfksi@quack3.lan> <CAOQ4uxjjfaU4xefu1-qK5MzGq+m0EChB9mK6TZo1Lp6bmBviUQ@mail.gmail.com>
 <20220512172058.j2zyhpmyt4trlwvf@quack3.lan> <CAOQ4uxitDOdh4mvY7JXN1hDuN3BmLg2AS=SJ+rW6Ex-K76NeXg@mail.gmail.com>
In-Reply-To: <CAOQ4uxitDOdh4mvY7JXN1hDuN3BmLg2AS=SJ+rW6Ex-K76NeXg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 May 2022 06:07:28 +0300
Message-ID: <CAOQ4uxiXDjf4FJ3LA+7y6TV_RstZki3AVykv_zAbz-3Jf5khEA@mail.gmail.com>
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

On Thu, May 12, 2022 at 8:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, May 12, 2022 at 8:20 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 11-05-22 21:26:16, Amir Goldstein wrote:
> > > On Wed, May 11, 2022 at 3:54 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Wed 11-05-22 12:29:13, Amir Goldstein wrote:
> > > > > fsnotify_foreach_iter_mark_type() is used to reduce boilerplate code
> > > > > of iteratating all marks of a specific group interested in an event
> > > > > by consulting the iterator report_mask.
> > > > >
> > > > > Use an open coded version of that iterator in fsnotify_iter_next()
> > > > > that collects all marks of the current iteration group without
> > > > > consulting the iterator report_mask.
> > > > >
> > > > > At the moment, the two iterator variants are the same, but this
> > > > > decoupling will allow us to exclude some of the group's marks from
> > > > > reporting the event, for example for event on child and inode marks
> > > > > on parent did not request to watch events on children.
> > > > >
> > > > > Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events on child and on dir")
> > > > > Reported-by: Jan Kara <jack@suse.com>
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > Mostly looks good. Two nits below.
> > > >
> > > > >  /*
> > > > > - * Pop from iter_info multi head queue, the marks that were iterated in the
> > > > > + * Pop from iter_info multi head queue, the marks that belong to the group of
> > > > >   * current iteration step.
> > > > >   */
> > > > >  static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
> > > > >  {
> > > > > +     struct fsnotify_mark *mark;
> > > > >       int type;
> > > > >
> > > > >       fsnotify_foreach_iter_type(type) {
> > > > > -             if (fsnotify_iter_should_report_type(iter_info, type))
> > > > > +             mark = iter_info->marks[type];
> > > > > +             if (mark && mark->group == iter_info->current_group)
> > > > >                       iter_info->marks[type] =
> > > > >                               fsnotify_next_mark(iter_info->marks[type]);
> > > >
> > > > Wouldn't it be more natural here to use the new helper
> > > > fsnotify_foreach_iter_mark_type()? In principle we want to advance mark
> > > > types which were already reported...
> > >
> > > Took me an embarrassing amount of time to figure out why this would be wrong
> > > and I must have known this a few weeks ago when I wrote the patch, so
> > > a comment is in order:
> > >
> > >         /*
> > >          * We cannot use fsnotify_foreach_iter_mark_type() here because we
> > >          * may need to check if next group has a mark of type X even if current
> > >          * group did not have a mark of type X.
> > >          */
> >
> > Well, but this function is just advancing the lists for marks we have
> > already processed. And processed marks are exactly those set in report_mask.
> > So your code should be equivalent to the old one but using
> > fsnotify_foreach_iter_mark_type() should work as well AFAICT.
>
> Yes, you are right about that. But,
> With the 2 patches applied, fanotify09 test gets into livelock here.
> Fixing the livelock requires that fsnotify_iter_should_report_type()
> condition is removed.
>
> I am assuming that it is the next patch that introduces the livelock,
> but I cannot figure out why the comment I have written above is not true
> in the code in master.

Nevermind. I got it.

>
> Could it be that the livelock already exists but we do not have a test case
> to trigger it and the test case in fanotify09 which checks the next patch
> is just a private case?
>

No. This is because of the change of behavior in the next patch.

> In any case, even if the logic change here is not needed before the next
> patch, it would make no sense to convert this function to
> fsnotify_foreach_iter_mark_type() and change it back.
> The most that could make sense is to add this comment and remove
> fsnotify_iter_should_report_type() together with the next patch.

Yes. I will do that and better explain in the comment.

Thanks,
Amir.
