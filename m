Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF0735C19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 18:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjFSQVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 12:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSQVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:21:10 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BF61AC
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 09:21:06 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-51a33cee83fso2063800a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687191665; x=1689783665;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dE2HQAaQINRXvx47hzhULtFE0EXNdRQkWD9N3/S5SgE=;
        b=WiHcqkDw3Gg457FRmDb3i2A7JxrlAT00jciaI87tdrqdD9gHSrQDWSnIDaA4ZVxdDp
         HSKtf4JIo2G/bIV3zEB53psgPS51i+poZOTY9BB1qKzAknZpZibbdm32l5e+FxsjRVsI
         6Ian3P6bdMNIGlKDCOUxfDLUliCjpQHAU0Te6Qs+axvHzRi9QeXa+yAbt3qmjwIX0vMX
         80KWNnrnQb2X9GrZnO5XA4Bi5pmaF5YjAbAHvAeHNlXEa8pLDS9d+n8HFQUcvX6VKU2U
         VtvHnhlH3Yj6Sg0FbVUXgaqfdMy5t556kNKp1jXhWVjvEHLZlPMkFNlEZcnIZHgAEqTp
         P/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191665; x=1689783665;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dE2HQAaQINRXvx47hzhULtFE0EXNdRQkWD9N3/S5SgE=;
        b=cWukhftsCgJxJcZBxWcTQ+06EroheVqEkuF+agKo3dcp6gYmCO+Zhjhfa3rvWyHXZf
         0Fd26Q+NtXTRywZYW0+wXkp/qLO34fFmT1VOWeELZ3KAyiU7RoCcGIe4OW1oL6sEjtAC
         G8hw5Ly6oHQd1uoI+wzWAWQTgaH2jzqEyedYzd/y4FShtp+lR2Q/2w1S5d/cPgpUU1u5
         WmU0uDQwPVLy13WWOeJ11wBraQcImvPThzRNnVhHHU+t/DybloatB5ZGqy46snSFU4IE
         WwbKlRYnWHL/JU8TlijxojvFLzeOnpMauVRONHbtSAymgJK0NnqM6qT24CDunYCx8vrD
         a3HQ==
X-Gm-Message-State: AC+VfDwbTm4MwIDos9sdnU24FXgEVpszOifeJqD/S5IOAhsZtef8w7TT
        RuMPsed2d5bYg3XnwbBruiy4m7zADEw=
X-Google-Smtp-Source: ACHHUZ6+HwsVFLzND0FSw1Y7rHxF/fvtpGjx7Mgm6amazT4c/2hXDz+qyyMWtMl/8CfGVuG42SpJUL9YHcA=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:1650:a378:a78f:6c23])
 (user=gnoack job=sendgmr) by 2002:a50:8e55:0:b0:51a:2db4:f7a0 with SMTP id
 21-20020a508e55000000b0051a2db4f7a0mr1879260edx.1.1687191665365; Mon, 19 Jun
 2023 09:21:05 -0700 (PDT)
Date:   Mon, 19 Jun 2023 18:21:02 +0200
In-Reply-To: <d4f1395c-d2d4-1860-3a02-2a0c023dd761@digikod.net>
Message-Id: <ZJCAbvA5WB+P1jjZ@google.com>
Mime-Version: 1.0
References: <20230502171755.9788-1-gnoack3000@gmail.com> <1cb74c81-3c88-6569-5aff-154b8cf626fa@digikod.net>
 <20230510.c667268d844f@gnoack.org> <d4f1395c-d2d4-1860-3a02-2a0c023dd761@digikod.net>
Subject: Re: [RFC 0/4] Landlock: ioctl support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack3000@gmail.com>,
        Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Jeff Xu <jeffxu@chromium.org>,
        Dmitry Torokhov <dtor@google.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Micka=C3=ABl!

On Sat, Jun 17, 2023 at 11:47:55AM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> This subject is not easy, but I think we're reaching a consensus (see my
> 3-steps proposal plan below). I answered your questions about the (comple=
x)
> interface I proposed, but we should focus on the first step now (your
> initial proposal) and get back to the other steps later in another email
> thread.

Thanks for the review!


> On 10/05/2023 21:21, G=C3=BCnther Noack wrote:
> > [...]
> > Some specific things I don't understand well are:
> > [...]

Thanks, this all make sense now. =F0=9F=91=8D


> >    Would it not be a more orthogonal API if the "file selection" part
> >    of the Landlock API and the "policy adding" part for these selected
> >    files were independent of each other?  Then the .device and
> >    .file_type selection scheme could be used for the existing policies
> >    as well?
>=20
> Both approaches have pros and cons. I propose a new incremental approach
> below that starts with the simple case where there is no direct links
> between different rule types (only the third step add that).
>=20
> >=20
> > * When restricting by dev_t (major and minor number), aren't there use
> >    cases where a system might have 256 CDROM drives, and you'd need to
> >    allow-list all of these minor number combinations?
>=20
> Indeed, we should be able to just ignore device minors.

They device numbers are listed in
https://www.kernel.org/doc/Documentation/admin-guide/devices.txt

Some major numbers are grab-bags of miscellaneous devices, for example
major numbers 10 and 13; 13/0-31 (maj/min) are joysticks, whereas
13/32-62) are mice.

Maybe this can be specified as ranges on dev_t, so that it would be
possible to specify 13/32-62, without matching the joysticks too?


> > I think that it might be a feasible approach to start with the
> > LANDLOCK_ACCESS_FS_IOCTL approach and then look at its usage to
> > understand whether we see a significant number of programs whose
> > sandboxes are too coarse because of this.
> >=20
> > If more fine-granular control is needed, we can still put the other
> > approach on top, and the additional complexity from
> > LANDLOCK_ACCESS_FS_IOCTL that we have to support is not that
> > dramatically high.
> >
> > [...]
>=20
> I agree that IOCTLs are a security risk and that we should propose a simp=
le
> solution short-term, and maybe a more complete one long-term.
>=20
> The main issue with a unique IOCTL access right for a file hierarchy is t=
hat
> we may not know which device/driver will be the target/server, and hence =
if
> we need to allow some IOCTL for regular files (e.g., fscrypt), we might e=
nd
> up allowing all IOCTLs.
>=20
> Here is a plan to incrementally develop a fine-grained IOCTL access contr=
ol
> in 3 steps:
>=20
> 1/ Add a simple IOCTL access right for path_beneath: what you initially
> proposed. For systems that already configure nodev mount points, it could=
 be
> even more useful (e.g., safely allow IOCTL on /home for fscrypt, and
> specific /dev files otherwise).

Ack, I'll continue on that implementation then. =F0=9F=91=8D


> 2/ Create a new type of rule to identify file/device type:
> struct landlock_inode_type_attr {
>     __u64 allowed_access; /* same as for path_beneath */
>     __u64 flags; /* bit 0: ignores device minor */
>     dev_t device; /* same as stat's st_rdev */
>     __u16 file_type; /* same as stat's st_mode & S_IFMT */
> };
>=20
> We'll probably need to differentiate the handled accesses for path_beneat=
h
> rules and those for inode_type rules to be more useful.
>=20
> One issue with this type of rule is that it could be used as an oracle to
> bypass stat restrictions. We could check if such (virtual) action is allo=
wed
> without the current domain though.
>=20
>=20
> 3/ Add a new type of rule to match IOCTL commands, with a mechanism to ti=
e
> this to inode_type rules (because a command ID is relative to a file
> type/device), and potentially the same mechanism to tie inode_type rules =
to
> path_beneath rules.
>=20
>=20
> Each of this step can be implemented one after the other, and each one is
> valuable. What do you think?

I think it is a good idea to do it in multiple steps,
as I also believe that step 1) already provides value on its own.

To make sure we are on the same page, let me paraphrase my understanding he=
re:

1) is what I already sent as RFC, with tests and documentation etc.

   With 1), callers could allow and deny ioctls on newly opened files,
   independent of file path.

2) makes dev_t and file_type predicates which can be used to limit
   file accesses on already opened files.

   With 2), callers could allow and deny ioctls and other operations
   also on files which are already opened before enablement, such
   as the TTY FD inherited from the parent process.
  =20
3) would make it possible to restrict individual ioctl commands,
   depending on the dev_t, the file_type, and possibly the path.

Is that accurate?

In 2) and 3), I'm still contemplating a bit whether we have
alternative approaches, but I believe in any case, it's clear that
they can be built on top of each other without much overhead, and for
many programs, outright denying ioctl on newly opened files with 1)
might be the most straightforward approach which already delivers
value.

Some notes which I collected on the side:

* I'm still worried about the already-opened file descriptors like the
  TTY, through which it can be easy to escape a sandbox
  (c.f. https://nvd.nist.gov/vuln/detail/CVE-2017-5226) - I would like
  to have a solution for that.  Step (2) would fix it, but maybe I can
  find a workaround to at least detect the problem in step (1)
  already.

* I looked at OpenBSD's pledge and unveil.  In OpenBSD, the ioctl
  policy is based on the properties of an already opened file.  They
  have hardcoded their ioctl logic in the kernel, which would be a
  mistake to do in Linux due to stronger backwards compatibility
  guarantees.  OpenBSD is making the allow/deny decisions based on
  device major/minor numbers and file type (usually block/char
  device).

  I think it is noteworthy that OpenBSD does *not* use the file path
  to make that decision.

  I wonder whether we should replicate that in steps (2) and (3).  It
  would make for a simpler, more orthogonal API, where the ioctl
  policy would become a property of the task, and it would be enforced
  independently of the existing path-based logic.  When callers
  combine that with the overall ioctl check from (1), it might be
  flexible enough for practical purposes.

* We should not rely on the way that ioctl request numbers are
  structured, because it is used inconsistently.  More background:
  https://lwn.net/Articles/428140/ (Thank you for pointing out this
  article, Jeff!)

> > > > * Should we introduce a "landlock_fd_rights_limit()" syscall?
> > > [...]
> > >
> > > We should also think about batch operations on FD (see the
> > > close_range syscall), for instance to deny all IOCTLs on inherited
> > > or received FDs.
> >=20
> > Hm, you mean a landlock_fd_rights_limit_range() syscall to limit the
> > rights for an entire range of FDs?
> >=20
> > I have to admit, I'm not familiar with the real-life use cases of
> > close_range().  In most programs I work with, it's difficult to reason
> > about their ordering once the program has really started to run. So I
> > imagine that close_range() is mostly used to "sanitize" the open file
> > descriptors at the start of main(), and you have a similar use case in
> > mind for this one as well?
> >=20
> > If it's just about closing the range from 0 to 2, I'm not sure it's
> > worth adding a custom syscall. :)
>=20
> The advantage of this kind of range is to efficiently manage all potentia=
l
> FDs, and the main use case is to close (or change, see the flags) everyth=
ing
> *except" 0-2 (i.e. 3-~0), and then avoid a lot of (potentially useless)
> syscalls.
>=20
> The Landlock interface doesn't need to be a syscall. We could just add a =
new
> rule type which could take a FD range and restrict them when calling
> landlock_restrict_self(). Something like this:
> struct landlock_fd_attr {
>     __u64 allowed_access;
>     __u32 first;
>     __u32 last;
> }

Ack, I see it a bit better. Let's discuss this topic separately.

=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
