Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9526E9D1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 22:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjDTUZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 16:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjDTUYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:24:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639106EA6
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 13:23:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94f6c285d92so118711466b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682022209; x=1684614209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDPS2kJGA9qHFAhB01dB7yBOdSjj/en4thGsxxtxQ0Y=;
        b=EGJMPcsyHoAX/3gJSN5xuzkkXvuy7iPOrcCdkFFe5y4qoCmbLuUudZ5/py08XvZhAD
         dTESHFeDumQ2LmNnLOMS8aDauca5eoCn+hdL6UEhIyzkE1wwZHtB7EaW0ttXr/UB1/yo
         30CiV9bU0Ied0qmn7FdLPavRsZfDwtu9FTDG/cSmGQASCWDb3iAhYHICJ3KKwcZYnQUf
         LAFiq4XGTjTI7PcCQVTQHP286d/cKqQucx0gkmMRuQVaGQGuuLHbr6IW14F9/+HPpVwj
         hPkuaDIbBkTtFGVKEB4DEGjLzorQM0fNJEw/yASZ3odr6htflmHhSoLYzmq/4N7BOWd7
         dALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022209; x=1684614209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDPS2kJGA9qHFAhB01dB7yBOdSjj/en4thGsxxtxQ0Y=;
        b=lF3pnHd1VTSpceVE1jwzvpOOjwaMptBFE0aVI4P3FSpSp1BEtgs/MeAUDJZx3sAAUK
         CqssiyglKaGw9grTwWwjifoJ1xh8FUaTsWjKOtkJSX1r5zjZB/yfEPfGmuiIgN9Ii9Fc
         eKYzckpgOXF+StiEdVEuNYzqZSveI0w7u+ymXfsGS7w0jGNnWcnWTyd+a6ZpVqS1xhlx
         k0MMGw9zTvrSSwpJCSPDDRiUgvIqCgHT28ycAvIzSNaughNeYd7iSpqrO5qEqeISUYoZ
         Lyz9W0p43hjEut30io3fvJqSZd8WJZg/6U1z3MP2MrFuUhQMOX3Fb+F5pGqNDCd9mLCz
         fs7A==
X-Gm-Message-State: AAQBX9fQ36Wi42HCKw4EVje3UmPaeEIkizwTrNt2Zl+QaInxz88wzcsq
        hw6E9z86O3TmQM4pdRID7fmPMPook5IZl7DF3EpG0g==
X-Google-Smtp-Source: AKy350Y6JgZn+n32RVYt90ndNBzxPcxioaUY46Yi32s9vSyYFUTnxZMryzRw8uFSHj66bl/ng+HSO9ExYjhITUUmcQ4=
X-Received: by 2002:a17:907:50a1:b0:878:7c18:8fd9 with SMTP id
 fv33-20020a17090750a100b008787c188fd9mr149599ejc.44.1682022208633; Thu, 20
 Apr 2023 13:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
 <20230403220337.443510-2-yosryahmed@google.com> <CALvZod5h5G9YNu8d9fAOL5eXie5iM3urw9QgD=vucBdCMAQnxA@mail.gmail.com>
In-Reply-To: <CALvZod5h5G9YNu8d9fAOL5eXie5iM3urw9QgD=vucBdCMAQnxA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Apr 2023 13:22:52 -0700
Message-ID: <CAJD7tkbd=CJjRWbPev-8aZm=mufE5Sp7u5AzPUUJTK9xL_yOgQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 1/5] writeback: move wb_over_bg_thresh()
 call outside lock section
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 20, 2023 at 11:53=E2=80=AFAM Shakeel Butt <shakeelb@google.com>=
 wrote:
>
> +Jens & Jan
>
> The patch looks good but it would be nice to pass this patch through
> the eyes of experts of this area.

Thanks for taking a look and CC'ing folks. I will make sure to include
them in the next rounds as well. FWIW, Jens & Jan did not show up when
I ran scripts/get_maintainers.ph if I remember correctly.

>
> On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > wb_over_bg_thresh() calls mem_cgroup_wb_stats() which invokes an rstat
> > flush, which can be expensive on large systems. Currently,
> > wb_writeback() calls wb_over_bg_thresh() within a lock section, so we
> > have to make the rstat flush atomically. On systems with a lot of
> > cpus/cgroups, this can cause us to disable irqs for a long time,
> > potentially causing problems.
> >
> > Move the call to wb_over_bg_thresh() outside the lock section in
> > preparation to make the rstat flush in mem_cgroup_wb_stats() non-atomic=
.
> > The list_empty(&wb->work_list) should be okay outside the lock section
> > of wb->list_lock as it is protected by a separate lock (wb->work_lock),
> > and wb_over_bg_thresh() doesn't seem like it is modifying any of the b_=
*
> > lists the wb->list_lock is protecting. Also, the loop seems to be
> > already releasing and reacquring the lock, so this refactoring looks
> > safe.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  fs/fs-writeback.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 195dc23e0d831..012357bc8daa3 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -2021,7 +2021,6 @@ static long wb_writeback(struct bdi_writeback *wb=
,
> >         struct blk_plug plug;
> >
> >         blk_start_plug(&plug);
> > -       spin_lock(&wb->list_lock);
> >         for (;;) {
> >                 /*
> >                  * Stop writeback when nr_pages has been consumed
> > @@ -2046,6 +2045,9 @@ static long wb_writeback(struct bdi_writeback *wb=
,
> >                 if (work->for_background && !wb_over_bg_thresh(wb))
> >                         break;
> >
> > +
> > +               spin_lock(&wb->list_lock);
> > +
> >                 /*
> >                  * Kupdate and background works are special and we want=
 to
> >                  * include all inodes that need writing. Livelock avoid=
ance is
> > @@ -2075,13 +2077,19 @@ static long wb_writeback(struct bdi_writeback *=
wb,
> >                  * mean the overall work is done. So we keep looping as=
 long
> >                  * as made some progress on cleaning pages or inodes.
> >                  */
> > -               if (progress)
> > +               if (progress) {
> > +                       spin_unlock(&wb->list_lock);
> >                         continue;
> > +               }
> > +
> >                 /*
> >                  * No more inodes for IO, bail
> >                  */
> > -               if (list_empty(&wb->b_more_io))
> > +               if (list_empty(&wb->b_more_io)) {
> > +                       spin_unlock(&wb->list_lock);
> >                         break;
> > +               }
> > +
> >                 /*
> >                  * Nothing written. Wait for some inode to
> >                  * become available for writeback. Otherwise
> > @@ -2093,9 +2101,7 @@ static long wb_writeback(struct bdi_writeback *wb=
,
> >                 spin_unlock(&wb->list_lock);
> >                 /* This function drops i_lock... */
> >                 inode_sleep_on_writeback(inode);
> > -               spin_lock(&wb->list_lock);
> >         }
> > -       spin_unlock(&wb->list_lock);
> >         blk_finish_plug(&plug);
> >
> >         return nr_pages - work->nr_pages;
> > --
> > 2.40.0.348.gf938b09366-goog
> >
