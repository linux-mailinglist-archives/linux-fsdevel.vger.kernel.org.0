Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3848E806
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jan 2022 11:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbiANKDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jan 2022 05:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiANKDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:03:31 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F389C061574;
        Fri, 14 Jan 2022 02:03:31 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so7114609pjl.0;
        Fri, 14 Jan 2022 02:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6C6u8TBdc9M8p01GH9e4dr/uBTHy41NUIFTVoZys3s=;
        b=AWImLrAs920lXTMlJh1le5mebyLF8myq0jAjgSxB7poe4xKclRAZnV1wwiTAeZwg7l
         gOPwBezlQW1DrpOhR5tO7z9GP0NIS5iXqYs468SWoedP4tvmCToTiQQXLIgyawCNGCKB
         /1vn7uFHOypitUcOUQ4yD5fy1p1BJ+DByEOkkIXWRFP1MEDXI9kaocPtp3/kffXoHH7a
         /debY7bmd5TweIrldcsgcMKd61jpC2tBAUl9Pjgg7eVO/9kxdYRoN+N98SMYGDmCUZtJ
         LMRGyqfY31Lt7VTuWxSrm9i0yJ1SGHPcfWPnd0SKggOrbM8k+36j4ofYabvUv+plAoa6
         5Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6C6u8TBdc9M8p01GH9e4dr/uBTHy41NUIFTVoZys3s=;
        b=WM+dFjkJULOc5bg7R8PFzZalUwXRkMvbq7wasibC5eU0UyccrcwnI+gBlyi/mckZDH
         64xQ3iweW8kdd+O71duNIbzBqkQHyJ6YJtJBcp61rTA6WLJCtt5dslDgXHLozMQM8kIo
         WS3vHQPpFBmBfK3PFzOfbvi4rE1cT92R25lmRTM4MGW95llXiWLoqkpUhSzhuMs7EuTn
         rH1F3gGABvPK551AEW5OFf3fq8aqRVzRXWOxJJf4ml5SoGjx09u4Y/KawVqmC12B0UsC
         Fk+r/n5G9b0P4nOQFiPPKDTDo3NTD3zLFM+M/ajimZ3w6tqEI1cFliHqwYFEawO8KXTh
         C5Lg==
X-Gm-Message-State: AOAM531gEtuWHN83AclmkPzVCsl5buAjAqksdh7tQuWKCMebTHpY+hvY
        qLb3RGCuURpgWBCKhIgU52P+Mn0Ob5mUm+K4Jmo=
X-Google-Smtp-Source: ABdhPJzFXa1+5zcRjtQjdRUQ9nz12FaliOO8vqTVftxdvQWzLH3ulk1/Iqq/aVM9G7JxKxcAYpWnfmMhIj8CRQKjUSY=
X-Received: by 2002:a17:90a:a588:: with SMTP id b8mr19504354pjq.25.1642154611189;
 Fri, 14 Jan 2022 02:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20220112143517.262143-1-sxwjean@me.com> <20220112143517.262143-3-sxwjean@me.com>
 <YeBFxBwaHtfs8jmg@dhcp22.suse.cz>
In-Reply-To: <YeBFxBwaHtfs8jmg@dhcp22.suse.cz>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Fri, 14 Jan 2022 18:03:04 +0800
Message-ID: <CAEVVKH-L-6Yra75XEWUNiq=ajJmtWauDTcmN=b1VCcJ0NVS7OA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] proc: Add getting pages info of ZONE_DEVICE support
To:     Michal Hocko <mhocko@suse.com>
Cc:     Xiongwei Song <sxwjean@me.com>, akpm@linux-foundation.org,
        David Hildenbrand <david@redhat.com>, dan.j.williams@intel.com,
        osalvador@suse.de, naoya.horiguchi@nec.com,
        thunder.leizhen@huawei.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

HI Michal,

On Thu, Jan 13, 2022 at 11:31 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 12-01-22 22:35:17, sxwjean@me.com wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > When requesting pages info by /proc/kpage*, the pages in ZONE_DEVICE were
> > ignored.
> >
> > The pfn_to_devmap_page() function can help to get page that belongs to
> > ZONE_DEVICE.
>
> Why is this needed? Who would consume that information and what for?

It's for debug purpose, which checks page flags in system wide. No any other
special thought. But it looks like it's not appropriate to expose now from my
understand, which is from David's comment.
https://lore.kernel.org/linux-mm/20220110141957.259022-1-sxwjean@me.com/T/#m4eccbb2698dbebc80ec00be47382b34b0f64b4fc

Regards,
Xingwei
