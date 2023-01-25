Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F0F67AFE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 11:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjAYKn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 05:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjAYKnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:43:25 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEA97A9D;
        Wed, 25 Jan 2023 02:43:23 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id i185so19355801vsc.6;
        Wed, 25 Jan 2023 02:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5syxfjTKp4jnhM5s/DjT919ih8t8R4fS/QwMr687tDQ=;
        b=gF5kBKbwR+Ai+n1WCm8Qf+F9nf5+GdzqemY5pZV+pwJpoP2FZQA/bW4rr0kOc6z8BY
         jCKhIOTtO3lwtU+1VNErWpu5GUOsEa92M3R34Btt4HgMm9uHu9tpPQhietRncT8WTrX5
         1l/cS/KO8wtCBgJvFErUsTeIr1uZq6/3oLLOXAse5HqcatAMe9KJ/Rmmjias4L+rUbFx
         vLUEManRzTC7/YPVRwUIQsyjLSH6LY596kope7oESEEkMbIBnVDqSOmnhBCdcwtc+uEw
         4yXwGqQr39ipZVpqItaE8yoxpmVOqIJPzfU2hriwcXsox9bW72wPfc3yFKBX89Hb2mcP
         PIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5syxfjTKp4jnhM5s/DjT919ih8t8R4fS/QwMr687tDQ=;
        b=H8E8eb5Aqv98zVedTYmuYZtPk7YDkYWags3ZenFInol2o1jRwF8HVpVb6WZom9GH/L
         wldCPnTxl0+TrLWSpY/BXHi/9vzZ0WY2myCMm201ZBzNb7L+FCg3PG7Waq6oeyd3ynEx
         mE949VX+6wUpXs3H3Hd/okmRLXSsyzpfC9bQJANLMMFbq4HHtQYz3V1/5vBJ91Vq0sAj
         lYy+xuNYwO0/pB5xNbloRn8EP84Gz4ceq/IWtGKXiqsYv6A6RK7ox9WqDPLoqazQ13CF
         9rsK+cygST7b6q8/jrfPKcA1HOdr43VjjMRIIanDUy9EjwOLP0T/u+5y0d4+kUlWWNWB
         KmQA==
X-Gm-Message-State: AFqh2kriQDU9j/3ejFRtxWv7Dawi8EbcI8GRF3UiBpAMEzJ0HqgFER7C
        e283kd2XICPTp2h3sphhN0HEGUsGwQOrzQLYN1g=
X-Google-Smtp-Source: AMrXdXsMjL3OSFAMkJGJh+3Mfqj1r0cZd52PQV3a5mcJe0OZueFMR/DUitA4Q0kWz+sTk87hu9fMJBWng1LDcyiQOAY=
X-Received: by 2002:a05:6102:5587:b0:3d1:2167:11ad with SMTP id
 dc7-20020a056102558700b003d1216711admr3958357vsb.2.1674643402914; Wed, 25 Jan
 2023 02:43:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <20230125041835.GD937597@dread.disaster.area> <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
 <ef68afb508f85eebb40fa3926edbff145e831c63.camel@redhat.com>
In-Reply-To: <ef68afb508f85eebb40fa3926edbff145e831c63.camel@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Jan 2023 12:43:10 +0200
Message-ID: <CAOQ4uxiVLJrMuEWT6oWDoFV3BzrxabvR3A-_K2HLR8V6Taxn4A@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Alexander Larsson <alexl@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
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

On Wed, Jan 25, 2023 at 12:08 PM Alexander Larsson <alexl@redhat.com> wrote:
>
> On Wed, 2023-01-25 at 10:32 +0200, Amir Goldstein wrote:
> > On Wed, Jan 25, 2023 at 6:18 AM Dave Chinner <david@fromorbit.com>
> > wrote:
> > >
> > >
> > >
> > > I've already described the real world production system bottlenecks
> > > that composefs is designed to overcome in a previous thread.
> > >
> > > Please go back an read this:
> > >
> > > https://lore.kernel.org/linux-fsdevel/20230118002242.GB937597@dread.disaster.area/
> > >
> >
> > I've read it and now re-read it.
> > Most of the post talks about the excess time of creating the
> > namespace,
> > which is addressed by erofs+overlayfs.
> >
> > I guess you mean this requirement:
> > "When you have container instances that might only be needed for a
> > few seconds, taking half a minute to set up the container instance
> > and then another half a minute to tear it down just isn't viable -
> > we need instantiation and teardown times in the order of a second or
> > two."
> >
> > Forgive for not being part of the containers world, so I have to ask
> > -
> > Which real life use case requires instantiation and teardown times in
> > the order of a second?
> >
> > What is the order of number of files in the manifest of those
> > ephemeral
> > images?
> >
> > The benchmark was done on a 2.6GB centos9 image.
>
> What does this matter? We want to measure a particular kind of
> operation, so, we use a sample with a lot of those operations. What
> would it help running some operation on a smaller image that does much
> less of the critical operations. That would just make it harder to see
> the data for all the noise. Nobody is saying that reading all the
> metadata in a 2.6GB image is something a container would do. It is
> however doing lots of the operations that constrains container startup,
> and it allows us to compare the performance of these operation between
> different alternatives.
>

When talking about performance improvements sometimes the
absolute numbers matter just as well as the percentage.
You write that:
"The primary KPI is cold boot performance, because there are
 legal requirements for the entire system to boot in 2 seconds."
so the size of the image does matter.

If for the automotive use case, a centos9-like image needs to boot
in 2 seconds and you show that you can accomplish that with
composefs and cannot accomplish that with overlayfs+composefs
then you have a pretty strong argument, with very few performance
numbers ;-)

> > My very minimal understanding of containers world, is that
> > A large centos9 image would be used quite often on a client so it
> > would be deployed as created inodes in disk filesystem
> > and the ephemeral images are likely to be small changes
> > on top of those large base images.
> >
> > Furthermore, the ephmeral images would likely be composed
> > of cenos9 + several layers, so the situation of single composefs
> > image as large as centos9 is highly unlikely.
> >
> > Am I understanding the workflow correctly?
>
> In a composefs based container storage implementation one would likely
> not use a layered approach for the "derived" images. Since all file
> content is shared anyway its more useful to just combine the metadata
> of the layers into a single composefs image. It is not going to be very
> large anyway, and it will make lookups much faster as you don't need to
> do all the negative lookups in the upper layers when looking for files
> in the base layer.
>

Aha! that is something that wasn't clear to me - that the idea is to
change the image distribution so that there are many "data layers"
but the "metadata layers" are merged on the server, so the client
uses only one.

Maybe I am slow and maybe this part needs to be explained better.

> > If I am, then I would rather see benchmarks with images
> > that correspond with the real life use case that drives composefs,
> > such as small manifests and/or composefs in combination with
> > overlayfs as it would be used more often.
>
> I feel like there is a constant moving of the goal post here. I've
> provided lots of raw performance numbers, and explained that they are
> important to our usecases, there has to be an end to how detailed they
> need to be. I'm not interested in implementing a complete container
> runtime based on overlayfs just to show that it performs poorly.
>

Alexander, be patient. This is the process everyone that wants to
upstream a new fs/subsystem/feature has to go through and
everyone that wants to publish an academic paper has to go through.

The reviewers are also in a learning process and you cannot expect
reviewers to have all the questions ready for you on V1 and not
have other questions pop up as their understanding of the problem
space evolves.

Note that my request was conditional to "if my understanding of the
workflow is correct".

Since you explained that your workflow does not include overlayfs
you do not need to provide the benchmark of overlayfs+composefs,
but if you intend to use the argument that
"It is also quite typical to have shortlived containers in cloud workloads,
 and startup time there is very important."
then you have to be honest about it and acknowledge that those short
lived containers are not readonly, so if you want to use this use case
when arguing for composefs, please do provide the performance
numbers that correspond with this use case.


> > > Cold cache performance dominates the runtime of short lived
> > > containers as well as high density container hosts being run to
> > > their container level memory limits. `ls -lR` is just a
> > > microbenchmark that demonstrates how much better composefs cold
> > > cache behaviour is than the alternatives being proposed....
> > >
> > > This might also help explain why my initial review comments
> > > focussed
> > > on getting rid of optional format features, straight lining the
> > > processing, changing the format or search algorithms so more
> > > sequential cacheline accesses occurred resulting in less memory
> > > stalls, etc. i.e. reductions in cold cache lookup overhead will
> > > directly translate into faster container workload spin up.
> > >
> >
> > I agree that this technology is novel and understand why it results
> > in faster cold cache lookup.
> > I do not know erofs enough to say if similar techniques could be
> > applied to optimize erofs lookup at mkfs.erofs time, but I can guess
> > that this optimization was never attempted.
>
> > > > > >
> On the contrary, erofs lookup is very similar to composefs. There is
> nothing magical about it, we're talking about pre-computed, static
> lists of names. What you do is you sort the names, put them in a
> compact seek-free form, and then you binary search on them. Composefs
> v3 has some changes to make larger directories slightly more efficient
> (no chunking), but the general performance should be comparable.
>
> I believe Gao said that mkfs.erofs could do slightly better at how data
> arranged so that related things are closer to each other. That may help
> some, but I don't think this is gonna be a massive difference.

Cool, so for readonly images, it is down to a performance comparison
of overlayfs vs. composefs and to be fair overlayfs will also have a single
upper metadata layer.

May the best fs win!

Thanks,
Amir.
