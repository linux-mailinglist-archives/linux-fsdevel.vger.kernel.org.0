Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E38368BA67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 11:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjBFKgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 05:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjBFKgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:36:12 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20FD212AA
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Feb 2023 02:35:23 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qw12so32874933ejc.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Feb 2023 02:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m94BwFlFyXWtZKulAZnXL1PoyoyosxIVZsf57AOoJBg=;
        b=ExOavtExka8SfFVynRZ4vq6qJ2oveId7lwjHL8IoxKGNtstt74RgLFXLjmTJWMexEY
         NWLgHjxHtxEniPMSjo/sEKPRV5VdgsNgxHAOdqPbwnjTZBXgH0ZQ9NgBT8//hO1nHi+o
         /HXfnWx4/OHYSH0mEF2PjJNJ8VZRvTIhYsKPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m94BwFlFyXWtZKulAZnXL1PoyoyosxIVZsf57AOoJBg=;
        b=FfJZe0b67Q6tHddH1rsSb7mdxuXYwdTryk78hR96sejPsh0Hiv0q+PNM5L7xf5DyN3
         6ADbnQIzChDq5VhYY/dHE9h+XllhTu/HIgMxr/GrlL7KZcDpzhS/dZzSjJfdUsdfIcwx
         5BGCVSpP8UBcf/Icqzdb1KNCdSl1GRhYwEbvWesemD7+DBOyfNh8CQ8xPxtIBxLmxX0A
         Z/9CUvNNpYyaBmATBDIwVUvdu3+T6i6YM763f4eY5k/5c3/Wgm0mkofVFzych9CtqQP0
         RYThp/mxTXD1dO1bJo/Kx5hAXKqiP3x+jTxHNtkDwJIlv1xnv9jbs0gnBWoH24SGskoQ
         bk0w==
X-Gm-Message-State: AO0yUKW0sIY67J51rQLslNfYg0rYxuPrjLv037qa2b1aT08AuVfz+RG2
        oBGaBEJ+UbMkZyU84VkbZxxYlBdO+/6pICVxSstAoA==
X-Google-Smtp-Source: AK7set+XaoKc5dTEcN8lEeEcja5V5H79kYWduDZw/wEg2Vj4jId3c+YWtRAxWnMQm0s0cVPB9NfTMeF+9MYV8BewOBU=
X-Received: by 2002:a17:906:b7d7:b0:889:a006:7db5 with SMTP id
 fy23-20020a170906b7d700b00889a0067db5mr5648969ejb.138.1675679718373; Mon, 06
 Feb 2023 02:35:18 -0800 (PST)
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
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 Feb 2023 11:35:07 +0100
Message-ID: <CAJfpegtRacAoWdhVxCE8gpLVmQege4yz8u11mvXCs2weBBQ4jg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Larsson <alexl@redhat.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 5 Feb 2023 at 20:06, Amir Goldstein <amir73il@gmail.com> wrote:
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

Sorry about being late to the party...

Can you give a little detail about what exactly this does?

Thanks,
Miklos
