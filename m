Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CA75505C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 17:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiFRPau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 11:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiFRPat (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:30:49 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671AC10FD5;
        Sat, 18 Jun 2022 08:30:47 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id r4so6660275vsf.10;
        Sat, 18 Jun 2022 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ec81JYS9w05iELXFjalVH4ADOj7J/oGdbyFrCIUI9hk=;
        b=dL596wyrSxQmSMAyW4DEZlFRo8n7C8VTb+84OXnV7Wx6dY+JGfce4zLMP0ZENZ9SWI
         hTCTUoGqUcviCHKpYRVfLFl0ciQW/gFqqafwcrSSSKD5qJguLfPTyIMT15sgEw1vyQSK
         NeGPMM3qfIcAWAVnqkQUTGjrmMnWzv9/RSKgYIwmtym0sQnc9UY5pB6X9u1aetCo0Orp
         xipzKRc/s0HIFRhv+0qFdf77Ccwo1Z/P2JPhgZ9Dxy3PsM3Q3PXS/tfPd81nF8cIkofk
         DkPYMYI3P/LhnqY5V04VUUfNO07B3B6tRtHTiwfodPYfPWg/5Mv47h6eXKMbRvfIawFf
         uw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ec81JYS9w05iELXFjalVH4ADOj7J/oGdbyFrCIUI9hk=;
        b=dH2ZMCvaOL18udr8r1UuhcOI4Ixwd5pkOEsP7E4mjoVWRRFyZAli7h6rlYFTSF/kDj
         qLhriPaWqw06I2k6BSuOjirrUxuyFfVrC64iGmbYgPr3mqodY1fOFNq2UgF2M+/ZwLRg
         3JIzqRRE5rcrqDmfB0mMTyIZmbtYNrWf6jyXybMHEDXGfM5AlAt0Tio9RQb6RZqZgPZG
         xy+/+6RkKzQ33VDu8rQyxKURa88MjjCtncXyCByZzLBLcAkldg6uBlrDYSHdSXbyN0WA
         Q0qWiFc0ro2Bo4EGnjJ9EdUNFZCum7XG4BUVjbCtXE4bNWq5ipAIuzDChT/1UrNX8mz+
         t7MQ==
X-Gm-Message-State: AJIora9/CDFN/WY3Xb1jdIVOupPhHpfdJjtBJgsVoTHGUZdlKxPFI1v4
        5yTPkEgyXeIec/iAPmx1Z9jBJJPnoXolRu3bgMM=
X-Google-Smtp-Source: AGRyM1v8FLa38qza3BLrfAhoH5oURZdetNTjGy6tO2zlIgKlS9EB/2GFEvwQpjIsWr1FZsLeHAcdErKBzoh11r25H0U=
X-Received: by 2002:a05:6102:3bc5:b0:34c:bfaa:1d31 with SMTP id
 a5-20020a0561023bc500b0034cbfaa1d31mr6340120vsv.3.1655566246401; Sat, 18 Jun
 2022 08:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153139.35588-1-cgzones@googlemail.com>
 <20220608112728.b4xrdppxqmyqmtwf@wittgenstein> <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
 <20220608124808.uylo5lntzfgxxmns@wittgenstein> <CAOQ4uxjP7kC95ou56wabVhQcc2vkNcD-8usYhLhbLOoJZ-jkOw@mail.gmail.com>
 <20220618031805.nmgiuapuqeblm3ba@senku> <CAOQ4uxg6QLJ26pX8emXmUvq6jDDEH_Qq=Z4RPUK-jGLsZpHzfg@mail.gmail.com>
 <CAJ2a_DectnRF56fxpOjvVm2ZdvO+shxCjtjzLbH4oaa7KnsgTA@mail.gmail.com>
In-Reply-To: <CAJ2a_DectnRF56fxpOjvVm2ZdvO+shxCjtjzLbH4oaa7KnsgTA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 18 Jun 2022 18:30:35 +0300
Message-ID: <CAOQ4uxj1YhDmXqkwzfVt6JjRu4Fqtq-u1vj72m75U_AggBhs=g@mail.gmail.com>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <brauner@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Sat, Jun 18, 2022 at 2:19 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Sat, 18 Jun 2022 at 11:11, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sat, Jun 18, 2022 at 6:18 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > >
> > > On 2022-06-08, Amir Goldstein <amir73il@gmail.com> wrote:
> > > > On Wed, Jun 8, 2022 at 3:48 PM Christian Brauner <brauner@kernel.or=
g> wrote:
> > > > >
> > > > > On Wed, Jun 08, 2022 at 03:28:52PM +0300, Amir Goldstein wrote:
> > > > > > On Wed, Jun 8, 2022 at 2:57 PM Christian Brauner <brauner@kerne=
l.org> wrote:
> > > > > > >
> > > > > > > On Tue, Jun 07, 2022 at 05:31:39PM +0200, Christian G=C3=B6tt=
sche wrote:
> > > > > > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > > > > > >
> > > > > > > > Support file descriptors obtained via O_PATH for extended a=
ttribute
> > > > > > > > operations.
> > > > > > > >
> > > > > > > > Extended attributes are for example used by SELinux for the=
 security
> > > > > > > > context of file objects. To avoid time-of-check-time-of-use=
 issues while
> > > > > > > > setting those contexts it is advisable to pin the file in q=
uestion and
> > > > > > > > operate on a file descriptor instead of the path name. This=
 can be
> > > > > > > > emulated in userspace via /proc/self/fd/NN [1] but requires=
 a procfs,
> > > > > > > > which might not be mounted e.g. inside of chroots, see[2].
> > > > > > > >
> > > > > > > > [1]: https://github.com/SELinuxProject/selinux/commit/7e979=
b56fd2cee28f647376a7233d2ac2d12ca50
> > > > > > > > [2]: https://github.com/SELinuxProject/selinux/commit/de285=
252a1801397306032e070793889c9466845
> > > > > > > >
> > > > > > > > Original patch by Miklos Szeredi <mszeredi@redhat.com>
> > > > > > > > https://patchwork.kernel.org/project/linux-fsdevel/patch/20=
200505095915.11275-6-mszeredi@redhat.com/
> > > > > > > >
> > > > > > > > > While this carries a minute risk of someone relying on th=
e property of
> > > > > > > > > xattr syscalls rejecting O_PATH descriptors, it saves the=
 trouble of
> > > > > > > > > introducing another set of syscalls.
> > > > > > > > >
> > > > > > > > > Only file->f_path and file->f_inode are accessed in these=
 functions.
> > > > > > > > >
> > > > > > > > > Current versions return EBADF, hence easy to detect the p=
resense of
> > > > > > > > > this feature and fall back in case it's missing.
> > > > > > > >
> > > > > > > > CC: linux-api@vger.kernel.org
> > > > > > > > CC: linux-man@vger.kernel.org
> > > > > > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.=
com>
> > > > > > > > ---
> > > > > > >
> > > > > > > I'd be somewhat fine with getxattr and listxattr but I'm worr=
ied that
> > > > > > > setxattr/removexattr waters down O_PATH semantics even more. =
I don't
> > > > > > > want O_PATH fds to be useable for operations which are semant=
ically
> > > > > > > equivalent to a write.
> > > > > >
> > > > > > It is not really semantically equivalent to a write if it works=
 on a
> > > > > > O_RDONLY fd already.
> > > > >
> > > > > The fact that it works on a O_RDONLY fd has always been weird. An=
d is
> > > > > probably a bug. If you look at xattr_permission() you can see tha=
t it
> > > >
> > > > Bug or no bug, this is the UAPI. It is not fixable anymore.
> > > >
> > > > > checks for MAY_WRITE for set operations... setxattr() writes to d=
isk for
> > > > > real filesystems. I don't know how much closer to a write this ca=
n get.
> > > > >
> > > > > In general, one semantic aberration doesn't justify piling anothe=
r one
> > > > > on top.
> > > > >
> > > > > (And one thing that speaks for O_RDONLY is at least that it actua=
lly
> > > > > opens the file wheres O_PATH doesn't.)
> > > >
> > > > Ok. I care mostly about consistent UAPI, so if you want to set the
> > > > rule that modify f*() operations are not allowed to use O_PATH fd,
> > > > I can live with that, although fcntl(2) may be breaking that rule, =
but
> > > > fine by me.
> > > > It's good to have consistent rules and it's good to add a new UAPI =
for
> > > > new behavior.
> > > >
> > > > However...
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > In sensitive environments such as service management/containe=
r runtimes
> > > > > > > we often send O_PATH fds around precisely because it is restr=
icted what
> > > > > > > they can be used for. I'd prefer to not to plug at this strin=
g.
> > > > > >
> > > > > > But unless I am mistaken, path_setxattr() and syscall_fsetxattr=
()
> > > > > > are almost identical w.r.t permission checks and everything els=
e.
> > > > > >
> > > > > > So this change introduces nothing new that a user in said envir=
onment
> > > > > > cannot already accomplish with setxattr().
> > > > > >
> > > > > > Besides, as the commit message said, doing setxattr() on an O_P=
ATH
> > > > > > fd is already possible with setxattr("/proc/self/$fd"), so what=
ever security
> > > > > > hole you are trying to prevent is already wide open.
> > > > >
> > > > > That is very much a something that we're trying to restrict for t=
his
> > > > > exact reason and is one of the main motivator for upgrade mask in
> > > > > openat2(). If I want to send a O_PATH around I want it to not be
> > > > > upgradable. Aleksa is working on upgrade masks with openat2() (se=
e [1]
> > > > > and part of the original patchset in [2]. O_PATH semantics don't =
need to
> > > > > become weird.
> > > > >
> > > > > [1]: https://lore.kernel.org/all/20220526130355.fo6gzbst455fxywy@=
senku
> > > > > [2]: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/2019=
0728010207.9781-8-cyphar@cyphar.com
> > > >
> > > > ... thinking forward, if this patch is going to be rejected, the pa=
tch that
> > > > will follow is *xattrat() syscalls.
> > > >
> > > > What will you be able to argue then?
> > > >
> > > > There are several *at() syscalls that modify metadata.
> > > > fchownat(.., AT_EMPTY_PATH) is intentionally designed for this.
> > > >
> > > > Do you intend to try and block setxattrat()?
> > > > Just try and block setxattrat(.., AT_EMPTY_PATH)?
> > > > those *at() syscalls have real use cases to avoid TOCTOU races.
> > > > Do you propose that applications will have to use fsetxattr() on an=
 open
> > > > file to avert races?
> > > >
> > > > I completely understand the idea behind upgrade masks
> > > > for limiting f_mode, but I don't know if trying to retroactively
> > > > change semantics of setxattr() in the move to setxattrat()
> > > > is going to be a good idea.
> > >
> > > The goal would be that the semantics of fooat(<fd>, AT_EMPTY_PATH) an=
d
> > > foo(/proc/self/fd/<fd>) should always be identical, and the current
> > > semantics of /proc/self/fd/<fd> are too leaky so we shouldn't always
> > > assume that keeping them makes sense (the most obvious example is bei=
ng
> > > able to do tricks to open /proc/$pid/exe as O_RDWR).
> >
> > Please make a note that I have applications relying on current magic sy=
mlink
> > semantics w.r.t setxattr() and other metadata operations, and the libse=
linux
> > commit linked from the patch commit message proves that magic symlink
> > semantics are used in the wild, so it is not likely that those semantic=
s could
> > be changed, unless userspace breakage could be justified by fixing a se=
rious
> > security issue (i.e. open /proc/$pid/exe as O_RDWR).
> >
> > >
> > > I suspect that the long-term solution would be to have more upgrade
> > > masks so that userspace can opt-in to not allowing any kind of
> > > (metadata) write access through a particular file descriptor. You're
> > > quite right that we have several metadata write AT_EMPTY_PATH APIs, a=
nd
> > > so we can't retroactively block /everything/ but we should try to com=
e
> > > up with less leaky rules by default if it won't break userspace.
> > >
> >
> > Ok, let me try to say this in my own words using an example to see that
> > we are all on the same page:
> >
> > - lsetxattr(PATH_TO_FILE,..) has inherent TOCTOU races
> > - fsetxattr(fd,...) is not applicable for symbolic links
>
> fsetxattr(2) works on symbolic links, e.g. for "security.selinux",
> except for the user namespace:
>
> https://github.com/torvalds/linux/blob/4b35035bcf80ddb47c0112c4fbd84a63a2=
836a18/fs/xattr.c#L124-L136
> /*
> * In the user.* namespace, only regular files and directories can have
> * extended attributes. For sticky directories, only the owner and
> * privileged users can write attributes.
> */
> if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
>     if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
>         return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
>     if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
>        (mask & MAY_WRITE) &&
>         !inode_owner_or_capable(mnt_userns, inode))
>         return -EPERM;
> }
>
> Currently it just does not support O_PATH file descriptors.
> And with O_RDONLY setting extended attributes is supported as well
> (fsetxattr(2) does not require O_RDWR or O_WRONLY).

But it is not possible to get a O_RDONLY fd for a symlink object, is it?
That's why I wrote "fsetxattr() is not applicable for symbolic links".
And then libselinux is left to choose between one API that is racy (lsetxat=
tr)
and another API that does not work in containers (magic symlink).
They need to be give a proper API.

>
> > - setxattr("/proc/self/fd/<fd>",...) is the current API to avoid TOCTOU=
 races
> >   when setting xattr on symbolic links
> > - setxattrat(o_path_fd, "", ..., AT_EMPTY_PATH) is proposed as a the
> >   "new API" for setting xattr on symlinks (and special files)
> > - The new API is going to be more strict than the old magic symlink API
> > - *If* it turns out to not break user applications, old API can also be=
come
> >   more strict to align with new API (unlikely the case for setxattr())
> > - This will allow sandboxed containers to opt-out of the "old API", by
> >   restricting access to /proc/self/fd and to implement more fine graine=
d
> >   control over which metadata operations are allowed on an O_PATH fd
> >
> > Did I understand the plan correctly?
> > Do you agree with me that the plan to keep AT_EMPTY_PATH and
> > magic symlink semantics may not be realistic?

Sorry, this gave out messy.
This was supposed to ask whether this part of the plan:
"semantics of fooat(<fd>, AT_EMPTY_PATH) and foo(/proc/self/fd/<fd>)
should always be identical" is realistic, given that applications
already depend on existing setxattr(MAGIC_SYMLINK) semantics.

IMO, it should be fine to keep the same semantic and allow
setxattrat() on O_PATH fd (subject to xattr_permission() of course),
as long as open masks could be added to further restrict the O_PATH
fd from being used for setxattr() in the future.

IOW, we don't have to think of O_PATH as the "least capable" fd mode.
It is just a mode that that is not capable for data manipulations, but
there could be even less capable fd modes that are also not capable
for metadata manipulations such as setxattrat() or chownat().

Does that make sense?

Thanks,
Amir.
