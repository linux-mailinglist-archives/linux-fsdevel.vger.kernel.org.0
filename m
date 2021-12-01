Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6624D465978
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 23:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353705AbhLAWvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 17:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhLAWu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:50:59 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3220C061574;
        Wed,  1 Dec 2021 14:47:37 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id b187so21892013iof.11;
        Wed, 01 Dec 2021 14:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qDz1YkpinHk/4tHAysAlqU34+YOb+JwtrMjPi8YGQN8=;
        b=ReCWQGCvqXvrHllStogrYsdGQYrg9/lsDbBobMx4go9J55lhhkeAz29YeB/7MaZody
         EYX5q0kycHsPZ6sPUaaa8xdOaRV2kD/VH69I8exSL1m20W7kcv8J8aWC0qX6sO/maYwS
         7JEOxdaTqimFnK5uK19mGCw0VTZpKSZ6ZWcSnmQVYr5Va1YReM/KfVLwc7l9CZEjD2qt
         nEOLTkREy/Xlz0fVTQ225Was3TyPnIitrddWKJZ15FqHJZyCUGtBS4pOzqfDPI2Wj0Xl
         zdIq1bTw+DVaSrC0Sn6cLLZmsIbky/PvJK7AnMNPNpg08kwgaLC+f2/dpLPjyq9W8dlM
         wYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qDz1YkpinHk/4tHAysAlqU34+YOb+JwtrMjPi8YGQN8=;
        b=EPTMOYQruyvyescRA09a67/ctDGL4zVvIeaa4Z4aZF/Kb9hCNc86Kz13UXvSKUxC5X
         Id+5dK78AecYEsePDa7mLvDEN+YOWThHhjzFDbvu0qeQBfQzIlxkx6YD0BTyGKaTVV4b
         RHMOIDXc+0c3Gbi232Oudyy4RB+RNq3VMXTF9TURTv22+ItTphKcXDzZaTES6Kf5FLA2
         oalMB0/mAZYWGaylKXOCZBY52v4ssB63ScrlXAl4cPrmlrRqAVxb2bmcYsmhl/JkM4ta
         o85+YxrhmTyGDawIDFBxz7jF10h0em6oj44GUfZzTMb/u6f27/fDq96TpGbteVhwgGQq
         J3UQ==
X-Gm-Message-State: AOAM5332escqmHq7vqVVuxAqJAxiw79iW2l8XJ1jZTbIf19GzIYpPaAc
        /bisW36TFvyzwo9wg/NwZDe2+o59JHXX452WqVE=
X-Google-Smtp-Source: ABdhPJzlCHoS2lUMFs4aCOQf/OxdrbyCrV2DcI7KEjtyF00RhtQQLuoMQwUhekdbPqPgvGPcQiLMnyIbjTYppafEDeA=
X-Received: by 2002:a05:6602:29c2:: with SMTP id z2mr11632027ioq.196.1638398857258;
 Wed, 01 Dec 2021 14:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20211118112315.GD13047@quack2.suse.cz> <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz> <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz> <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
 <20211201134610.GA1815@quack2.suse.cz> <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net>
In-Reply-To: <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 Dec 2021 00:47:25 +0200
Message-ID: <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com>
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

On Wed, Dec 1, 2021 at 6:24 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-12-01 21:46:10 Jan Kara=
 <jack@suse.cz> =E6=92=B0=E5=86=99 ----
>  > On Wed 01-12-21 09:19:17, Amir Goldstein wrote:
>  > > On Wed, Dec 1, 2021 at 8:31 AM Chengguang Xu <cgxu519@mykernel.net> =
wrote:
>  > > > So the final solution to handle all the concerns looks like accura=
tely
>  > > > mark overlay inode diry on modification and re-mark dirty only for
>  > > > mmaped file in ->write_inode().
>  > > >
>  > > > Hi Miklos, Jan
>  > > >
>  > > > Will you agree with new proposal above?
>  > > >
>  > >
>  > > Maybe you can still pull off a simpler version by remarking dirty on=
ly
>  > > writably mmapped upper AND inode_is_open_for_write(upper)?
>  >
>  > Well, if inode is writeably mapped, it must be also open for write, do=
esn't
>  > it? The VMA of the mapping will hold file open. So remarking overlay i=
node
>  > dirty during writeback while inode_is_open_for_write(upper) looks like
>  > reasonably easy and presumably there won't be that many inodes open fo=
r
>  > writing for this to become big overhead?

I think it should be ok and a good tradeoff of complexity vs. performance.

>  >
>  > > If I am not mistaken, if you always mark overlay inode dirty on ovl_=
flush()
>  > > of FMODE_WRITE file, there is nothing that can make upper inode dirt=
y
>  > > after last close (if upper is not mmaped), so one more inode sync sh=
ould
>  > > be enough. No?
>  >
>  > But we still need to catch other dirtying events like timestamp update=
s,
>  > truncate(2) etc. to mark overlay inode dirty. Not sure how reliably th=
at
>  > can be done...
>  >

Oh yeh, we have those as well :)
All those cases should be covered by ovl_copyattr() that updates the
ovl inode ctime/mtime, so always dirty in ovl_copyattr() should be good.
I *think* the only case of ovl_copyattr() that should not dirty is in
ovl_inode_init(), so need some special helper there.

>
> To be honest I even don't fully understand what's the ->flush() logic in =
overlayfs.
> Why should we open new underlying file when calling ->flush()?
> Is it still correct in the case of opening lower layer first then copy-up=
ed case?
>

The semantics of flush() are far from being uniform across filesystems.
most local filesystems do nothing on close.
most network fs only flush dirty data when a writer closes a file
but not when a reader closes a file.
It is hard to imagine that applications rely on flush-on-close of
rdonly fd behavior and I agree that flushing only if original fd was upper
makes more sense, so I am not sure if it is really essential for
overlayfs to open an upper rdonly fd just to do whatever the upper fs
would have done on close of rdonly fd, but maybe there is no good
reason to change this behavior either.

Thanks,
Amir.
