Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D5925745E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgHaHeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 03:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgHaHed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:34:33 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16760C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 00:34:33 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g11so1711061ual.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQtCZV6OcGw1uD1dzGqgWCbvYywzacdDufrrrKQpbMc=;
        b=SN+/PgW4HCg5Bepl+5Q/FJF8EugFG/wvFJigTotEyZWulsoHaj4W6E+41pCgVq/bf0
         hYAec+0/FHePRZfa0D24u1U4UddCRBqAvDevnL6pujM7m5THWX2TsIQpbb5VckIfu8E0
         HnUQblEnFThSLB8H1nCtSAh8tDMplqc7jB2z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQtCZV6OcGw1uD1dzGqgWCbvYywzacdDufrrrKQpbMc=;
        b=njcD1GB8P6x3cswuCnorgjVCi0HyN7k5tnirrNimM3hCvoXAwUb4E+9JF9a9NtfXuN
         rJuF8wcrg3cLbY5oZLY5g4/jikjgHC/QiOY1CYe7EaWEIooHDOC/VL+m6k/yXEWsPa/F
         pcVqL0xSndHMrrioW5g+cUwGC9TFgOGoIWnERfaGX/nqDWd2rqb3EeIT9vtwgUfSGsQc
         kU2gD0VVReMe3Dp0D4NtB7vV3u3U9CR4dMG/9843EYtT6hdagqJ70/SMnKfiyojt47iM
         viw93W+VbpJWQSrhrTggfQpltsTc37ZRCZ9n9zhm4y+rf4mR2SZpUAN/Xs13sA8u+sLx
         IVUA==
X-Gm-Message-State: AOAM530EEz6BrosUF7a4DMYdB/adOfBH9mbj2j6FLYlReRtIE7oYuy6t
        fJEW87OQZUQ0YcLTwDcIOM3EUr+WaUzYU4ril8xrpQ==
X-Google-Smtp-Source: ABdhPJyW1ztwNEzOg6Z0sH0/cohRECp1L2Q+qXcUuH5/RZHAzIE+IYH3II/FmsQJWvhDTXDLJzyLjnyLjBSYDj+Dah4=
X-Received: by 2002:ab0:5611:: with SMTP id y17mr4898688uaa.137.1598859272050;
 Mon, 31 Aug 2020 00:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200817002930.GB28218@dread.disaster.area> <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area> <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk> <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
 <20200829180448.GQ1236603@ZenIV.linux.org.uk> <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk> <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
 <20200830191016.GZ14765@casper.infradead.org>
In-Reply-To: <20200830191016.GZ14765@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 31 Aug 2020 09:34:20 +0200
Message-ID: <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
Subject: Re: xattr names for unprivileged stacking?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 30, 2020 at 9:10 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Aug 30, 2020 at 09:05:40PM +0200, Miklos Szeredi wrote:
> > Yes, open(..., O_ALT) would be special.  Let's call it open_alt(2) to
> > avoid confusion with normal open on a normal filesystem.   No special
> > casing anywhere at all.   It's a completely new interface that returns
> > a file which either has ->read/write() or ->iterate() and which points
> > to an inode with empty i_ops.
>
> I think fiemap() should be allowed on a stream.  After all, these extents
> do exist.  But I'm opposed to allowing getdents(); it'll only encourage
> people to think they can have non-files as streams.

Call it whatever you want.  I think getdents (without lseek!!!)  is a
fine interface for enumeration.

Also let me stress again, that this ALT thing is not just about
streams, but a generic interface for getting OOB/meta/whatever data
for a given inode/path.  Hence it must have a depth of at least 2, but
limiting it to 2 would again be shortsighted.

Thanks,
Miklos
