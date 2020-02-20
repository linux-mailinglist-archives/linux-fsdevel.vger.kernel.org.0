Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9E61658D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 08:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgBTHw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 02:52:58 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38176 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgBTHw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:52:57 -0500
Received: by mail-il1-f196.google.com with SMTP id f5so22949792ilq.5;
        Wed, 19 Feb 2020 23:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1oB3Q6IOsGJuHSkpjxVpkQ8YE2VHk/UEGZOTbpLfio=;
        b=TkbVniFyW6q+bRvCNwF6Mt/IOqV2WWLn8V7VNK+KeuRqOgpD52VFlflBwWuKHWfBlR
         DWS/F0GghTl8OpYUhtBbLTsAZF3VUmVJu/mwTA3F2PTkHzfk3TpWtJ1bRcGkBO3LZww6
         etZsp+T1IqhnOP622ZEdGC9WqmZOa8Pltkli8s6RLnxXrQOyeoMD3uGaNlG7HRT8qBDl
         zXHWUGXAiC/B/iyT4yLmizV16fnt/jdmkKgIcwEE63OfBcvSuNpbhTFXSWagxR0QUYrT
         e9DLkqGGhQtDL+sLlIy9ltuGILbC+uF4T/Ovz/B6QhBUA8R4DyfjDp8G17BmrHcBNdQB
         cW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1oB3Q6IOsGJuHSkpjxVpkQ8YE2VHk/UEGZOTbpLfio=;
        b=M4p+zA+zWI8AKa06E8KbAwpo+8uLGUf5Pb0DArk1dqEIwcMRxPWFa6bQ5fmjGhD4KN
         SEfsvh4uEg3iaxYC7/PVA9lEz8Q6Xudgfy1JpIIibXGwrXbxEkKS/x31928HUHaVW7j1
         gZ2Gp/hZbRGC2v6SszXJkgF6BCM35QKJ3ixB9v0bAT25uqfwxMQGZgDvYXgJbCvS3pRC
         ke998Q7D9lUsfjCsibAbOemZ18Jpw1MDK8V1cmmuil1lMfHszMzomY/Q4zR8tqrw4NBe
         lhTkZQ5jCs1Jzy8A0CbOv9a8t2bjh0dfzLkYZXl7D50Z4SownnUI38YjLRHutTKxqBYq
         rTMw==
X-Gm-Message-State: APjAAAXCXj2TQjp0PwpS02Vu0lcWynMeWNNrBjm/lJmt1y3DAZkvTIRr
        2VsrYXZ1EvRllJO/rTgdJo/6uPN7ySCpd39fPO0=
X-Google-Smtp-Source: APXvYqx6OY5EmxBMVHe2XA4Dyn9uCB3yodVd7TZVKcVVil5nlz5MMARXh5CfRRcI4Bi7mwLw1PEIcICfYsQo0A04JRg=
X-Received: by 2002:a92:8656:: with SMTP id g83mr29006690ild.9.1582185177120;
 Wed, 19 Feb 2020 23:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
 <20200204145951.GC11631@redhat.com> <CAJfpegtq4A-m9vOPwUftiotC_Xv6w-dnhCi9=E0t-b1ZPJXPGw@mail.gmail.com>
 <CAOQ4uxj_pVp9-EN2Gmq9j6G3xozzpK_zQiRO-brx6PZ9VpgD0Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxj_pVp9-EN2Gmq9j6G3xozzpK_zQiRO-brx6PZ9VpgD0Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 20 Feb 2020 09:52:46 +0200
Message-ID: <CAOQ4uxjFYO28r+0pY+pKxK-dDJcQF2nf2EivnOUBgrgkYTFjPQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 4, 2020 at 7:02 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Feb 4, 2020 at 6:17 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, Feb 4, 2020 at 3:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Fri, Jan 31, 2020 at 12:50:04PM +0100, Miklos Szeredi wrote:
> > > > No reason to prevent upper layer being a remote filesystem.  Do the
> > > > revalidation in that case, just as we already do for lower layers.
> > > >
> > > > This lets virtiofs be used as upper layer, which appears to be a real use
> > > > case.
> > >
> > > Hi Miklos,
> > >
> > > I have couple of very basic questions.
> > >
> > > - So with this change, we will allow NFS to be upper layer also?
> >
> > I haven't tested, but I think it will fail on the d_type test.
>
> But we do not fail mount on no d_type support...
> Besides, I though you were going to add the RENAME_WHITEOUT
> test to avert untested network fs as upper.
>

Pushed strict remote upper check to:
https://github.com/amir73il/linux/commits/ovl-strict-upper

FWIW, overlayfs-next+ovl-strict-upper passes the quick xfstests,
except for overlay/031 - it fails because the RENAME_WHITEOUT check
leaves behind a whiteout in workdir.
I think it it is not worth to cleanup that whiteout leftover and
easier to fix the test.

Thanks,
Amir.
