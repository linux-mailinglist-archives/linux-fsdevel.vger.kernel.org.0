Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D157A5AAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 09:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjISHRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 03:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjISHRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:17:08 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A831DFC
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 00:17:02 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-495e049a28bso2249068e0c.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 00:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695107822; x=1695712622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niCTnD1sReZam+pUwocaKtn2VWJuNUAAEyfTuxalc9k=;
        b=hmOk4RBknZ11NQOP6b2//YB/MrjEypVghnIXBo2+0IfP/BmsBVkkGrwhumcVrZr+RC
         2eBO2Tt3ntdjt7rfywfgCFlbQ6D8hWGeB8Ha8Bwp4mTQDD5s1H9uYK0fps3VnxXrCXDL
         ED6NSdB6o0pIojUW7AA/kj183XZFtTmrAf4NWq3njI9oCpAsR69iEMXavfDjKTpFz4Bi
         5+EV5kvXCTxcbI2sjTES+UKh04GzqIAjsta8QJYKpzkgI6h+4GArxqcsE60qUpkYImM2
         LXYzpY4ofW4LL9bsMvsW2dPpCSiVoxlyPx4YWwRJklYNmLf6oiHpFZ7rtpcXFgVo5M2b
         RKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695107822; x=1695712622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niCTnD1sReZam+pUwocaKtn2VWJuNUAAEyfTuxalc9k=;
        b=ktUmCcLvTAtCGgdHshP2HCegvD2Wrr4dF2XJvrGmVITfddEEWkkVBs2di1RmtsxReE
         TwwzYV7tKb9lGuT4WbyVHWqZl3SLhwFdL+kjAErW2MDrh2tutcK8izXgj7UQIQzpHxr5
         b4uaMRp0bWAvo3C49Rhcv0F1ca8E0NfTqbuJAITdoZYN9jjn3p1Nj6Xq00oQx1a7pv+K
         OqQNGkKSuKkhcXR8OfV+Td9fpEHYWrozikH1PIwyMFcnXZwXu2gWU8DF89RpnTfafzqE
         74KB3hvUg7DBoohLca+brm2VH/XE+hsmWFLl0LOGfNBwI919lWdyW3J0TG7YNQDFH63v
         65AQ==
X-Gm-Message-State: AOJu0YwrRYGQd3b9nq3onmE6WeVnfuSi4gXPmwtDM5Ud4veWlhU9eDME
        UfCz/nZ/h13ahiS120SCjfb4oWoROUG74pMhVVY=
X-Google-Smtp-Source: AGHT+IGHoKf5dtfrUDb23pBpwtYuh8Harb5axVsKyxb6sXUQ0tV+/zIrEz7zwqfEiA2EKf8tewh0EfBPWN6iyee9qMc=
X-Received: by 2002:a1f:c547:0:b0:490:100:abc with SMTP id v68-20020a1fc547000000b0049001000abcmr9312375vkf.5.1695107821609;
 Tue, 19 Sep 2023 00:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Sep 2023 10:16:50 +0300
Message-ID: <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 9:05=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> [Forked from https://lore.kernel.org/linux-fsdevel/20230918123217.932179-=
1-max.kellermann@ionos.com/]
>
> On Mon, Sep 18, 2023 at 6:28=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Mon, Sep 18, 2023 at 5:23=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 18-09-23 15:57:43, Max Kellermann wrote:
> > > > On Mon, Sep 18, 2023 at 2:40=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > > Note that since kernel 5.13 you
> > > > > don't need CAP_SYS_ADMIN capability for fanotify functionality th=
at is
> > > > > more-or-less equivalent to what inotify provides.
> > > >
> > > > Oh, I missed that change - I remember fanotify as being inaccessibl=
e
> > > > for unprivileged processes, and fanotify being designed for things
> > > > like virus scanners. Indeed I should migrate my code to fanotify.
> > > >
> > > > If fanotify has now become the designated successor of inotify, tha=
t
> > > > should be hinted in the inotify manpage, and if inotify is effectiv=
ely
> > > > feature-frozen, maybe that should be an extra status in the
> > > > MAINTAINERS file?
> > >
> > > The manpage update is a good idea. I'm not sure about the MAINTAINERS
> > > status - we do have 'Obsolete' but I'm reluctant to mark inotify as
> > > obsolete as it's perfectly fine for existing users, we fully maintain=
 it
> > > and support it but we just don't want to extend the API anymore. Amir=
, what
> > > are your thoughts on this?
> >
> > I think that the mention of inotify vs. fanotify features in fanotify.7=
 man page
> > is decent - if anyone wants to improve it I won't mind.
> > A mention of fanotify as successor in inotify.7 man page is not a bad i=
dea -
> > patches welcome.
> >
> > As to MAINTAINERS, I think that 'Maintained' feels right.
> > We may consider 'Odd Fixes' for inotify and certainly for 'dnotify',
> > but that sounds a bit too harsh for the level of maintenance they get.
> >
> > I'd like to point out that IMO, man-page is mainly aimed for the UAPI
> > users and MAINTAINERS is mostly aimed at bug reporters and drive-by
> > developers who submit small fixes.
> >
> > When developers wish to add a feature/improvement to a subsystem,
> > they are advised to send an RFC with their intentions to the subsystem
> > maintainers/list to get feedback on their design before starting to imp=
lement.
> > Otherwise, the feature could be NACKed for several reasons other than
> > "we would rather invest in the newer API".
> >
> > Bottom line - I don't see a strong reason to change anything, but I als=
o do
> > not object to improving man page nor to switching to 'Odd Fixes' status=
.
> >
>
> BTW, before we can really mark inotify as Obsolete and document that
> inotify was superseded by fanotify, there are at least two items on the
> TODO list [1]:
> 1. UNMOUNT/IGNORED events
> 2. Filesystems without fid support
>
> MOUNT/UNMOUNT fanotify events have already been discussed
> and the feature has known users.
>
> Christian has also mentioned [1] the IN_UNMOUNT use case for
> waiting for sb shutdown several times and I will not be surprised
> to see systemd starting to use inotify for that use case before too long.=
..
>
> Regarding the second item on the TODO list, we have had this discussion
> before - if we are going to continue the current policy of opting-in to f=
anotify
> (i.e. tmpfs, fuse, overlayfs, kernfs), we will always have odd filesystem=
s that
> only support inotify and we will need to keep supporting inotify only for=
 the
> users that use inotify on those odd filesystems.
>
> OTOH, if we implement FAN_REPORT_DINO_NAME, we could
> have fanotify inode mark support for any filesystem, where the
> pinned marked inode ino is the object id.
>

Hi Max,

Not sure if you have seen my email before asking your question
on the original patch review thread.
I prefer to answer it here in the wider context of inotify maintenance,
because it touches directly on the topic I raised above.

On Mon, Sep 18, 2023 at 10:45=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> On Mon, Sep 18, 2023 at 2:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > Is there any problem with using fanotify for you?
>
> Turns out fanotify is unusable for me, unfortunately.
> I have been using inotify to get notifications of cgroup events, but
> the cgroup filesystem appears to be unsupported by fanotify: all
> attempts to use fanotify_mark() on cgroup event files fail with
> ENODEV. I think that comes from fanotify_test_fsid(). Filesystems
> without a fsid work just fine with inotify, but fail with fanotify.
>

This was just fixed by Ivan in commit:
0ce7c12e88cf ("kernfs: attach uuid for every kernfs and report it in fsid")

> Since fanotify lacks important features, is it really a good idea to
> feature-freeze inotify?

As my summary above states, it is correct that fanotify does not
yet fully supersedes inotify, but there is a plan to go in this direction,
hence, inotify is "being phased out" it is not Obsolete nor Deprecated.

However, the question to be asked is different IMO:
When both inotify and fanotify do not support the use case at hand
(as in your case), which is better? to fix/improve inotify or to fix/improv=
e
fanotify?

For me, there should be a very strong reason to choose improving
inotify over improving fanotify.

With the case at hand, you can see that the patch to improve fanotify
to support your use case was far simpler (in LOC at least) than your
patches, not to mention, not having to add a new syscall and new
documentation for an old phased out API.

But there may be exceptions, for example, in 4.19, inotify gained
a new feature:

4d97f7d53da7 ("inotify: Add flag IN_MASK_CREATE for inotify_add_watch()")

I am not sure if this patch would have been accepted nowadays, but
we need to judge every case.

>
> (By the way, what was not documented is that fanotify_init() can only
> be used by unprivileged processes if the FAN_REPORT_FID flag was

fanotify_init(2):
       Prior to Linux 5.13, calling fanotify_init() required the
CAP_SYS_ADMIN capability.
       Since Linux 5.13, users may call fanotify_init() without the
CAP_SYS_ADMIN capability
       to create  and  initialize an fanotify group with limited functional=
ity.

       The limitations imposed on an event listener created by a user
without the
              CAP_SYS_ADMIN capability are as follows:
...
              =E2=80=A2  The user is required to create a group that
identifies filesystem objects
                  by file handles, for example, by providing the
FAN_REPORT_FID flag.

I find this documentation that was written by Matthew very good,
but writing documentation is not my strong side and if you feel that
any part of the documentation should be improved I highly appreciate
the feedback and would appreciate man page patches even more.

When we get to the point that the missing functionality gaps between
inotify and fanotify have been closed, I will surely follow your advice
to mention that in the inotify man page and possibly also in MAINTAINERS.

> specified. I had to read the kernel sources to figure that out - I
> have no idea why this limitation exists - the code comment in the
> kernel source doesn't explain it.)

The legacy fanotify events open and report an event->fd as a way
to identify the object - that is not a safe practice for unprivileged liste=
ners
for several reasons.

FAN_REPORT_FID is designed in a way to be almost a drop in replacement
for inotify watch descriptors as an opaque identifier of the object, except=
 that
fsid+fhanle provide much stronger functionality than wd did.

The limitation that FAN_REPORT_FID requires that fs has fsid+fhandle is
a technicality.  It can be solved by either providing fsid and trivial
encode_fh() (*)
to the filesystem in question (as was done in 6.6-rc1 for overlayfs and ker=
nfs)
or by introducing a new mode FAN_REPORT_INO which reports inode number
instead of fsid+fhandle and is enough for listeners that watch directories
and files on a single fs.

Thanks,
Amir.

(*) the ability for fs to support only encode_fh() was added in kernel v6.5
96b2b072ee62 ("exportfs: allow exporting non-decodeable file handles
to userspace")
and a man page patch was already posted [3].

>
> [1] https://github.com/amir73il/fsnotify-utils/wiki/fsnotify-TODO
> [2] https://lore.kernel.org/linux-fsdevel/20230908-verflachen-neudefiniti=
on-4da649d673a9@brauner/
[3] https://lore.kernel.org/linux-fsdevel/20230903120433.2605027-1-amir73il=
@gmail.com/
