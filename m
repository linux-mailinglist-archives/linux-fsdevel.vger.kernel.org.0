Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35716E8A35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 08:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjDTGNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 02:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjDTGNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:13:05 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C4846A5;
        Wed, 19 Apr 2023 23:13:04 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-44048c2de31so170351e0c.0;
        Wed, 19 Apr 2023 23:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681971183; x=1684563183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBJtHUl3WWXKQhLJMTuHgqqfjlIWf5tHymiO1bzFmxI=;
        b=sIXTGCdSZJ0VDuteowLQt+J4N8RRAuFSKfN2WOhhbAsJqOqMt7PvcsS7HvPDd/+/Wz
         b+CrC+E3g7p6OgFM3KJzXjjFRjQLkdkeJZt7Ai9RYDsXpTo2XdB95rZFLTJ5Na2fGU08
         yq4vPrnXfrRsouKbkoCbyLRK6HHRNY8+mZ/lB/93ohsNnGSq7GjaMcFAEJ/pQmJINdPQ
         pfPZq/+u901tTl8N/iMEv5EWr2UpnXsWKpahAmBb8VJ+pHUENfk2rwyZnKhNsO7udi30
         c3sSXNinRi4mYbMmvb5vM4hFSI/dgvjW66FPLVCVP0nQTmAsj+O6bnkibdE509YVNRI2
         kAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681971183; x=1684563183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBJtHUl3WWXKQhLJMTuHgqqfjlIWf5tHymiO1bzFmxI=;
        b=MnPtHSGGfnwQoRvBravjy1dloULfpAP+r54Kf9j/KN2YrY1Dk5B6S6NC5e0NjNPv92
         fNjuyIj854I7q8hpBDeWyVSJiobXUEXqmieqDVLGG2b7u59Q8vCcvHlx5JIIlDFThVx+
         sScas0qbBKXl8F9iyUTEHVyOWv1tFZOiGhDZKdx1zuR01gIoPxKemHxpe+tJqUGfF8nS
         59ae1n3i4BqwKd6l5ZZ4lRFy54Xd+g9HpxL1tNvO4q1ovuYKVRjTus6KKmIBTxGZBWoR
         6ckV8obWYBo37uTRwAE8qFe32g8v2m7JBwwsIVyz7Ib7XHkveYsaWZYf2qWIkkwaqUkQ
         AOlw==
X-Gm-Message-State: AAQBX9e6UyqqfZkcp4gklSJRZTNuysQpZpcNoAyevR+iDs0UdDJOSpco
        me/NWmSFrn0oMdvdAV2OjRxqphDoPopZlfRl6dSF0a2g3p0=
X-Google-Smtp-Source: AKy350YKu3sdNcj1YMw9OXYB1/PGoawX7KuJccVyHva4G1i75Ic4ZlZfxiUOrqIVDBKPuE+avRjQsMlY33vOjeu4ZRg=
X-Received: by 2002:a67:e049:0:b0:42c:9397:429 with SMTP id
 n9-20020a67e049000000b0042c93970429mr411637vsl.0.1681971183411; Wed, 19 Apr
 2023 23:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230414182903.1852019-1-amir73il@gmail.com> <20230418-diesmal-heimlaufen-ba2f2d1e1938@brauner>
 <CAOQ4uxj5UwDhV7XxWZ-Os+fzM=_N1DDWHpjmt6UnHr96EDriMw@mail.gmail.com>
 <20230418-absegnen-sputen-11212a0615c7@brauner> <CAOQ4uxgM2x93UKcJ5D5tfoTt8s0ChTrEheTGqTcndGoyGwS=7w@mail.gmail.com>
 <20230419-besungen-filzen-adad4a1f3247@brauner>
In-Reply-To: <20230419-besungen-filzen-adad4a1f3247@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 20 Apr 2023 09:12:52 +0300
Message-ID: <CAOQ4uxgPsxtNHgvETTUyYrguPmOBOK=jzRHgfivSDbbNPnzL2w@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/2] Monitoring unmounted fs with fanotify
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 8:19=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Apr 18, 2023 at 06:20:22PM +0300, Amir Goldstein wrote:
> > On Tue, Apr 18, 2023 at 5:12=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Tue, Apr 18, 2023 at 04:56:40PM +0300, Amir Goldstein wrote:
> > > > On Tue, Apr 18, 2023 at 4:33=E2=80=AFPM Christian Brauner <brauner@=
kernel.org> wrote:

[...]

> > > > Just thought of another reason:
> > > >  c) FAN_UNMOUNT does not need to require FAN_REPORT_FID
> > > >      so it does not depend on filesystem having a valid f_fsid nor
> > > >      exports_ops. In case of "pseudo" fs, FAN_UNMOUNT can report
> > > >      only MNTID record (I will amend the patch with this minor chan=
ge).
> > >
> > > I see some pseudo fses generate f_fsid, e.g., tmpfs in mm/shmem.c
> >
> > tmpfs is not "pseudo" in my eyes, because it implements a great deal of=
 the
> > vfs interfaces, including export_ops.
>
> The term "pseudo" is somewhat well-defined though, no? It really just
> means that there's no backing device associated with it. So for example,
> anything that uses get_tree_nodev() including tmpfs. If erofs is
> compiled with fscache support it's even a pseudo fs (TIL).
>

Ok, "pseudo fs" is an ambiguous term.

For the sake of this discussion, let's refer to fs that use get_tree_nodev(=
)
"non-disk fs".

But as far as fsnotify is concerned, tmpfs is equivalent to xfs, because
all of the changes are made by users via vfs.

Let's call fs where changes can occur not via vfs "remote fs", those
include the network fs and some "internal fs" like the kernfs class of fs
and the "simple fs" class of fs (i.e. simple_fill_super).

With all the remote fs, the behavior of fsnotify is (and has always been)
undefined, that is, you can use inotify to subscribe for events and you
never know what you will get when changes are not made via vfs.

Some people (hypothetical) may expect to watch nsfs for dying ns
and may be disappointed to find out that they do not get the desired
IN_DELETE event.

We have had lengthy discussions about remote fs change notifications
with no clear decisions of the best API for them:
https://lore.kernel.org/linux-fsdevel/20211025204634.2517-1-iangelak@redhat=
.com/

> >
> > and also I fixed its f_fsid recently:
> > 59cda49ecf6c shmem: allow reporting fanotify events with file handles o=
n tmpfs
>
> Well thank you for that this has been very useful in userspace already
> I've been told.
>
> >
> > > At the risk of putting my foot in my mouth, what's stopping us from
> > > making them all support f_fsid?
> >
> > Nothing much. Jan had the same opinion [1].
>
> I think that's what we should try to do without having thought too much
> about potential edge-cases.
>
> >
> > We could do either:
> > 1. use uuid_to_fsid() in vfs_statfs() if fs has set s_uuid and not set =
f_fsid
> > 2. use s_dev as f_fsid in vfs_statfs() if fs did not set f_fsid nor s_u=
uid
> > 3. randomize s_uuid for simple fs (like tmpfs)
> > 4. any combination of the above and more
> >
> > Note that we will also need to decide what to do with
> > name_to_handle_at() for those pseudo fs.
>
> Doing it on the fly during vfs_statfs() feels a bit messy and could
> cause bugs. One should never underestimate the possibility that there's
> some fs that somehow would get into trouble because of odd behavior.
>
> So switching each fs over to generate a s_uuid seems the prudent thing
> to do. Doing it the hard way also forces us to make sure that each
> filesystem can deal with this.
>
> It seems that for pseudo fses we can just allocate a new s_uuid for each
> instance. So each tmpfs instance - like your patch did - would just get
> a new s_uuid.
>
> For kernel internal filesystems - mostly those that use init_pseudo -
> the s_uuid would remain stable until the next reboot when it is
> regenerated.
>

I am fine with opt-in for every fs as long as we do not duplicate
boilerplate code.
An FS_ flag could be a simple way to opt-in for this generic behavior.

> Looking around just a little there's some block-backed fses like fat
> that have an f_fsid but no s_uuid. So if we give those s_uuid then it'll
> mean that the f_fsid isn't generated based on the s_uuid. That should be
> ok though and shouldn't matter to userspace.
>
> Afterwards we could probably lift the ext4 and xfs specific ioctls to
> retrieve the s_uuid into a generic ioctl to allow userspace to get the
> s_uuid.
>
> That's my thinking without having crawled to all possible corner
> cases... Also needs documenting that s_uuid is not optional anymore and
> explain the difference between pseudo and device-backed fses. I hope
> that's not completely naive...
>

I don't think that the dichotomy of device-backed vs. pseudo is enough
to describe the situation.

I think what needs to be better documented and annotated is what type
of fsnotify services can be expected to work on a given fs.

Jan has already introduced FS_DISALLOW_NOTIFY_PERM to opt-out
of permission events (for procfs).

Perhaps this could be generalized to s_type->fs_notify_supported_events
or s_type->fs_notify_supported_features.

For example, if an fs opts-in to FAN_REPORT_FID, then it gets an auto
allocated s_uuid and f_fsid if it did not fill them in fill_super and in st=
atfs
and it gets a default implementation for encoding file handles from ino/gen=
.

Thanks,
Amir.
