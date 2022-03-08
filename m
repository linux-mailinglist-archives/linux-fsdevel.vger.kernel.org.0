Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7684D158E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 12:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346193AbiCHLFO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 06:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346186AbiCHLFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:05:13 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4F443E6
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 03:04:17 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so21632365ooi.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 03:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Syu0+WZQYDiC7Z2n+Wkyb7mzViFQamxzapgnxVkp+ws=;
        b=J+wlgMI0qsfmLRy28qbD4+fD9qEi3htSqUCzQlpxdJCgAqFXMRIKqqgZf4OmkygKxy
         Ad7dO7sx4dIt8QqPOz5F6UvtMv3LuAXyb0eJSdEzB0R7hPlLeqWJKCDSPcdjklWynfhR
         dwR+ePuFcW4d/54kmxUzYT1aGoU+c6Qw1/1d2SgjzcejaXuT28U3joQR7VraY3fRo+/U
         0Owlm2yzHr6DvJrMbMNMi0Wt7A9OhkvbvLkMTeEJTcN3NVtlefgOmc/P5FaEvacY6kjD
         4gA671XwNzxc9mQlJ3JU8moz35M0OQo7VlH1j3ILnsF79jmFs3Iqp9vb8x+D68Y7a4ne
         6kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Syu0+WZQYDiC7Z2n+Wkyb7mzViFQamxzapgnxVkp+ws=;
        b=vc4PoZjIzi0pYiNM9ieaOY7ZVUhBGRkY+vs+IWfPRyDMdQ5c13B4mkAbHZvXlZy3K6
         wn1k5EV3kBSuODlt2x/OtpvpljZi8TJhdZaQR/4xtjRrjyS7ZQ8J83mkCvAeaUt1tSl3
         k28cFwwuLBjiIodGNrx+WDksc5ErqScSNXWw4vn23v6C8812nkqNYQvFj0kCmWBVdV41
         P1Jx2C5RKnhNn1/WWkqh5jXsSZr9mqwQ2DjB99aqeUSFDIGROHxVpcw7ZSAojtO6C8Hg
         TMu2mpDxfjv0MViKWYYXiN6Bu0PhJL1G+tul5kYIFG/Gav7SSEPyhgA/0QXn7VAq15X/
         o0vA==
X-Gm-Message-State: AOAM533WIPn2JncbLrutNr+cB5FMUxvytZaGQJn71yWKb9Oj5odlv2hD
        zOWus91KzfbmS9uNtt1SzBWrnOyrBQvwBzP3T5I=
X-Google-Smtp-Source: ABdhPJyJ0ekS/5OvjGCdx7b0RwO1P8uLF9+7ceITCKAo9XVnvQp7+q0TX/FeWeDQqyhAac8XdBmnD+DZ08VGs91H71g=
X-Received: by 2002:a05:6871:88b:b0:d9:f657:be16 with SMTP id
 r11-20020a056871088b00b000d9f657be16mr2035565oaq.98.1646737456828; Tue, 08
 Mar 2022 03:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20190212170012.GF69686@sasha-vm> <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
In-Reply-To: <YicrMCidylefTC3n@kroah.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 8 Mar 2022 13:04:05 +0200
Message-ID: <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 8, 2022 at 12:08 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 08, 2022 at 11:32:43AM +0200, Amir Goldstein wrote:
> > On Tue, Feb 12, 2019 at 7:31 PM Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > Hi all,
> > >
> > > I'd like to propose a discussion about the workflow of the stable trees
> > > when it comes to fs/ and mm/. In the past year we had some friction with
> > > regards to the policies and the procedures around picking patches for
> > > stable tree, and I feel it would be very useful to establish better flow
> > > with the folks who might be attending LSF/MM.
> > >
> > > I feel that fs/ and mm/ are in very different places with regards to
> > > which patches go in -stable, what tests are expected, and the timeline
> > > of patches from the point they are proposed on a mailing list to the
> > > point they are released in a stable tree. Therefore, I'd like to propose
> > > two different sessions on this (one for fs/ and one for mm/), as a
> > > common session might be less conductive to agreeing on a path forward as
> > > the starting point for both subsystems are somewhat different.
> > >
> > > We can go through the existing processes, automation, and testing
> > > mechanisms we employ when building stable trees, and see how we can
> > > improve these to address the concerns of fs/ and mm/ folks.
> > >
> >
> > Hi Sasha,
> >
> > I think it would be interesting to have another discussion on the state of fs/
> > in -stable and see if things have changed over the past couple of years.
> > If you do not plan to attend LSF/MM in person, perhaps you will be able to
> > join this discussion remotely?
> >
> > >From what I can see, the flow of ext4/btrfs patches into -stable still looks
> > a lot healthier than the flow of xfs patches into -stable.
>
> That is explicitly because the ext4/btrfs developers/maintainers are
> marking patches for stable backports, while the xfs
> developers/maintainers are not.
>
> It has nothing to do with how me and Sasha are working,

Absolutely, I have no complaints to the stable maintainers here, just wanted
to get a status report from Sasha, because he did invest is growing the stable
tree xfstests coverage AFAIK, which should have addressed some of the
earlier concerns of xfs developers.

> so go take this up with the fs developers :)

It is easy to blame the "fs developers", but is it also very hard on an
overloaded maintainer to ALSO take care of GOOD stable tree updates.

Here is a model that seems to be working well for some subsystems:
When a tester/developer finds a bug they write an LTP test.
That LTP test gets run by stable kernel test bots and prompts action
from distros who now know of this issue and may invest resources
in backporting patches.

If I am seeing random developers reporting bugs from running xfstests
on stable kernels and I am not seeing the stable kernel test bots reporting
those bugs, then there may be room for improvement in the stable kernel
testing process??

> > In 2019, Luis started an effort to improve this situation (with some
> > assistance from me and you) that ended up with several submissions
> > of stable patches for v4.19.y, but did not continue beyond 2019.
> >
> > When one looks at xfstest bug reports on the list for xfs on kernels > v4.19
> > one has to wonder if using xfs on kernels v5.x.y is a wise choice.
>
> That's up to the xfs maintainers to discuss.
>
> > Which makes me wonder: how do the distro kernel maintainers keep up
> > with xfs fixes?
>
> Who knows, ask the distro maintainers that use xfs.  What do they do?
>

So here I am - asking them via proxy fs developers :)

> The xfs developers/maintainer told us (Sasha and I) to not cherry-pick
> any xfs "fixes:" patches to the stable trees unless they explicitly
> marked it for stable.  So there's not much we can do here about this
> without their involvement as I do not want to ever route around an
> active maintainer like that.
>
> > Many of the developers on CC of this message are involved in development
> > of a distro kernel (at least being consulted with), so I would be very much
> > interested to know how and if this issue is being dealt with.
>
> Maybe no distro cares about xfs?  :)

Some distros (Android) do not care about xfs.
Some distros have a business model to support xfs.
Many distros are still stuck on v4.19 and earlier.
Other distros may be blissfully ignorant about the situation.

Thanks,
Amir.
