Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89987B4E3E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 10:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbjJBI5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 04:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbjJBI5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:57:15 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ED3CD0
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 01:53:35 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-45456121514so3680826137.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696236814; x=1696841614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFWzK8RV7OdbpTIqxieo4id1ibt8jTOvrir6WVA6tSA=;
        b=DaZGtpFRNYyzNdMDGNhD6TbdAARHyrdTLHnEIBf5E0uHbP6BcZUnuMogy8HQx6t7QU
         UBqWEWslwkwii5Bfbd7vSoJM+R3roqAfJoQ2UjkfbPsg+UpxmOcMWsILNAzUT24278U5
         g70dZ37oHJ0yYkGNrUMgpnSRWpp4wMWEXVO1U7mNy6GdZJaSUQF8+iyfyTuofCN3gtKb
         Y0H2+55ydMSQLYe/Jd+sxPT5yDDTsZVkwDhcngKMPLd7hlL3xtwe6kg7PWLA113uAX44
         uJyF6kamkJKxh2qHyOznlYbrfiOEFhW3Tp6EOtoYYcB/utSes5zTHD7tAo6t60Q9dcS6
         XBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696236814; x=1696841614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFWzK8RV7OdbpTIqxieo4id1ibt8jTOvrir6WVA6tSA=;
        b=RLg7wAv/f/4XZ8uGIt+Lfu7r0Q60ypxZHQfQtYPtQT6jPtPLW0KHZwRMYA4d/V7mk2
         QjDPhwmOK1sy2zIvuYRpq/geHwbW2F4mI3kjT2M9XYUzdJu8/0orfPJ6qejqvgfHVHvY
         fB5hrHuD0HQ2EJTcTosYTYUqk+u82dQBh2CBvz2Nfkx9j08WQf1ha+2V7dGSFnwOMozF
         /KnKoHGLW9/khnC3hf5VbPxa7Wo196d+5PMrgTTD+SCle9dRz1X9/F6yzIcvJphxJ3kN
         0jcVs4bS2kKkrQrIWzUmM1gIYVLVNgoM8ijxBFRTIxpeuYCpUI7OHZNlQ8MaG8u5bppX
         LfbQ==
X-Gm-Message-State: AOJu0YwsSBDpDuweRrtsyCM0gEcHyUwotVoh/NkjkA4QHz64j82CGs6F
        bi9ygFhGX1Ihl7zh7xIl+Pd50PmgV3gdZ1q3ydo=
X-Google-Smtp-Source: AGHT+IFXHXnxF8wx+S3ghEKSFJNXEzsv1SherDYtLCPdufb5WgO/irEyNQVVdB0jhbQASfMpX7KP3w9m3EDspjU6U5w=
X-Received: by 2002:a67:fa10:0:b0:452:c5b5:e666 with SMTP id
 i16-20020a67fa10000000b00452c5b5e666mr9846128vsq.34.1696236814022; Mon, 02
 Oct 2023 01:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231002022815.GQ800259@ZenIV> <20231002022846.GA3389589@ZenIV>
 <20231002023613.GN3389589@ZenIV> <20231002023643.GO3389589@ZenIV>
 <20231002023711.GP3389589@ZenIV> <CAOQ4uxjAcKVGT03uDTNYiSoG2kSgT9eqbqjBThwTo7pF0jef4g@mail.gmail.com>
 <20231002072332.GV800259@ZenIV>
In-Reply-To: <20231002072332.GV800259@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 2 Oct 2023 11:53:23 +0300
Message-ID: <CAOQ4uxgPrfsJc6g6W4Q2b-SRSvNpih7NHrV4vybQzrWFa_4rOA@mail.gmail.com>
Subject: Re: [PATCH 15/15] overlayfs: make use of ->layers safe in rcu pathwalk
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
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

On Mon, Oct 2, 2023 at 10:23=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Mon, Oct 02, 2023 at 09:40:15AM +0300, Amir Goldstein wrote:
> > On Mon, Oct 2, 2023 at 5:37=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> > >
> > > ovl_permission() accesses ->layers[...].mnt; we can't have ->layers
> > > freed without an RCU delay on fs shutdown.  Fortunately, kern_unmount=
_array()
> > > used to drop those mounts does include an RCU delay, so freeing is
> > > delayed; unfortunately, the array passed to kern_unmount_array() is
> > > formed by mangling ->layers contents and that happens without any
> > > delays.
> > >
> > > Use a separate array instead; local if we have a few layers,
> > > kmalloc'ed if there's a lot of them.  If allocation fails,
> > > fall back to kern_unmount() for individual mounts; it's
> > > not a fast path by any stretch of imagination.
> >
> > If that is the case, then having 3 different code paths seems
> > quite an excessive over optimization...
> >
> > I think there is a better way -
> > layout the mounts array linearly in ofs->mounts[] to begin with,
> > remove .mnt out of ovl_layer and use ofs->mounts[layer->idx] to
> > get to a layer's mount.
> >
> > I can try to write this patch to see how it ends up looking.
>
> Fine by me; about the only problem I see is the cache footprint...

I've also considered just allocating the extra space for
ofs->mounts[] at super creation time rather than on super destruction.
I just cannot get myself to be bothered with this cleanup code
because of saving memory of ovl_fs.

However, looking closer, we have a wasfull layer->name pointer,
which is only ever used for ovl_show_options() (to print the original
requested layer path from mount options).

So I am inclined to move these rarely accessed pointers to
ofs->layer_names[], which can be used for the temp array for
kern_unmount_array() because freeing name does not need
RCU delay AFAICT (?).

I will take a swing at it.

> How many layers do you consider the normal use, actually?

Define "normal".
Currently, we have #define OVL_MAX_STACK 500
and being able to create an overlay with many layers was
cited as one of the requirements to drive the move to new mount api:

https://lore.kernel.org/linux-unionfs/20230605-fs-overlayfs-mount_api-v3-0-=
730d9646b27d@kernel.org/

I am not really familiar with the user workloads that need that many layers
and why. It's obviously not the common case.

Thanks,
Amir.
