Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BABF466762
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 17:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359304AbhLBQDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 11:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355540AbhLBQDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:03:30 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC8FC06174A;
        Thu,  2 Dec 2021 08:00:07 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id h16so28568535ila.4;
        Thu, 02 Dec 2021 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=efGeiJ/GSvNA8GpE74Rzl8Jk1u536irX6BsYP5Fxck0=;
        b=fODnySamKnmbcP2mTNMULmfhC93FCdzwVnI3nafMu1ZvUa9ww2491GhDcLx9PHk4JF
         hWIoCyVGriRFrXb1vGhacJ4xZ2M+X1dgNsRGdFfkXr99+PXZIZwEWg1noCyk76km4ffI
         qrNlTe3oKXvcRRlFcDTjGxVubiqras7arbLZ+hbGv1Li7HHjJ2HamLfqcEzfs0HbZeEi
         KBf6nk+P2LrdsHmakAxBiSr4oobEahC5CB7Byu323KWswhW3FAKQ/VTizCQNdfxFiY9u
         MTXMXh7g4p4ibvuI+xAT2LsoitmtHQ5JUJ1abkS8VkDnKVUfCDZ/NKhSzHP3Xcug/Y5s
         Y/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=efGeiJ/GSvNA8GpE74Rzl8Jk1u536irX6BsYP5Fxck0=;
        b=NX8yCWkY5JMDY+nBkusOMDy2kuUooaAoW8m4pD5Owispky3lVyxM7B06IUlEf3AreC
         aT5hgAqr4Niy/mlEnCb+eHg1pFeFRUVicDwOUXsuWZqzR9NmfW/gJ3OXtluenCFbij6G
         6WQTZqrGflzGgfrwW52KfVRN6nkeQvPQyy4/EXjPVJX1aL2L56g+hfrN8xQo7DeQXrz8
         TDCcKp0IcFvQ34s7XEBsTCCtAetl47QnWb7sMUleK0c5D2l+J8pzPkGqXxqSAxQULOFP
         UafxPedXTgEp51wCn4W/VgaF2mMEdUroGtJvxcv0xq3bozMhycBANNBvT2Elht67neiN
         Gr/w==
X-Gm-Message-State: AOAM531OUrc7U/WcpphrXXg061GM8C+u52fXhalzLHIZtSnA2wolysp+
        +1CSuyF3eHttwP5EkJYzQV7mFUhk5Spzn9u/SaA=
X-Google-Smtp-Source: ABdhPJzwR/WG1XQmZr+htmJ+/QbuNy7wKwSl1cRWMi60/L5kK88Z25LObxao9nMh9oD8ybeeRy4lPwF7oXiXzS1XGJ0=
X-Received: by 2002:a92:c88e:: with SMTP id w14mr13976244ilo.24.1638460807330;
 Thu, 02 Dec 2021 08:00:07 -0800 (PST)
MIME-Version: 1.0
References: <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
 <20211201134610.GA1815@quack2.suse.cz> <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net>
 <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com>
 <CAOQ4uxg6FATciQhzRifOft4gMZj15G=UA6MUiPX2n9-NR5+1Pg@mail.gmail.com>
 <17d78e95c35.ceeffaaf22655.2727336036618811041@mykernel.net> <YajkQUpxWQI1N64l@redhat.com>
In-Reply-To: <YajkQUpxWQI1N64l@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 Dec 2021 17:59:56 +0200
Message-ID: <CAOQ4uxj4Gh=hjoXgq-=c+JStKnK=iY4R+CZqEfb8eBd95218Mg@mail.gmail.com>
Subject: Re: ovl_flush() behavior
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ronyjin <ronyjin@tencent.com>,
        charliecgxu <charliecgxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 2, 2021 at 5:20 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Dec 02, 2021 at 10:11:39AM +0800, Chengguang Xu wrote:
> >
> >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-12-02 07:23:17 Amir G=
oldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
> >  > > >
> >  > > > To be honest I even don't fully understand what's the ->flush() =
logic in overlayfs.
> >  > > > Why should we open new underlying file when calling ->flush()?
> >  > > > Is it still correct in the case of opening lower layer first the=
n copy-uped case?
> >  > > >
> >  > >
> >  > > The semantics of flush() are far from being uniform across filesys=
tems.
> >  > > most local filesystems do nothing on close.
> >  > > most network fs only flush dirty data when a writer closes a file
> >  > > but not when a reader closes a file.
> >  > > It is hard to imagine that applications rely on flush-on-close of
> >  > > rdonly fd behavior and I agree that flushing only if original fd w=
as upper
> >  > > makes more sense, so I am not sure if it is really essential for
> >  > > overlayfs to open an upper rdonly fd just to do whatever the upper=
 fs
> >  > > would have done on close of rdonly fd, but maybe there is no good
> >  > > reason to change this behavior either.
> >  > >
> >  >
> >  > On second thought, I think there may be a good reason to change
> >  > ovl_flush() otherwise I wouldn't have submitted commit
> >  > a390ccb316be ("fuse: add FOPEN_NOFLUSH") - I did observe
> >  > applications that frequently open short lived rdonly fds and suffere=
d
> >  > undesired latencies on close().
> >  >
> >  > As for "changing existing behavior", I think that most fs used as
> >  > upper do not implement flush at all.
> >  > Using fuse/virtiofs as overlayfs upper is quite new, so maybe that
> >  > is not a problem and maybe the new behavior would be preferred
> >  > for those users?
> >  >
> >
> > So is that mean simply redirect the ->flush request to original underly=
ing realfile?
>
> If the file has been copied up since open(), then flush should go on uppe=
r
> file, right?
>
> I think Amir is talking about that can we optimize flush in overlay and
> not call ->flush at all if file was opened read-only, IIUC.
>

Maybe that's what I wrote, but what I meant was if file was open as
lower read-only and later copied up, not sure we should bother with
ovl_open_realfile() for flushing upper.

> In case of fuse he left it to server. If that's the case, then in case
> of overlayfs, it should be left to underlyng filesystem as well?
> Otherwise, it might happen underlying filesystem (like virtiofs) might
> be expecting ->flush() and overlayfs decided not to call it because
> file was read only.
>

Certainly, if upper wants flush on rdonly file we must call flush on
close of rdonly file *that was opened on upper*.

But if we opened rdonly file on lower, even if lower is virtiofs, does
virtiosfd needs this flush? that same file on the server was not supposed
to be written by anyone.
If virtiofsd really needs this flush then it is a problem already today,
because if lower file was copied up since open rdonly, virtiofsd
is not going to get the flushes for the lower file (only the release).

However, I now realize that if we opened file rdonly on lower,
we may have later opened a short lived realfile on upper for read post
copy up and we never issued a flush for this short live rdonly upper fd.
So actually, unless we store a flag or something that says that
we never opened upper realfile, we should keep current behavior.

> So I will lean towards continue to call ->flush in overlay and try to
> optimize virtiofsd to set FOPEN_NOFLUSH when not required.
>

Makes sense.
Calling flush() on fs that does nothing with it doesn't hurt.

Thanks,
Amir.
