Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51195B9930
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiIOKyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 06:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiIOKyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:54:49 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD742A714;
        Thu, 15 Sep 2022 03:54:47 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id b81so8881706vkf.1;
        Thu, 15 Sep 2022 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=jBCqjZQhM/o2kgiH3fd30TwImm9d1zPB2UICxDX7kuw=;
        b=eX0SVo0mJOT6sZsdCTar5X4xX1Imt+8Fdf5CZIStddXm3Jj9p5Y1zIK9kVdmQo09Pw
         R30TK/rY5h5mdEMpCl+Tzz6takJbhu6IrXfmwQaqvErHmAoXR0zAQTmDsvHZeS0eJlA8
         F56uAo3bBlG+qvEraOiubRzeUXHIQ/Q5zPKnTcbxu4eAdV9+eIqaVtGwgeuu+fAghDKs
         7iiHPAh3KhcNCgYXiwr1a6grbTswIdNJ0AI+WvypiDp2oVid+aUEUD5gx7NPZ5iPy3M0
         XqkFtkStUW5f4t8z11gYSIQ6O3sLldCExRP37cf6qEr0vNe5cjLK7wWCcqJ3yABmGtnD
         JBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jBCqjZQhM/o2kgiH3fd30TwImm9d1zPB2UICxDX7kuw=;
        b=BFxPp4HNKZ3K0fypXcRoZsNccWOZaLZ02amzjrV2yVjit8hUqrXYai3VdfFlyMD8N4
         XKZsZN9ugTG6r1IKrCRzXKwlta+1a1fXoAVodIiPIGxmtYVmsaAPICxEyWvjT9oR8R+9
         4F9q+CY5+uqBBcPIR65rDu1cg47CPF5vrigYz1APHdOihET4obKKiHlvbPRKvnsVj9Qx
         DKm6qJOxnku/A/7BYeFpdo1ViPXDQjSFH3/mo60mzLf9YVPKuhzggqg8MvadL2iBsmq4
         IG5rc/axYKqu8CwdjCXZFy3e4ZqpLvcsq+2jKRIe88ISyoOINV88eDOvg1qyd/RlKlGj
         CQUg==
X-Gm-Message-State: ACgBeo2EHwqCwt8WaSZizW5acvBe1ubfjDdrt7VJhK0iRq6KgdzMnCNQ
        hrlvPi6QL4/AkMMld5F9eoPgHvSI77JyVX+/9DEtYxrBYmQ=
X-Google-Smtp-Source: AA6agR6ZRLI8jHOQFCmTaZZfufLGTWj+3ylpH6ucliF96GDm2GSlayNXwHg5yX2Me1Q8irmGIoFRkDnvRpnEwNG0T6M=
X-Received: by 2002:a1f:5c16:0:b0:39e:c313:cb5b with SMTP id
 q22-20020a1f5c16000000b0039ec313cb5bmr12874283vkb.25.1663239286171; Thu, 15
 Sep 2022 03:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
 <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
 <CAJfpegtTHhjM5f3R4PVegCoyARA0B2VTdbwbwDva2GhBoX9NsA@mail.gmail.com>
 <CAOQ4uxh2OZ_AMp6XRcMy0ZtjkQnBfBZFhH0t-+Pd298uPuSEVw@mail.gmail.com>
 <CAJfpegt4N2nmCQGmLSBB--NzuSSsO6Z0sue27biQd4aiSwvNFw@mail.gmail.com>
 <CAOQ4uxjjPOtH9+r=oSV4iVAUvW6s3RBjA9qC73bQN1LhUqjRYQ@mail.gmail.com>
 <CA+khW7hviAT6DbNORYKcatOV1cigGyrd_1mH-oMwehafobVXVg@mail.gmail.com>
 <CAOQ4uxjUbwKmLAO-jTE3y6EnH2PNw0+V=oXNqNyD+H9U+nX49g@mail.gmail.com>
 <CA+khW7jQ6fZbEgzxCafsaaTyv7ze58bd9hQ0HBH4R+dQyRaqog@mail.gmail.com>
 <CAOQ4uxjP0qeuUrdjT6hXCb5zO0AoY+LKM6uza2cL9UCGMo8KsQ@mail.gmail.com>
 <CA+khW7h907VDeD1mR2wH4pOWxPBG18C2enkZKSZgyWYrFP7Vnw@mail.gmail.com>
 <CAOQ4uxh9_7wRoDuzLkYCQVWWihuOFz5WmQemCskKg+U6FqR8wg@mail.gmail.com>
 <CA+khW7hwnX3d9=TA9W+-t-2nqAS+wV8JFC42B_aB9VDT-fEG9Q@mail.gmail.com>
 <CAOQ4uxi7hFL0rWBRbkHuJFJoyu1h0wU6ug_pXS_vYoGaqYGL9g@mail.gmail.com> <CA+khW7gS+=D6F3x9k+=8juknzooxjZyqwAMDrEY0NrR2kYAjMQ@mail.gmail.com>
In-Reply-To: <CA+khW7gS+=D6F3x9k+=8juknzooxjZyqwAMDrEY0NrR2kYAjMQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 15 Sep 2022 13:54:34 +0300
Message-ID: <CAOQ4uxi3muNRfKtvt6U8gQRiVCfGghKdxsGhLjbhL7GPrrs+ZA@mail.gmail.com>
Subject: Re: Overlayfs with writable lower layer
To:     Hao Luo <haoluo@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 10:33 PM Hao Luo <haoluo@google.com> wrote:
>
> On Wed, Sep 14, 2022 at 12:23 PM Amir Goldstein <amir73il@gmail.com> wrot=
e:
> >
> > On Wed, Sep 14, 2022 at 9:00 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Tue, Sep 13, 2022 at 8:46 PM Amir Goldstein <amir73il@gmail.com> w=
rote:
> > > >
> > > > On Tue, Sep 13, 2022 at 11:33 PM Hao Luo <haoluo@google.com> wrote:
> > > > >
> > > > > On Tue, Sep 13, 2022 at 11:54 AM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> [...]
> > > > There are probably some other limitations at the moment
> > > > related to pseudo filesystems that prevent them from being
> > > > used as upper and/or lower fs in overlayfs.
> > > >
> > > > We will need to check what those limitations are and whether
> > > > those limitations could be lifted for your specific use case.
> > > >
> > >
> > > How can we approach this? Maybe I can send my patch that adds tmp dir=
,
> > > tmp files and xattr, attr to upstream as RFC, so you can take a look?
> > >
> >
> > I don't think I need your fs to test.
> > The only thing special in this setup as far as I can tell is the dynami=
c
> > cgroupfs (or cgroup2?) lower dirs.
> >
> > IIUC, everything worked for you except for oddities related to
> > lower directories not appearing and not disappearing from the union.
> > Is that correct? is that the only thing that you need a fix for?
> >
>
> Yes, that's correct.
>
> > > > > Further, directory B could disappear from lower. When that happen=
s, I
> > > > > think there are two possible behaviors:
> > > > >  - make 'file' disappear from union as well;
> > > > >  - make 'file' and its directory accessible as well.
> > > > >
> > > > > In behavior 1, it will look like
> > > > > $ tree union
> > > > > .
> > > > > =E2=94=94=E2=94=80=E2=94=80 A
> > > > >     =E2=94=94=E2=94=80=E2=94=80 lower1
> > > > >
> > > > > In behavior 2, it will look like
> > > > > $ tree union
> > > > > .
> > > > > =E2=94=94=E2=94=80=E2=94=80 A
> > > > >     =E2=94=9C=E2=94=80=E2=94=80 B
> > > > >     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file
> > > > >     =E2=94=94=E2=94=80=E2=94=80 lower1
> > > > >
> > > > > IMHO, behavior 1 works better in my use case. But if the FS exper=
ts
> > > > > think behavior 2 makes more sense, I can work around.
> > > > >
> > > >
> > > > Something that I always wanted to try is to get rid of the duplicat=
ed
> > > > upper fs hierarchy.
> > > >
> > > > It's a bit complicated to explain the details, but if your use case
> > > > does not involve any directory renames(?), then the upper path
> > > > for the merge directories can be index based and not hierarchical.
> > > >
> > >
> > > Yeah, I don't expect directory renaming. But I can't say if there is
> > > anyone trying to do that by accident, or by bad intention.
> > >
> >
> > Your fs will return an error for rename if you did not implement it.
> >
> > Anyway, if you can accept behavior 2, it is much more simple.
> > This other idea is very vague and not simple, so better not risk it.
> >
> > If you confirm that you only need to get uptodate view of
> > lower dirs in union, then I will look for the patches that I have
> > and see if they can help you.
> >
>
> Yes, I acknowledge that behavior 2 works for me.

OK. I took a closer look and there are some challenges.
Nothing that cannot be fixed if you are willing to do the work.
I will try to explain the challenges and possible solutions.

Current overlayfs code assumes in many places that the
lower fs is not being changed at all while overlayfs is mounted.
As overlayfs.rst says:

"Changes to the underlying filesystems while part of a mounted overlay
filesystem are not allowed.  If the underlying filesystem is changed,
the behavior of the overlay is undefined, though it will not result in
a crash or deadlock."

One of the most visible impacts of changes to lower later
is that the merge dir cache is not invalidated, which is the
immediate reason that you are seeing the ghost lower dir A/B
in the union even if you did not create file A/B/file.

You can check if this hack fixes your first order problem:

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 78f62cc1797b..4eb6fcf341de 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -326,7 +326,7 @@ static void ovl_dir_reset(struct file *file)
        struct dentry *dentry =3D file->f_path.dentry;
        bool is_real;

-       if (cache && ovl_dentry_version_get(dentry) !=3D cache->version) {
+       if (cache /*&& ovl_dentry_version_get(dentry) !=3D cache->version*/=
) {
                ovl_cache_put(od, dentry);
                od->cache =3D NULL;
                od->cursor =3D NULL;
---

If it does, it may be acceptable to add that behavior as a mount option.

But it doesn't end here, there is also lookup cache and possibly other
issues as well related to merge dirs with ghosted lower.

If you did create file A/B/file then trying to list A/B after A/B
has gone from lower fs,  may depend on the lower fs behavior.
Some of the issues are not related to overlayfs but to cgroupfs.

For "standard" Linux fs, if you keep an open fd to a directory,
that directory can be removed and then if you try to readdir from
the open fd, or use the fd in one of the XXXat() syscalls,
you will get ENOENT, because of the IS_DEADDIR(dir) checks
in the vfs.

Do you get this behavior with an open fd on a cgroupfs dir
that has disappeared? Please check.

I think that ovl_iterate() can be made more tolerant to
ENOENT when iterating a merge dir with ghosted lower dir.
If you run into this error when trying to list A/B, find out
the place in the code that returns the error and I'll see
if that error may be relaxed.

The patches that I have are doing something different.
The idea is that overlayfs can watch for lower fs changes using
fsnotify() callbacks and do "something" proactive when they happen.

My Overlayfs watch [1] patches do "something" else - they
record the changes to lower fs when they happen, but they
demonstrate the basic concept of watching changes in lower fs.

[1] https://github.com/amir73il/overlayfs/wiki/Overlayfs-watch

The "something" that overlayfs could do when a lower dir
is removed is to invalidate the caches of the union dir and
everything under it.

There is one other small problem with this method w.r.t
lower cgroupfs - cgroupfs does not call any fsnotify callbacks when
directories disappear...

cgroupfs is an instance of kernfs.
kenfs is calling the fsnotify_modify() hook when kernel changes
the content of a file:

d911d9874801 kernfs: make kernfs_notify() trigger inotify events too

but it does not call fsnotify_rmdir/mkdir/delete/create() like other pseudo
fs do (debugfs, configfs, tracefs, ...) when directories appear/disappear -
at least I don't think that it does.

Please run inotifywatch on cgroupfs and find out for yourself.

Hope that some of the info here can help you move forward.
Most of it you can probably ignore.

Thanks,
Amir.
