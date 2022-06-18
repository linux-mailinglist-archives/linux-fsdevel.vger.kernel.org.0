Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FE45503B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiFRJLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 05:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiFRJLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 05:11:22 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463F8369D2;
        Sat, 18 Jun 2022 02:11:21 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id m10so2316346uao.11;
        Sat, 18 Jun 2022 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T27n52o5oNu11ktCmO2xx7oDuKYN4gENGGqgyY2+GNI=;
        b=jHKFb+fkXyYLqOT5yfBzcDxh65H50LcHcCb+EGHEa6XKquaYyxK5jKcGZc3qQJRXrV
         YvsfNZmLDYJ5VK/64BuysWxYe1Xst0ZldKhJIpOMys5Cq+XsUYqbkmt5a89wBoaQ4kph
         OMPzTnn70PIo6S4RMxAWlFK20B0oEAolkPci/e4fYDphIkC6DNeCV3qKEA47XSmt/2By
         0425/QgLbsLy0f+S1CKkQbwqolGfXFLw39lU309WgHnQu85IJtKYo6JsHJ7SJYl/Q9iH
         r3VonLe/Jhr/VVdWf3j1viaVOpLuvPZjDvRGi3vRWxKFLG7L3OTRMtE/2HotErWJEjv5
         JdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T27n52o5oNu11ktCmO2xx7oDuKYN4gENGGqgyY2+GNI=;
        b=ll2N/SDq/Ki6AMKM+FUT6qMCvFlhNlHayRx0kA3mAfcj5XOa3D94XNcYhCqqhLRVu2
         j8Rl7IQZ1R1xJGOJXji9H+AlvOrhnISZ91VVwiYI9xgjaWUiAwQI6IelqTvoZ8vQTyRY
         K4HBolDeslzPYoPsU3+bMHcZ6Ul8L+CO4dqiCOEGF9fmjnfuYIHHFczwW83NYvwUCQgc
         3Gq7L6jC8B6IVjAQ1p5D6lx2DKiR28no3uHaDST1Qz1f0ugoZfcuIVscS/JNCLrUSi1x
         SWGZbZeOwgVlOSG1o51Fprj4f/uf1o4nWNuk3ycfoT7m9nmheVCsEMU1YwVzLnwrx2Jm
         DvtQ==
X-Gm-Message-State: AJIora9JgzoLn3h9+uxolMlXVcIrQloNbM62Oe8JhfxANlza7SDyVOx4
        J4xMs3LXojPo/384TOwMXfoEWK9ZzAYUCxgTRus=
X-Google-Smtp-Source: AGRyM1tB49ibfiXPNIEjj7VPRHTK5Fza2eL7VggKag9bPrK3MP00mZwTZrfgJXhgVKA1gDKzm+pgznHlK5h2AiVw+BQ=
X-Received: by 2002:ab0:2c09:0:b0:379:a983:96fe with SMTP id
 l9-20020ab02c09000000b00379a98396femr5691723uar.102.1655543480323; Sat, 18
 Jun 2022 02:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153139.35588-1-cgzones@googlemail.com>
 <20220608112728.b4xrdppxqmyqmtwf@wittgenstein> <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
 <20220608124808.uylo5lntzfgxxmns@wittgenstein> <CAOQ4uxjP7kC95ou56wabVhQcc2vkNcD-8usYhLhbLOoJZ-jkOw@mail.gmail.com>
 <20220618031805.nmgiuapuqeblm3ba@senku>
In-Reply-To: <20220618031805.nmgiuapuqeblm3ba@senku>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 18 Jun 2022 12:11:08 +0300
Message-ID: <CAOQ4uxg6QLJ26pX8emXmUvq6jDDEH_Qq=Z4RPUK-jGLsZpHzfg@mail.gmail.com>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
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

On Sat, Jun 18, 2022 at 6:18 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2022-06-08, Amir Goldstein <amir73il@gmail.com> wrote:
> > On Wed, Jun 8, 2022 at 3:48 PM Christian Brauner <brauner@kernel.org> w=
rote:
> > >
> > > On Wed, Jun 08, 2022 at 03:28:52PM +0300, Amir Goldstein wrote:
> > > > On Wed, Jun 8, 2022 at 2:57 PM Christian Brauner <brauner@kernel.or=
g> wrote:
> > > > >
> > > > > On Tue, Jun 07, 2022 at 05:31:39PM +0200, Christian G=C3=B6ttsche=
 wrote:
> > > > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > > > >
> > > > > > Support file descriptors obtained via O_PATH for extended attri=
bute
> > > > > > operations.
> > > > > >
> > > > > > Extended attributes are for example used by SELinux for the sec=
urity
> > > > > > context of file objects. To avoid time-of-check-time-of-use iss=
ues while
> > > > > > setting those contexts it is advisable to pin the file in quest=
ion and
> > > > > > operate on a file descriptor instead of the path name. This can=
 be
> > > > > > emulated in userspace via /proc/self/fd/NN [1] but requires a p=
rocfs,
> > > > > > which might not be mounted e.g. inside of chroots, see[2].
> > > > > >
> > > > > > [1]: https://github.com/SELinuxProject/selinux/commit/7e979b56f=
d2cee28f647376a7233d2ac2d12ca50
> > > > > > [2]: https://github.com/SELinuxProject/selinux/commit/de285252a=
1801397306032e070793889c9466845
> > > > > >
> > > > > > Original patch by Miklos Szeredi <mszeredi@redhat.com>
> > > > > > https://patchwork.kernel.org/project/linux-fsdevel/patch/202005=
05095915.11275-6-mszeredi@redhat.com/
> > > > > >
> > > > > > > While this carries a minute risk of someone relying on the pr=
operty of
> > > > > > > xattr syscalls rejecting O_PATH descriptors, it saves the tro=
uble of
> > > > > > > introducing another set of syscalls.
> > > > > > >
> > > > > > > Only file->f_path and file->f_inode are accessed in these fun=
ctions.
> > > > > > >
> > > > > > > Current versions return EBADF, hence easy to detect the prese=
nse of
> > > > > > > this feature and fall back in case it's missing.
> > > > > >
> > > > > > CC: linux-api@vger.kernel.org
> > > > > > CC: linux-man@vger.kernel.org
> > > > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > > > ---
> > > > >
> > > > > I'd be somewhat fine with getxattr and listxattr but I'm worried =
that
> > > > > setxattr/removexattr waters down O_PATH semantics even more. I do=
n't
> > > > > want O_PATH fds to be useable for operations which are semantical=
ly
> > > > > equivalent to a write.
> > > >
> > > > It is not really semantically equivalent to a write if it works on =
a
> > > > O_RDONLY fd already.
> > >
> > > The fact that it works on a O_RDONLY fd has always been weird. And is
> > > probably a bug. If you look at xattr_permission() you can see that it
> >
> > Bug or no bug, this is the UAPI. It is not fixable anymore.
> >
> > > checks for MAY_WRITE for set operations... setxattr() writes to disk =
for
> > > real filesystems. I don't know how much closer to a write this can ge=
t.
> > >
> > > In general, one semantic aberration doesn't justify piling another on=
e
> > > on top.
> > >
> > > (And one thing that speaks for O_RDONLY is at least that it actually
> > > opens the file wheres O_PATH doesn't.)
> >
> > Ok. I care mostly about consistent UAPI, so if you want to set the
> > rule that modify f*() operations are not allowed to use O_PATH fd,
> > I can live with that, although fcntl(2) may be breaking that rule, but
> > fine by me.
> > It's good to have consistent rules and it's good to add a new UAPI for
> > new behavior.
> >
> > However...
> >
> > >
> > > >
> > > > >
> > > > > In sensitive environments such as service management/container ru=
ntimes
> > > > > we often send O_PATH fds around precisely because it is restricte=
d what
> > > > > they can be used for. I'd prefer to not to plug at this string.
> > > >
> > > > But unless I am mistaken, path_setxattr() and syscall_fsetxattr()
> > > > are almost identical w.r.t permission checks and everything else.
> > > >
> > > > So this change introduces nothing new that a user in said environme=
nt
> > > > cannot already accomplish with setxattr().
> > > >
> > > > Besides, as the commit message said, doing setxattr() on an O_PATH
> > > > fd is already possible with setxattr("/proc/self/$fd"), so whatever=
 security
> > > > hole you are trying to prevent is already wide open.
> > >
> > > That is very much a something that we're trying to restrict for this
> > > exact reason and is one of the main motivator for upgrade mask in
> > > openat2(). If I want to send a O_PATH around I want it to not be
> > > upgradable. Aleksa is working on upgrade masks with openat2() (see [1=
]
> > > and part of the original patchset in [2]. O_PATH semantics don't need=
 to
> > > become weird.
> > >
> > > [1]: https://lore.kernel.org/all/20220526130355.fo6gzbst455fxywy@senk=
u
> > > [2]: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20190728=
010207.9781-8-cyphar@cyphar.com
> >
> > ... thinking forward, if this patch is going to be rejected, the patch =
that
> > will follow is *xattrat() syscalls.
> >
> > What will you be able to argue then?
> >
> > There are several *at() syscalls that modify metadata.
> > fchownat(.., AT_EMPTY_PATH) is intentionally designed for this.
> >
> > Do you intend to try and block setxattrat()?
> > Just try and block setxattrat(.., AT_EMPTY_PATH)?
> > those *at() syscalls have real use cases to avoid TOCTOU races.
> > Do you propose that applications will have to use fsetxattr() on an ope=
n
> > file to avert races?
> >
> > I completely understand the idea behind upgrade masks
> > for limiting f_mode, but I don't know if trying to retroactively
> > change semantics of setxattr() in the move to setxattrat()
> > is going to be a good idea.
>
> The goal would be that the semantics of fooat(<fd>, AT_EMPTY_PATH) and
> foo(/proc/self/fd/<fd>) should always be identical, and the current
> semantics of /proc/self/fd/<fd> are too leaky so we shouldn't always
> assume that keeping them makes sense (the most obvious example is being
> able to do tricks to open /proc/$pid/exe as O_RDWR).

Please make a note that I have applications relying on current magic symlin=
k
semantics w.r.t setxattr() and other metadata operations, and the libselinu=
x
commit linked from the patch commit message proves that magic symlink
semantics are used in the wild, so it is not likely that those semantics co=
uld
be changed, unless userspace breakage could be justified by fixing a seriou=
s
security issue (i.e. open /proc/$pid/exe as O_RDWR).

>
> I suspect that the long-term solution would be to have more upgrade
> masks so that userspace can opt-in to not allowing any kind of
> (metadata) write access through a particular file descriptor. You're
> quite right that we have several metadata write AT_EMPTY_PATH APIs, and
> so we can't retroactively block /everything/ but we should try to come
> up with less leaky rules by default if it won't break userspace.
>

Ok, let me try to say this in my own words using an example to see that
we are all on the same page:

- lsetxattr(PATH_TO_FILE,..) has inherent TOCTOU races
- fsetxattr(fd,...) is not applicable for symbolic links
- setxattr("/proc/self/fd/<fd>",...) is the current API to avoid TOCTOU rac=
es
  when setting xattr on symbolic links
- setxattrat(o_path_fd, "", ..., AT_EMPTY_PATH) is proposed as a the
  "new API" for setting xattr on symlinks (and special files)
- The new API is going to be more strict than the old magic symlink API
- *If* it turns out to not break user applications, old API can also become
  more strict to align with new API (unlikely the case for setxattr())
- This will allow sandboxed containers to opt-out of the "old API", by
  restricting access to /proc/self/fd and to implement more fine grained
  control over which metadata operations are allowed on an O_PATH fd

Did I understand the plan correctly?
Do you agree with me that the plan to keep AT_EMPTY_PATH and
magic symlink semantics may not be realistic?

Thanks,
Amir.
