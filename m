Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3BB68B6FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 09:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBFIA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 03:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjBFH7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:59:50 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B515AE3AB;
        Sun,  5 Feb 2023 23:59:49 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id e9so11785731vsj.3;
        Sun, 05 Feb 2023 23:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8slw0Qg+cMCp4bkGQF6pgeBTiY9FDkAbpzCDD9owIbw=;
        b=o311mvM7xuj9qYFltFA+bvO5GD5ReVKGiwcORLADYI9FBekAu2D3aA9+FxNNTScYbg
         AyKaArfMiZKthdee8YHkPL6YDmXma+Yhp4is0kL2r/pczE+v7l34nGR/ySqzWqNBmEWW
         oe60TWivbw9psWRFF5iWiDnN2TyMLdeu5UnHhPvXCwy8hjY6LsCmzxpYKbcjxfivqpFn
         TZpOeG8zCtMPrYPmNEEDQ9QXML0kVe8Zlk5Zan+JC/ZzmqTx0eJ3iUhXdLvZc3e4i8k5
         A5ymglmnXvx2nFRn6G9bx174NMG+j89V5wdYcildvDPxDAaW0iNzTstwbfw6NFN7VuOG
         IERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8slw0Qg+cMCp4bkGQF6pgeBTiY9FDkAbpzCDD9owIbw=;
        b=ftaLA6DUVpcV16vLU6Aw+jJzQMv/gvkKq4M5HzaX1hbvgpz2pokDDDXLJSRcIsdr6L
         U1AGup/g/4PUT28/l/XxSxYekkBbNNlbGCWGbS2lWk/cCBoQ06XgV6SKTpIFdy/Ud1tX
         k4Eod29/ekwu6mUcAb1eE3J3s9nU2RsnbkqXPffePON0+pDkN3nlEwTFGjdFxZBBrxfV
         FxVxT8sf/Sfa+U726Bki+H5eIvCz2uq3Kq/ttuhS7ZHx9xf/RWaKc9H4hCnhjPj1oUqV
         wlR4usmZFoLczcYUt8sN0fzt5YKSpxcOgQYL07RQh4mAAfXtBgm8borU0ipJ0wMe6Oe/
         Uraw==
X-Gm-Message-State: AO0yUKUcs8oJrJByz6Gf+62TgCoB+UCxIdvK/6DH3gpJ3ldH5lV5Nd3Q
        7fz02TxRtOzVV2ym/tLQI00saTlduOs0IUmuQ5r8nuF3kRY=
X-Google-Smtp-Source: AK7set9bV8S+WJMeOw91bdCx2PIVJuhlojGIRyaq9f5azWNPeXH/X2hfM5Z1xJTjHjDSQfNLjAcis8O+zeCYGRty9IY=
X-Received: by 2002:a67:e1cb:0:b0:3e9:6d7f:6f37 with SMTP id
 p11-20020a67e1cb000000b003e96d7f6f37mr2873948vsl.3.1675670388732; Sun, 05 Feb
 2023 23:59:48 -0800 (PST)
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
In-Reply-To: <CAOQ4uximQZ_DL1atbrCg0bQ8GN8JfrEartxDSP+GB_hFvYQOhg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 Feb 2023 09:59:36 +0200
Message-ID: <CAOQ4uxjDz93CNHJpenBzSNqsktnKg0NwpBV4LZ+dTDhKtbi5Vg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Alexander Larsson <alexl@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
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

On Sun, Feb 5, 2023 at 9:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > >>> Apart from that, I still fail to get some thoughts (apart from
> > >>> unprivileged
> > >>> mounts) how EROFS + overlayfs combination fails on automative real
> > >>> workloads
> > >>> aside from "ls -lR" (readdir + stat).
> > >>>
> > >>> And eventually we still need overlayfs for most use cases to do
> > >>> writable
> > >>> stuffs, anyway, it needs some words to describe why such < 1s
> > >>> difference is
> > >>> very very important to the real workload as you already mentioned
> > >>> before.
> > >>>
> > >>> And with overlayfs lazy lookup, I think it can be close to ~100ms or
> > >>> better.
> > >>>
> > >>
> > >> If we had an overlay.fs-verity xattr, then I think there are no
> > >> individual features lacking for it to work for the automotive usecase
> > >> I'm working on. Nor for the OCI container usecase. However, the
> > >> possibility of doing something doesn't mean it is the better technical
> > >> solution.
> > >>
> > >> The container usecase is very important in real world Linux use today,
> > >> and as such it makes sense to have a technically excellent solution for
> > >> it, not just a workable solution. Obviously we all have different
> > >> viewpoints of what that is, but these are the reasons why I think a
> > >> composefs solution is better:
> > >>
> > >> * It is faster than all other approaches for the one thing it actually
> > >> needs to do (lookup and readdir performance). Other kinds of
> > >> performance (file i/o speed, etc) is up to the backing filesystem
> > >> anyway.
> > >>
> > >> Even if there are possible approaches to make overlayfs perform better
> > >> here (the "lazy lookup" idea) it will not reach the performance of
> > >> composefs, while further complicating the overlayfs codebase. (btw, did
> > >> someone ask Miklos what he thinks of that idea?)
> > >>
> > >
> > > Well, Miklos was CCed (now in TO:)
> > > I did ask him specifically about relaxing -ouserxarr,metacopy,redirect:
> > > https://lore.kernel.org/linux-unionfs/20230126082228.rweg75ztaexykejv@wittgenstein/T/#mc375df4c74c0d41aa1a2251c97509c6522487f96
> > > but no response on that yet.
> > >
> > > TBH, in the end, Miklos really is the one who is going to have the most
> > > weight on the outcome.
> > >
> > > If Miklos is interested in adding this functionality to overlayfs, you are going
> > > to have a VERY hard sell, trying to merge composefs as an independent
> > > expert filesystem. The community simply does not approve of this sort of
> > > fragmentation unless there is a very good reason to do that.
> > >
> > >> For the automotive usecase we have strict cold-boot time requirements
> > >> that make cold-cache performance very important to us. Of course, there
> > >> is no simple time requirements for the specific case of listing files
> > >> in an image, but any improvement in cold-cache performance for both the
> > >> ostree rootfs and the containers started during boot will be worth its
> > >> weight in gold trying to reach these hard KPIs.
> > >>
> > >> * It uses less memory, as we don't need the extra inodes that comes
> > >> with the overlayfs mount. (See profiling data in giuseppes mail[1]).
> > >
> > > Understood, but we will need profiling data with the optimized ovl
> > > (or with the single blob hack) to compare the relevant alternatives.
> >
> > My little request again, could you help benchmark on your real workload
> > rather than "ls -lR" stuff?  If your hard KPI is really what as you
> > said, why not just benchmark the real workload now and write a detailed
> > analysis to everyone to explain it's a _must_ that we should upstream
> > a new stacked fs for this?
> >
>
> I agree that benchmarking the actual KPI (boot time) will have
> a much stronger impact and help to build a much stronger case
> for composefs if you can prove that the boot time difference really matters.
>
> In order to test boot time on fair grounds, I prepared for you a POC
> branch with overlayfs lazy lookup:
> https://github.com/amir73il/linux/commits/ovl-lazy-lowerdata
>
> It is very lightly tested, but should be sufficient for the benchmark.
> Note that:
> 1. You need to opt-in with redirect_dir=lazyfollow,metacopy=on
> 2. The lazyfollow POC only works with read-only overlay that
>     has two lower dirs (1 metadata layer and one data blobs layer)
> 3. The data layer must be a local blockdev fs (i.e. not a network fs)
> 4. Only absolute path redirects are lazy (e.g. "/objects/cc/3da...")
Forgot to mention that
5. The redirect path should be a realpath within the local fs -
    symlinks are not followed.

>
> These limitations could be easily lifted with a bit more work.
> If any of those limitations stand in your way for running the benchmark
> let me know and I'll see what I can do.
>
> If there is any issue with the POC branch, please let me know.
>

Thanks,
Amir.
