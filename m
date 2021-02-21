Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3C03207C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 01:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBUAC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 19:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhBUACN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 19:02:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8B6C061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 16:01:31 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f7so13863896wrt.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 16:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPnt5pC7I+BFJNB6/kd9/bZfyGGdpx3Y4Rea5qPAaSs=;
        b=WljTpLw5f8Sn0oX2VL1zgSHgYxiff09eS6JW7JTuSKgWwP0t17tOIk6KJ4evbEG7gA
         KIVMgZkBOyGmkeeTCMsHVzwCVHQNPseCAFLtYcZ/CBCZVNk1lVipZ706DO7A+/UvYkO3
         5JzyBpNqMI8nobcNr80IXSqPMH2p7WQ5b64hv8eNpX7qMhV+qI822nc0zxzsGftSA8l7
         jG4wn6Nm28SIOmW4rFcvHegmkeGlH81hAh5drI5+G/lvwYoAjElUVoFXPASNGx+GD9vz
         oNDyq7W37LYJbZKRvTzQFmEwybI3lwqFza89YvVr65yrmDydY6Mpa1aTw6NsdJj/KRPG
         GCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPnt5pC7I+BFJNB6/kd9/bZfyGGdpx3Y4Rea5qPAaSs=;
        b=dn/2Jru08BaLRq2tku154ruqhM7y7qk/oPzzXs1TTg/14v+PHb8PLRTwtRZwu8sPfi
         Idpa+wYKH8t0Np5+QKUB5LLWQ9PnPe/fP0HsLUNEdIy07Iz2o96WY9bkSbvVi6q7As4L
         SswEzuvxBRMCkm8XdRaEVI6SIbgCVg3quh1M9OwWjtAHAABWc31qeRxUL9C9QId3KRT+
         YlfNwki6jOE0TEm+9DMcdFCiTLrPrD4r01bE7TwbV2ng4lBiOKRYqTa4kcHg8Ofrp13o
         5MVIp7BFornUupgGHbPbVeKbYLV36I/Zcbb3qjI0MZZCLW+9ZVJvI6ih2PCRVX/ugyKh
         8cBQ==
X-Gm-Message-State: AOAM531ocheiplnrp1T5LGpgzoT1CQMIaZUvWRf7DKbV5skpNOif4Mej
        FXa3gqUdMh16UwOLybo3H1mlqNyqs6BHokJ14uir/Q==
X-Google-Smtp-Source: ABdhPJxAecuonuT6I9DSIBacbRvcfb2wbgMcqS3aHfGWHLoGoKTYRy11ONjmUF6dvz5pH5dlazlQGbUsudsr2IbU6Mk=
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr15086085wrx.403.1613865689043;
 Sat, 20 Feb 2021 16:01:29 -0800 (PST)
MIME-Version: 1.0
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com> <20210218121503.GQ2858050@casper.infradead.org>
 <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com> <20210218133954.GR2858050@casper.infradead.org>
 <b3e40749-a30d-521a-904f-8182c6d0e258@rkjnsn.net> <20210220232224.GF2858050@casper.infradead.org>
In-Reply-To: <20210220232224.GF2858050@casper.infradead.org>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Sat, 20 Feb 2021 16:01:17 -0800
Message-ID: <CAMj6ewPxYkoPuVmER7QuBfyDK4O9Ksr4OZTiGkpGvbg4kmxh6A@mail.gmail.com>
Subject: Re: page->index limitation on 32bit system?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 3:23 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Sat, Feb 20, 2021 at 03:02:26PM -0800, Erik Jensen wrote:
> > Out of curiosity, would it be at all feasible to use 64-bits for the page
> > offset *without* changing XArray, perhaps by indexing by the lower 32-bits,
> > and evicting the page that's there if the top bits don't match (vaguely like
> > how the CPU cache works)? Or, if there are cases where a page can't be
> > evicted (I don't know if this can ever happen), use chaining?
> >
> > I would expect index contention to be extremely uncommon, and it could only
> > happen for inodes larger than 16 TiB, which can't be used at all today. I
> > don't know how many data structures store page offsets today, but it seems
> > like this should significantly reduce the performance impact versus upping
> > XArray to 64-bit indexes.
>
> Again, you're asking for significant development work for a dying
> platform.

Depending on how complex it would be, I'm not unwilling to give it a
go myself, but I admittedly have no kernel development experience or
knowledge of how locking works around the page cache. E.g., I have no
idea if evicting the old page at an index before bringing in a new one
is even possible without causing deadlocks right and left.

> Did you try the bootlin patch?

While looking into it, I discovered that btrfs can't currently handle
mounting a filesystem that was created on a system with a different
page size. However, it sounds like there is currently work being done
to support subpage sector sizes, with read-only support coming in 3.12
and write support coming later, so hopefully the bootlin patch will be
helpful to bump my page size up to 64 KiB once btrfs support for it is
fully stable. Thanks!

It does feel like I'd just be kicking the can down the road a bit, but
hopefully it will turn out to be long enough for there to be either a
better fix or an AArch64 system that meets my needs by then (e.g., if
Kobol were to release a version of the Helios64 with ECC RAM).

I do appreciate your help and explanations.

Thanks!
