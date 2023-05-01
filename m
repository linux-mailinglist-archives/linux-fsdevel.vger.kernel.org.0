Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAD96F3633
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 20:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjEASsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 14:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjEASst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 14:48:49 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8967DE65;
        Mon,  1 May 2023 11:48:22 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-42ca0c08aa9so962622137.2;
        Mon, 01 May 2023 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682966894; x=1685558894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKVQwJa5t0eCyrACkPbSAhR6esPfeMb3yfCd45qddgk=;
        b=sGK41Ul01upKR24d9eXIIetBsjW99C0LOtlgakWWlXmv+QzeTMZb9pD6+wZGHIybnR
         mXgTUwbrT1iDvs4Y5LeGGkxfBSwU5Jdf8rZZX+hP6lkSnO2sdk1HZNwG9/eGJcQtQrYf
         /zKQ4R89cCBl7rj832OhuDiwOIf9v0KdHrtFP69vB4fWs5Ff4TabONd6v+kDCvpOR77k
         pZCOgiBzjamnj6dXWsczWlcnYHwfoiqIIXh+3jRIpUyieU6g0gyv0ahFG1Px+96Tgn6E
         g/IBISxQS5RIzF+P8xcAUmm4V1SnyvWqv5WOXWJXPwN9stmjvzSsl8T35GLVNBcqTbTG
         OF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682966894; x=1685558894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKVQwJa5t0eCyrACkPbSAhR6esPfeMb3yfCd45qddgk=;
        b=mEfNOI/cagVI3I9VltqknzUPrEhZlpGEziBmIscafefn/a4tbL6i82PN+cPSoDH/KX
         /373hpy1I8XGEWyOvQle5gPYlQYoUCb2mblsJSH7ktlE+mbRMuq+ItnRuXAtGSbyOgCx
         RcLqNOccTcmJexX8ItzpOwFOszdJTIsMzlcvZSZ2LaqxFtA1LZ+VDq9UAVO/5UJGIKcA
         oVeRml1ry0sBl9SalH47f2F7RnO9ZxKrxICI4vELDUlRVjDz/uyNNYwSBVMLQ2fgX28x
         77GklJG9J/RvECV8V5wiulZ9M4MEgTOj1JX5W4LuWZZYodytTk7/V8s4PvU4giq+DdGN
         q9kw==
X-Gm-Message-State: AC+VfDzKn8sDqVbIIPaS7lRs0I8hztv5HIuld1SLjZdw36NNGFP5+JFb
        8Bs0EtwVSqp7XL6Vfjusnb9OpY030e2ba7R1K9n3TCO+8yg=
X-Google-Smtp-Source: ACHHUZ5anjqIupPqMHtGBlrEJyuK4EuO6dOYCEi5tH3W7e38LxPaJ2OTR73mWRaHssIQGUa5drtnEjypZIeDjse6Wb4=
X-Received: by 2002:a67:eb16:0:b0:42c:761a:90ed with SMTP id
 a22-20020a67eb16000000b0042c761a90edmr6389721vso.6.1682966894656; Mon, 01 May
 2023 11:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230425130105.2606684-1-amir73il@gmail.com> <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
 <ZE0teudDjXJFz+1b@manet.1015granger.net> <CAOQ4uxi6-fZp8WzQAR7wbv+0c-xncFTsAa=U=9ZCcdcT3vQpgg@mail.gmail.com>
In-Reply-To: <CAOQ4uxi6-fZp8WzQAR7wbv+0c-xncFTsAa=U=9ZCcdcT3vQpgg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 1 May 2023 21:48:03 +0300
Message-ID: <CAOQ4uxhEXJ2j7WzwVa1v9zH-4Tm72SsyjJ=RiJcOghViE-mGQg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] Prepare for supporting more filesystems with fanotify
To:     Chuck Lever <cel@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
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

On Sat, Apr 29, 2023 at 8:26=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Sat, Apr 29, 2023 at 5:45=E2=80=AFPM Chuck Lever <cel@kernel.org> wrot=
e:
> >
> > On Thu, Apr 27, 2023 at 11:13:33AM -0400, Jeff Layton wrote:
> > > On Tue, 2023-04-25 at 16:01 +0300, Amir Goldstein wrote:
> > > > Jan,
> > > >
> > > > Following up on the FAN_REPORT_ANY_FID proposal [1], here is a shot=
 at an
> > > > alternative proposal to seamlessly support more filesystems.
> > > >
> > > > While fanotify relaxes the requirements for filesystems to support
> > > > reporting fid to require only the ->encode_fh() operation, there ar=
e
> > > > currently no new filesystems that meet the relaxed requirements.
> > > >
> > > > I will shortly post patches that allow overlayfs to meet the new
> > > > requirements with default overlay configurations.
> > > >
> > > > The overlay and vfs/fanotify patch sets are completely independent.
> > > > The are both available on my github branch [2] and there is a simpl=
e
> > > > LTP test variant that tests reporting fid from overlayfs [3], which
> > > > also demonstrates the minor UAPI change of name_to_handle_at(2) for
> > > > requesting a non-decodeable file handle by userspace.
> > > >
> > > > Thanks,
> > > > Amir.
> > > >
> > > > [1] https://lore.kernel.org/linux-fsdevel/20230417162721.ouzs33oh6m=
b7vtft@quack3/
> > > > [2] https://github.com/amir73il/linux/commits/exportfs_encode_fid
> > > > [3] https://github.com/amir73il/ltp/commits/exportfs_encode_fid
> > > >
> > > > Amir Goldstein (4):
> > > >   exportfs: change connectable argument to bit flags
> > > >   exportfs: add explicit flag to request non-decodeable file handle=
s
> > > >   exportfs: allow exporting non-decodeable file handles to userspac=
e
> > > >   fanotify: support reporting non-decodeable file handles
> > > >
> > > >  Documentation/filesystems/nfs/exporting.rst |  4 +--
> > > >  fs/exportfs/expfs.c                         | 29 +++++++++++++++++=
+---
> > > >  fs/fhandle.c                                | 20 ++++++++------
> > > >  fs/nfsd/nfsfh.c                             |  5 ++--
> > > >  fs/notify/fanotify/fanotify.c               |  4 +--
> > > >  fs/notify/fanotify/fanotify_user.c          |  6 ++---
> > > >  fs/notify/fdinfo.c                          |  2 +-
> > > >  include/linux/exportfs.h                    | 18 ++++++++++---
> > > >  include/uapi/linux/fcntl.h                  |  5 ++++
> > > >  9 files changed, 67 insertions(+), 26 deletions(-)
> > > >
> > >
> > > This set looks fairly benign to me, so ACK on the general concept.
> >
> > Me also (modulo previous review comments), so
> >
> >   Acked-by: Chuck Lever <chuck.lever@oracle.com>
> >
> > I assume either Amir or Jeff will take these when they are ready.
> > If I'm wrong, please do let me know and I can take them via the
> > NFSD tree.
> >
>
> With your and Jeff's ACKs I think it would be best if Jan takes
> these changes through the fsnotify tree, because they are only
> meant to improve fanotify at this point.
>
> >
> > > I am starting to dislike how the AT_* flags are turning into a bunch =
of
> > > flags that only have meanings on certain syscalls. I don't see a clea=
ner
> > > way to handle it though.
>
> With all the various proposals of file_handle_v2, I still think that the
> AT_HANDLE_FID is the cleanest in terms of API simplicity.
>
> Just trying to document file_handle_v2 and backward compat with
> file_handle_v1 gives me a headache and documenting AT_HANDLE_FID
> is a no brainer.
>

To prove my point, here is the man page draft for AT_HANDLE_FID:

https://github.com/amir73il/man-pages/commit/da7e8dc4749ced85ba692073a42724=
f2bbe5fe3b

Thanks,
Amir.
