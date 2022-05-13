Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FBF525A17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 05:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376733AbiEMD2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 23:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376680AbiEMD2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 23:28:41 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5950B20D4FF
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 20:28:39 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s22so283543qta.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 20:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUrbAVqKNIghAyICwSFdFXjIamir2iAIMDv5j0+X5U0=;
        b=jbOsxahCQQJkrJ0lnvTIL82YPdULOQO3XHXyCzXnfPKOfaPE9o5ru/qomuqER1aI8w
         X0xMaMbYvIvLoK9w5TTliA1VMxbKjUoRh6LD4nLEoHwiXeZc4AFk2Sm3SDx+ALMci6uh
         k6zpCyAfoDjP1qrxH/IydUJ+NyJsa/B1EBUufsydibAUgee1ZhSMix5fTY8CdA/y+ZxM
         vfhwj2V55z0AxOR81wQyij4txN72T05umFN3kBQohru0ELVEZJRc+DcDbcIvC9xXnXx+
         v4DuBVrLTOf/VxHZ4MuqMUZL6LwAXSwYJNUMOIVT5R2ArMWqLp49uShU7aX8lhgUEt7E
         w1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUrbAVqKNIghAyICwSFdFXjIamir2iAIMDv5j0+X5U0=;
        b=RCB5+90kRqSHw7rP7kHTNUAFwi1AfX4jjJicCQbsUXkq+2H9hFxpx1Uf/zlwDq9R4O
         5cDnjwYWBq+SN7/CedVn5YmcQB6rgeolzo1GSobo+j9zqbU2IvCh1y5Zi3OIvPDrf7O0
         b36OXnp+deK85YSqaUE/hormrGrk2PHCb880Y2+00nG8UWyZQ41gyt5Ux4q1Y1S2zmbL
         nherqye1IFiwm7OdOpk0thCDWdWEvDSYJUPvghV0PHiYjpYxmWw4GounSMORxlWSGZty
         +ahj4nj3UGCRl4h0UEGcxPxakr+m/S/+fsO5nZSczUMZAjA6Go7ywcakdPB5v4R9fJQi
         oLOA==
X-Gm-Message-State: AOAM532bEU5jMWM3SIdw1d1MClqvUuRIdMtie7gBhnQpT1sR4zPfP/9Y
        Osz/9EJ37rhBO3ujHq3Wjxnm8PwYdcnyfb4+gnY=
X-Google-Smtp-Source: ABdhPJxJ+kAF4RbMnjQt7ce+CwfUaULKxCmzFLveLfhyfCNqbjHBJ49ZucY298u5/cR6dbLDzt7r6vULax/4yJJB9Og=
X-Received: by 2002:ac8:5a53:0:b0:2f3:c6bc:b66d with SMTP id
 o19-20020ac85a53000000b002f3c6bcb66dmr2758328qta.477.1652412518395; Thu, 12
 May 2022 20:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220511092914.731897-1-amir73il@gmail.com> <20220511092914.731897-2-amir73il@gmail.com>
 <20220511125440.5zsuzn7eemdvfksi@quack3.lan> <CAOQ4uxjjfaU4xefu1-qK5MzGq+m0EChB9mK6TZo1Lp6bmBviUQ@mail.gmail.com>
 <20220512172058.j2zyhpmyt4trlwvf@quack3.lan> <CAOQ4uxitDOdh4mvY7JXN1hDuN3BmLg2AS=SJ+rW6Ex-K76NeXg@mail.gmail.com>
 <CAOQ4uxiXDjf4FJ3LA+7y6TV_RstZki3AVykv_zAbz-3Jf5khEA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiXDjf4FJ3LA+7y6TV_RstZki3AVykv_zAbz-3Jf5khEA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 May 2022 06:28:26 +0300
Message-ID: <CAOQ4uxihxfVeRt7ygL923Xa11Mj=x0zZREFEH548sbJg9YQ+yw@mail.gmail.com>
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

On Fri, May 13, 2022 at 6:07 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, May 12, 2022 at 8:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, May 12, 2022 at 8:20 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 11-05-22 21:26:16, Amir Goldstein wrote:
> > > > On Wed, May 11, 2022 at 3:54 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Wed 11-05-22 12:29:13, Amir Goldstein wrote:
> > > > > > fsnotify_foreach_iter_mark_type() is used to reduce boilerplate code
> > > > > > of iteratating all marks of a specific group interested in an event
> > > > > > by consulting the iterator report_mask.
> > > > > >
> > > > > > Use an open coded version of that iterator in fsnotify_iter_next()
> > > > > > that collects all marks of the current iteration group without
> > > > > > consulting the iterator report_mask.
> > > > > >
> > > > > > At the moment, the two iterator variants are the same, but this
> > > > > > decoupling will allow us to exclude some of the group's marks from
> > > > > > reporting the event, for example for event on child and inode marks
> > > > > > on parent did not request to watch events on children.
> > > > > >
> > > > > > Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events on child and on dir")
> > > > > > Reported-by: Jan Kara <jack@suse.com>
> > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > >
> > > > > Mostly looks good. Two nits below.
> > > > >
> > > > > >  /*
> > > > > > - * Pop from iter_info multi head queue, the marks that were iterated in the
> > > > > > + * Pop from iter_info multi head queue, the marks that belong to the group of
> > > > > >   * current iteration step.
> > > > > >   */
> > > > > >  static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
> > > > > >  {
> > > > > > +     struct fsnotify_mark *mark;
> > > > > >       int type;
> > > > > >
> > > > > >       fsnotify_foreach_iter_type(type) {
> > > > > > -             if (fsnotify_iter_should_report_type(iter_info, type))
> > > > > > +             mark = iter_info->marks[type];
> > > > > > +             if (mark && mark->group == iter_info->current_group)
> > > > > >                       iter_info->marks[type] =
> > > > > >                               fsnotify_next_mark(iter_info->marks[type]);
> > > > >
> > > > > Wouldn't it be more natural here to use the new helper
> > > > > fsnotify_foreach_iter_mark_type()? In principle we want to advance mark
> > > > > types which were already reported...
> > > >
> > > > Took me an embarrassing amount of time to figure out why this would be wrong
> > > > and I must have known this a few weeks ago when I wrote the patch, so
> > > > a comment is in order:
> > > >
> > > >         /*
> > > >          * We cannot use fsnotify_foreach_iter_mark_type() here because we
> > > >          * may need to check if next group has a mark of type X even if current
> > > >          * group did not have a mark of type X.
> > > >          */
> > >
> > > Well, but this function is just advancing the lists for marks we have
> > > already processed. And processed marks are exactly those set in report_mask.
> > > So your code should be equivalent to the old one but using
> > > fsnotify_foreach_iter_mark_type() should work as well AFAICT.
> >
> > Yes, you are right about that. But,
> > With the 2 patches applied, fanotify09 test gets into livelock here.
> > Fixing the livelock requires that fsnotify_iter_should_report_type()
> > condition is removed.
> >
> > I am assuming that it is the next patch that introduces the livelock,
> > but I cannot figure out why the comment I have written above is not true
> > in the code in master.
>
> Nevermind. I got it.
>
> >
> > Could it be that the livelock already exists but we do not have a test case
> > to trigger it and the test case in fanotify09 which checks the next patch
> > is just a private case?
> >
>
> No. This is because of the change of behavior in the next patch.

Bah, no it is not.
Emailing before coffee is not a good idea...

It is *this* patch that changes the behavior:
fsnotify_iter_select_report_types() can return true with 0 report_mask
and it is valid.
This is documented in the updated comments above fsnotify_iter_next()
and fsnotify_iter_select_report_types() and also in commit message:

    Use an open coded version of that iterator in fsnotify_iter_next()
    that collects all marks of the current iteration group without
    consulting the iterator report_mask.

The comment I added to v2 could be better phrased as:

 /*
  * We cannot use fsnotify_foreach_iter_mark_type() here because we
  * may need to advance a mark of type X that belongs to current_group
  * but was not selected for reporting.
  */

Is that better? Do you want me to re-post or can you fix that on commit?
Maybe even phrase it better than I did.

Thanks,
Amir.
