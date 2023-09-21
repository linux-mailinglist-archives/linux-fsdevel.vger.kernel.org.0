Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0DE7A9A55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjIUSi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjIUSho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:37:44 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64856D9D08
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:30:41 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6c4a25f6390so399582a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695321040; x=1695925840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvWLyFCcepLx9P5Fv+ZQeo8QGk+ui/ICUJ0lmWwYeFI=;
        b=DHEf5fDP/qKFe89knPhf0fpODUb2F8Zqa/YqTboRmO8C2Nu+hZcbC8z0yo8rElE5AY
         TJaka4nR5A6nTtlO3ZzVuE1i8lqTaQh/zvvCg9pFCUGsbeKt867CO3xcxB42cQrLsJEe
         7j5baXBmqhI7ZtBDsJFLjcriSC7Zir6bZCJ/S9HcAzg9daq7/F6uqErdwrni4caEQ3aL
         yywi8M3/+nqZvksA2hLArKi5BUDvS+PDiINZmjR07gAx8pnRsYYeBv4yFCw7jq0e8KBG
         hP4V4eGpPPEhvFnC1HhvkpgNAmU/CVsWPV/P7kDDUogsPQPSPL1AnJDaNwfki4acg4fi
         0nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321040; x=1695925840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvWLyFCcepLx9P5Fv+ZQeo8QGk+ui/ICUJ0lmWwYeFI=;
        b=OVTSbnNeb/H5q+7RNOTX9HIoCDGMtiuze41ep4q9oaj8+5HwTjguLMFtymFTEpUyyh
         9Ao76xx8uzu4ABpTHaPIUEE1mnZNmm+qfWu/rAwUbVajFZnOMrRnSvw1di6zjwI8pjj5
         r0KgpMioHHy7yEJY77KyI+5xgtEYiRSA7ZpLdSd1dkkSoiqgj7l+Z2drXmWq03o7TP6q
         kmUYce4L+OrJ9QpoNcncVkFlyjMfBc2CNezIBBumg2BzNDzHGnrnqNAKSzRdddDNAtK2
         GFLuw6dvyuoJGfGhH2vHkF4fFoe5MD/xsrs92f+DYOT/yFOsYUZ5Z7pbLk92V94pWzOR
         A/ng==
X-Gm-Message-State: AOJu0Yx6Vgj1Pg0p/1IEQVhpL+smJVvx9CWMHKOCFPq7bIGkqYV/vcZY
        GLHy0EnD8MEO1qGnAUP+cyblJYawg0R6erkVKYvOsZ8VA1Q=
X-Google-Smtp-Source: AGHT+IEcPAabxdAmzGXWjb3mZYE3jTwA/7Fd9Lyw2fSviSGiLkPHCoVtzD+OyeaKRzIPtyUutYfhT1XcRZh1BCjAEpk=
X-Received: by 2002:a67:f887:0:b0:451:124:2bb2 with SMTP id
 h7-20020a67f887000000b0045101242bb2mr4487712vso.1.1695287870843; Thu, 21 Sep
 2023 02:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
 <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
 <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com> <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com>
In-Reply-To: <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Sep 2023 12:17:39 +0300
Message-ID: <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:21=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Thu, 21 Sept 2023 at 09:33, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > In my example, the server happens to setup the mapping
> > of the backing file to inode
> > *before the first open for read on the inode*
> > and to teardown the mapping
> > *after the last close on the inode* (not even last rdonly file close)
> > but this is an arbitrary implementation choice of the server.
>
> Okay.
>
> So my question becomes: is this flexibility really needed?
>
> I understand the need to set up the mapping on open.   I think it also
> makes sense to set up the mapping on lookup, since then OPEN/RELEASE
> can be omitted.
>
> Removing the mapping at a random point int time might also make sense,
> because of limitation on the number of open files, but that's
> debatable.
>
> What I'm getting at is that I'd prefer the ioctl to just work one way:
> register a file and return a ID. Then there would be ways to associate
> that ID with an inode (in LOOKUP or OPEN) or with an open file (in
> OPEN).

With my current kernel implementation, this change implies changing
the lifetime rules of fuse_backing object, so that last put will also
remove the backing_id from idr.
It complicates things a bit and is not needed IMO (see below).

The thing that I am concerned about is the complexity of
the AUTO_CLOSE semantics for per-inode and per-file.
IOW, explaining who owns the backing_id becomes more complex
to understand and communicate in a simple API.

I was aiming for a simple to use API and I think my example
demonstrates two modes that are simple to use and even
the server managed backing_id mode would be simple to use.

I don't mind dropping the "inode bound" patch altogether
and staying with server managed backing_id without support
for auto-close-on-evict and only support per-file-auto-close
as is already implemented in my POC.

IWO, if the server want to associate a backing file id with an
inode on LOOKUP or on open, it has no problem is keeping
this association in the server internally, replying to any open
with the backing_id that it associated and closing the
backing_id on FORGET or on the last close.

I see no real gain in the kernel handling the inode-backing_id
association for the server. At least not until this association is
needed to passthough inode operations and in that case
server would probably mapping an O_PATH fd to the inode.

I can easily change my example to work like that and drop the
"inode bound" backing file patch.

In fact, it will make the example even more flexible, because
the server can keep 2 files per inode, one rdonly and one rdwr
(same as the kernel nfsd v3 open files cache does) and for the
example, we could let any open request with non trivial flags
(i.e. O_SYNC) use a per-file-auto-close backing file.

>
> Can you please also remind me why we need the per-open-file mapping
> mode?  I'm sure that we've discussed this, but my brain is like a
> sieve...

Different FUSE files may have different open flags
(e.g. O_RDONLY/O_RDWR/O_SYNC) so server may want to use
different backing files for different FUSE files on the same inode,
but perhaps this is not what you were asking?

Thanks,
Amir.
