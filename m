Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D4A6875F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 07:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjBBGhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 01:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBBGhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:37:51 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB76DB07;
        Wed,  1 Feb 2023 22:37:50 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id i185so808700vsc.6;
        Wed, 01 Feb 2023 22:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oUrgmR2JpDzxHH9f6uB2VCUzu/st6c355nkUP38ricU=;
        b=HjysaVpAq5PlV0enuBBVth9Z1UyzYeDqjduG5kh2xUlLfg5k6J5kjBbL0fnTONRSjq
         oKITtMEviHye7MZ2pMFQbyH+lRWAz/Eb0hy0cj++Hm/ZkTPVPb1fsOUOiBi1Z7X56IMd
         UZM7MpzVmkR4BTFOjluZ75/D0N2HhvnHhAfYfXHKHl3nCApLJogJeJiGWFxclhZsu8OE
         9tTnuSEIi8AL4T7Di1VI0lbwDGE/VKnI2cPb2Px+XRGBXB3u22vKFx1cQsGEYu4sBaWP
         O46HFY6wmcz2hvQbCO4D/y/tvXkh1DM2X32dK0yAKyA7kp1HAdZk2cAU3n9ur+AuOLp5
         oMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUrgmR2JpDzxHH9f6uB2VCUzu/st6c355nkUP38ricU=;
        b=FcH0Q4OpncOsO8ddTnkwrr3B+1OtWdyBaEAHQOLnPBgL1+ACjUmxRiy+TOI+qDBnZs
         i0TJ/DSuko4C972onRqLtyry5iGqqNJIsTOloxcgmj2KyelXrFWLXrctjZMY9H2JrCVl
         9Q4vmgLTHBghb77sDrmacoU4jRI+umnEd3NUR9NCChQDpmPrnbo5a5mrqzx+YUcqrJhZ
         GJbW6SyJdrrpx1IjbAVvYnJ38Vqxt+H6zzXZ7ruFG7eqQsKnygT1rtb+PonepGy5VS32
         YMHVeGVg03UcVUYQfUOUgL9OvoqVCghkHHvUzPF4U3F30G1R5UDucG8FopNpzjhgH2XY
         HI2g==
X-Gm-Message-State: AO0yUKUmkJbrCjBVDNnUlaI5qzKLDPQdr0+gDUc71hFYTXJRtgPFaszS
        9KZBB6iTo2+YZp0RCMhMMElRbvEMy/RkwO/NG8g=
X-Google-Smtp-Source: AK7set9bs7YOIEA4qd6yKWxxUmS4rXaCbjmJ/E+0tFqRevT30FW1YPooSjhB0XhFrHtpnKZKHQqPr52I+5aPemvAF3U=
X-Received: by 2002:a67:e102:0:b0:3f0:89e1:7c80 with SMTP id
 d2-20020a67e102000000b003f089e17c80mr721383vsl.72.1675319869330; Wed, 01 Feb
 2023 22:37:49 -0800 (PST)
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
In-Reply-To: <de57aefc-30e8-470d-bf61-a1cca6514988@linux.alibaba.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 Feb 2023 08:37:37 +0200
Message-ID: <CAOQ4uxgS+-MxydqgO8+NQfOs9N881bHNbov28uJYX9XpthPPiw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
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

On Wed, Feb 1, 2023 at 1:22 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
>
>
> On 2023/2/1 18:01, Gao Xiang wrote:
> >
> >
> > On 2023/2/1 17:46, Alexander Larsson wrote:
> >
> > ...
> >
> >>>
> >>>                                    | uncached(ms)| cached(ms)
> >>> ----------------------------------|-------------|-----------
> >>> composefs (with digest)           | 326         | 135
> >>> erofs (w/o -T0)                   | 264         | 172
> >>> erofs (w/o -T0) + overlayfs       | 651         | 238
> >>> squashfs (compressed)                | 538         | 211
> >>> squashfs (compressed) + overlayfs | 968         | 302
> >>
> >>
> >> Clearly erofs with sparse files is the best fs now for the ro-fs +
> >> overlay case. But still, we can see that the additional cost of the
> >> overlayfs layer is not negligible.
> >>
> >> According to amir this could be helped by a special composefs-like mode
> >> in overlayfs, but its unclear what performance that would reach, and
> >> we're then talking net new development that further complicates the
> >> overlayfs codebase. Its not clear to me which alternative is easier to
> >> develop/maintain.
> >>
> >> Also, the difference between cached and uncached here is less than in
> >> my tests. Probably because my test image was larger. With the test
> >> image I use, the results are:
> >>
> >>                                    | uncached(ms)| cached(ms)
> >> ----------------------------------|-------------|-----------
> >> composefs (with digest)           | 681         | 390
> >> erofs (w/o -T0) + overlayfs       | 1788        | 532
> >> squashfs (compressed) + overlayfs | 2547        | 443
> >>
> >>
> >> I gotta say it is weird though that squashfs performed better than
> >> erofs in the cached case. May be worth looking into. The test data I'm
> >> using is available here:
> >
> > As another wild guess, cached performance is a just vfs-stuff.
> >
> > I think the performance difference may be due to ACL (since both
> > composefs and squashfs don't support ACL).  I already asked Jingbo
> > to get more "perf data" to analyze this but he's now busy in another
> > stuff.
> >
> > Again, my overall point is quite simple as always, currently
> > composefs is a read-only filesystem with massive symlink-like files.
> > It behaves as a subset of all generic read-only filesystems just
> > for this specific use cases.
> >
> > In facts there are many options to improve this (much like Amir
> > said before):
> >    1) improve overlayfs, and then it can be used with any local fs;
> >
> >    2) enhance erofs to support this (even without on-disk change);
> >
> >    3) introduce fs/composefs;
> >
> > In addition to option 1), option 2) has many benefits as well, since
> > your manifest files can save real regular files in addition to composefs
> > model.
>
> (add some words..)
>
> My first response at that time (on Slack) was "kindly request
> Giuseppe to ask in the fsdevel mailing list if this new overlay model
> and use cases is feasable", if so, I'm much happy to integrate in to
> EROFS (in a cooperative way) in several ways:
>
>   - just use EROFS symlink layout and open such file in a stacked way;
>
> or (now)
>
>   - just identify overlayfs "trusted.overlay.redirect" in EROFS itself
>     and open file so such image can be both used for EROFS only and
>     EROFS + overlayfs.
>
> If that happened, then I think the overlayfs "metacopy" option can
> also be shown by other fs community people later (since I'm not an
> overlay expert), but I'm not sure why they becomes impossible finally
> and even not mentioned at all.
>
> Or if you guys really don't want to use EROFS for whatever reasons
> (EROFS is completely open-source, used, contributed by many vendors),
> you could improve squashfs, ext4, or other exist local fses with this
> new use cases (since they don't need any on-disk change as well, for
> example, by using some xattr), I don't think it's really hard.
>

Engineering-wise, merging composefs features into EROFS
would be the simplest option and FWIW, my personal preference.

However, you need to be aware that this will bring into EROFS
vfs considerations, such as  s_stack_depth nesting (which AFAICS
is not see incremented composefs?). It's not the end of the world, but this
is no longer plain fs over block game. There's a whole new class of bugs
(that syzbot is very eager to explore) so you need to ask yourself whether
this is a direction you want to lead EROFS towards.

Giuseppe expressed his plans to make use of the composefs method
inside userns one day. It is not a hard dependency, but I believe that
keeping the "RO efficient verifiable image format" functionality (EROFS)
separate from "userns composition of verifiable images" (overlayfs)
may benefit the userns mount goal in the long term.

Thanks,
Amir.
