Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3A414F023
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 16:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAaPup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 10:50:45 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46922 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAaPup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:50:45 -0500
Received: by mail-io1-f67.google.com with SMTP id t26so8600596ioi.13;
        Fri, 31 Jan 2020 07:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iO5jAxtqX2zPQNb4u14zP84Hz4xAcObR7cLjtp8YJTI=;
        b=lkeVpjlaDuyZuzJEa+6efhrFl60lcdc2AI711KIAHcU1VRUUY4pde0o7eo1ku8DNmW
         w2z5vRCVCWMCy//8QYsPNFKPrxjtvkOt7erx1MjnTUaIRLtUUznEL0K+uHJySaY9/Dcs
         Oq59rzMvQYKY/aMk6PFrsst/L//QljGhJagIGI1+M9pcbvzHqTIjCnjkcM52zAKPBsk4
         RxLDTuBnqZg+tfxkl/e9yXRnrGsqku8dHE2wkiqoYIBb1eKbouLf1uod89du+uPdhFdr
         B15F6u8iiR/hF19kxhMbgrftlO812Z/yxpXoHCfL7+S3H0CYu2wVdgyMzGCTB7Hn0w1P
         r3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iO5jAxtqX2zPQNb4u14zP84Hz4xAcObR7cLjtp8YJTI=;
        b=g5KChbJ6CSPDh7tGJgw5fPcOpm4+YvV72q5qDJSJHgsTTQGztLmnWxU6LoXFuY2HwC
         XMv+BHlgqwGRdVhtsYN51drlhsBgK+qgrCV5qLHiQ7xEcBBgbnavrAZJV09jGIhJg0VU
         ettpNU/AITJK0Fhx3zDLcUlmZmQKTgekH81StJfL3BTbbxBQ5f0gqu3UewJ7uk9Ua/fe
         VsYztEKdfP3gGlMygrcR8uJspVZygZ/C7rOqYBDVK0MSjpxu6O702PAxf780GdWVHtKC
         Dmgdtw+c29tJ/HI3qVBhN/RIrmKuJbkka8dk/tynOVV72hCRf/MSS7yUn/NLXJjceFXF
         d/Eg==
X-Gm-Message-State: APjAAAXUwYzi71bhKIvxmVuCtQlOwlU3803M/IQV9y9W8chNOhUDBLlj
        LlKkPGG2COY7bZ656mSC++SzfryphXs2y4guo0U=
X-Google-Smtp-Source: APXvYqzLEjH7DQIQbPRcsupsEimRUF9G6IuUWdIku8eGzv/u0etfe7f1SWJegYyOY4H98Vh7I04G2Ow4+CDIY9c+fF0=
X-Received: by 2002:a5e:a616:: with SMTP id q22mr8996773ioi.250.1580485843985;
 Fri, 31 Jan 2020 07:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
 <CAOQ4uxgV9KbE9ROCi5=RmXe1moqnmwWqaZ98jDjLcpDuM70RGQ@mail.gmail.com> <CAJfpegvMz-nHOb3GkoU_afqRrBKt-uvOXL6GxWLa3MVhwNGLpg@mail.gmail.com>
In-Reply-To: <CAJfpegvMz-nHOb3GkoU_afqRrBKt-uvOXL6GxWLa3MVhwNGLpg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 31 Jan 2020 17:50:33 +0200
Message-ID: <CAOQ4uxificaCG4uVRh94WC-nSNbGSqtmNt6Bx92j1chF_Khpmw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 5:38 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, Jan 31, 2020 at 4:30 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Jan 31, 2020 at 1:51 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> > >
> > > No reason to prevent upper layer being a remote filesystem.  Do the
> > > revalidation in that case, just as we already do for lower layers.
> > >
> >
> > No reason to prevent upper layer from being a remote filesystem, but
> > the !remote criteria for upper fs kept away a lot of filesystems from
> > upper. Those filesystems have never been tested as upper and many
> > of them are probably not fit for upper.
> >
> > The goal is to lift the !remote limitation, not to allow for lots of new
> > types of upper fs's.
> >
> > What can we do to minimize damages?
> >
> > We can assert that is upper is remote, it must qualify for a more strict
> > criteria as upper fs, that is:
> > - support d_type
> > - support xattr
> > - support RENAME_EXCHANGE|RENAME_WHITEOUT
> >
> > I have a patch on branch ovl-strict which implements those restrictions.
>
> Sounds good.  Not sure how much this is this going to be a
> compatibility headache.  If it does, then we can conditionally enable
> this with a config/module option.
>

No headache at all:
- For now, do not change criteria for !remote fs
- Only remote fs needs to meet the most strict criteria
- We can add the 'strict' config later if we want impose
  same criteria also for local fs

> >
> > Now I know fuse doesn't support RENAME_WHITEOUT, but it does
> > support RENAME_EXCHANGE, which already proves to be a very narrow
> > filter for remote fs: afs, fuse, gfs2.
> > Did not check if afs, gfs2 qualify for the rest of the criteria.
> >

I checked - afs has d_automount and gfs2 is d_hash.
They do not qualify as any layer.

> > Is it simple to implement RENAME_WHITEOUT for fuse/virtiofs?
>
> Trivial.
>

So that leaves only fuse after implementing RENAME_WHITEOUT.
We are back in control ;-)

Thanks,
Amir.
