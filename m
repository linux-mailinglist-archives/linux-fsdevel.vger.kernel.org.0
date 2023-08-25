Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A66788D8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 19:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbjHYRDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 13:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjHYRDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:03:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED8B1FF5
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 10:03:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so4551286a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google; t=1692982996; x=1693587796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSpUxbBXVj26kOGi+OlLtmtncpHe6F+9WWjDFtfafPk=;
        b=rdwLij6Cp+xCDzwni/DraMiKplwvtFJSSx53HIKdXUiLs1Q/iTg47JpA69sSpC0efN
         Dv8jVLdX+ZomI4EOE3JVESZi/kGIKKgLxr38aisXqho58iXXSBQzXjhTQHs1cFBl8mXO
         3yAahAylCR4AhjTrA5JxgMEs3kmtnvaig81nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692982996; x=1693587796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSpUxbBXVj26kOGi+OlLtmtncpHe6F+9WWjDFtfafPk=;
        b=YZoPhfE2fQpIFdvf5dzx5j211V/a2YgJI40o8Q4g/lnRagfQejriI3nwzb6MyjyCW5
         tsAJ+F4Y2SGiBFmkvrKRwd90yTohF6DDBSxAFMgiRHB/MQDJJG/sL43PDb0xevF2yA+J
         DTitZxr9qweDyoQccoz6bptc2LaOnkLYgGuarEpbTQ2Bk4xD/+U3j95L+MlnRFk05BA0
         4KxmCZz99z4JeUo/n78/kbpOWJZphTr2u6MCIMG9eJqyE28IXAVrxDYxCr25T1KeNxaF
         5tA8vhcqFKquPB7bDRnLZFp92A3MJILBciVyph/laTlePm9FASXHDYxl1MqPrJWHBr/0
         CC5g==
X-Gm-Message-State: AOJu0YyVs4rI7rg2VgaP90aN8Q+F6TdfNNpxsjTiPL8rQDoFdO2EVGj9
        KkJ8zxpFqX8RZnDwnUMAjUygjF79NfgPLxoTWH1Hug==
X-Google-Smtp-Source: AGHT+IGC8oAT9I6eJpDXZfWiYkFHuXY6lU1y4ZsC9TiZk8SBENPsUm/XcRqHoO3KnfrkgBFw0FgCzLupyAD9J9xiBYI=
X-Received: by 2002:a17:907:7714:b0:99b:4210:cc76 with SMTP id
 kw20-20020a170907771400b0099b4210cc76mr18802362ejc.28.1692982995706; Fri, 25
 Aug 2023 10:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230810090044.1252084-1-sargun@sargun.me> <20230810090044.1252084-2-sargun@sargun.me>
 <20230815-ableisten-offiziell-9b4de6357f7c@brauner> <CAMp4zn_RM+X8PBkAxXSuXrxbLTb2ndzVNXt10eaWj4uyWna30w@mail.gmail.com>
 <20230816-gauner-ehrung-95dc455055a0@brauner> <20230816.081541-lush.apricots.naughty.importer-1AIDZGMF3bd@cyphar.com>
 <20230816-covern-kronzeuge-6d60381f598c@brauner>
In-Reply-To: <20230816-covern-kronzeuge-6d60381f598c@brauner>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 25 Aug 2023 11:02:39 -0600
Message-ID: <CAMp4zn9FwArMzibK6XY15b9_ouHo03DfUzOC199n2bNHkMqtGA@mail.gmail.com>
Subject: Re: [PATCH 2/3] fs: Allow user to lock mount attributes with mount_setattr
To:     Christian Brauner <brauner@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 4:36=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Aug 16, 2023 at 06:56:25PM +1000, Aleksa Sarai wrote:
> > On 2023-08-16, Christian Brauner <brauner@kernel.org> wrote:
> > > On Tue, Aug 15, 2023 at 06:46:33AM -0700, Sargun Dhillon wrote:
> > > > On Tue, Aug 15, 2023 at 2:30=E2=80=AFAM Christian Brauner <brauner@=
kernel.org> wrote:
> > > > >
> > > > > On Thu, Aug 10, 2023 at 02:00:43AM -0700, Sargun Dhillon wrote:
> > > > > > We support locking certain mount attributes in the kernel. This=
 API
> > > > > > isn't directly exposed to users. Right now, users can lock moun=
t
> > > > > > attributes by going through the process of creating a new user
> > > > > > namespaces, and when the mounts are copied to the "lower privil=
ege"
> > > > > > domain, they're locked. The mount can be reopened, and passed a=
round
> > > > > > as a "locked mount".
> > > > >
> > > > > Not sure if that's what you're getting at but you can actually fu=
lly
> > > > > create these locked mounts already:
> > > > >
> > > > > P1                                                 P2
> > > > > # init userns + init mountns                       # init userns =
+ init mountns
> > > > > sudo mount --bind /foo /bar
> > > > > sudo mount --bind -o ro,nosuid,nodev,noexec /bar
> > > > >
> > > > > # unprivileged userns + unprivileged mountns
> > > > > unshare --mount --user --map-root
> > > > >
> > > > > mount --bind -oremount
> > > > >
> > > > > fd =3D open_tree(/bar, OPEN_TREE_CLONE)
> > > > >
> > > > > send(fd_send, P2);
> > > > >
> > > > >                                                    recv(&fd_recv,=
 P1)
> > > > >
> > > > >                                                    move_mount(fd_=
recv, /locked-mnt);
> > > > >
> > > > > and now you have a fully locked mount on the host for P2. Did you=
 mean that?
> > > > >
> > > >
> > > > Yep. Doing this within a program without clone / fork is awkward. F=
orking and
> > > > unsharing in random C++ programs doesn't always go super well, so i=
n my
> > > > mind it'd be nice to have an API to do this directly.
> > > >
> > > > In addition, having the superblock continue to be owned by the user=
ns that
> > > > its mounted in is nice because then they can toggle the other mount=
 attributes
> > > > (nodev, nosuid, noexec are the ones we care about).
> > > >
> > > > > >
> > > > > > Locked mounts are useful, for example, in container execution w=
ithout
> > > > > > user namespaces, where you may want to expose some host data as=
 read
> > > > > > only without allowing the container to remount the mount as mut=
able.
> > > > > >
> > > > > > The API currently requires that the given privilege is taken aw=
ay
> > > > > > while or before locking the flag in the less privileged positio=
n.
> > > > > > This could be relaxed in the future, where the user is allowed =
to
> > > > > > remount the mount as read only, but once they do, they cannot m=
ake
> > > > > > it read only again.
> > > > >
> > > > > s/read only/read write/
> > > > >
> > > > > >
> > > > > > Right now, this allows for all flags that are lockable via the
> > > > > > userns unshare trick to be locked, other than the atime related
> > > > > > ones. This is because the semantics of what the "less privilege=
d"
> > > > > > position is around the atime flags is unclear.
> > > > >
> > > > > I think that atime stuff doesn't really make sense to expose to
> > > > > userspace. That seems a bit pointless imho.
> > > > >
> > > > > >
> > > > > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > > > > ---
> > > > > >  fs/namespace.c             | 40 ++++++++++++++++++++++++++++++=
+++++---
> > > > > >  include/uapi/linux/mount.h |  2 ++
> > > > > >  2 files changed, 39 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > > > index 54847db5b819..5396e544ac84 100644
> > > > > > --- a/fs/namespace.c
> > > > > > +++ b/fs/namespace.c
> > > > > > @@ -78,6 +78,7 @@ static LIST_HEAD(ex_mountpoints); /* protecte=
d by namespace_sem */
> > > > > >  struct mount_kattr {
> > > > > >       unsigned int attr_set;
> > > > > >       unsigned int attr_clr;
> > > > > > +     unsigned int attr_lock;
> > > > >
> > > > > So when I originally noted down this crazy idea
> > > > > https://github.com/uapi-group/kernel-features
> > > > > I didn't envision a new struct member but rather a flag that coul=
d be
> > > > > raised in attr_set like MOUNT_ATTR_LOCK that would indicate for t=
he
> > > > > other flags in attr_set to become locked.
> > > > >
> > > > > So if we could avoid growing the struct pointlessly I'd prefer th=
at. Is
> > > > > there a reason that wouldn't work?
> > > > No reason. The semantics were just a little more awkward, IMHO.
> > > > Specifically:
> > > > * This attr could never be cleared, only set, which didn't seem to =
follow
> > > > the attr_set / attr_clr semantics
> > > > * If we ever introduced a mount_getattr call, you'd want to expose
> > > > each of the locked bits independently, I'd think, and exposing
> > > > that through one flag wouldn't give you the same fidelity.
> > >
> > > Hm, right. So it's either new flags or a new member. @Aleksa?
> >
> > I like ->attr_lock more tbh, especially since they cannot be cleared.
> > They are implemented as mount flags internally, but conceptually lockin=
g
> > flags is a separate thing to setting them.
>
> Ok, it'd be neat if could do the sanity review of this api then as you
> know the eventual users probably best.

Aleksa,
What do you think? The biggest miss / frustration with this API is that
there is no way to introspect which flags are locked from userspace,
but given the absence of a mount_getattr syscall (currently), I think
that we can add that later.
