Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4334647CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 08:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347193AbhLAHWu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 02:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhLAHWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:22:50 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B306FC061574;
        Tue, 30 Nov 2021 23:19:29 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id c3so29523509iob.6;
        Tue, 30 Nov 2021 23:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W42RCJlEds63KYEFS5bNvHOTueCgejloTTAeKuH4dpI=;
        b=XLi1t09ZX6lCYG1AT8qmEVfx0I+gy6ApvyyAj2wq6PKp1tY8NJ6+tJt2TvjoXfYpNJ
         RIHnrIGKQaBJvSUROMIMlc/keLqMgrsXeRhWlFuPv3/DaSEVQmxSpzTdBKLgKQ7I7DGV
         Ud6Varjw6l0mGxrs0KURFpkVaGj91koU1QVo/G0q/jz7yYmUZbmvGz4C6MZr8+D3Ws1o
         q5O0H/1lEzIIZWn2nhBHmOhc62LSeJ4+XFvbujYNW6QZLUxwO1fv1KTiQV6H3LYeiDPz
         AINJil2aea1e2Ec0LzuUaV3BTQFX8pQSe4wWwZXVKnB97P5UWXNjuhdPdR2lYZx/rOFM
         Qe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W42RCJlEds63KYEFS5bNvHOTueCgejloTTAeKuH4dpI=;
        b=nZlSQEnc5pdz/ryuXaPsEycjrI+Bh8YvN8W2B79k+QSzj8eVxTG/1p/y/r1yS+T+BK
         9zjj5xrMkV7GFzZ43Mx/Ea1VFd97WAxIUcrCVsVyEfSlHtXd8pEzQ04N8lp/p11Xs1o4
         EA9VXxNE3ctotT4BFU2eXQwiEubCGfYv/QdH9jbV7GuPK/z1Oia3IV8DMg4bDTbYTeYg
         NAuTCKj4prbnL1gt7VkLY+AbjPTwU4zydTk1KKtZ5Qsef0bMxPOTzveDmMrtr/iCE6CT
         kKG4jHaXnnq+2l5KyWOCH6j7IqltYLZGn6dFBf5Bv5lzU3Bnv4Qr0hloYcAc70i7xaDf
         xdpA==
X-Gm-Message-State: AOAM533c0TIncI5TlivgseFxcg90yqy1qcg9SP3sVW+6fv2rwSC+E+fa
        dfPh/g348ues++Nikfk+ZKQsJrfc9Rgrk53DHXY=
X-Google-Smtp-Source: ABdhPJzsk71aQ4hKPDW7OZPUk51D41MeTE8kUWEi0IC/aW28L8En/Gc6tkoZ+Rb5NrCuOifUXmpLuPcMyaIq2OvLiUw=
X-Received: by 2002:a6b:d904:: with SMTP id r4mr6169415ioc.52.1638343169091;
 Tue, 30 Nov 2021 23:19:29 -0800 (PST)
MIME-Version: 1.0
References: <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
 <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net>
 <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com>
 <17d2c858d76.d8a27d876510.8802992623030721788@mykernel.net>
 <17d31bf3d62.1119ad4be10313.6832593367889908304@mykernel.net>
 <20211118112315.GD13047@quack2.suse.cz> <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz> <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz> <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net> <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
In-Reply-To: <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 1 Dec 2021 09:19:17 +0200
Message-ID: <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode operation
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ronyjin <ronyjin@tencent.com>,
        charliecgxu <charliecgxu@tencent.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 1, 2021 at 8:31 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-12-01 10:37:15 Chenggua=
ng Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
>  >
>  >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-12-01 03:04:59 Amir =
Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  >  > >  > I was thinking about this a bit more and I don't think I buy t=
his
>  >  > >  > explanation. What I rather think is happening is that real wor=
k for syncfs
>  >  > >  > (writeback_inodes_sb() and sync_inodes_sb() calls) gets offloa=
ded to a flush
>  >  > >  > worker. E.g. writeback_inodes_sb() ends up calling
>  >  > >  > __writeback_inodes_sb_nr() which does:
>  >  > >  >
>  >  > >  > bdi_split_work_to_wbs()
>  >  > >  > wb_wait_for_completion()
>  >  > >  >
>  >  > >  > So you don't see the work done in the times accounted to your =
test
>  >  > >  > program. But in practice the flush worker is indeed burning 1.=
3s worth of
>  >  > >  > CPU to scan the 1 million inode list and do nothing.
>  >  > >  >
>  >  > >
>  >  > > That makes sense. However, in real container use case,  the upper=
 dir is always empty,
>  >  > > so I don't think there is meaningful difference compare to accura=
tely marking overlay
>  >  > > inode dirty.
>  >  > >
>  >  >
>  >  > It's true the that is a very common case, but...
>  >  >
>  >  > > I'm not very familiar with other use cases of overlayfs except co=
ntainer, should we consider
>  >  > > other use cases? Maybe we can also ignore the cpu burden because =
those use cases don't
>  >  > > have density deployment like container.
>  >  > >
>  >  >
>  >  > metacopy feature was developed for the use case of a container
>  >  > that chowns all the files in the lower image.
>  >  >
>  >  > In that case, which is now also quite common, all the overlay inode=
s are
>  >  > upper inodes.
>  >  >
>  >
>  > Regardless of metacopy or datacopy, that copy-up has already modified =
overlay inode
>  > so initialy marking dirty to all overlay inodes which have upper inode=
 will not be a serious
>  > problem in this case too, right?
>  >
>  > I guess maybe you more concern about the re-mark dirtiness on above us=
e case.
>  >
>  >
>  >
>  >  > What about only re-mark overlay inode dirty if upper inode is dirty=
 or is
>  >  > writeably mmapped.
>  >  > For other cases, it is easy to know when overlay inode becomes dirt=
y?
>  >  > Didn't you already try this?
>  >  >
>  >
>  > Yes, I've tried that approach in previous version but as Miklos pointe=
d out in the
>  > feedback there are a few of racy conditions.
>  >

Right..

>
> So the final solution to handle all the concerns looks like accurately ma=
rk overlay inode
> diry on modification and re-mark dirty only for mmaped file in ->write_in=
ode().
>
> Hi Miklos, Jan
>
> Will you agree with new proposal above?
>

Maybe you can still pull off a simpler version by remarking dirty only
writably mmapped upper AND inode_is_open_for_write(upper)?

If I am not mistaken, if you always mark overlay inode dirty on ovl_flush()
of FMODE_WRITE file, there is nothing that can make upper inode dirty
after last close (if upper is not mmaped), so one more inode sync should
be enough. No?

Thanks,
Amir.
