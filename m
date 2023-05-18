Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44C4708AD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 23:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjERV4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 17:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjERV4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 17:56:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A118F;
        Thu, 18 May 2023 14:56:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965ddb2093bso411927966b.2;
        Thu, 18 May 2023 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684446980; x=1687038980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4PaaD3J5ioNYOH+7Gy4E8NmlgV45J9uQ6WnKhEJswY=;
        b=DHNeSY73iRZYV3gWrBRkAwkUJufIG0PI+Mf5njLXH4HV9bFoBhVgZTeJus/oLbeZw4
         I3+F2iZWVKEpaQ7rvePtGtDx1UVNEBRFc3GppIo5mAD79Sv4biOyETHj/eL1JXyI1uPn
         mkfW4doy0BT5ILOb7wUPqAhPpKfpdsGbHj0Hk6RURT4UklpUcwyVKyop6tlgf9mSDkSm
         Pk8Fwze0jf94HZI/ma5MQsOdEAl5TqnOTVQJTIakQ30+5PmZ8ogGKIKufNkGyyCFe5mE
         GXiQyLW5VFUTvXyz5d8FdtteodiwxYzQROjFSGPDreGmYr0R8FKCwBXD4sSvzRh/aehB
         8D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684446980; x=1687038980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4PaaD3J5ioNYOH+7Gy4E8NmlgV45J9uQ6WnKhEJswY=;
        b=AzvBNWojF7mTnPIexylNofTu8FQxhdyQo5ylgkyELtg3GhGUYfmKUkkn1PsZKrRm7Y
         y3lO8xDwuwsr7lLqUV0I224JzVbbn1MiX5idvrNRLjtfYShoXG7xQt5l7fMK4rhCeIja
         gcCW4gbqdwkoEa5ovtTal8uMi5iEfInRdTfHkyc0oQwOMe5fP8h+le0AmmP6TLroIODf
         bFkn6AAMt1+kwqJ9BG36716BFE0QxnT305eiXLptGPLRlJE+fR7DGgGDrM4Rit3B7jfa
         PjlJNY58MWkl0IQ7p/28LRdPFc/Vb4MF1DC6PefLSBOUeaSVnl4xGQbaI4DndA0lbYGE
         9usw==
X-Gm-Message-State: AC+VfDwS/sQZiYNRJ0uR5prR1c0riCik7cGpA3LaXbvWUGsZlI+/yCGn
        Vvej6DFEIwYr1g8BhP2JIlzarHX1irs6Mflgtj4=
X-Google-Smtp-Source: ACHHUZ6d0qDNnRMtPOKLiUg0AfEnZzBmy0sP8Nxs9L7cWt+RvH8bjauxbJxKjsGf9BaAp8yitQ2SfAktFiTj2HdowUU=
X-Received: by 2002:a17:906:6a10:b0:96f:504b:4672 with SMTP id
 qw16-20020a1709066a1000b0096f504b4672mr585480ejc.13.1684446979672; Thu, 18
 May 2023 14:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230516001348.286414-1-andrii@kernel.org> <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner> <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
In-Reply-To: <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 May 2023 14:56:07 -0700
Message-ID: <CAEf4BzYW2_P8FQEkOZ6-O1OBuLFXtDoE=x-g_TieUC54wbgGXg@mail.gmail.com>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        cyphar@cyphar.com, lennart@poettering.net,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
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

On Wed, May 17, 2023 at 2:11=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, May 16, 2023 at 11:02:42AM -0700, Andrii Nakryiko wrote:
> > On Tue, May 16, 2023 at 2:07=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Mon, May 15, 2023 at 05:13:46PM -0700, Andrii Nakryiko wrote:
> > > > Current UAPI of BPF_OBJ_PIN and BPF_OBJ_GET commands of bpf() sysca=
ll
> > > > forces users to specify pinning location as a string-based absolute=
 or
> > > > relative (to current working directory) path. This has various
> > > > implications related to security (e.g., symlink-based attacks), for=
ces
> > > > BPF FS to be exposed in the file system, which can cause races with
> > > > other applications.
> > > >
> > > > One of the feedbacks we got from folks working with containers heav=
ily
> > > > was that inability to use purely FD-based location specification wa=
s an
> > > > unfortunate limitation and hindrance for BPF_OBJ_PIN and BPF_OBJ_GE=
T
> > > > commands. This patch closes this oversight, adding path_fd field to
> > >
> > > Cool!
> > >
> > > > BPF_OBJ_PIN and BPF_OBJ_GET UAPI, following conventions established=
 by
> > > > *at() syscalls for dirfd + pathname combinations.
> > > >
> > > > This now allows interesting possibilities like working with detache=
d BPF
> > > > FS mount (e.g., to perform multiple pinnings without running a risk=
 of
> > > > someone interfering with them), and generally making pinning/gettin=
g
> > > > more secure and not prone to any races and/or security attacks.
> > > >
> > > > This is demonstrated by a selftest added in subsequent patch that t=
akes
> > > > advantage of new mount APIs (fsopen, fsconfig, fsmount) to demonstr=
ate
> > > > creating detached BPF FS mount, pinning, and then getting BPF map o=
ut of
> > > > it, all while never exposing this private instance of BPF FS to out=
side
> > > > worlds.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  include/linux/bpf.h            |  4 ++--
> > > >  include/uapi/linux/bpf.h       |  5 +++++
> > > >  kernel/bpf/inode.c             | 16 ++++++++--------
> > > >  kernel/bpf/syscall.c           |  8 +++++---
> > > >  tools/include/uapi/linux/bpf.h |  5 +++++
> > > >  5 files changed, 25 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 36e4b2d8cca2..f58895830ada 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -2077,8 +2077,8 @@ struct file *bpf_link_new_file(struct bpf_lin=
k *link, int *reserved_fd);
> > > >  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
> > > >  struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
> > > >
> > > > -int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
> > > > -int bpf_obj_get_user(const char __user *pathname, int flags);
> > > > +int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *path=
name);
> > > > +int bpf_obj_get_user(int path_fd, const char __user *pathname, int=
 flags);
> > > >
> > > >  #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
> > > >  #define DEFINE_BPF_ITER_FUNC(target, args...)                     =
   \
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index 1bb11a6ee667..db2870a52ce0 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -1420,6 +1420,11 @@ union bpf_attr {
> > > >               __aligned_u64   pathname;
> > > >               __u32           bpf_fd;
> > > >               __u32           file_flags;
> > > > +             /* same as dirfd in openat() syscall; see openat(2)
> > > > +              * manpage for details of dirfd/path_fd and pathname =
semantics;
> > > > +              * zero path_fd implies AT_FDCWD behavior
> > > > +              */
> > > > +             __u32           path_fd;
> > > >       };
> > >
> > > So 0 is a valid file descriptor and can trivially be created and made=
 to
> > > refer to any file. Is this a conscious decision to have a zero value
> > > imply AT_FDCWD and have you done this somewhere else in bpf already?
> > > Because that's contrary to how any file descriptor based apis work.
> > >
> > > How this is usually solved for extensible structs is to have a flag
> > > field that raises a flag to indicate that the fd fiel is set and thus=
 0
> > > can be used as a valid value.
> > >
> > > The way you're doing it right now is very counterintuitive to userspa=
ce
> > > and pretty much guaranteed to cause subtle bugs.
> >
> > Yes, it's a very bpf()-specific convention we've settled on a while
> > ago. It allows a cleaner and simpler backwards compatibility story
> > without having to introduce new flags every single time. Most of BPF
> > UAPI by now dictates that (otherwise valid) FD 0 can't be used to pass
> > it to bpf() syscall. Most of the time users will be blissfully unaware
> > because libbpf and other BPF libraries are checking for fd =3D=3D 0 and
> > dup()'ing them to avoid ever returning FD 0 to the user.
> >
> > tl;dr, a conscious decision consistent with the rest of BPF UAPI. It
> > is a bpf() peculiarity, yes.
>
> Adding fsdevel so we're aware of this quirk.
>
> So I'm not sure whether this was ever discussed on fsdevel when you took
> the decision to treat fd 0 as AT_FDCWD or in general treat fd 0 as an
> invalid value.
>
> If it was discussed then great but if not then I would like to make it
> very clear that if in the future you decide to introduce custom
> semantics for vfs provided infrastructure - especially when exposed to
> userspace - that you please Cc us.

Yep, I'll remember to cc linux-fsdevel@vger.kernel.org for future
patches touching on vfs-related concepts, no problem. I wasn't trying
to sneak it in or anything, it just never occurred to me, sorry about
that.

>
> You often make it very clear on the list that you don't like it when
> anything that touches bpf code doesn't end up getting sent to the bpf
> mailing list. It is exactly the same for us.

That's a fair request, ack.

>
> This is not a rant I'm really just trying to make sure that we agree on
> common ground when it comes to touching each others code or semantic
> assumptions.
>
> I personally find this extremely weird to treat fd 0 as anything other
> than a random fd number as it goes against any userspace assumptions and
> drastically deviates from basically every file descriptor interface we
> have. I mean, you're not just saying fd 0 is invalid you're even saying
> it means AT_FDCWD.

Agreed, I can see how this could have undesirable (not just
surprising) implications if, say, open(O_PATH) returned fd=3D0. I just
sent a v2 with a new flag that needs to be specified to be able to use
path FD (and falling back to backwards-compatible AT_FDCWD behavior
otherwise).

>
> For every other interface, including those that pass fds in structs
> whose extensibility is premised on unknown fields being set to zero,
> have ways to make fd 0 work just fine. You could've done that to without
> inventing custom fd semantics.
