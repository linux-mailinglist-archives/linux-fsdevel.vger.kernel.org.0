Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EE250B399
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 11:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377597AbiDVJFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 05:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiDVJF3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:05:29 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AA25370E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 02:02:36 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id d198so5358716qkc.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNOuwA48pKvc4UnFkIjgb1b/GUP0I1w88fP9RmtHvqg=;
        b=iGFelV6lO9VSWPdNcdy3oYDos7k83TD+Z6/hxfMY4DTIljzi4MK234Ro1oPwTdsUaO
         JSwslZBs12uihktOs9VqfydlHMNLzBhtsN2RivOycM76MNFjteVmrAaALh9RsTeoryPj
         DnQNmLLQWeal3O1lASwvDy3IrZOkupjFJeyOaW+LB+LixeWCGYzHlbtnPmHG5xpQxdY+
         Y+UKMle7Znj0iznA0YaQj9+MYwnFuy0B8XvnYxuN+hotIMMFUsgzdINnC+R8HC3d31cW
         BOCqJBUpOFtCDVut87MyZO/e7+ofxTsuhkR7echFhk+Ms3odVIINujK2AWhTYeh+DkmJ
         eRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNOuwA48pKvc4UnFkIjgb1b/GUP0I1w88fP9RmtHvqg=;
        b=0D4ANVF+YhpKnzy/cGOuWi5x8BHjxMLrE/4Uw10qjl6LbO+6beLK0AxKGOaxyx6jvn
         6U7A66XBkncAKn3GQ8PjGrCpwLKjz3fe8z772RD5sAIse4CPQBa6cErFYrukKqjKuoYB
         H0ZZLhGrPdIGnhVJfMNnnExYvs0WwUnR8TFBpzsIH0BYw3SPXwgurt29Qq2AYvY9Cejr
         eF6sAHbGikFUju+9ER2i2xiC48l/rpQoDLruOrmNXfyrM1qUxz4RQ+n6Cwnq/arKSe8C
         mLjQv06o0YB5gXo7aZqQQqA1/VMs4dbpS0csFkLLBSmYDjEYrPKbBdHcMyewyLzx/ZTA
         WQ4w==
X-Gm-Message-State: AOAM530tontTtjiie+yg6/QwWqQMv4EPe4SK/4HqBNFdIsWYajoI44yT
        a9y+3KSJtUVXsUPwmjtTzpPUXLVT0LMuPKl9FEzk1bkQ9b0=
X-Google-Smtp-Source: ABdhPJyXhogquPFFpSGRzpzeR9IYHnfitadHFYEi7QrBtnpjSqvpJArV8BNgFHUGH7WcySmSfzc0mg0eWc4K/VFdD4s=
X-Received: by 2002:ae9:eb87:0:b0:69e:75b3:6527 with SMTP id
 b129-20020ae9eb87000000b0069e75b36527mr1992206qkg.386.1650618155493; Fri, 22
 Apr 2022 02:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220418213713.273050-1-krisman@collabora.com>
 <20220418204204.0405eda0c506fd29e857e1e4@linux-foundation.org>
 <87h76pay87.fsf@collabora.com> <CAOQ4uxhjvwwEQo+u=TD-CJ0xwZ7A1NjkA5GRFOzqG7m1dN1E2Q@mail.gmail.com>
 <CACGdZY+KqPKaW3jM2SN4MA8_SUHSRiA2Dt43Q7NbK7BO2t_FVw@mail.gmail.com>
In-Reply-To: <CACGdZY+KqPKaW3jM2SN4MA8_SUHSRiA2Dt43Q7NbK7BO2t_FVw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 Apr 2022 12:02:22 +0300
Message-ID: <CAOQ4uxiTu1k9ngxquPwxTsEzF72U9jkBs69wjfgRY7E8w4bj4g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] shmem: Allow userspace monitoring of tmpfs for
 lack of space.
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel@collabora.com,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 2:19 AM Khazhy Kumykov <khazhy@google.com> wrote:
>
> On Wed, Apr 20, 2022 at 10:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Apr 19, 2022 at 6:29 PM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> > >
> > > Andrew Morton <akpm@linux-foundation.org> writes:
> > >
> > > Hi Andrew,
> > >
> > > > On Mon, 18 Apr 2022 17:37:10 -0400 Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
> > > >
> > > >> When provisioning containerized applications, multiple very small tmpfs
> > > >
> > > > "files"?
> > >
> > > Actually, filesystems.  In cloud environments, we have several small
> > > tmpfs associated with containerized tasks.
> > >
> > > >> are used, for which one cannot always predict the proper file system
> > > >> size ahead of time.  We want to be able to reliably monitor filesystems
> > > >> for ENOSPC errors, without depending on the application being executed
> > > >> reporting the ENOSPC after a failure.
> > > >
> > > > Well that sucks.  We need a kernel-side workaround for applications
> > > > that fail to check and report storage errors?
> > > >
> > > > We could do this for every syscall in the kernel.  What's special about
> > > > tmpfs in this regard?
> > > >
> > > > Please provide additional justification and usage examples for such an
> > > > extraordinary thing.
> > >
> > > For a cloud provider deploying containerized applications, they might
> > > not control the application, so patching userspace wouldn't be a
> > > solution.  More importantly - and why this is shmem specific -
> > > they want to differentiate between a user getting ENOSPC due to
> > > insufficiently provisioned fs size, vs. due to running out of memory in
> > > a container, both of which return ENOSPC to the process.
> > >
> >
> > Isn't there already a per memcg OOM handler that could be used by
> > orchestrator to detect the latter?
> >
> > > A system administrator can then use this feature to monitor a fleet of
> > > containerized applications in a uniform way, detect provisioning issues
> > > caused by different reasons and address the deployment.
> > >
> > > I originally submitted this as a new fanotify event, but given the
> > > specificity of shmem, Amir suggested the interface I'm implementing
> > > here.  We've raised this discussion originally here:
> > >
> > > https://lore.kernel.org/linux-mm/CACGdZYLLCqzS4VLUHvzYG=rX3SEJaG7Vbs8_Wb_iUVSvXsqkxA@mail.gmail.com/
> > >
> >
> > To put things in context, the points I was trying to make in this
> > discussion are:
> >
> > 1. Why isn't monitoring with statfs() a sufficient solution? and more
> >     specifically, the shared disk space provisioning problem does not sound
> >     very tmpfs specific to me.
> >     It is a well known issue for thin provisioned storage in environments
> >     with shared resources as the ones that you describe
>
> I think this solves a different problem: to my understanding statfs
> polling is useful for determining if a long lived, slowly growing FS
> is approaching its limits - the tmpfs here are generally short lived,
> and may be intentionally running close to limits (e.g. if they "know"
> exactly how much they need, and don't expect to write any more than
> that). In this case, the limits are there to guard against runaway
> (and assist with scheduling), so "monitor and increase limits
> periodically" isn't appropriate.
>
> It's meant just to make it easier to distinguish between "tmpfs write
> failed due to OOM" and "tmpfs write failed because you exceeded tmpfs'
> max size" (what makes tmpfs "special" is that tmpfs, for good reason,
> returns ENOSPC for both of these situations to the user). For a small

Maybe it's for a good reason, but it clearly is not the desired behavior
in your use case. Perhaps what is needed here is a way for user to opt-in
to a different OOM behavior from shmem using a mount option?
Would that be enough to cover your use case?

> task a user could easily go from 0% to full, or OOM, rather quickly,
> so statfs polling would likely miss the event. The orchestrator can,
> when the task fails, easily (and reliably) look at this statistic to
> determine if a user exceeded the tmpfs limit.
>
> (I do see the parallel here to thin provisioned storage - "exceeded
> your individual budget" vs. "underlying overcommitted system ran out
> of bytes")

Right, and in this case, the application gets a different error in case
of "underlying space overcommitted", usually EIO, that's why I think that
opting-in for this same behavior could make sense for tmpfs.

We can even consider shutdown behavior for shmem in that case, but
that is up to whoever may be interested in that kind of behavior.

Thanks,
Amir.
