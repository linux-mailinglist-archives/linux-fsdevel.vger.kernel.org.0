Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F4F689901
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 13:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjBCMrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 07:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCMrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:47:04 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D116A9B6E7;
        Fri,  3 Feb 2023 04:46:59 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id ay40so189235uab.2;
        Fri, 03 Feb 2023 04:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cQTyr+wcRtbm/34X8EVigyLN5I1ioHQMUt6zGcrTA98=;
        b=dH6L9iurY5zAhbO23dxITbxaMXJtVS5PMKld7/bl2L6JVbZ7IxXu6LTDuHeSZHoB5B
         CBR1RlTuJ+WybrGXqeURws8qtnG3LKPqH+w6UqkJ7MMhjRdtvw5LOpdQl+9iZ4Ex9+IG
         t9/McfTiAaQq7DD5s4csxkm6gHF/wJn3O2STCTAJigaIos25P3ukQ29z6u6KmINbQ6M0
         owdUY0rxbTQ6C1mgS6Nc6+GmpU9a/IhAaCxR8uqkybvySXIieRJNnU13Cmgy+7UENZDx
         ruphhlH2N7SA+F481bvuQaBrFCf5CmUbZBKtdUUALqfUQi0DHmMppsotPNxcUB9nZbsY
         RnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQTyr+wcRtbm/34X8EVigyLN5I1ioHQMUt6zGcrTA98=;
        b=X/NbDUPIrPoi3creMYSE5GSVVA5Te4y6Ho2X96aLiplGUYjZ2DDlrT6M8w1F0Sy+d3
         NUsb8cAwWgpLuT0zSXCWCTmW6PVY1tSJ0P3YUR1ed13lTX8TuDTgRxTIo7hlzCnbAduE
         c+AesktL0bWicJuq2RwDUtGJT/o3p7vwDHvetFMpMFdJUu1WnQAwQ0rPzFxtAAqGVnAl
         E4Jh5kBHO8+2V6xV3U4Y9ASvRdRdloEFCXw4Vi32i968HWkD7o0P14Gz+V7tEgAz14eu
         +Yu5wf4p0Osd5Ug99+TuDLMPXb9sSvQw1ufQj0myW6rnyBYfFEWzi2TS39b+1wTUzNqZ
         up9Q==
X-Gm-Message-State: AO0yUKUDpaUVixDc7ju1lnCglGq1ZAbx+MiNx0KNBcfTmPeVv6sjCyvM
        fRwLxEPdz8AKg53gjU+ipOuHtimGxa97fdIauvc=
X-Google-Smtp-Source: AK7set/yvd2MttPhk2T3objVuV0nzcW2uzpYtU7HW+ti5JnN8SGfpEmK9KZLadg4SjtRBjea1O+zh/gyLiwF5Q5BjoI=
X-Received: by 2002:ab0:3903:0:b0:631:641a:ed3b with SMTP id
 b3-20020ab03903000000b00631641aed3bmr1552557uaw.13.1675428418730; Fri, 03 Feb
 2023 04:46:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
 <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
 <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com> <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com> <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
 <071074ad149b189661681aada453995741f75039.camel@redhat.com>
 <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com> <de57aefc-30e8-470d-bf61-a1cca6514988@linux.alibaba.com>
 <CAOQ4uxgS+-MxydqgO8+NQfOs9N881bHNbov28uJYX9XpthPPiw@mail.gmail.com>
 <9c8e76a3-a60a-90a2-f726-46db39bc6558@linux.alibaba.com> <02edb5d6-a232-eed6-0338-26f9a63cfdb6@linux.alibaba.com>
 <3d4b17795413a696b373553147935bf1560bb8c0.camel@redhat.com>
In-Reply-To: <3d4b17795413a696b373553147935bf1560bb8c0.camel@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 3 Feb 2023 14:46:46 +0200
Message-ID: <CAOQ4uxjNmM81mgKOBJeScnmeR9+jG_aWvDWxAx7w_dGh0XHg3Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Alexander Larsson <alexl@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
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

> > > > Engineering-wise, merging composefs features into EROFS
> > > > would be the simplest option and FWIW, my personal preference.
> > > >
> > > > However, you need to be aware that this will bring into EROFS
> > > > vfs considerations, such as  s_stack_depth nesting (which AFAICS
> > > > is not see incremented composefs?). It's not the end of the
> > > > world, but this
> > > > is no longer plain fs over block game. There's a whole new class
> > > > of bugs
> > > > (that syzbot is very eager to explore) so you need to ask
> > > > yourself whether
> > > > this is a direction you want to lead EROFS towards.
> > >
> > > I'd like to make a seperated Kconfig for this.  I consider this
> > > just because
> > > currently composefs is much similar to EROFS but it doesn't have
> > > some ability
> > > to keep real regular file (even some README, VERSION or Changelog
> > > in these
> > > images) in its (composefs-called) manifest files. Even its on-disk
> > > super block
> > > doesn't have a UUID now [1] and some boot sector for booting or
> > > some potential
> > > hybird formats such as tar + EROFS, cpio + EROFS.
> > >
> > > I'm not sure if those potential new on-disk features is unneeded
> > > even for
> > > future composefs.  But if composefs laterly supports such on-disk
> > > features,
> > > that makes composefs closer to EROFS even more.  I don't see
> > > disadvantage to
> > > make these actual on-disk compatible (like ext2 and ext4).
> > >
> > > The only difference now is manifest file itself I/O interface --
> > > bio vs file.
> > > but EROFS can be distributed to raw block devices as well,
> > > composefs can't.
> > >
> > > Also, I'd like to seperate core-EROFS from advanced features (or
> > > people who
> > > are interested to work on this are always welcome) and composefs-
> > > like model,
> > > if people don't tend to use any EROFS advanced features, it could
> > > be disabled
> > > from compiling explicitly.
> >
> > Apart from that, I still fail to get some thoughts (apart from
> > unprivileged
> > mounts) how EROFS + overlayfs combination fails on automative real
> > workloads
> > aside from "ls -lR" (readdir + stat).
> >
> > And eventually we still need overlayfs for most use cases to do
> > writable
> > stuffs, anyway, it needs some words to describe why such < 1s
> > difference is
> > very very important to the real workload as you already mentioned
> > before.
> >
> > And with overlayfs lazy lookup, I think it can be close to ~100ms or
> > better.
> >
>
> If we had an overlay.fs-verity xattr, then I think there are no
> individual features lacking for it to work for the automotive usecase
> I'm working on. Nor for the OCI container usecase. However, the
> possibility of doing something doesn't mean it is the better technical
> solution.
>
> The container usecase is very important in real world Linux use today,
> and as such it makes sense to have a technically excellent solution for
> it, not just a workable solution. Obviously we all have different
> viewpoints of what that is, but these are the reasons why I think a
> composefs solution is better:
>
> * It is faster than all other approaches for the one thing it actually
> needs to do (lookup and readdir performance). Other kinds of
> performance (file i/o speed, etc) is up to the backing filesystem
> anyway.
>
> Even if there are possible approaches to make overlayfs perform better
> here (the "lazy lookup" idea) it will not reach the performance of
> composefs, while further complicating the overlayfs codebase. (btw, did
> someone ask Miklos what he thinks of that idea?)
>

Well, Miklos was CCed (now in TO:)
I did ask him specifically about relaxing -ouserxarr,metacopy,redirect:
https://lore.kernel.org/linux-unionfs/20230126082228.rweg75ztaexykejv@wittgenstein/T/#mc375df4c74c0d41aa1a2251c97509c6522487f96
but no response on that yet.

TBH, in the end, Miklos really is the one who is going to have the most
weight on the outcome.

If Miklos is interested in adding this functionality to overlayfs, you are going
to have a VERY hard sell, trying to merge composefs as an independent
expert filesystem. The community simply does not approve of this sort of
fragmentation unless there is a very good reason to do that.

> For the automotive usecase we have strict cold-boot time requirements
> that make cold-cache performance very important to us. Of course, there
> is no simple time requirements for the specific case of listing files
> in an image, but any improvement in cold-cache performance for both the
> ostree rootfs and the containers started during boot will be worth its
> weight in gold trying to reach these hard KPIs.
>
> * It uses less memory, as we don't need the extra inodes that comes
> with the overlayfs mount. (See profiling data in giuseppes mail[1]).

Understood, but we will need profiling data with the optimized ovl
(or with the single blob hack) to compare the relevant alternatives.

>
> The use of loopback vs directly reading the image file from page cache
> also have effects on memory use. Normally we have both the loopback
> file in page cache, plus the block cache for the loopback device. We
> could use loopback with O_DIRECT, but then we don't use the page cache
> for the image file, which I think could have performance implications.
>

I am not sure this is correct. The loop blockdev page cache can be used,
for reading metadata, can it not?
But that argument is true for EROFS and for almost every other fs
that could be mounted with -oloop.
If the loopdev overhead is a problem and O_DIRECT is not a good enough
solution, then you should work on a generic solution that all fs could use.

> * The userspace API complexity of the combined overlayfs approach is
> much greater than for composefs, with more moving pieces. For
> composefs, all you need is a single mount syscall for set up. For the
> overlay approach you would need to first create a loopback device, then
> create a dm-verity device-mapper device from it, then mount the
> readonly fs, then mount the overlayfs.

Userspace API complexity has never been and will never be a reason
for making changes in the kernel, let alone add a new filesystem driver.
Userspace API complexity can be hidden behind a userspace expert library.
You can even create a mount.composefs helper that users can use
mount -t composefs that sets up erofs+overlayfs behind the scenes.

Similarly, mkfs.composefs can be an alias to mkfs.erofs with a specific
set of preset options, much like mkfs.ext* family.

> All this complexity has a cost
> in terms of setup/teardown performance, userspace complexity and
> overall memory use.
>

This claim needs to be quantified *after* the proposed improvements
(or equivalent hack) to existing subsystems.

> Are any of these a hard blocker for the feature? Not really, but I
> would find it sad to use an (imho) worse solution.
>

I respect your emotion and it is not uncommon for people to want
to see their creation merged as is, but from personal experience,
it is often a much better option for you, to have your code merge into
an existing subsystem. I think if you knew all the advantages, you
would have fought for this option yourself ;)

>
>
> The other mentioned approach is to extend EROFS with composefs
> features.  For this to be interesting to me it would have to include:
>
>  * Direct reading of the image from page cache (not via loopback)
>  * Ability to verify fs-verity digest of that image file
>  * Support for stacked content files in a set of specified basedirs
>    (not using fscache).
>  * Verification of expected fs-verity digest for these basedir files
>
> Anything less than this and I think the overlayfs+erofs approach is a
> better choice.
>
> However, this is essentially just proposing we re-implement all the
> composefs code with a different name. And then we get a filesystem
> supporting *both* stacking and traditional block device use, which
> seems a bit weird to me. It will certainly make the erofs code more
> complex having to support all these combinations. Also, given the harsh
> arguments and accusations towards me on the list I don't feel very
> optimistic about how well such a cooperation would work.
>

I understand why you write that  and I am sorry that you feel this way.
This is a good opportunity to urge you and Giuseppe again to request
an invite to LSFMM [1] and propose composefs vs. erofs+ovl as a TOPIC.

Meeting the developers in person is often the best way to understand each
other in situations just like this one where the email discussions fail to
remain on a purely technical level and our emotions get involved.
It is just too hard to express emotions accurately in emails and people are
so very often misunderstood when that happens.

I guarantee you that it is much more pleasant to argue with people over email
after you have met them in person ;)

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/Y9qBs82f94aV4%2F78@localhost.localdomain/
