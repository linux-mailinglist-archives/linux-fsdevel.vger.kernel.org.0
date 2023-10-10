Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B97C0020
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 17:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjJJPOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjJJPOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:14:40 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BDFB0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 08:14:38 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7b92cd0ccso14603627b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696950877; x=1697555677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kq068J4n8hFmSzBZLHqBsK/AsztOycnacRHGEEx3NQ=;
        b=cxMWwaeZX6AfwGPm19hOLGr/EQiJXnns6jyzVftmjNT8puutTirUqB3IjricuRTHUr
         itVrysJMDoPoJKgyHR98CyEyx1CAm/DSrkLlCveN2hYG3+u+7WV+si8nfWJR3OcBBOkM
         KuIVqxw431rN1ghJ1hg3vTklZmWBpLOEc9rbi6WzKBG19DC0690sLRYo6wRVQYYnU8UH
         ibad8KnE/2zXsbe9lidUfMhOdNy2BlMwZXYek6Gcre7xeREB4FYLlK3GpwbRvSE/xqlV
         9t8Pg1eK1NWJGp1xvTD32jz8QvZ03/181VHgjU0S6OJXNn+9xjtq8xGu3Opv+dlxsuyd
         lh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696950877; x=1697555677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kq068J4n8hFmSzBZLHqBsK/AsztOycnacRHGEEx3NQ=;
        b=roCj9pMjFYkYw79ChBiuSEvUxNjCLsaSC9HnblktVlfchiJk+LZrgiSZ3Ri0tX8fQd
         zNxFUEie2ls3GJHZCV837o/GVQP5I2AvySyFxczIrZDiLi5NisJ1Lvm0SxzGdPKUyted
         4dFd0w7Ampd62VOYNMQn+DnJMU0+++l43gTGcAfTptP9rhzGZ77mJFinj1Lf2WareqSz
         A2QaapB03bk1/uQbCDGNzKMdGHpF9Wzp4vXIMbdGa9XBmIb6T5315AZRdzelRqaN8XDw
         UWTJoVLqw+DZrDrA1aXlWNP9A+CZ3wcooSNmpU92kKDw/5mVLqP5VPVu74ALIM7/A1hA
         l8HQ==
X-Gm-Message-State: AOJu0YwdXidP3Yf9l6AuaQUL4ze0Iub2IUactdZDAnZHzxLOkTUBWF0w
        G5Py/g45N8Iqtf/dL6qM8/znMS6Uzf4ekaZ6ZclABCBrfWQ=
X-Google-Smtp-Source: AGHT+IHDNnJNKFcw3eofaqW77FHV73pG5zXnrGB2Nbl4lGdevJfceUkSajjfAmUK+0pMRn1YfTkoIEO4+k0lQYbQpdQ=
X-Received: by 2002:a25:870d:0:b0:d81:a721:d812 with SMTP id
 a13-20020a25870d000000b00d81a721d812mr18637334ybl.31.1696950877585; Tue, 10
 Oct 2023 08:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
 <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
 <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
 <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com>
 <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com>
 <CAJfpegvS_KPprPCDCQ-HyWfaVoM7M2ioJivrKYNqy0P0GbZ1ww@mail.gmail.com>
 <CAOQ4uxhkcZ8Qf+n1Jr0R8_iGoi2Wj1-ZTQ4SNooryXzxxV_naw@mail.gmail.com>
 <CAJfpegstwnUSCX1vf2VsRqE_UqHuBegDnYmqt5LmXdR5CNLAVg@mail.gmail.com>
 <CAOQ4uxhu0RXf7Lf0zthfMv9vUzwKM3_FUdqeqANxqUsA5CRa7g@mail.gmail.com>
 <CAOQ4uxjQx3nBPuWiS0upV_q9Qe7xW=iJDG8Wyjq+rZfvWC3NWw@mail.gmail.com> <CAJfpegtLAxY+vf18Yht+NPztv+wO9S28wyJp9MB_=yuAOSbCDA@mail.gmail.com>
In-Reply-To: <CAJfpegtLAxY+vf18Yht+NPztv+wO9S28wyJp9MB_=yuAOSbCDA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Oct 2023 18:14:26 +0300
Message-ID: <CAOQ4uxj1LvL+Gszag-3umA-YGLOhQBmC-WF6ks1v+upQUQNZ9w@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
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

On Tue, Oct 10, 2023 at 5:31=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sun, 8 Oct 2023 at 19:53, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Ok, posted your original suggestion for opt-in to fake path:
> > https://lore.kernel.org/linux-fsdevel/20231007084433.1417887-1-amir73il=
@gmail.com/
> >
> > Now the problem is that on FUSE_DEV_IOC_BACKING_OPEN ioctl,
> > the fake (fuse) path is not known.
> >
> > We can set the fake path on the first FOPEN_PASSTHROUGH response,
> > but then the whole concept of a backing id that is not bound to a
> > single file/inode
> > becomes a bit fuzzy.
> >
> > One solution is to allocate a backing_file container per fuse file on
> > FOPEN_PASSTHROUGH response.
>
> Right.   How about the following idea:
>
>  - mapping request is done with an O_PATH fd.
>  - fuse_open() always opens a backing file (just like overlayfs)
>

I think it makes sense and it is in the direction that FUSE BPF took
so that's good.

> The disadvantage is one more struct file (the third).  The advantage
> is that the server doesn't have to care about open flags, hence the
> mapping can always be per-inode.

I am fine with that.
One more struct file per inode is not that big of an overhead
and one backing file per fuse file is the same overhead as overlayfs.

Does it mean that we can drop backing_id's and use the "inode bound"
FUSE_BACKING_MAP_INODE mode to map the O_PATH fd to an inode,
where the FUSE_DEV_IOC_BACKING_OPEN ioctl takes a nodeid as
an input argument?

Or do you still think that we need the backing_id, so we can map
the same O_PATH fd to different inodes?

To me, one O_PATH fd per inode without any backing_id seems
like a simpler start.

Thanks,
Amir.
