Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521825B7FA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 05:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiINDqz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 23:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiINDqw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:46:52 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A634A6AA2A;
        Tue, 13 Sep 2022 20:46:50 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a18so5057877uak.12;
        Tue, 13 Sep 2022 20:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=yUDym3ehzI6AmjjrIybEaCVUegk1hmpWzbzT6HzAP/U=;
        b=aG2C/2JeXc6CTyXWlZrNqu0OTJDS+WtmUqyC+fYwFaMjrYCmimI4DpxnnxD3nXsK0k
         UVnrB+ZZtfXFdEiKmeCvZvzLCFrq588Krwmt9o0NWVcp4i7lNjeSajrH86CP5dg+2w4K
         HmO3TTmPAArl/C2dK2Da8RgMIDkwVkzdVW9qnDaTJURmkB6VFTiLipTJKqe5EVaGIfI3
         69GrjZnGswC90nO1LTiVtT5aDaHndk4tCPY1Oz3Cwum6QjhTs/4sBX0b2Lg+w2ZZkUQ3
         5uW+6ldilYG8DSBM2xZqUUqgZLzy/t75kMJwE4ENBbOZbsrDIjZSX3UIG3BJ07gWq0YO
         mz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yUDym3ehzI6AmjjrIybEaCVUegk1hmpWzbzT6HzAP/U=;
        b=rnmCMV0z2USSM/vyOCJEzwgAdvz0fZjDnDxzBqx7NQI3vkczoIWEOzPBibLo7i7xKu
         5cZbwjCQVmnQvmoETDhCmOGo90KLi15Fqb0Bijapbs9Kf9y3mT7e8UvWP6EuJqsoNBYe
         GgUDtWQnaksjFZltc07hFIYLTcNqC30EpXe1aYCtub82oRZqc8FktfsOOIicjgMAybtt
         25HPQKbT2WFLOnaJsJpWStEj4uPDU0VU4hChCvz1F9RfTimgLQVC15lvzxDdcDtL4igB
         MsaOl4MYt7A6+G5l9tzmKMN4KuIEvff2ewvbT7WFB8qfvKmD10xuMHENNhW3DPHoPbSJ
         FL1g==
X-Gm-Message-State: ACgBeo2qLYVnpfUim7DY+MXKskSEnrPH6l0QcSqM2varkVTAv3g0gfb2
        YtVnW3oPsLnMLJa1WTPiSoeuLkhQu6y1lmpIcEb8gjs2PPk=
X-Google-Smtp-Source: AA6agR5OHWjTrdYy41nUp5wgC9uF9OFLtlrc57T5Q3YNnQC/JldeOchZ8/pRPDXqo/lw4GjdmqBeHRcvTzVqfdK3FkI=
X-Received: by 2002:ab0:1c55:0:b0:3b6:3cbe:19ca with SMTP id
 o21-20020ab01c55000000b003b63cbe19camr6949644uaj.114.1663127209734; Tue, 13
 Sep 2022 20:46:49 -0700 (PDT)
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
 <CAOQ4uxjP0qeuUrdjT6hXCb5zO0AoY+LKM6uza2cL9UCGMo8KsQ@mail.gmail.com> <CA+khW7h907VDeD1mR2wH4pOWxPBG18C2enkZKSZgyWYrFP7Vnw@mail.gmail.com>
In-Reply-To: <CA+khW7h907VDeD1mR2wH4pOWxPBG18C2enkZKSZgyWYrFP7Vnw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 14 Sep 2022 06:46:38 +0300
Message-ID: <CAOQ4uxh9_7wRoDuzLkYCQVWWihuOFz5WmQemCskKg+U6FqR8wg@mail.gmail.com>
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

On Tue, Sep 13, 2022 at 11:33 PM Hao Luo <haoluo@google.com> wrote:
>
> On Tue, Sep 13, 2022 at 11:54 AM Amir Goldstein <amir73il@gmail.com> wrot=
e:
> > OK. IIUC, you have upper fs files only in the root dir?
>
> Sorry, no, the upper fs files need to be in subdir.
>
> > And the lower root dir has only subdirs?
>
> There could be files.
>

And assuming that those files are cgroupfs files, why
did you say there is no need to write to those files?

I seem to recall that was an important distinction from
standard overlayfs when you described the problem in LSFMM.

> > Can you give a small example of an upper a lower and their
> > union trees just for the sake of discussion?
> >
>
> For example, assume lower has the following layout:
> $ tree lower
> .
> =E2=94=94=E2=94=80=E2=94=80 A
>     =E2=94=9C=E2=94=80=E2=94=80 B
>     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 lower
>     =E2=94=94=E2=94=80=E2=94=80 lower
>
> I can't create files in the fs in the lower.
> $ touch A/B/file
> touch: cannot touch 'A/B/file': Permission denied
>
> The upper is initially empty.
>
> I would like to overlay a writable fs on top of lower, so the union
> tree looks like
> $ tree union
> .
> =E2=94=94=E2=94=80=E2=94=80 A
>     =E2=94=9C=E2=94=80=E2=94=80 B
>     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 lower
>     =E2=94=94=E2=94=80=E2=94=80 lower
> $ touch A/B/file
> $ tree union
> .
> =E2=94=94=E2=94=80=E2=94=80 A
>     =E2=94=9C=E2=94=80=E2=94=80 B
>     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 file
>     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 lower2
>     =E2=94=94=E2=94=80=E2=94=80 lower1
>
> Here, 'file' exists in the upper.
>

So B is now called a "merged" dir - it is not a "pure" dir
anymore because it contains both upper and lower files.

Normally in overlayfs before creating 'file' in upper,
the hierarchy A/B/ needs to be created in upper fs
to contain the file.

Unless your upper fs automagically has the same
dirs hierarchy as the lower fs?

You should know that overlayfs does more than just
mkdir("A");mkdir("A/B")
it created tmp dirs, sets xattrs and attrs on them and moves
them into place.
I am not sure if you planned to support all those operations
in your upper fs?

There are probably some other limitations at the moment
related to pseudo filesystems that prevent them from being
used as upper and/or lower fs in overlayfs.

We will need to check what those limitations are and whether
those limitations could be lifted for your specific use case.

> Further, directory B could disappear from lower. When that happens, I
> think there are two possible behaviors:
>  - make 'file' disappear from union as well;
>  - make 'file' and its directory accessible as well.
>
> In behavior 1, it will look like
> $ tree union
> .
> =E2=94=94=E2=94=80=E2=94=80 A
>     =E2=94=94=E2=94=80=E2=94=80 lower1
>
> In behavior 2, it will look like
> $ tree union
> .
> =E2=94=94=E2=94=80=E2=94=80 A
>     =E2=94=9C=E2=94=80=E2=94=80 B
>     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file
>     =E2=94=94=E2=94=80=E2=94=80 lower1
>
> IMHO, behavior 1 works better in my use case. But if the FS experts
> think behavior 2 makes more sense, I can work around.
>

Something that I always wanted to try is to get rid of the duplicated
upper fs hierarchy.

It's a bit complicated to explain the details, but if your use case
does not involve any directory renames(?), then the upper path
for the merge directories can be index based and not hierarchical.

IOW:
- union tree lookup/traversal by path is performed on the lower fs
- upper fs is traversed by name only for pure upper dirs
- merged dirs are found by index of lower dir inode

The result will be behavior 1 that you wanted

I have some other use cases that might benefit from this mode.

> >
> > If that is all then it sounds pretty simple.
> > It could be described something like this:
> > 1. merged directories cannot appear/disappear
> > 2. lower pure directories can appear/disappear
> > 3. upper files/dirs can be created inside merge dirs and pure upper dir=
s
> >
> > I think I have some patches that could help with #2.
> >
>
> These three semantics looks good to me.
>

Except the case about disappearing B that you just described
above breaks rule #1 ;)
so other semantics are needed.

I will need some more clarifications about your use case to
understand if what I have in mind could help your use case.

Thanks,
Amir.
