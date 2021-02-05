Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F6C3115EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhBEWpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 17:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhBENKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:10:51 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9A4C061221;
        Fri,  5 Feb 2021 05:07:41 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id a19so6777832qka.2;
        Fri, 05 Feb 2021 05:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=eifO5w09vaVkYD/HNL+OdTyeOvd9OOp5ZX1K5KzvrTo=;
        b=uux1/nfGwEFnTg/EJ2HdZY7y2r9LwQKaqqCMlBfo/r+87x8xBc1uCR0W4HA3Am8xxl
         ND1paPnztrtHvNqVIgvl09Jb1LpjoEee062glaCBFJhxTMlYL2zD4VLZjUfhr7KJXI/X
         fJvt+NE/9xjR/1gC3nfciFI0dFE3sHddFXC0ahFKSrUk0s6KY4qJR8IwJ3WKvRGVXVK4
         E+3VIHAJpsRFvpC08M2b03BT4xu2f3usNNGnS1eJnSkz6j72tNoGD4aOY1kmQB2mfx+W
         pFA/+RQmR/jGXkd87VAeGcFW6y6uO9LeK2MDx1Lyd/NE+9NNWjpB/gI+QQZ3d6tEahWl
         72CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=eifO5w09vaVkYD/HNL+OdTyeOvd9OOp5ZX1K5KzvrTo=;
        b=NbkmFD8Cy96L60BIf4Y9FbWQ9BT7BWsXHZ05oxxb+sG6qs4Jvsq9gOjBMIuiW+J6Pt
         rDddVTwzMQZwXpRhg3cDm7ipK+fmdRVfdf/nNz9YzMyyxy9sAJxgMLuD7ZxYRhy/MuiR
         upKTIPIYYZwSOHVgOYyLBJV8UqIHJCuY/tU9XaWtuTkd39E5WG6pzt2NNvFXpEWnkVsN
         F07TaQkR/zQSuYCQN4fDGKQVjwc7YE9IkWpwPlPJuuiQd9tCBEfqrZyp00DRSx/xw3bY
         sWM2PalPNlJ/NoaCWX4EBsWLLGTLYw/F38OwUj/Z+bfmbQfSutfU1dyze4JIVzsaiMYd
         /PlQ==
X-Gm-Message-State: AOAM531LEjxhayoPDMFnkuGZcg252qAUj41hrsbBoUaD5pCbPUqG2O1w
        8SZihCe1SZQ92rmlxzO6Oc2RSjUZmlw42Y9tPio=
X-Google-Smtp-Source: ABdhPJx6LvF5n7cqNVXse1TC5iGMbFDY6ruGVS89G9oW4Vnhy82FeiuC3aqWafe15OIyMsm+d23xaqLM96nQCFOTmFY=
X-Received: by 2002:a37:6491:: with SMTP id y139mr3989047qkb.479.1612530460261;
 Fri, 05 Feb 2021 05:07:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612433345.git.naohiro.aota@wdc.com> <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <20210205092635.i6w3c7brawlv6pgs@naota-xeon> <CAL3q7H6REfruE-DSyiqZQ_Y0=HmXbiTbEC3d18Q7+3Z7pf5QzQ@mail.gmail.com>
 <20210205125526.4oeqd3utuho3b2hv@naota-xeon>
In-Reply-To: <20210205125526.4oeqd3utuho3b2hv@naota-xeon>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 5 Feb 2021 13:07:29 +0000
Message-ID: <CAL3q7H6x4hcs3T17EKPQkHwth_2_M6c=c8=GxGy1eu1nDDDAUQ@mail.gmail.com>
Subject: Re: [PATCH v15 43/43] btrfs: zoned: deal with holes writing out
 tree-log pages
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, hare@suse.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 5, 2021 at 12:55 PM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> On Fri, Feb 05, 2021 at 11:49:05AM +0000, Filipe Manana wrote:
> > On Fri, Feb 5, 2021 at 9:26 AM Naohiro Aota <naohiro.aota@wdc.com> wrot=
e:
> > >
> > > Since the zoned filesystem requires sequential write out of metadata,=
 we
> > > cannot proceed with a hole in tree-log pages. When such a hole exists=
,
> > > btree_write_cache_pages() will return -EAGAIN. We cannot wait for the=
 range
> > > to be written, because it will cause a deadlock. So, let's bail out t=
o a
> > > full commit in this case.
> > >
> > > Cc: Filipe Manana <fdmanana@gmail.com>
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > ---
> > >  fs/btrfs/tree-log.c | 19 ++++++++++++++++++-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > >
> > > This patch solves a regression introduced by fixing patch 40. I'm
> > > sorry for the confusing patch numbering.
> >
> > Hum, how does patch 40 can cause this?
> > And is it before the fixup or after?
>
> With pre-5.10 code base + zoned series at that time, it passed
> xfstests without this patch.
>
> With current code base + zoned series without the fixup for patch 40,
> it also passed the tests, because we are mostly bailing out to a full
> commit.
>
> The fixup now stressed the new fsync code on zoned mode and revealed
> an issue to have -EAGAIN from btrfs_write_marked_extents(). This error
> happens when a concurrent transaction commit is writing a dirty extent
> in this tree-log commit. This issue didn't occur previously because of
> a longer critical section, I guess.

Ok, if I understand you correctly, the problem is a transaction commit
and an fsync both allocating metadata extents at the same time.

>
> >
> > >
> > > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > > index 4e72794342c0..629e605cd62d 100644
> > > --- a/fs/btrfs/tree-log.c
> > > +++ b/fs/btrfs/tree-log.c
> > > @@ -3120,6 +3120,14 @@ int btrfs_sync_log(struct btrfs_trans_handle *=
trans,
> > >          */
> > >         blk_start_plug(&plug);
> > >         ret =3D btrfs_write_marked_extents(fs_info, &log->dirty_log_p=
ages, mark);
> > > +       /*
> > > +        * There is a hole writing out the extents and cannot proceed=
 it on
> > > +        * zoned filesystem, which require sequential writing. We can
> >
> > require -> requires
> >
> > > +        * ignore the error for now, since we don't wait for completi=
on for
> > > +        * now.
> >
> > So why can we ignore the error for now?
> > Why not just bail out here and mark the log for full commit? (without
> > a transaction abort)
>
> As described above, -EAGAIN happens when a concurrent process writes
> out an extent buffer of this tree-log commit. This concurrent write
> out will fill a hole for us, so the next write out might
> succeed. Indeed we can bail out here, but I opted to try the next
> write.

Ok, if I understand you correctly, you mean it will be fine if after
this point no one allocates metadata extents from the hole?

I think such a clear explanation would fit nicely in the comment.

Thanks.

>
> > > +        */
> > > +       if (ret =3D=3D -EAGAIN)
> > > +               ret =3D 0;
> > >         if (ret) {
> > >                 blk_finish_plug(&plug);
> > >                 btrfs_abort_transaction(trans, ret);
> > > @@ -3229,7 +3237,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *=
trans,
> > >                                          &log_root_tree->dirty_log_pa=
ges,
> > >                                          EXTENT_DIRTY | EXTENT_NEW);
> > >         blk_finish_plug(&plug);
> > > -       if (ret) {
> > > +       /*
> > > +        * There is a hole in the extents, and failed to sequential w=
rite
> > > +        * on zoned filesystem. We cannot wait for this write outs, s=
inc it
> >
> > this -> these
> >
> > > +        * cause a deadlock. Bail out to the full commit, instead.
> > > +        */
> > > +       if (ret =3D=3D -EAGAIN) {
> > > +               btrfs_wait_tree_log_extents(log, mark);
> > > +               mutex_unlock(&log_root_tree->log_mutex);
> > > +               goto out_wake_log_root;
> >
> > Must also call btrfs_set_log_full_commit(trans);
>
> Oops, I missed this one.
>
> > Thanks.
> >
> > > +       } else if (ret) {
> > >                 btrfs_set_log_full_commit(trans);
> > >                 btrfs_abort_transaction(trans, ret);
> > >                 mutex_unlock(&log_root_tree->log_mutex);
> > > --
> > > 2.30.0
> > >
> >
> >
> > --
> > Filipe David Manana,
> >
> > =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 yo=
u're right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
