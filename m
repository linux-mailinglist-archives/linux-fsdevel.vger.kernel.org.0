Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379FC311538
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhBEWZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 17:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhBEO01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:26:27 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A8C061356;
        Fri,  5 Feb 2021 08:04:47 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cl8so3872834pjb.0;
        Fri, 05 Feb 2021 08:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Rk6es5Odc/haVC290vOZ/DrPzl+e7E/xVq07/LjGq1c=;
        b=VxnW++F5gSNLGypVHizPxI7LX9NOuNgc00qjhJnHmIYEZ7QYs8bByXI4YqIGJtHcxC
         ShTIoWzG6sJ/tqsOJ7WlyyPzCgPeUyCqrhwsBPM3I3s1vBY2uxvbt9oLK+xx1wjKSmC6
         QUMKjYtoJu+7MIfXV4tGc/lre/akRLkvOxKWhfCKqJd0MeRVdZFb3wV+7f0W4OFAsgpo
         +p9eC3ZfeOz7RJwrHkxOCiob1ns5iq8fBlsX7+kFtHorsdk83ELU20ckEqYklpilOD3g
         MBaZFEFUNRfENaraZ+FKGwab/v/rSrbBW+rjbcqCGSpiSvqnoWrWEDrGbQgWbsePVZEm
         9EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Rk6es5Odc/haVC290vOZ/DrPzl+e7E/xVq07/LjGq1c=;
        b=dg6O55eSWdLCHxCaZSrhq6XbiVkH2J1P+L2YfG/7mCK6cjgLPgffHJqB22+7LPiorm
         NOJuVULxdgtvhQsKV9GiCamv2TG4fzhp/TDqdF7bzKODh60UtOuM6Ls264IYWDJlFlWW
         U1cQ7ydtXBwI9MJN+i1kk8A0E9s/3DWZ9GIRsqxMhOFfqhxBv6RUlJBCBxOFgb7NkNcL
         6y8UNxtw7A4nVuK4s1AmefRyGue0smeUtxhqgReAwHbL7I2UwHy0c4uokqZfo3eKMhlM
         6YR2xiTzUAm2YcgPUSkUhIxEiqSZjA8yFsGHV+4a/KJcn9dk1jMkka8tgl5gyxLq5WyA
         OblA==
X-Gm-Message-State: AOAM531NW+QKPslpQHG9pkWK8gtQ3awRIR8atr3LMz9MiuTU7VJLxgR6
        2/G7j0e5GlhJJMNxrjlf+rI6QieSfBNd16EpFpgMQT1Zr0o=
X-Google-Smtp-Source: ABdhPJyf/XQErWc2swFQn6YLU1TeO7IBzDbRcW86bxibi00GlO0fcY7Eog9OGyvTRv2PELRSc3xOtovYjdw7x6w6rYE=
X-Received: by 2002:a0c:906c:: with SMTP id o99mr4539764qvo.28.1612534801508;
 Fri, 05 Feb 2021 06:20:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612433345.git.naohiro.aota@wdc.com> <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <20210205092635.i6w3c7brawlv6pgs@naota-xeon> <CAL3q7H6REfruE-DSyiqZQ_Y0=HmXbiTbEC3d18Q7+3Z7pf5QzQ@mail.gmail.com>
In-Reply-To: <CAL3q7H6REfruE-DSyiqZQ_Y0=HmXbiTbEC3d18Q7+3Z7pf5QzQ@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 5 Feb 2021 14:19:50 +0000
Message-ID: <CAL3q7H7YkUAJ1h_hQzJ5C_ek5DD==V1rD1petxrs1aDru5j1+A@mail.gmail.com>
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

On Fri, Feb 5, 2021 at 11:49 AM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 9:26 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
> >
> > Since the zoned filesystem requires sequential write out of metadata, w=
e
> > cannot proceed with a hole in tree-log pages. When such a hole exists,
> > btree_write_cache_pages() will return -EAGAIN. We cannot wait for the r=
ange
> > to be written, because it will cause a deadlock. So, let's bail out to =
a
> > full commit in this case.
> >
> > Cc: Filipe Manana <fdmanana@gmail.com>
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/tree-log.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > This patch solves a regression introduced by fixing patch 40. I'm
> > sorry for the confusing patch numbering.
>
> Hum, how does patch 40 can cause this?
> And is it before the fixup or after?
>
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 4e72794342c0..629e605cd62d 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -3120,6 +3120,14 @@ int btrfs_sync_log(struct btrfs_trans_handle *tr=
ans,
> >          */
> >         blk_start_plug(&plug);
> >         ret =3D btrfs_write_marked_extents(fs_info, &log->dirty_log_pag=
es, mark);
> > +       /*
> > +        * There is a hole writing out the extents and cannot proceed i=
t on
> > +        * zoned filesystem, which require sequential writing. We can
>
> require -> requires
>
> > +        * ignore the error for now, since we don't wait for completion=
 for
> > +        * now.
>
> So why can we ignore the error for now?
> Why not just bail out here and mark the log for full commit? (without
> a transaction abort)
>
> > +        */
> > +       if (ret =3D=3D -EAGAIN)
> > +               ret =3D 0;

Thinking again about this, it would be safer, and self-documenting to
check here that we are in zoned mode:

if (ret =3D=3D -EAGAIN && is_zoned)
    ret =3D 0;

Because if we start to get -EAGAIN here one day, from non-zoned code,
we risk not writing out some extent buffer and getting a corrupt log,
which may be very hard to find.
With that additional check in place, we'll end up aborting the
transaction with -EAGAIN and notice the problem much sooner.

> >         if (ret) {
> >                 blk_finish_plug(&plug);
> >                 btrfs_abort_transaction(trans, ret);
> > @@ -3229,7 +3237,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *tr=
ans,
> >                                          &log_root_tree->dirty_log_page=
s,
> >                                          EXTENT_DIRTY | EXTENT_NEW);
> >         blk_finish_plug(&plug);
> > -       if (ret) {
> > +       /*
> > +        * There is a hole in the extents, and failed to sequential wri=
te
> > +        * on zoned filesystem. We cannot wait for this write outs, sin=
c it
>
> this -> these
>
> > +        * cause a deadlock. Bail out to the full commit, instead.
> > +        */
> > +       if (ret =3D=3D -EAGAIN) {

I would add "&& is_zoned" here too.

Thanks.


> > +               btrfs_wait_tree_log_extents(log, mark);
> > +               mutex_unlock(&log_root_tree->log_mutex);
> > +               goto out_wake_log_root;
>
> Must also call btrfs_set_log_full_commit(trans);
>
> Thanks.
>
> > +       } else if (ret) {
> >                 btrfs_set_log_full_commit(trans);
> >                 btrfs_abort_transaction(trans, ret);
> >                 mutex_unlock(&log_root_tree->log_mutex);
> > --
> > 2.30.0
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
