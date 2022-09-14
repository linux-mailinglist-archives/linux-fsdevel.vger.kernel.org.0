Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF4D5B8E77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 20:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiINSAT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 14:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiINSAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:00:17 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87471409F
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 11:00:14 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h21so11794648qta.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=h4fGXoRURXYZVMZa3qpzUZ+qUx5M3FF8DFGX1noavt0=;
        b=hZolzGc3K3d6zmlh4cqzpkUtTmmqadXKb+i8ZBgEuTT9HIKHoH+TcZAHwxAS9uqOAJ
         kTfRjPHXE1hHlOzoJ1fsAFvxMJkN3hXk9oTkXahImB7y/jC0dh8XylykfhAJYzaAZlLb
         E4R/Kv2V1rI3EuMoK5aSbc9VKmOaYf0o5PtwYmWTuolU9fHr40j2ZQuapxnoZaLs8trv
         n7kldHfvgEhqFmOIt9pJ3DkGmm+6cPYh5D5he9akYDdFDvoJ3V7IagLo4xLfOPyaZHzG
         4ucrotNqwSJZ5aAp49cb3p+esYLWzTd9avguRivV1K658m9JL5QeqS2JAafTq+49cHfR
         dbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=h4fGXoRURXYZVMZa3qpzUZ+qUx5M3FF8DFGX1noavt0=;
        b=H4HdxHGedGsrap5OnuMayxs3PTfLXttcaZUGrgPMe++D94fotLIvPP7zMPISgDKVS6
         i+ehPe+p7/XmticIPdA9N7PVa47XIR+PfHRY0egPfLeKBAhz1yzBpF1vH+Kxwn4/4GlL
         sIjT6xLe+RIHoWMzgYSvmV86i+qMH70YE5ic87XbPA2EiLlTevdQZMdI1C1+nt9NzkT+
         pnR9pgD8HeQraqsCu1QWAiORG3T331xsWLyektCkrSPDJVd+JuJRAOXJuMchJPba2mat
         uc1iLVY+kyT13ks0J8FDansBHOmnJEUhXBJ8PjOnG13ijW4kQY3XnA+1Omdjz0O65Fei
         bACg==
X-Gm-Message-State: ACgBeo2Ew4RK1HA0Zajx4hkWB7AREY5+hAfp84cy0b+7EVRW77c+Tc9c
        uZPKSlm9EffhpeOmgGIc8X/4KO745pozMuJmV7UgkA==
X-Google-Smtp-Source: AA6agR5HMTsIjU0S2lb8GdZUj5zD3g4lsNi5o9eOXaZBbZnR+pi3UAbW+Y9eNamDCfY5Wo4uBKL8DYXEaLvJBpYX5BI=
X-Received: by 2002:a05:622a:30d:b0:343:63d1:3751 with SMTP id
 q13-20020a05622a030d00b0034363d13751mr33527856qtw.679.1663178413799; Wed, 14
 Sep 2022 11:00:13 -0700 (PDT)
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
 <CA+khW7h907VDeD1mR2wH4pOWxPBG18C2enkZKSZgyWYrFP7Vnw@mail.gmail.com> <CAOQ4uxh9_7wRoDuzLkYCQVWWihuOFz5WmQemCskKg+U6FqR8wg@mail.gmail.com>
In-Reply-To: <CAOQ4uxh9_7wRoDuzLkYCQVWWihuOFz5WmQemCskKg+U6FqR8wg@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 14 Sep 2022 11:00:02 -0700
Message-ID: <CA+khW7hwnX3d9=TA9W+-t-2nqAS+wV8JFC42B_aB9VDT-fEG9Q@mail.gmail.com>
Subject: Re: Overlayfs with writable lower layer
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 8:46 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Sep 13, 2022 at 11:33 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Tue, Sep 13, 2022 at 11:54 AM Amir Goldstein <amir73il@gmail.com> wr=
ote:
> > > OK. IIUC, you have upper fs files only in the root dir?
> >
> > Sorry, no, the upper fs files need to be in subdir.
> >
> > > And the lower root dir has only subdirs?
> >
> > There could be files.
> >
>
> And assuming that those files are cgroupfs files, why
> did you say there is no need to write to those files?
>
> I seem to recall that was an important distinction from
> standard overlayfs when you described the problem in LSFMM.

In my last reply, I was assuming all the writes to the cgroupfs files
happen from remote, not from the union. One can read files from union,
or create files that exist in the upper.

The idea is, I can provide two copies of lower to users. One is the
original lower, writable, so any update happens there. And the other
is a union of the lower and the upper, it's a read-only view of the
lower, but extended by the upper.

I actually don't know whether supporting writes to the lower from the
union is better. It probably is, because then I can combine the two
copies into one.

>
>
> > > Can you give a small example of an upper a lower and their
> > > union trees just for the sake of discussion?
> > >
> >
> > For example, assume lower has the following layout:
> > $ tree lower
> > .
> > =E2=94=94=E2=94=80=E2=94=80 A
> >     =E2=94=9C=E2=94=80=E2=94=80 B
> >     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 lower
> >     =E2=94=94=E2=94=80=E2=94=80 lower
> >
> > I can't create files in the fs in the lower.
> > $ touch A/B/file
> > touch: cannot touch 'A/B/file': Permission denied
> >
> > The upper is initially empty.
> >
> > I would like to overlay a writable fs on top of lower, so the union
> > tree looks like
> > $ tree union
> > .
> > =E2=94=94=E2=94=80=E2=94=80 A
> >     =E2=94=9C=E2=94=80=E2=94=80 B
> >     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 lower
> >     =E2=94=94=E2=94=80=E2=94=80 lower
> > $ touch A/B/file
> > $ tree union
> > .
> > =E2=94=94=E2=94=80=E2=94=80 A
> >     =E2=94=9C=E2=94=80=E2=94=80 B
> >     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 file
> >     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 lower2
> >     =E2=94=94=E2=94=80=E2=94=80 lower1
> >
> > Here, 'file' exists in the upper.
> >
>
> So B is now called a "merged" dir - it is not a "pure" dir
> anymore because it contains both upper and lower files.
>
> Normally in overlayfs before creating 'file' in upper,
> the hierarchy A/B/ needs to be created in upper fs
> to contain the file.
>
> Unless your upper fs automagically has the same
> dirs hierarchy as the lower fs?
>
> You should know that overlayfs does more than just
> mkdir("A");mkdir("A/B")
> it created tmp dirs, sets xattrs and attrs on them and moves
> them into place.
> I am not sure if you planned to support all those operations
> in your upper fs?
>

Yeah. I can add support for tmp dirs, tmp files in my upper fs, that
is, bpffs. I played it a bit back in May, that is totally doable. I
remembered I successfully made bpffs accepted as overlayfs's upper
without xattrs and attrs back then. Maybe I missed something.

> There are probably some other limitations at the moment
> related to pseudo filesystems that prevent them from being
> used as upper and/or lower fs in overlayfs.
>
> We will need to check what those limitations are and whether
> those limitations could be lifted for your specific use case.
>

How can we approach this? Maybe I can send my patch that adds tmp dir,
tmp files and xattr, attr to upstream as RFC, so you can take a look?

> > Further, directory B could disappear from lower. When that happens, I
> > think there are two possible behaviors:
> >  - make 'file' disappear from union as well;
> >  - make 'file' and its directory accessible as well.
> >
> > In behavior 1, it will look like
> > $ tree union
> > .
> > =E2=94=94=E2=94=80=E2=94=80 A
> >     =E2=94=94=E2=94=80=E2=94=80 lower1
> >
> > In behavior 2, it will look like
> > $ tree union
> > .
> > =E2=94=94=E2=94=80=E2=94=80 A
> >     =E2=94=9C=E2=94=80=E2=94=80 B
> >     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file
> >     =E2=94=94=E2=94=80=E2=94=80 lower1
> >
> > IMHO, behavior 1 works better in my use case. But if the FS experts
> > think behavior 2 makes more sense, I can work around.
> >
>
> Something that I always wanted to try is to get rid of the duplicated
> upper fs hierarchy.
>
> It's a bit complicated to explain the details, but if your use case
> does not involve any directory renames(?), then the upper path
> for the merge directories can be index based and not hierarchical.
>

Yeah, I don't expect directory renaming. But I can't say if there is
anyone trying to do that by accident, or by bad intention.

> IOW:
> - union tree lookup/traversal by path is performed on the lower fs
> - upper fs is traversed by name only for pure upper dirs
> - merged dirs are found by index of lower dir inode
>
> The result will be behavior 1 that you wanted
>
> I have some other use cases that might benefit from this mode.
>

That will be very cool!

> > >
> > > If that is all then it sounds pretty simple.
> > > It could be described something like this:
> > > 1. merged directories cannot appear/disappear
> > > 2. lower pure directories can appear/disappear
> > > 3. upper files/dirs can be created inside merge dirs and pure upper d=
irs
> > >
> > > I think I have some patches that could help with #2.
> > >
> >
> > These three semantics looks good to me.
> >
>
> Except the case about disappearing B that you just described
> above breaks rule #1 ;)
> so other semantics are needed.
>

Yes :) Now I understand. Thanks for the explanation on "merged" dir.

> I will need some more clarifications about your use case to
> understand if what I have in mind could help your use case.
>
> Thanks,
> Amir.
