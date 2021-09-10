Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E347D406B4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 14:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhIJMUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 08:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhIJMUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:20:39 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BDEC061574;
        Fri, 10 Sep 2021 05:19:29 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id y128so2648823oie.4;
        Fri, 10 Sep 2021 05:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7N91pqKq8beoDgw/AQ3VlvWVBfWO9GtOToYGj0IQ50=;
        b=IfqToNnCoZ3YN849dLmvG2gmwSx4vYcHgCOoDaef6PE96595XSw607vvL2Q6ZdEhEh
         Ovq1ccG9+u6oCuRkvnNU/7RTWcNpBJb0+LKE1R204Uva1Seuuch9iafDI9t+btT6F32f
         MiXsC5f6gSi32ULZGxjNYfqEht3ULsY+dEAM1ZOyfVPVF2G3KtlvpeqHpbSE47MvkeIU
         4zM4niLWK4mY0RCEslasUbsEm0wf3kreZtpyh9gGgC+RSqzUYU0t0vuUSqhUWlR0hX0b
         uZ03efzVqLnFZYEMXCZwnzgixAjC7vQK3fDAWB4UQFnMPibXNXBhyOFfmvm0obk/O0Uk
         uFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7N91pqKq8beoDgw/AQ3VlvWVBfWO9GtOToYGj0IQ50=;
        b=p/U6jEKo1wTAzU4A52+uPpIEVxjxdLPGygfSalBzsEyEDTs3eY7cki4rdXucnDYBoy
         YZaOLAWg4edXBTtqYpKbHuOwpaRKSMojQCru4udtisna2AL18MkPTzSz0oGO/ViP5J2m
         hPccHeJ72gWy0FATE0t/RWbi0Ucdykh/zJP4ImgHOQDMkscNaEEhHf8+/wlx9LhvH4Q4
         V86DPBcBovH3WFzFSsyAOdRPvMd+qUQP6Y93W/uNlB4fGuj1TsorEsYVLhsgpESk5CAp
         5zgJDAIKUOrjaddeZrsr7JGPq6fGol94f/YgaZ6ArG6EwskYNlBv4YdrpAWrVd6vNglN
         RVTQ==
X-Gm-Message-State: AOAM5331oUyc0tXxZ40lQKOpMJT09MVjICzTvVFH4KAGLLbVBeHQu0Cq
        0vZgtED9uuW5f+Rof7h2oHKdEoEP/Xdo1IigREMp3z5q8ROtBg==
X-Google-Smtp-Source: ABdhPJybGAvirYtlTNGtvzGtavu0JzXzwICVUsbU6PRjwVVdmxgANHwypFZZP1w7wnvqQ/WjLk0+aZtUuW7M0S/w+IQ=
X-Received: by 2002:a05:6808:1a19:: with SMTP id bk25mr3821810oib.62.1631276368327;
 Fri, 10 Sep 2021 05:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZVDJAJa+j=hx2JswdvS35t9VU6TYF3uDZnzZ5hhtSzo9E-LA@mail.gmail.com>
In-Reply-To: <CAJZVDJAJa+j=hx2JswdvS35t9VU6TYF3uDZnzZ5hhtSzo9E-LA@mail.gmail.com>
From:   Kari Argillander <kari.argillander@gmail.com>
Date:   Fri, 10 Sep 2021 15:19:16 +0300
Message-ID: <CAC=eVgQKOdNbyDf2Qf=O9SnG=6nAGZ-nyuwOosf7YW5R3xbVLw@mail.gmail.com>
Subject: Re: ntfs3 mount options
To:     Marcos Mello <marcosfrm@gmail.com>, ntfs3@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

10.09.2021 14.23 Marcos Mello (marcosfrm@gmail.com) wrote:
> Hi, sorry email you directly, but this mailing list thing is cryptic
> to me.

I CC also lists to this so now everyone knows. Also CC couple
others who might be interested to talk about this.

> I was reading your patches cleaning up ntfs3 documentation and
> realized some mount options diverge from NTFS-3G. This will make
> udisks people unhappy.

This is true. They also diverge from the current NTFS driver. We have
talk about it a little bit and before ntfs driver can go out from kernel we
need to support those flags or at least some. udisk currently does only
support NTFS-3G and it does not support kernel ntfs driver. So nothing
will change.

I also agree that we should check mount options from ntfs-3g and maybe
implement them in. Maybe we can just take some mount options with
deprecated and print that this option is meant to use with ntfs-3g please
note that this is kernel ntfs3 driver or something. It would still work for
users. Ntfs-3g contains imo lot of unnecessary flags. Kernel community
would probably not want to maintain so large list of different options.

Ntfs-3g group also has acounted problems because they say that you
should example use "big_writes", but not everyone does and that drops
performance. Driver should work good way by default. And only if there
is really demand there should be real mount option. But like I said, maybe
we should add "fake" ntfs-3g options so if some user change to use ntfs3
it will be pretty painless.

> NTFS-3G options:
> https://github.com/tuxera/ntfs-3g/blob/edge/src/ntfs-3g.8.in
>
> UDISKS default and allowed options:
> https://github.com/storaged-project/udisks/blob/master/data/builtin_mount_options.conf
>
> For example, windows_names is not supported in ntfs3 and
> show_sys_files should probably be an alias to showmeta.

Imo windows_names is good option. There is so many users who just
want to use this with dual boot. That is why I think best option would
be windows_compatible or something. Then we do everything to user
not screw up things with disk and that when he checks disk with windows
everything will be ok. This option has to also select ignore_case.

But right now we are horry to take every mount option away what we won't
need. We can add options later. And this is so early that we really cannot
think so much how UDSIKS threats ntfs-3g. It should imo not be problem
for them to also support for ntfs3 with different options.

> Also, is NTFS-3G locale= equivalent to ntfs3 nls=?

Pretty much. It is now called iocharset and nls will be deprecated.
This is work towards that every Linux kernel filesystem driver which
depends on this option will be same name. Ntfs-3g should also use
it.

> Thank you a lot for all the work put into ntfs3!
>
> Marcos
