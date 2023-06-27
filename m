Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85E97401D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 19:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjF0RDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 13:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjF0RD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:03:29 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2CA10FF
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 10:03:27 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-57059626276so53307817b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687885407; x=1690477407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwJpQjqEtRpc/SEmt5pFPTPTYI4cOuq5x7buDx5ZuQ0=;
        b=VNU6l8MQAHnG/R3gJ3KAuxwjiBJWuDsgo0tU96FjtiRPcbwah5Beuv6ZFNsUbpKf+Y
         od3zt5MqA8N/KnROUYO5UBxfbReNGZwSm0DKfdYg7HKQ6tJm0r7cupQznzsSGNMZHxQu
         R2HsDLOK/kVS1KnpxoGBybdPHBX/zJPfu4Al4J3gN6dJ/ywxc8sy2uxfttDpeMaru5x0
         KmKCRrLJNja0vWGI2qMoyYuxgHgR7bGCrFz5XH05BII/O5/2HW7PUuhklZ/8K2jpnfwG
         jTxxxS7tkMfbGze3Jgd7fqt5WINMKOS6wR07oPT0lM1R/uhJdWBnM3utYlqTbs8Tdi/e
         9EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687885407; x=1690477407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwJpQjqEtRpc/SEmt5pFPTPTYI4cOuq5x7buDx5ZuQ0=;
        b=ODqN+t68cWQcNr6g+VVA2wrWxjVBrbgaOrASnmKo1mN7k4Ntb2HETx3REXmdDr3aDS
         8Pcv4EDOwKIF6bjXuUUR0J/TN+yj4WGKfHxxm+gnqN/yAyLtu3peZ2S+NLevtzHlqo6m
         gPbfNPD9iOTT+qbH+ODyZnm+gLLMUmr5h4V0dZhiybmtxg/Xf9X4kD++pwW98lZuHVnJ
         GOPqpe/VvAAOvlMzH5H9bOC4dQVhkaAyN8BkZsveW6MzpqC8jXEzhea6uUDpwTphDWU/
         wQAVLMxFvcVN3EgwLzsYBBbM33PXqScJTawv4h1+/hCrO4JDQa8gGk1oUmaTIanB+YKj
         wCHw==
X-Gm-Message-State: AC+VfDymLkcLjshDC3grGMfKLMvLK8ZoWdlkeUXsib2MNCkPZqxZVqLU
        wf95OjHqLo5c+tv3U6gA647n/kjJbZW0dzLmjN3i4A==
X-Google-Smtp-Source: ACHHUZ5PVaGCJu4BN1A9Mb4T/fUpUO1U6zkHsUD52ji5cOi00nbkf1CK+leY05Kw4YrbFD4QsPZpoHAEBW+fjnL4AW4=
X-Received: by 2002:a25:acd4:0:b0:ba8:ae3a:dd39 with SMTP id
 x20-20020a25acd4000000b00ba8ae3add39mr33038525ybd.43.1687885406546; Tue, 27
 Jun 2023 10:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230626201713.1204982-1-surenb@google.com> <2023062757-hardening-confusion-6f4e@gregkh>
In-Reply-To: <2023062757-hardening-confusion-6f4e@gregkh>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 10:03:15 -0700
Message-ID: <CAJuCfpGUTMP2FTzzx+bq9_5KZjo1r_qspHYZXK2Ors-yU3XhqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
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

On Mon, Jun 26, 2023 at 11:25=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Jun 26, 2023 at 01:17:12PM -0700, Suren Baghdasaryan wrote:
> > kernfs_ops.release operation can be called from kernfs_drain_open_files
> > which is not tied to the file's real lifecycle. Introduce a new kernfs_=
ops
> > free operation which is called only when the last fput() of the file is
> > performed and therefore is strictly tied to the file's lifecycle. This
> > operation will be used for freeing resources tied to the file, like
> > waitqueues used for polling the file.
>
> This is confusing, shouldn't release be the "last" time the file is
> handled and then all resources attached to it freed?  Why do we need
> another callback, shouldn't release handle this?

That is what I thought too but apparently kernfs_drain_open_files()
can also cause ops->release to be called while the file keeps on
living (see details here:
https://lore.kernel.org/all/CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru=3D=
=3DMdEHQg@mail.gmail.com/#t).

>
>
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/kernfs/file.c       | 8 +++++---
> >  include/linux/kernfs.h | 5 +++++
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > index 40c4661f15b7..acc52d23d8f6 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -766,7 +766,7 @@ static int kernfs_fop_open(struct inode *inode, str=
uct file *file)
> >
> >  /* used from release/drain to ensure that ->release() is called exactl=
y once */
> >  static void kernfs_release_file(struct kernfs_node *kn,
> > -                             struct kernfs_open_file *of)
> > +                             struct kernfs_open_file *of, bool final)
>
> Adding flags to functions like this are a pain, now we need to look it
> up every time to see what that bool means.
>
> And when we do, we see that it is not documented here so we have no idea
> of what it is :(
>
> This is not going to be maintainable as-is, sorry.

It's a static function with only two places it's used in the same
file. I can add documentation too if that helps.

>
> >  {
> >       /*
> >        * @of is guaranteed to have no other file operations in flight a=
nd
> > @@ -787,6 +787,8 @@ static void kernfs_release_file(struct kernfs_node =
*kn,
> >               of->released =3D true;
> >               of_on(of)->nr_to_release--;
> >       }
> > +     if (final && kn->attr.ops->free)
> > +             kn->attr.ops->free(of);
> >  }
> >
> >  static int kernfs_fop_release(struct inode *inode, struct file *filp)
> > @@ -798,7 +800,7 @@ static int kernfs_fop_release(struct inode *inode, =
struct file *filp)
> >               struct mutex *mutex;
> >
> >               mutex =3D kernfs_open_file_mutex_lock(kn);
> > -             kernfs_release_file(kn, of);
> > +             kernfs_release_file(kn, of, true);
> >               mutex_unlock(mutex);
> >       }
> >
> > @@ -852,7 +854,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn=
)
> >               }
> >
> >               if (kn->flags & KERNFS_HAS_RELEASE)
> > -                     kernfs_release_file(kn, of);
> > +                     kernfs_release_file(kn, of, false);
>
> Why isn't this also the "last" time things are touched here?  why is it
> false?

Because it's called from the context of the process doing rmdir() and
if another process has the file in the directory opened it will have
that file alive until it calls the last fput(). These are the call
paths:

do_rmdir
  cgroup_rmdir
    kernfs_drain_open_files
      kernfs_release_file(..., false)
        kn->attr.ops->release(), of->released=3Dtrue

fput()
  kernfs_fop_release()
    kernfs_release_file(..., true), of->released=3D=3Dtrue,
kn->attr.ops->release() is not called.

So, when kn->attr.ops->release() is called by do_rmdir() the file is
still kept alive by another process holding a reference to the file.
It's a problem in our case because if we free the resources associated
with that file (waitqueue head) from inside our release() operation
then the ongoing poll() operation on that file will step on that freed
resource.

>
>
> >       }
> >
> >       WARN_ON_ONCE(on->nr_mmapped || on->nr_to_release);
> > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > index 73f5c120def8..a7e404ff31bb 100644
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -273,6 +273,11 @@ struct kernfs_ops {
> >        */
> >       int (*open)(struct kernfs_open_file *of);
> >       void (*release)(struct kernfs_open_file *of);
> > +     /*
> > +      * Free resources tied to the lifecycle of the file, like a
> > +      * waitqueue used for polling.
> > +      */
> > +     void (*free)(struct kernfs_open_file *of);
>
> I agree with Tejun, this needs to be documented much better and show how
> you really should never need to use this :)

I'll be happy not to use it if we can fix the release() to be called
only when the file is truly going away.
Thanks,
Suren.

>
> thanks,
>
> greg k-h
