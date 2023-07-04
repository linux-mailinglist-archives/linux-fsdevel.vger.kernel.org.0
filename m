Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85495747294
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 15:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGDNUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 09:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjGDNUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:20:13 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516EA10FE
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 06:19:59 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-44360717659so3931100137.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jul 2023 06:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688476798; x=1691068798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1PniUUS68jgh2I5jLNaEDWZDT7d1+sKpssQYin0Oc8=;
        b=n4DJK/zzluoa7Dh4E94haZ9p2N13DmOMod3PI1vFlUwrbLQvMCEUGbqLXxrfwa3+cO
         7d0RqfRbCy7hdzTtAlwuMhRoP9SLu/EgP42q5prB0up2VtkGn7VuWDyXGmf4YKxm5RLc
         ZCBK8BY8Ob1UdTUr9SnJ3D3YuieK8jk1ThyBWupsUXUX5b3Pv9I+6FKDEBMFIj234rN/
         FrCCiWi+iF6Tv/3PFQ2NCVSZXuVdQv2encDbjVfg5Yf6PUnNI1s6sTFuAVoYaYTYGhCT
         pzgKoDY37zYavnGns07cB+zJKUM8qtJxWRYXexNg10W2EEJZQLGy5VJaaDua4ZD4GK8g
         9UCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688476798; x=1691068798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1PniUUS68jgh2I5jLNaEDWZDT7d1+sKpssQYin0Oc8=;
        b=eQMrMG/2Lq30s6qERHeA/oU/wpLV1gumH5qkZW1KCFXH2/VPK6G42amvxUeQo28DgN
         LFJOlTvGAdIln8CpCztJZGfEaGaRk+bXExGIWCtWkfGyeENfbVgXxwwJzwjbjNigA5op
         cwnGjXA1MCU78qPEKgN1UbkjHbffbhib0yuicCWROAuB5i5iQX0lLJWUe8EE8EIOesh+
         QrOtCNExbpnDOWQq0T/41Ukv0kRp9VWFUqx9QnWTHF0jVKu3Veck+qrHDZ9NcSZfhdOh
         W5U6HS5D3Z2uX6I8VWRrZE0S9hn/noTb6Jc1w3iH6N58XfqLcvZ2ur+HIs5lQaeV0NB6
         EesQ==
X-Gm-Message-State: AC+VfDxPWzGrCBzZGoEx6hCiiScCCkRSy3F1FArJkZugrkOKO4Y8xaxJ
        +Igvaym5FFti2OCG95BejVtrqQKq8yXRzNZAlPI=
X-Google-Smtp-Source: ACHHUZ79kKpO5qo1lzQ/wF8Lu6kgzlUrterpC2RAjB9WFtwSFvxZA91I4IztgBlX4B3E42/gvHuLMTZPEURgnFNImA0=
X-Received: by 2002:a05:6102:215c:b0:43f:34a0:cc92 with SMTP id
 h28-20020a056102215c00b0043f34a0cc92mr5286315vsg.1.1688476798045; Tue, 04 Jul
 2023 06:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230629042044.25723-1-amir73il@gmail.com> <20230630-kitzeln-sitzt-c6b4325362e5@brauner>
 <CAOQ4uxheb7z=5ricKUz7JduQGVbxNRp-FNrViMtd0Dy6cAgOnQ@mail.gmail.com>
 <20230703112551.7fvcyibdxwtmjucf@quack3> <20230704-gedauert-beantragen-7334fb6b5cdf@brauner>
 <20230704111833.c6yqnu5b6fhzit3k@quack3> <20230704-urkunden-behindern-8b0f4eb1f3c7@brauner>
In-Reply-To: <20230704-urkunden-behindern-8b0f4eb1f3c7@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 4 Jul 2023 16:19:46 +0300
Message-ID: <CAOQ4uxjjxToZ2sc28Q2MQqBEFKgk1SNi81HK04733qhiMjXtXw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: disallow mount/sb marks on kernel internal
 pseudo fs
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
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

On Tue, Jul 4, 2023 at 3:47=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Tue, Jul 04, 2023 at 01:18:33PM +0200, Jan Kara wrote:
> > On Tue 04-07-23 11:58:07, Christian Brauner wrote:
> > > On Mon, Jul 03, 2023 at 01:25:51PM +0200, Jan Kara wrote:
> > > > On Sat 01-07-23 19:25:14, Amir Goldstein wrote:
> > > > > On Fri, Jun 30, 2023 at 10:29=E2=80=AFAM Christian Brauner <braun=
er@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Jun 29, 2023 at 07:20:44AM +0300, Amir Goldstein wrote:
> > > > > > > Hopefully, nobody is trying to abuse mount/sb marks for watch=
ing all
> > > > > > > anonymous pipes/inodes.
> > > > > > >
> > > > > > > I cannot think of a good reason to allow this - it looks like=
 an
> > > > > > > oversight that dated back to the original fanotify API.
> > > > > > >
> > > > > > > Link: https://lore.kernel.org/linux-fsdevel/20230628101132.kv=
chg544mczxv2pm@quack3/
> > > > > > > Fixes: d54f4fba889b ("fanotify: add API to attach/detach supe=
r block mark")
> > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Jan,
> > > > > > >
> > > > > > > As discussed, allowing sb/mount mark on anonymous pipes
> > > > > > > makes no sense and we should not allow it.
> > > > > > >
> > > > > > > I've noted FAN_MARK_FILESYSTEM as the Fixes commit as a trigg=
er to
> > > > > > > backport to maintained LTS kernels event though this dates ba=
ck to day one
> > > > > > > with FAN_MARK_MOUNT. Not sure if we should keep the Fixes tag=
 or not.
> > > > > > >
> > > > > > > The reason this is an RFC and that I have not included also t=
he
> > > > > > > optimization patch is because we may want to consider banning=
 kernel
> > > > > > > internal inodes from fanotify and/or inotify altogether.
> > > > > > >
> > > > > > > The tricky point in banning anonymous pipes from inotify, whi=
ch
> > > > > > > could have existing users (?), but maybe not, so maybe this i=
s
> > > > > > > something that we need to try out.
> > > > > > >
> > > > > > > I think we can easily get away with banning anonymous pipes f=
rom
> > > > > > > fanotify altogeter, but I would not like to get to into a sit=
uation
> > > > > > > where new applications will be written to rely on inotify for
> > > > > > > functionaly that fanotify is never going to have.
> > > > > > >
> > > > > > > Thoughts?
> > > > > > > Am I over thinking this?
> > > > > > >
> > > > > > > Amir.
> > > > > > >
> > > > > > >  fs/notify/fanotify/fanotify_user.c | 14 ++++++++++++++
> > > > > > >  1 file changed, 14 insertions(+)
> > > > > > >
> > > > > > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/f=
anotify/fanotify_user.c
> > > > > > > index 95d7d8790bc3..8240a3fdbef0 100644
> > > > > > > --- a/fs/notify/fanotify/fanotify_user.c
> > > > > > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > > > > > @@ -1622,6 +1622,20 @@ static int fanotify_events_supported(s=
truct fsnotify_group *group,
> > > > > > >           path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_N=
OTIFY_PERM)
> > > > > > >               return -EINVAL;
> > > > > > >
> > > > > > > +     /*
> > > > > > > +      * mount and sb marks are not allowed on kernel interna=
l pseudo fs,
> > > > > > > +      * like pipe_mnt, because that would subscribe to event=
s on all the
> > > > > > > +      * anonynous pipes in the system.
> > > > > >
> > > > > > s/anonynous/anonymous/
> > > > > >
> > > > > > > +      *
> > > > > > > +      * XXX: SB_NOUSER covers all of the internal pseudo fs =
whose objects
> > > > > > > +      * are not exposed to user's mount namespace, but there=
 are other
> > > > > > > +      * SB_KERNMOUNT fs, like nsfs, debugfs, for which the v=
alue of
> > > > > > > +      * allowing sb and mount mark is questionable.
> > > > > > > +      */
> > > > > > > +     if (mark_type !=3D FAN_MARK_INODE &&
> > > > > > > +         path->mnt->mnt_sb->s_flags & SB_NOUSER)
> > > > > > > +             return -EINVAL;
> > > > > >
> > > > >
> > > > > On second thought, I am not sure about  the EINVAL error code her=
e.
> > > > > I used the same error code that Jan used for permission events on
> > > > > proc fs, but the problem is that applications do not have a decen=
t way
> > > > > to differentiate between
> > > > > "sb mark not supported by kernel" (i.e. < v4.20) vs.
> > > > > "sb mark not supported by fs" (the case above)
> > > > >
> > > > > same for permission events:
> > > > > "kernel compiled without FANOTIFY_ACCESS_PERMISSIONS" vs.
> > > > > "permission events not supported by fs" (procfs)
> > > > >
> > > > > I have looked for other syscalls that react to SB_NOUSER and I've
> > > > > found that mount also returns EINVAL.
> > > >
> > > > We tend to return EINVAL both for invalid (combination of) flags as=
 well as
> > > > for flags applied to invalid objects in various calls. In practice =
there is
> > > > rarely a difference.
> > > >
> > > > > So far, fanotify_mark() and fanotify_init() mostly return EINVAL
> > > > > for invalid flag combinations (also across the two syscalls),
> > > > > but not because of the type of object being marked, except for
> > > > > the special case of procfs and permission events.
> > > > >
> > > > > mount(2) syscall OTOH, has many documented EINVAL cases
> > > > > due to the type of source object (e.g. propagation type shared).
> > > > >
> > > > > I know there is no standard and EINVAL can mean many
> > > > > different things in syscalls, but I thought that maybe EACCES
> > > > > would convey more accurately the message:
> > > > > "The sb/mount of this fs is not accessible for placing a mark".
> > > > >
> > > > > WDYT? worth changing?
> > > > > worth changing procfs also?
> > > > > We don't have that EINVAL for procfs documented in man page btw.
> > > >
> > > > Well, EACCES translates to message "Permission denied" which as Chr=
istian
> > > > writes is justifiable but frankly I find it more confusing. Because=
 when I
> > > > get "Permission denied", I go looking which permissions are wrong, =
perhaps
> > > > suspecting SELinux or other LSM and don't think that object type / =
location
> > > > is at fault.
> > > >
> > > > I agree that with EINVAL it is impossible to distinguish "unsupport=
ed on
> > > > this object only" vs "completely unknown flag" but it doesn't seem =
like a
> > > > huge problem for userspace to me as I can think of workarounds even=
 if
> > > > userspace wants to do something else than "report error and bail".
> > >
> > > Userspace is pretty used to the flood of EINVAL from the vfs apis so
> > > they often have good workarounds. It doesn't mean it's something we
> > > should just discount ofc. I think having ways to surface more
> > > descriptive errors would overall be a good thing.
> >
> > Oh, I absolutely agree with that. I'm just not sure whether returning
> > EACCES in this particular case is going to cause more or less confusion=
.
>
> Yeah, I really meant it as a generic comment that also applies to my
> own comment about EINVAL being ubiquitous; so not directed at your
> comment about EACCES specifically.

No worries. Let it stay EINVAL.
Sorry for the noise :)

Thanks,
Amir.
