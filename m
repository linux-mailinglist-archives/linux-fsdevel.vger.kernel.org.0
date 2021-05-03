Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B30372248
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 23:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhECVPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECVPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 17:15:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A399C061573;
        Mon,  3 May 2021 14:14:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q10so4711302pgj.2;
        Mon, 03 May 2021 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=It1zjPkEL+hRPlnEYkgjmUV8PVd1QmMXrrkuwW0r37g=;
        b=lTG86IjcKyoIJ6uC/ScuvVwBHIzejmkRjw1SHeXEQ9C3D2CVfelvUoxXvunTmZ18Ku
         3D9pk+TO0qajcURGY9ar2nLlIwOLL/24rK7QfgFOMRdlNk/DM3zHj5RjbBjSAQ/yicyV
         QzMoNUSyxyvSzD/+tFFfYkIU0FBJpntworf6AnlN7zlqVLPXes0fpAlM9/4w40u4Zexh
         EIIJmPSOwhSKI0xJCK12lRTfiZnYb/C6499kZoPR+Zr5e2CLLPWAAia6nI2BjM9n7psZ
         qDvKCFn90tXePEDdYB+30QvjojZHH9pdS3kUuoEmvandFfblt7vqz85pOZEfKablNBrX
         Cemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=It1zjPkEL+hRPlnEYkgjmUV8PVd1QmMXrrkuwW0r37g=;
        b=Ez727UL4T7g/d4SlnHDKlXP1r6SwnCR43pzx2t3ENB2sTktxap7TRRd3DmsWw9RJFb
         wwXXRrbYmh2Lu7AmlG7CUA8WF2qy9tglkiGL72oHPGAj0INt0Plfo5ul2dApzCu9RyZC
         tZHC/LS5ECYG7RmEPn51E8+JOYZjsdABjHcczDArGMeCG15RLhYG9dvVZdXq+QNjfdRX
         l8MkWYZ3cDVl2ENTXiO3dQwuYc49/q28ouWc0TBZfe9PdqWeF3Mr2dI7aYSiHlPUSOZt
         e/EmhJXInGGvZaWRm4RwAAh91DJgTNdLdoKA0yzClGus8uGEkEozhMYAQQeTSin5dawM
         D+oA==
X-Gm-Message-State: AOAM531ZkXtJh2bvYfcWZ3NAnaiVYbaWsSFld7QEZWLYH9tYzFQ4sCf2
        b0KcnIbLZZNB03TmmLWXbjK4OWZspMU7Y4D0dnIndMPSSKw=
X-Google-Smtp-Source: ABdhPJyRhL/uzKUtzrReo+/l3jvLDaJW1/oBGKS4XaEQaqH8bYH9B92wSyNqP0yfrBeUdXLFBo44AxR9PHFNEdDvvU8=
X-Received: by 2002:a17:90a:246:: with SMTP id t6mr8414352pje.228.1620076462906;
 Mon, 03 May 2021 14:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
 <20210503204907.34013-11-andriy.shevchenko@linux.intel.com>
 <YJBi5NU2WmZPYbBG@zeniv-ca.linux.org.uk> <CAHp75VfZKX_oYzoAA9Mbya1_+hP6+1mDKqyfy9d=hsokEAGQsQ@mail.gmail.com>
 <YJBmkNky4QfFhPD1@zeniv-ca.linux.org.uk> <CAHp75Vet8CN3Cx2Loi_7PiXyf_XX1FWF3uPB-jUS51UC5B8U_w@mail.gmail.com>
In-Reply-To: <CAHp75Vet8CN3Cx2Loi_7PiXyf_XX1FWF3uPB-jUS51UC5B8U_w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 00:14:07 +0300
Message-ID: <CAHp75VfogqstLpViF_+0YkAqFFTTHn0kt2j2n1Oe4CKVJUfPCQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/12] nfsd: Avoid non-flexible API in seq_quote_mem()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 4, 2021 at 12:11 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, May 4, 2021 at 12:09 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Mon, May 03, 2021 at 11:56:41PM +0300, Andy Shevchenko wrote:
> > > On Mon, May 3, 2021 at 11:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:

...

> > > Any suggestions how to replace that API with a newer one?
> >
> > seq_escape_mem(), perhaps?
>
> I think I have a better idea. What about adding seq_escape_with_flags()
> and seq_escape() --> seq_escape_with_flags(..., ESCAPE_OCTAL, ...) ?
>
> Would it work for you?

Ah, it wouldn't work for the user, because it wants to pass the buffer size.
Okay, I'll take your suggestion, thanks!

-- 
With Best Regards,
Andy Shevchenko
