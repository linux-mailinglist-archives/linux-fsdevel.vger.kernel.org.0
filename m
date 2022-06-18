Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4FA550438
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 13:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiFRLT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 07:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiFRLT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 07:19:56 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECD622BC5;
        Sat, 18 Jun 2022 04:19:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id p8so8269279oip.8;
        Sat, 18 Jun 2022 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+ovsNsX2exXRxFilGeoHWMXXLCrH6R1SwEdr3sFNVV4=;
        b=PB9YQFzYwBUst0w3lu3p6nmktp/eae106e8aThMkj/8A3+e002QVBuzfvbZB4i9Rx+
         cFlC9EFLiAd8g16SO0MJR12B9i2WoLc7Bsmgff4LQid8emkLXv0W50b7gv4o+m5zEHuf
         7IfxEt6yPLBE2j6vcWJUujz1RRkbITP/dGkEssuTxy4YWiSK8FOj33Sp936pewOSQzfJ
         CTTmmVS/5sXVwiqLkXg9VUZWfXTohhihkQOlwdQQzcufoZl4Qc6zhDxx0F8iGpsDbcCL
         7UQtFnb8g8f6MACSB5Fly0wwx06sqNWDgHc6O9GRcsiT3HxHMI+CiCgQoB7HIvnZORfz
         Xvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+ovsNsX2exXRxFilGeoHWMXXLCrH6R1SwEdr3sFNVV4=;
        b=TdLJTB/3IzVHV7XtXlSsTbqh9jjHW/P/Wz5+6mwyhfFGFzL7ZmVln97QFqeCLTfTe4
         ZDC/fXlS+lbq1jPNvaG7g7cwy2zu3EDMHaOtxJfV3qKZ+IiWIfzMUrk4jzxlBNo2ug4V
         xCpbDWfxuX6laDgZxfsgknUQcDFseiy6L+DlWwrgLIpHgqM20M6jGEMWcuJcrBURator
         09S0tEOuiIyx1mR/NBUJ1ln+h8E5vMcxXwKHf1iQYrLla6LBdUbjK/BdbDrLaE1dZXzu
         XV72+opfSojn0/0whJ6qu5H9IH0wde6cBX8Ovn7MGDHaYwqymyD+OUbgFxqVffXJGA1I
         WDtA==
X-Gm-Message-State: AOAM531z6ME/FseHq04x1cPfzL4eWj+gHEyBSMS+TN68+bd/Z/gy9TIA
        n1v5NKtLjnvy26qNZZiVCnISM9P7pmODib7kc1M=
X-Google-Smtp-Source: ABdhPJySZU2F0RpXQGGWfR2UFyes2bH/2YUxt59MoXE+a9b3wc3SsFn5JwFxNIGHI+J+2qml2lrWeIGGtGH6ebiJpps=
X-Received: by 2002:a05:6808:10ce:b0:32e:70c0:dcb5 with SMTP id
 s14-20020a05680810ce00b0032e70c0dcb5mr12458828ois.71.1655551194452; Sat, 18
 Jun 2022 04:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153139.35588-1-cgzones@googlemail.com>
 <20220608112728.b4xrdppxqmyqmtwf@wittgenstein> <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
 <20220608124808.uylo5lntzfgxxmns@wittgenstein> <CAOQ4uxjP7kC95ou56wabVhQcc2vkNcD-8usYhLhbLOoJZ-jkOw@mail.gmail.com>
 <20220618031805.nmgiuapuqeblm3ba@senku> <CAOQ4uxg6QLJ26pX8emXmUvq6jDDEH_Qq=Z4RPUK-jGLsZpHzfg@mail.gmail.com>
In-Reply-To: <CAOQ4uxg6QLJ26pX8emXmUvq6jDDEH_Qq=Z4RPUK-jGLsZpHzfg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sat, 18 Jun 2022 13:19:43 +0200
Message-ID: <CAJ2a_DectnRF56fxpOjvVm2ZdvO+shxCjtjzLbH4oaa7KnsgTA@mail.gmail.com>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
To:     Amir Goldstein <amir73il@gmail.com>
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

On Sat, 18 Jun 2022 at 11:11, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sat, Jun 18, 2022 at 6:18 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > On 2022-06-08, Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Wed, Jun 8, 2022 at 3:48 PM Christian Brauner <brauner@kernel.org>=
 wrote:
> > > >
> > > > On Wed, Jun 08, 2022 at 03:28:52PM +0300, Amir Goldstein wrote:
> > > > > On Wed, Jun 8, 2022 at 2:57 PM Christian Brauner <brauner@kernel.=
org> wrote:
> > > > > >
> > > > > > On Tue, Jun 07, 2022 at 05:31:39PM +0200, Christian G=C3=B6ttsc=
he wrote:
> > > > > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > > > > >
> > > > > > > Support file descriptors obtained via O_PATH for extended att=
ribute
> > > > > > > operations.
> > > > > > >
> > > > > > > Extended attributes are for example used by SELinux for the s=
ecurity
> > > > > > > context of file objects. To avoid time-of-check-time-of-use i=
ssues while
> > > > > > > setting those contexts it is advisable to pin the file in que=
stion and
> > > > > > > operate on a file descriptor instead of the path name. This c=
an be
> > > > > > > emulated in userspace via /proc/self/fd/NN [1] but requires a=
 procfs,
> > > > > > > which might not be mounted e.g. inside of chroots, see[2].
> > > > > > >
> > > > > > > [1]: https://github.com/SELinuxProject/selinux/commit/7e979b5=
6fd2cee28f647376a7233d2ac2d12ca50
> > > > > > > [2]: https://github.com/SELinuxProject/selinux/commit/de28525=
2a1801397306032e070793889c9466845
> > > > > > >
> > > > > > > Original patch by Miklos Szeredi <mszeredi@redhat.com>
> > > > > > > https://patchwork.kernel.org/project/linux-fsdevel/patch/2020=
0505095915.11275-6-mszeredi@redhat.com/
> > > > > > >
> > > > > > > > While this carries a minute risk of someone relying on the =
property of
> > > > > > > > xattr syscalls rejecting O_PATH descriptors, it saves the t=
rouble of
> > > > > > > > introducing another set of syscalls.
> > > > > > > >
> > > > > > > > Only file->f_path and file->f_inode are accessed in these f=
unctions.
> > > > > > > >
> > > > > > > > Current versions return EBADF, hence easy to detect the pre=
sense of
> > > > > > > > this feature and fall back in case it's missing.
> > > > > > >
> > > > > > > CC: linux-api@vger.kernel.org
> > > > > > > CC: linux-man@vger.kernel.org
> > > > > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.co=
m>
> > > > > > > ---
> > > > > >
> > > > > > I'd be somewhat fine with getxattr and listxattr but I'm worrie=
d that
> > > > > > setxattr/removexattr waters down O_PATH semantics even more. I =
don't
> > > > > > want O_PATH fds to be useable for operations which are semantic=
ally
> > > > > > equivalent to a write.
> > > > >
> > > > > It is not really semantically equivalent to a write if it works o=
n a
> > > > > O_RDONLY fd already.
> > > >
> > > > The fact that it works on a O_RDONLY fd has always been weird. And =
is
> > > > probably a bug. If you look at xattr_permission() you can see that =
it
> > >
> > > Bug or no bug, this is the UAPI. It is not fixable anymore.
> > >
> > > > checks for MAY_WRITE for set operations... setxattr() writes to dis=
k for
> > > > real filesystems. I don't know how much closer to a write this can =
get.
> > > >
> > > > In general, one semantic aberration doesn't justify piling another =
one
> > > > on top.
> > > >
> > > > (And one thing that speaks for O_RDONLY is at least that it actuall=
y
> > > > opens the file wheres O_PATH doesn't.)
> > >
> > > Ok. I care mostly about consistent UAPI, so if you want to set the
> > > rule that modify f*() operations are not allowed to use O_PATH fd,
> > > I can live with that, although fcntl(2) may be breaking that rule, bu=
t
> > > fine by me.
> > > It's good to have consistent rules and it's good to add a new UAPI fo=
r
> > > new behavior.
> > >
> > > However...
> > >
> > > >
> > > > >
> > > > > >
> > > > > > In sensitive environments such as service management/container =
runtimes
> > > > > > we often send O_PATH fds around precisely because it is restric=
ted what
> > > > > > they can be used for. I'd prefer to not to plug at this string.
> > > > >
> > > > > But unless I am mistaken, path_setxattr() and syscall_fsetxattr()
> > > > > are almost identical w.r.t permission checks and everything else.
> > > > >
> > > > > So this change introduces nothing new that a user in said environ=
ment
> > > > > cannot already accomplish with setxattr().
> > > > >
> > > > > Besides, as the commit message said, doing setxattr() on an O_PAT=
H
> > > > > fd is already possible with setxattr("/proc/self/$fd"), so whatev=
er security
> > > > > hole you are trying to prevent is already wide open.
> > > >
> > > > That is very much a something that we're trying to restrict for thi=
s
> > > > exact reason and is one of the main motivator for upgrade mask in
> > > > openat2(). If I want to send a O_PATH around I want it to not be
> > > > upgradable. Aleksa is working on upgrade masks with openat2() (see =
[1]
> > > > and part of the original patchset in [2]. O_PATH semantics don't ne=
ed to
> > > > become weird.
> > > >
> > > > [1]: https://lore.kernel.org/all/20220526130355.fo6gzbst455fxywy@se=
nku
> > > > [2]: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/201907=
28010207.9781-8-cyphar@cyphar.com
> > >
> > > ... thinking forward, if this patch is going to be rejected, the patc=
h that
> > > will follow is *xattrat() syscalls.
> > >
> > > What will you be able to argue then?
> > >
> > > There are several *at() syscalls that modify metadata.
> > > fchownat(.., AT_EMPTY_PATH) is intentionally designed for this.
> > >
> > > Do you intend to try and block setxattrat()?
> > > Just try and block setxattrat(.., AT_EMPTY_PATH)?
> > > those *at() syscalls have real use cases to avoid TOCTOU races.
> > > Do you propose that applications will have to use fsetxattr() on an o=
pen
> > > file to avert races?
> > >
> > > I completely understand the idea behind upgrade masks
> > > for limiting f_mode, but I don't know if trying to retroactively
> > > change semantics of setxattr() in the move to setxattrat()
> > > is going to be a good idea.
> >
> > The goal would be that the semantics of fooat(<fd>, AT_EMPTY_PATH) and
> > foo(/proc/self/fd/<fd>) should always be identical, and the current
> > semantics of /proc/self/fd/<fd> are too leaky so we shouldn't always
> > assume that keeping them makes sense (the most obvious example is being
> > able to do tricks to open /proc/$pid/exe as O_RDWR).
>
> Please make a note that I have applications relying on current magic syml=
ink
> semantics w.r.t setxattr() and other metadata operations, and the libseli=
nux
> commit linked from the patch commit message proves that magic symlink
> semantics are used in the wild, so it is not likely that those semantics =
could
> be changed, unless userspace breakage could be justified by fixing a seri=
ous
> security issue (i.e. open /proc/$pid/exe as O_RDWR).
>
> >
> > I suspect that the long-term solution would be to have more upgrade
> > masks so that userspace can opt-in to not allowing any kind of
> > (metadata) write access through a particular file descriptor. You're
> > quite right that we have several metadata write AT_EMPTY_PATH APIs, and
> > so we can't retroactively block /everything/ but we should try to come
> > up with less leaky rules by default if it won't break userspace.
> >
>
> Ok, let me try to say this in my own words using an example to see that
> we are all on the same page:
>
> - lsetxattr(PATH_TO_FILE,..) has inherent TOCTOU races
> - fsetxattr(fd,...) is not applicable for symbolic links

fsetxattr(2) works on symbolic links, e.g. for "security.selinux",
except for the user namespace:

https://github.com/torvalds/linux/blob/4b35035bcf80ddb47c0112c4fbd84a63a283=
6a18/fs/xattr.c#L124-L136
/*
* In the user.* namespace, only regular files and directories can have
* extended attributes. For sticky directories, only the owner and
* privileged users can write attributes.
*/
if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
    if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
        return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
    if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
       (mask & MAY_WRITE) &&
        !inode_owner_or_capable(mnt_userns, inode))
        return -EPERM;
}

Currently it just does not support O_PATH file descriptors.
And with O_RDONLY setting extended attributes is supported as well
(fsetxattr(2) does not require O_RDWR or O_WRONLY).

> - setxattr("/proc/self/fd/<fd>",...) is the current API to avoid TOCTOU r=
aces
>   when setting xattr on symbolic links
> - setxattrat(o_path_fd, "", ..., AT_EMPTY_PATH) is proposed as a the
>   "new API" for setting xattr on symlinks (and special files)
> - The new API is going to be more strict than the old magic symlink API
> - *If* it turns out to not break user applications, old API can also beco=
me
>   more strict to align with new API (unlikely the case for setxattr())
> - This will allow sandboxed containers to opt-out of the "old API", by
>   restricting access to /proc/self/fd and to implement more fine grained
>   control over which metadata operations are allowed on an O_PATH fd
>
> Did I understand the plan correctly?
> Do you agree with me that the plan to keep AT_EMPTY_PATH and
> magic symlink semantics may not be realistic?
>
> Thanks,
> Amir.
