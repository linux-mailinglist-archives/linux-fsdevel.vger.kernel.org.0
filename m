Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF56146B26F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 06:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbhLGFhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 00:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhLGFhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:37:34 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9FBC061746;
        Mon,  6 Dec 2021 21:34:04 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x6so15562295iol.13;
        Mon, 06 Dec 2021 21:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Foo5IT0QdYnxFFa9bodUnnVRJ7cPv1e6msV9QJTF8yk=;
        b=nwKSc1DBij0ic3RJCjNMNBgt8KadqTdhcbqBlCBquECz/FRCFZXA65gyTbhSteFeo3
         LIOhRQMwp1FmO9XTum0yQtkfgsMmRewLZNJDVt/GOZhu8hGy08PC2ejkwhELo9yNYfci
         PeFVc5pl6T7TnibBwEczchCjINQAkVPsoJojZsCVaMiv52L8xpYqt+qY9Mc+a91fhQVA
         R+y12wt1x77dzeAj17IZ6wdnQxKpqICl+y3E+0itOaXkypST967YaRYah71zHU9i3Rkl
         WET99tW3ovvDJfGJkGolKInFlrV0IJ/gPXqrVcVPVSwl0aBvkiMKKCvTE9VKv9IqtOfK
         gTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Foo5IT0QdYnxFFa9bodUnnVRJ7cPv1e6msV9QJTF8yk=;
        b=ydYW0Qce7zNeAMb7F3NsX05dQOr/a5tDImewpQp0Bl4aqqdzs6UewG3U2/KeKfiA+S
         FIYa5uU3Z7XAVJfkkjCoNes+wUhwmygsJIyauLW7C2PoQmsTpUi0sWZesdyI/LFhYjyy
         6WFPGFBebfHyMUVYA00UuyN8QcKe5F4Zw3t8UEcvSL5uaY6+mpxZHn2lurYwqbAAkqix
         78b+z3MS7U5VAhfzEYM9PpQEszHUhzZ4JuhHw0OTSkt9absG1MrehrTvGS/cYXNps9qy
         NqFHa57BxzhAi9wcWcsExYGEO7A93SWPyX7CJbweuZqoZ2cvRhS7iVl5O1kReJE6hOMa
         2x4A==
X-Gm-Message-State: AOAM531NTFvqewutJ5p5+5R5xTwsLAGCNbTdbX7UUSGGHgrCl0B3jXHS
        awjmyS1zjzeMcr+0zJ62uqkJNt/vLv1Cr+IpE6Y=
X-Google-Smtp-Source: ABdhPJwV2Pgrf6dZi+UehOKNyiNBfmeN0PJyOjSEuaF+IAnJEBx55klJPHPNY04SmNimPt6Akpc6lDZZizWRoMWP+Hk=
X-Received: by 2002:a02:a489:: with SMTP id d9mr46258543jam.47.1638855243954;
 Mon, 06 Dec 2021 21:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20211118112315.GD13047@quack2.suse.cz> <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz> <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz> <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
 <20211201134610.GA1815@quack2.suse.cz> <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net>
 <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com> <17d8aeb19ac.f22523af26365.6531629287230366441@mykernel.net>
In-Reply-To: <17d8aeb19ac.f22523af26365.6531629287230366441@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 7 Dec 2021 07:33:52 +0200
Message-ID: <CAOQ4uxgwZoB5GQJZvpPLzRqrQA-+JSowD+brUwMSYWf9zZjiRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode operation
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ronyjin <ronyjin@tencent.com>,
        charliecgxu <charliecgxu@tencent.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 5, 2021 at 4:07 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-12-02 06:47:25 Amir Gol=
dstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > On Wed, Dec 1, 2021 at 6:24 PM Chengguang Xu <cgxu519@mykernel.net> wr=
ote:
>  > >
>  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-12-01 21:46:10 Jan=
 Kara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
>  > >  > On Wed 01-12-21 09:19:17, Amir Goldstein wrote:
>  > >  > > On Wed, Dec 1, 2021 at 8:31 AM Chengguang Xu <cgxu519@mykernel.=
net> wrote:
>  > >  > > > So the final solution to handle all the concerns looks like a=
ccurately
>  > >  > > > mark overlay inode diry on modification and re-mark dirty onl=
y for
>  > >  > > > mmaped file in ->write_inode().
>  > >  > > >
>  > >  > > > Hi Miklos, Jan
>  > >  > > >
>  > >  > > > Will you agree with new proposal above?
>  > >  > > >
>  > >  > >
>  > >  > > Maybe you can still pull off a simpler version by remarking dir=
ty only
>  > >  > > writably mmapped upper AND inode_is_open_for_write(upper)?
>  > >  >
>  > >  > Well, if inode is writeably mapped, it must be also open for writ=
e, doesn't
>  > >  > it? The VMA of the mapping will hold file open. So remarking over=
lay inode
>  > >  > dirty during writeback while inode_is_open_for_write(upper) looks=
 like
>  > >  > reasonably easy and presumably there won't be that many inodes op=
en for
>  > >  > writing for this to become big overhead?
>  >
>  > I think it should be ok and a good tradeoff of complexity vs. performa=
nce.
>
> IMO, mark dirtiness on write is relatively simple, so I think we can mark=
 the
> overlayfs inode dirty during real write behavior and only remark writable=
 mmap
> unconditionally in ->write_inode().
>

If by "on write" you mean on write/copy_file_range/splice_write/...
then yes I agree
since we have to cover all other mnt_want_write() cases anyway.

>
>  >
>  > >  >
>  > >  > > If I am not mistaken, if you always mark overlay inode dirty on=
 ovl_flush()
>  > >  > > of FMODE_WRITE file, there is nothing that can make upper inode=
 dirty
>  > >  > > after last close (if upper is not mmaped), so one more inode sy=
nc should
>  > >  > > be enough. No?
>  > >  >
>  > >  > But we still need to catch other dirtying events like timestamp u=
pdates,
>  > >  > truncate(2) etc. to mark overlay inode dirty. Not sure how reliab=
ly that
>  > >  > can be done...
>  > >  >
>  >
>  > Oh yeh, we have those as well :)
>  > All those cases should be covered by ovl_copyattr() that updates the
>  > ovl inode ctime/mtime, so always dirty in ovl_copyattr() should be goo=
d.
>
> Currently ovl_copyattr() does not cover all the cases, so I think we stil=
l need to carefully
> check all the places of calling mnt_want_write().
>

Careful audit is always good, but if we do not have ovl_copyattr() in
a call site
that should mark inode dirty, then it sounds like a bug, because ovl inode =
ctime
will not get updated. Do you know of any such cases?

Thanks,
Amir.
