Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B45B8F46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 21:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiINTeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 15:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiINTd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 15:33:58 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E967E313
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 12:33:57 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a20so9349959qtw.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=qazYFFAGYsh/2qjunUYVuQFoMxijz7GoVTi1EKjjJME=;
        b=LGKpjF1yz2w+AC5bTJyVVaHueX3ANspwGswR8DF1/kDU75SyMKEd2r7V+bUQMPU2pq
         AlKD0TcHrOYuRDsMp/LxjRG67F8pQNugjEk2q+dHDD5E4XskWRXO0oVT+1+/xRCy+vNl
         cbWJp67VvqhxtidC7NQwXI7v/c0Zkvk0dmiSR1lLmkjHno/feBcfgb7wdjcNdpWzA/hW
         1wrqBdC3i09So6J8ZSW2lPOBYRQBQkzd5UX+3NQDKbDNOwQybINh+zffJ2dqM1uxsnLu
         YBHTxe4tpPLk5q5Q3VQRvphK0lkw34mb/ehh4eECS3BL/HQ8hmz29hWMaAuXMNYeg8su
         xJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qazYFFAGYsh/2qjunUYVuQFoMxijz7GoVTi1EKjjJME=;
        b=Kg0j/QKWpygIaSW0AwAoyPxzYVC/Fe18jCa08MHyK24nhdJ0TyYkjFSomLLB8wxRwJ
         fgtt/aF5y6iFS6NLMGOivwPnp/LTyD1YuaMfedHRD0sIb/4HeLeVytI82sSgGVvNlUWB
         KHdLoRzKrikKlzltxKHiUWVkDxoQJTHJDYp9W+TdwB1BcDDWLZu9yNJ3RhnPUp6R+uLr
         U7QbZEvzGOCTfaDCCbrLzI5CsWE9WpSNZqJQhDaDrcqk1TgQx/lOGwgfYvbx2NDoJYzQ
         8J9Cr6YqsnPGP/ZO90/8eGt8VJuZZ1+8qsRCuN4CktYluhZ/psOWiLwafCW5EGGVvNU2
         LFHg==
X-Gm-Message-State: ACgBeo3Rfy7WHAjbZizEwbjDbBvwt97sh6/zZDjl5xNICFBn20DT0oi0
        qcxSTuE16eo6/O8/1M7oFoeOFW7iRTOJXJa0GFzG/A==
X-Google-Smtp-Source: AA6agR7xtlrl1bsE+AYsrQI4uNdPnlHZT4pP24OxTm1p1i9wrhy0MgfO8VUmwzsF9TGQPQe9NB8MRFvwsg6QaLR7H1c=
X-Received: by 2002:ac8:5794:0:b0:35b:fd92:6fae with SMTP id
 v20-20020ac85794000000b0035bfd926faemr8694095qta.429.1663184036428; Wed, 14
 Sep 2022 12:33:56 -0700 (PDT)
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
 <CA+khW7hwnX3d9=TA9W+-t-2nqAS+wV8JFC42B_aB9VDT-fEG9Q@mail.gmail.com> <CAOQ4uxi7hFL0rWBRbkHuJFJoyu1h0wU6ug_pXS_vYoGaqYGL9g@mail.gmail.com>
In-Reply-To: <CAOQ4uxi7hFL0rWBRbkHuJFJoyu1h0wU6ug_pXS_vYoGaqYGL9g@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 14 Sep 2022 12:33:45 -0700
Message-ID: <CA+khW7gS+=D6F3x9k+=8juknzooxjZyqwAMDrEY0NrR2kYAjMQ@mail.gmail.com>
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

On Wed, Sep 14, 2022 at 12:23 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Sep 14, 2022 at 9:00 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Tue, Sep 13, 2022 at 8:46 PM Amir Goldstein <amir73il@gmail.com> wro=
te:
> > >
> > > On Tue, Sep 13, 2022 at 11:33 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > On Tue, Sep 13, 2022 at 11:54 AM Amir Goldstein <amir73il@gmail.com=
> wrote:
[...]
> > > There are probably some other limitations at the moment
> > > related to pseudo filesystems that prevent them from being
> > > used as upper and/or lower fs in overlayfs.
> > >
> > > We will need to check what those limitations are and whether
> > > those limitations could be lifted for your specific use case.
> > >
> >
> > How can we approach this? Maybe I can send my patch that adds tmp dir,
> > tmp files and xattr, attr to upstream as RFC, so you can take a look?
> >
>
> I don't think I need your fs to test.
> The only thing special in this setup as far as I can tell is the dynamic
> cgroupfs (or cgroup2?) lower dirs.
>
> IIUC, everything worked for you except for oddities related to
> lower directories not appearing and not disappearing from the union.
> Is that correct? is that the only thing that you need a fix for?
>

Yes, that's correct.

> > > > Further, directory B could disappear from lower. When that happens,=
 I
> > > > think there are two possible behaviors:
> > > >  - make 'file' disappear from union as well;
> > > >  - make 'file' and its directory accessible as well.
> > > >
> > > > In behavior 1, it will look like
> > > > $ tree union
> > > > .
> > > > =E2=94=94=E2=94=80=E2=94=80 A
> > > >     =E2=94=94=E2=94=80=E2=94=80 lower1
> > > >
> > > > In behavior 2, it will look like
> > > > $ tree union
> > > > .
> > > > =E2=94=94=E2=94=80=E2=94=80 A
> > > >     =E2=94=9C=E2=94=80=E2=94=80 B
> > > >     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file
> > > >     =E2=94=94=E2=94=80=E2=94=80 lower1
> > > >
> > > > IMHO, behavior 1 works better in my use case. But if the FS experts
> > > > think behavior 2 makes more sense, I can work around.
> > > >
> > >
> > > Something that I always wanted to try is to get rid of the duplicated
> > > upper fs hierarchy.
> > >
> > > It's a bit complicated to explain the details, but if your use case
> > > does not involve any directory renames(?), then the upper path
> > > for the merge directories can be index based and not hierarchical.
> > >
> >
> > Yeah, I don't expect directory renaming. But I can't say if there is
> > anyone trying to do that by accident, or by bad intention.
> >
>
> Your fs will return an error for rename if you did not implement it.
>
> Anyway, if you can accept behavior 2, it is much more simple.
> This other idea is very vague and not simple, so better not risk it.
>
> If you confirm that you only need to get uptodate view of
> lower dirs in union, then I will look for the patches that I have
> and see if they can help you.
>

Yes, I acknowledge that behavior 2 works for me.
