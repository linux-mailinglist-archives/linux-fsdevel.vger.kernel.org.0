Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FE336096D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhDOMbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 08:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhDOMbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:31:14 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E40C061574;
        Thu, 15 Apr 2021 05:30:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w8so12487773pfn.9;
        Thu, 15 Apr 2021 05:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oc2rPOnWzyrclF7F9nO0fBn/63oDkmp1ea78ZK6nw5g=;
        b=Ma5rHnfELxLsbqH1af038TLPuGBjDd1FDm/XDEE6R75L8LcUmVbO9rcye6GLssvxEA
         QDF32oC/D6f6IrYUmqo9Y3UHWGLmGl2LTvi8T4JjXjRthmr8y1RduQucDw9N1TBMY+55
         vjop4ur7AGbVCu/6iUyvMKmy1u8z6YpR/j9tV6qAGKUlcx57mwdoFX9TDbvczt0sgpDh
         coTfFQfmM3X/spRr+acqJ6KWIBVCpqljaSGOhtbbZfgTXj9frz04rBlO2Hr6tx6cTTWk
         xk8FYrx1JUA8aZghQKnQOZyFlE7okttPFC7nqLjCJ+grVZodriJcy4UE4cv+HWXceTdU
         Z20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oc2rPOnWzyrclF7F9nO0fBn/63oDkmp1ea78ZK6nw5g=;
        b=U/CtfycdI7mFXEiRiG/NSy/vrXUX4XmZG1LX8euAIIFixGiWijsEft5yK6UJiGBdvp
         4ilgfzx8ymx56Wyc6IsxfegARwIMhOAa15+76C7las/aIlioh2zsGlSefHfwFtLWis7T
         9fk4nAx4ACFpfXYB27naE8Sy6RCU1NGqi5Er6UCji8b7B/wNqSVfv6AgXWXX5x8iuqSU
         emTy+UVgaGShGYnlTs/CJRT5wZ+MeBfePhDiVvMgGPuYXketVv0hbANu835IXsKjX96Y
         OMshFuHW74jR82Z2Et7FyWtJB1v7WGLAi0W28HIn8C1LFT91g/Ao7CvMFUdbrZPiLZxY
         ZhVg==
X-Gm-Message-State: AOAM532d9rXLjWJafl0wJZAf0k6s/eV+u1MoFlD/SrP315lmINq9pqWp
        mu2S886kpehoYDDlfAZaZGF0p46gvAw82mKb3+yd6ZP2n/8=
X-Google-Smtp-Source: ABdhPJz5GeIzW1eATHfdoBVFSQCgTq8fgQSaigNe1rclRFnPH2uLQCCEljnXanBpyq/PGxIwE/mXKugLiEbAnC57fnI=
X-Received: by 2002:a63:cb42:: with SMTP id m2mr3248502pgi.140.1618489851103;
 Thu, 15 Apr 2021 05:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <807bb470f90bae5dcd80a29020d38f6b5dd6ef8e.1616826872.git.baolin.wang@linux.alibaba.com>
 <f72f28cd-06b5-fb84-c7ce-ad1a3d14c016@linux.alibaba.com> <CAJfpegtJ6100CS34+MSi8Rn_NMRGHw5vxbs+fOHBBj8GZLEexw@mail.gmail.com>
 <CA+a=Yy4Ea6Vn7md2KxGc_Tkxx04Ck-JCBL7qz-JWecJ9W2nT_g@mail.gmail.com> <CAJfpegtXJ=waad2SNtru90Nn6f4yOkRD5Pot9K-13z249PjFgg@mail.gmail.com>
In-Reply-To: <CAJfpegtXJ=waad2SNtru90Nn6f4yOkRD5Pot9K-13z249PjFgg@mail.gmail.com>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Thu, 15 Apr 2021 20:30:40 +0800
Message-ID: <CA+a=Yy57TdKEpEn0SC8zBCm8KmMuAYwSDqS=vtownzyt9qD6bA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: Fix possible deadlock when writing back
 dirty pages
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 9:20 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Apr 14, 2021 at 2:22 PM Peng Tao <bergwolf@gmail.com> wrote:
> >
>
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -1117,17 +1117,12 @@ static ssize_t fuse_send_write_pages(str
> > >       count = ia->write.out.size;
> > >       for (i = 0; i < ap->num_pages; i++) {
> > >               struct page *page = ap->pages[i];
> > > +             bool page_locked = ap->page_locked && (i == ap->num_pages - 1);
> > Any reason for just handling the last locked page in the page array?
> > To be specific, it look like the first page in the array can also be
> > partial dirty and locked?
>
> In that case the first partial page will be locked, and it'll break
> out of the loop...
>
> > >
> > > -             if (!err && !offset && count >= PAGE_SIZE)
> > > -                     SetPageUptodate(page);
> > > -
> > > -             if (count > PAGE_SIZE - offset)
> > > -                     count -= PAGE_SIZE - offset;
> > > -             else
> > > -                     count = 0;
> > > -             offset = 0;
> > > -
> > > -             unlock_page(page);
> > > +             if (err)
> > > +                     ClearPageUptodate(page);
> > > +             if (page_locked)
> > > +                     unlock_page(page);
> > >               put_page(page);
> > >       }
> > >
> > > @@ -1191,6 +1186,16 @@ static ssize_t fuse_fill_write_pages(str
> > >               if (offset == PAGE_SIZE)
> > >                       offset = 0;
> > >
> > > +             /* If we copied full page, mark it uptodate */
> > > +             if (tmp == PAGE_SIZE)
> > > +                     SetPageUptodate(page);
> > > +
> > > +             if (PageUptodate(page)) {
> > > +                     unlock_page(page);
> > > +             } else {
> > > +                     ap->page_locked = true;
> > > +                     break;
>
> ... here, and send it as a separate WRITE request.
>
> So the multi-page case with a partial & non-uptodate head page will
> always result in the write request being split into two (even if
> there's no partial tail page).

Ah, good point! Thanks for the explanation. I agree that it can fix
the deadlock issue here.

One thing I'm still uncertain about is that fuse used to fill the
page, wait for page writeback, and send it to userspace all with the
page locked, which is kind of like a stable page mechanism for FUSE.
With the above change, we no longer lock a PG_uptodate page when
waiting for its writeback and sending it to userspace. Then the page
can be modified when being sent to userspace. Is it acceptable?

Cheers,
Tao
-- 
Into Sth. Rich & Strange
