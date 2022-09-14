Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483145B8F3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 21:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiINTXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 15:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiINTXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 15:23:41 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAE28305E;
        Wed, 14 Sep 2022 12:23:37 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id c3so16983857vsc.6;
        Wed, 14 Sep 2022 12:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Do8J8B6j7pJxw+o5QJieN1AwRGRATf5znOcYalBz9E0=;
        b=cRUZshCOeqq53CgEEQQZ90ee69cDPFAL6sqXDDO5ox71/ifR6Rii+qVikOBszd6Ucl
         6xGHgGCXIs9+Oeji/aI/lTQUMtMt4EleBKuU5W3/UXMF4dryKPgqYPhFkT4XYsVglsrb
         vOWkxs7Sis+a3xpGa6IBDaSbSEmGq43ZX9iXjcdYv3LqeLV92HX1rumqo0SwMQ5s96Xa
         N7Anhej/Dsicj+PmrZhimdeOiekLgBcGZNIcLyQZ8ejCh1UXU2R0MdARwIZX58OMAysl
         oOifPPvgQkVpFqVCGTeLCcHqAZ0aKX2O9r7y9gUsxra6NP2zqT7DwoG8vsxx8FSGix5a
         orNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Do8J8B6j7pJxw+o5QJieN1AwRGRATf5znOcYalBz9E0=;
        b=qblRu7uwU4JtS4oDH2uERIx0LekFOYlZWd9ktGsn7wFoivsHJxqG0BqaJveU8NdPWL
         H9Dhpgj+OXGw2ehk9PKp8fSiXNU0AeGcT5raSNkmP4qwb+ouQUL4iuBQ3ca5YA2cwCKE
         l9inwg0/AXqd/OskmWq6MEOe5Lt8IxUJunycx+CyzNn4+UG6Xtu18/baabpJoNK5OwHl
         dA3A0y57+QPvfBmJGiNasXHIrUKLIH9YGbZHdV6V3xHDqyYu2bseFZSuQ8D7a5xjmH5U
         jFn6iFbIT2l0SzAArdbNgku7C19P3bl6HPC7Pg9SyFZX/mnQEy7o5ycJq6p7AxLjhyzQ
         5DCg==
X-Gm-Message-State: ACgBeo3t4BH8VPXDU74HZxJH+DJfJ7o0xZMV9tCK8GbV1lMbG1LQG7wT
        FPoHbGhqCXziDPBq+FDBMmcIoup0biS3/Ks48hm5+fqZ
X-Google-Smtp-Source: AA6agR4nzxMuiDOAaafy6cwaMysE1QnyGPAnFZmDsTiMDiOsx3gGDbxXvviVSxMouY9kpZG//5iF9TA7CNOMbVNiCZM=
X-Received: by 2002:a05:6102:d3:b0:398:6f6a:8850 with SMTP id
 u19-20020a05610200d300b003986f6a8850mr6818110vsp.71.1663183416335; Wed, 14
 Sep 2022 12:23:36 -0700 (PDT)
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
 <CAOQ4uxh9_7wRoDuzLkYCQVWWihuOFz5WmQemCskKg+U6FqR8wg@mail.gmail.com> <CA+khW7hwnX3d9=TA9W+-t-2nqAS+wV8JFC42B_aB9VDT-fEG9Q@mail.gmail.com>
In-Reply-To: <CA+khW7hwnX3d9=TA9W+-t-2nqAS+wV8JFC42B_aB9VDT-fEG9Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 14 Sep 2022 22:23:24 +0300
Message-ID: <CAOQ4uxi7hFL0rWBRbkHuJFJoyu1h0wU6ug_pXS_vYoGaqYGL9g@mail.gmail.com>
Subject: Re: Overlayfs with writable lower layer
To:     Hao Luo <haoluo@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
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

On Wed, Sep 14, 2022 at 9:00 PM Hao Luo <haoluo@google.com> wrote:
>
> On Tue, Sep 13, 2022 at 8:46 PM Amir Goldstein <amir73il@gmail.com> wrote=
:
> >
> > On Tue, Sep 13, 2022 at 11:33 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Tue, Sep 13, 2022 at 11:54 AM Amir Goldstein <amir73il@gmail.com> =
wrote:
> > > > OK. IIUC, you have upper fs files only in the root dir?
> > >
> > > Sorry, no, the upper fs files need to be in subdir.
> > >
> > > > And the lower root dir has only subdirs?
> > >
> > > There could be files.
> > >
> >
> > And assuming that those files are cgroupfs files, why
> > did you say there is no need to write to those files?
> >
> > I seem to recall that was an important distinction from
> > standard overlayfs when you described the problem in LSFMM.
>
> In my last reply, I was assuming all the writes to the cgroupfs files
> happen from remote, not from the union. One can read files from union,
> or create files that exist in the upper.
>
> The idea is, I can provide two copies of lower to users. One is the
> original lower, writable, so any update happens there. And the other
> is a union of the lower and the upper, it's a read-only view of the
> lower, but extended by the upper.
>
> I actually don't know whether supporting writes to the lower from the
> union is better. It probably is, because then I can combine the two
> copies into one.
>

Understood.

> >
> >
> > > > Can you give a small example of an upper a lower and their
> > > > union trees just for the sake of discussion?
> > > >
> > >
> > > For example, assume lower has the following layout:
> > > $ tree lower
> > > .
> > > =E2=94=94=E2=94=80=E2=94=80 A
> > >     =E2=94=9C=E2=94=80=E2=94=80 B
> > >     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 lower
> > >     =E2=94=94=E2=94=80=E2=94=80 lower
> > >
> > > I can't create files in the fs in the lower.
> > > $ touch A/B/file
> > > touch: cannot touch 'A/B/file': Permission denied
> > >
> > > The upper is initially empty.
> > >
> > > I would like to overlay a writable fs on top of lower, so the union
> > > tree looks like
> > > $ tree union
> > > .
> > > =E2=94=94=E2=94=80=E2=94=80 A
> > >     =E2=94=9C=E2=94=80=E2=94=80 B
> > >     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 lower
> > >     =E2=94=94=E2=94=80=E2=94=80 lower
> > > $ touch A/B/file
> > > $ tree union
> > > .
> > > =E2=94=94=E2=94=80=E2=94=80 A
> > >     =E2=94=9C=E2=94=80=E2=94=80 B
> > >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 file
> > >     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 lower2
> > >     =E2=94=94=E2=94=80=E2=94=80 lower1
> > >
> > > Here, 'file' exists in the upper.
> > >
> >
> > So B is now called a "merged" dir - it is not a "pure" dir
> > anymore because it contains both upper and lower files.
> >
> > Normally in overlayfs before creating 'file' in upper,
> > the hierarchy A/B/ needs to be created in upper fs
> > to contain the file.
> >
> > Unless your upper fs automagically has the same
> > dirs hierarchy as the lower fs?
> >
> > You should know that overlayfs does more than just
> > mkdir("A");mkdir("A/B")
> > it created tmp dirs, sets xattrs and attrs on them and moves
> > them into place.
> > I am not sure if you planned to support all those operations
> > in your upper fs?
> >
>
> Yeah. I can add support for tmp dirs, tmp files in my upper fs, that
> is, bpffs. I played it a bit back in May, that is totally doable. I
> remembered I successfully made bpffs accepted as overlayfs's upper
> without xattrs and attrs back then. Maybe I missed something.
>

sounds reasonable.
xattr is not a hard requirement but some things (that you do not need)
cannot work without xattr like merged directory rename and rmdir.

> > There are probably some other limitations at the moment
> > related to pseudo filesystems that prevent them from being
> > used as upper and/or lower fs in overlayfs.
> >
> > We will need to check what those limitations are and whether
> > those limitations could be lifted for your specific use case.
> >
>
> How can we approach this? Maybe I can send my patch that adds tmp dir,
> tmp files and xattr, attr to upstream as RFC, so you can take a look?
>

I don't think I need your fs to test.
The only thing special in this setup as far as I can tell is the dynamic
cgroupfs (or cgroup2?) lower dirs.

IIUC, everything worked for you except for oddities related to
lower directories not appearing and not disappearing from the union.
Is that correct? is that the only thing that you need a fix for?

> > > Further, directory B could disappear from lower. When that happens, I
> > > think there are two possible behaviors:
> > >  - make 'file' disappear from union as well;
> > >  - make 'file' and its directory accessible as well.
> > >
> > > In behavior 1, it will look like
> > > $ tree union
> > > .
> > > =E2=94=94=E2=94=80=E2=94=80 A
> > >     =E2=94=94=E2=94=80=E2=94=80 lower1
> > >
> > > In behavior 2, it will look like
> > > $ tree union
> > > .
> > > =E2=94=94=E2=94=80=E2=94=80 A
> > >     =E2=94=9C=E2=94=80=E2=94=80 B
> > >     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file
> > >     =E2=94=94=E2=94=80=E2=94=80 lower1
> > >
> > > IMHO, behavior 1 works better in my use case. But if the FS experts
> > > think behavior 2 makes more sense, I can work around.
> > >
> >
> > Something that I always wanted to try is to get rid of the duplicated
> > upper fs hierarchy.
> >
> > It's a bit complicated to explain the details, but if your use case
> > does not involve any directory renames(?), then the upper path
> > for the merge directories can be index based and not hierarchical.
> >
>
> Yeah, I don't expect directory renaming. But I can't say if there is
> anyone trying to do that by accident, or by bad intention.
>

Your fs will return an error for rename if you did not implement it.

Anyway, if you can accept behavior 2, it is much more simple.
This other idea is very vague and not simple, so better not risk it.

If you confirm that you only need to get uptodate view of
lower dirs in union, then I will look for the patches that I have
and see if they can help you.

Thanks,
Amir.
