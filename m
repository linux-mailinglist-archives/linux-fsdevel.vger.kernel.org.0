Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B415168BE39
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 14:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBFNbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 08:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjBFNbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:31:14 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDA4241DD;
        Mon,  6 Feb 2023 05:31:11 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id h19so12605602vsv.13;
        Mon, 06 Feb 2023 05:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cTghmzthj1eVo6UlIcvmoqs3oAdOAJPrTblnEt4AALI=;
        b=jux8ze5nNE4HXD4lXcmwv5v6Ss7OTVtDtFSpsT4nJtTYJjLv++LiYnSoluCibfMRSH
         oGy+l9u/2dcfcIadR0lLmHP3V0Zw91EEqxTmNNjJiD2+TX80E6qm1AYAb0vIsh9ybiz/
         kKXrHA/LWmFpZCc5YKKD1wt6ImecGpj2iJBj/AItAGK0lZWd5f12YRUv3HJtHIJ3YrLI
         OXELvnZ0DQ2Oi/kB48ofRZSAsdrIwHUNU4v9g6VkzTyg6AE6ZYZlDVqHfdYKWMLfTMV3
         oMs1onsehU8RPbPv6FjpKa4bZ5KfUADmUDje9wJh9T6pI/6fHrl/bAWD0tyi4nm+7biU
         9jnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTghmzthj1eVo6UlIcvmoqs3oAdOAJPrTblnEt4AALI=;
        b=g23kKHUBYLf6/hBlMLCnca3/s/VVyN4Z9WKiN33qoIwmcf8JtVYkskkitMzom1Fh6J
         7lhxELhfu+wE/6M5gVSVL+YZw6BwnEz4K7glw23fWTK2R1S+DGZQ5Zo2iHBtJwGEzppt
         O2907p0Bj+XqMwGYB3OkNUQ7C2lgTA0QOf3xVA1eWkN07UIviQIRGhAmonfodI7zegz/
         nnjIv2SdM1O7APDrAU5BZs67ZohcwWgBJuItrzcoIu7nTYHbOvE1i2UMBvbp3Nl3iNND
         fEIdAPv+L/+yhbnVho0iVe3fWr4nYDH84myxkEOiDOZrmmiVXDJMOUAtbo9Y9RsJ8bqu
         vvLw==
X-Gm-Message-State: AO0yUKV9OH5aov242YCLprXjgxYxpQYWTpSUq5vTLxxE+ZkP6AFucoHr
        5tDxD9pChlNwAj4HNVNAe9u3wRJ2yYqhADvGubxDmDdDtw8=
X-Google-Smtp-Source: AK7set/56O2kwBcS7BFgA4V1nIRW3UlBxyYmCBSt5OmgwaqR8/OqXuiidSZCOrmNVExkg7LK+yvoe0zacbG3mHnmYwc=
X-Received: by 2002:a67:e1cb:0:b0:3e9:6d7f:6f37 with SMTP id
 p11-20020a67e1cb000000b003e96d7f6f37mr3024602vsl.3.1675690270849; Mon, 06 Feb
 2023 05:31:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com> <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com> <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
 <071074ad149b189661681aada453995741f75039.camel@redhat.com>
 <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com> <de57aefc-30e8-470d-bf61-a1cca6514988@linux.alibaba.com>
 <CAOQ4uxgS+-MxydqgO8+NQfOs9N881bHNbov28uJYX9XpthPPiw@mail.gmail.com>
 <9c8e76a3-a60a-90a2-f726-46db39bc6558@linux.alibaba.com> <02edb5d6-a232-eed6-0338-26f9a63cfdb6@linux.alibaba.com>
 <3d4b17795413a696b373553147935bf1560bb8c0.camel@redhat.com>
 <CAOQ4uxjNmM81mgKOBJeScnmeR9+jG_aWvDWxAx7w_dGh0XHg3Q@mail.gmail.com>
 <5fbca304-369d-aeb8-bc60-fdb333ca7a44@linux.alibaba.com> <CAOQ4uximQZ_DL1atbrCg0bQ8GN8JfrEartxDSP+GB_hFvYQOhg@mail.gmail.com>
 <CAJfpegtRacAoWdhVxCE8gpLVmQege4yz8u11mvXCs2weBBQ4jg@mail.gmail.com>
In-Reply-To: <CAJfpegtRacAoWdhVxCE8gpLVmQege4yz8u11mvXCs2weBBQ4jg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 Feb 2023 15:30:58 +0200
Message-ID: <CAOQ4uxiW0=DJpRAu90pJic0qu=pS6f2Eo7v-Uw3pmd0zsvFuuw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alexander Larsson <alexl@redhat.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > My little request again, could you help benchmark on your real workload
> > > rather than "ls -lR" stuff?  If your hard KPI is really what as you
> > > said, why not just benchmark the real workload now and write a detailed
> > > analysis to everyone to explain it's a _must_ that we should upstream
> > > a new stacked fs for this?
> > >
> >
> > I agree that benchmarking the actual KPI (boot time) will have
> > a much stronger impact and help to build a much stronger case
> > for composefs if you can prove that the boot time difference really matters.
> >
> > In order to test boot time on fair grounds, I prepared for you a POC
> > branch with overlayfs lazy lookup:
> > https://github.com/amir73il/linux/commits/ovl-lazy-lowerdata
>
> Sorry about being late to the party...
>
> Can you give a little detail about what exactly this does?
>

Consider a container image distribution system, with base images
and derived images and instruction on how to compose these images
using overlayfs or other methods.

Consider a derived image L3 that depends on images L2, L1.

With the composefs methodology, the image distribution server splits
each image is split into metadata only (metacopy) images M3, M2, M1
and their underlying data images containing content addressable blobs
D3, D2, D1.

The image distribution server goes on to merge the metadata layers
on the server, so U3 = M3 + M2 + M1.

In order to start image L3, the container client will unpack the data layers
D3, D2, D1 to local fs normally, but the server merged U3 metadata image
will be distributed as a read-only fsverity signed image that can be mounted
by mount -t composefs U3.img (much like mount -t erofs -o loop U3.img).

The composefs image format contains "redirect" instruction to the data blob
path and an fsverity signature that can be used to verify the redirected data
content.

When composefs authors proposed to merge composefs, Gao and me
pointed out that the same functionality can be achieved with minimal changes
using erofs+overlayfs.

Composefs authors have presented ls -lR time and memory usage benchmarks
that demonstrate how composefs performs better that erofs+overlayfs in
this workload and explained that the lookup of the data blobs is what takes
the extra time and memory in the erofs+overlayfs ls -lR test.

The lazyfollow POC optimizes-out the lowerdata lookup for the ls -lR
benchmark, so that composefs could be compared to erofs+overlayfs.

To answer Alexander's question:

> Cool. I'll play around with this. Does this need to be an opt-in
> option in the final version? It feels like this could be useful to
> improve performance in general for overlayfs, for example when
> metacopy is used in container layers.

I think lazyfollow could be enabled by default after we hashed out
all the bugs and corner cases and most importantly remove the
POC limitation of lower-only overlay.

The feedback that composefs authors are asking from you
is whether you will agree to consider adding the "lazyfollow
lower data" optimization and "fsverity signature for metacopy"
feature to overlayfs?

If you do agree, the I think they should invest their resources
in making those improvements to overlayfs and perhaps
other improvements to erofs, rather than proposing a new
specialized filesystem.

Thanks,
Amir.
