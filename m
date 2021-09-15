Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9037040CCD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 20:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhIOSzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhIOSzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:55:31 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF39C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 11:54:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q68so3623020pga.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FU15W3bm+SggfFBpu3PTbDkAmpOl9rR2fs66v56GTuA=;
        b=ci0GM5ZzWsDgYI4RF3fg/GEiOZ2FEpdwUx4HvXZ0z8NoNmt6ZvsTsrwErWm/Yzr37w
         gGOoKZXSetA44zYzYFlXcV//2m8UbC08VxxgJmEjTnRcQiXaBuE3e049pQqBypksWCbv
         zC1gXl4izxvk4l4mRD/cT3RPpvwRNQbo9GNWbwmuSYJXfcy+qLnKDIv+/SD6PWUp3dfr
         3Ixmo0TVLxVpVKw09Hlyrcq2Y8g2ZSrohbHgoc0yJmkQYobB04sEaOmRlOHHEONNVIIN
         o0BBNoMaUmRivPlqly+NRb/WpvJA4lyXTmA9x3C8KNsyEtJCMHbPttX7OVBMbKd4pUOS
         d7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FU15W3bm+SggfFBpu3PTbDkAmpOl9rR2fs66v56GTuA=;
        b=lNRtrovs+M47GwuaM2BdXiSjad7QRERfksmUZOaJd05/Kf4fJwxQATx4zxYhzyXWT0
         2qPWe5DkwSx2fpzLnHX/CqMieKuOAx12rj3LVlAG/9ThHwKQeuGazNpxJZStshDWwkfx
         vHX3DOj4VhAn7TMEfD5TMhlWyoi+r0KJulU8uWhKq8hL+w0MkDwUR5XPBpKaDQr3KAEv
         xKKwflvGRmzEMotWTDm59V7PIg5zAtsQU9X90VNLgicl6Gyol2lKHtV/+Y9AQA0+0Z0c
         OvBHbQx919OKc2aAQWJXRP/zRIR8l2xUvKqt0GlF9ma1XKL9q76FuiNEWmfoqhOvsiGK
         ei7A==
X-Gm-Message-State: AOAM533WSKRjDgtf3M+/96H9MAo6u+fvP+blJwgcK9PLE/BDQZzAkJz3
        fKXAgPAaTGRKCp5RKWD0lrLDXGmhucsaQxS4eKAKzg==
X-Google-Smtp-Source: ABdhPJw5Z+fp+HWidXw4oZTfP/Ym5ru7neeSncy6m/5gaRdoxV2Mu68YpHNJnhyVCYH0ucb176R4DyZvDmyH9UVELwg=
X-Received: by 2002:a05:6a00:1a10:b0:412:448c:89ca with SMTP id
 g16-20020a056a001a1000b00412448c89camr1010006pfv.86.1631732052381; Wed, 15
 Sep 2021 11:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <1631726561-16358-1-git-send-email-sandeen@redhat.com> <1631726561-16358-2-git-send-email-sandeen@redhat.com>
In-Reply-To: <1631726561-16358-2-git-send-email-sandeen@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 Sep 2021 11:54:01 -0700
Message-ID: <CAPcyv4jyo-z7Ndx2hD9hYtTP7Q4ccrEnc2vEqdhq-dct1D0_-Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] xfs: remove dax EXPERIMENTAL warning
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 10:23 AM Eric Sandeen <sandeen@redhat.com> wrote:
>
> As there seems to be no significant outstanding concern about
> dax on xfs at this point, remove the scary EXPERIMENTAL
> warning when in use.
>
> (dax+reflink is still unimplemented, but that can be considered
> a future feature, and doesn't require a warning for the
> non-reflink usecase.)

The original concern was that dax-reflink could not be implemented
without ABI regressions. As far as I can see that concern has been put
to rest by the proposed patches. Am I wrong? So, if we're committed to
not breaking past promises I think this change can be made
out-of-order from when the reflink support patches land.

Acked-by: Dan Williams <dan.j.williams@intel.com>

...but I'm also fine with waiting for the final reflink merge.
