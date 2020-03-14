Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A47B5185934
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 03:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgCOChr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Mar 2020 22:37:47 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45067 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgCOChq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:37:46 -0400
Received: by mail-il1-f193.google.com with SMTP id p1so13057536ils.12;
        Sat, 14 Mar 2020 19:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YrB0STOPBrcFa3wDj/x4Xpjhzh2ZYfbsAXQY/bQ52f0=;
        b=ad/1OwGQWpBm4hz6EIAfng1zuvHYg1K8+x6Q0a0yo2xXI1jHAH1Av8iwDGup0S1rtg
         9ZYjlwr6f+uqFecAXWkrLmOMGRHUHEehIKCY2kcfXk1ZWxD2zKMCFU8IxHdh8bhgwpyT
         8xxeM6mFFmMalNelh7Tawad/gtQn821ip+Mq7NfGSMnnXpeU5dd8iGOnnMFDbdwr9WK6
         2n/f5vPoqnQDwqoHXDY3TwjIdroEjBZ2gtKHqn8M5SWtajAK8dX/rkPrUPrvqGpSnpZe
         lKW/fxaQRC3tQ/qpC6vLlF4qlgqL1oV1SebJxm5JqHiPU184+jfy0BT0cCu2HNAmmIpw
         p7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrB0STOPBrcFa3wDj/x4Xpjhzh2ZYfbsAXQY/bQ52f0=;
        b=KIM43ccZh73fjv+Ro2cWlWRt3w3PkeuXSil33IWBgN9ydJdK12dRPnFSYs1WL+2Qoe
         Ko1v0q6jeScaSD1BRjsw/rXvh8vt56TeBOyOca+Oe2i9LMZtdwe0I4VKb9EHfnCdOIrb
         KeGd0gcFKOgZtpoQ6RsG7KBHs3CrZAV2Fh00mQ9A1OK49tCY92Wlctimy9LaoQaYrYPb
         Nzo1bxn9WOvrwTemc6o9Mvk6Jpqfju7UKAQmllGBNRZwZqpsdI86KlB5vxp7qt4FyhBv
         VsoWq0IArxUvCAGFx5GaSGrHKtW4MnTVFYJPFMjiuN0uWjqWBksB5+0T2pYwmnLpjz4P
         9Tug==
X-Gm-Message-State: ANhLgQ018KQYdUkKX1cj2tpU8p+p/DvgzV8yCArStq8PK6W+q0N31A4x
        HeDHiF1FXzB0s51ejClU5XOV/gl5YFab2O+40aixBlqD
X-Google-Smtp-Source: ADFU+vsEesvJLb2lU/vLuSWqyeu7wildcRCEvPxjHZ78c854A68RRSUYrFNbs1+keKmx8A0IMdcE+foiGw3LwONJneE=
X-Received: by 2002:a05:6602:448:: with SMTP id e8mr1583290iov.64.1584191799611;
 Sat, 14 Mar 2020 06:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
 <20200204145951.GC11631@redhat.com> <CAJfpegtq4A-m9vOPwUftiotC_Xv6w-dnhCi9=E0t-b1ZPJXPGw@mail.gmail.com>
 <CAOQ4uxj_pVp9-EN2Gmq9j6G3xozzpK_zQiRO-brx6PZ9VpgD0Q@mail.gmail.com>
 <CAOQ4uxjFYO28r+0pY+pKxK-dDJcQF2nf2EivnOUBgrgkYTFjPQ@mail.gmail.com> <CAOQ4uxhZ8a2ObfB9sUtrc=95mM70qurLtXkaNyHOXYxGEKvxFw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhZ8a2ObfB9sUtrc=95mM70qurLtXkaNyHOXYxGEKvxFw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 14 Mar 2020 15:16:28 +0200
Message-ID: <CAOQ4uxhkd5FkN5ynpQxQ0m1MR9MgzTBbvzjkoHfSRA2umb-JTA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
To:     Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Feb 20, 2020 at 9:52 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Feb 4, 2020 at 7:02 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Tue, Feb 4, 2020 at 6:17 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Tue, Feb 4, 2020 at 3:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > >
> > > > > On Fri, Jan 31, 2020 at 12:50:04PM +0100, Miklos Szeredi wrote:
> > > > > > No reason to prevent upper layer being a remote filesystem.  Do the
> > > > > > revalidation in that case, just as we already do for lower layers.
> > > > > >
> > > > > > This lets virtiofs be used as upper layer, which appears to be a real use
> > > > > > case.
> > > > >
> > > > > Hi Miklos,
> > > > >
> > > > > I have couple of very basic questions.
> > > > >
> > > > > - So with this change, we will allow NFS to be upper layer also?
> > > >
> > > > I haven't tested, but I think it will fail on the d_type test.
> > >
> > > But we do not fail mount on no d_type support...
> > > Besides, I though you were going to add the RENAME_WHITEOUT
> > > test to avert untested network fs as upper.
> > >
> >
> > Pushed strict remote upper check to:
> > https://github.com/amir73il/linux/commits/ovl-strict-upper
> >

Vivek,

Could you please make sure that the code in ovl-strict-upper branch
works as expected for virtio as upper fs?
I have rebased it on latest overlayfs-next merge into current master.

I would very much prefer that the code merged to v5.7-rc1 will be more
restrictive than the current overlayfs-next.

Thanks,
Amir.
