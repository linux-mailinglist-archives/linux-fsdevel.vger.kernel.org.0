Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1A42A4AF8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 17:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgKCQQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 11:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgKCQQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:16:02 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993F6C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 08:16:00 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id d9so12920164oib.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h74FlqMCzevL0NWt5YLJSOuU0/HUp2gkHFAS40/XbmE=;
        b=LqSLmgidOnJaKdAH3/FANeU8y6X6eBJtQhM/sjrBUm38vakMONJNjH2ASzUA28vaAC
         W2V+vkn4SVQUt43z8DSP1m7ZKJVGwCuOcNrBfQCDpHMWq5KlLCSn+/WGGmCbGOtZmRuF
         ihRhAhsEdWYfIQ3+dzMS5t5SQyPfbdcEzoq3o7jthQRjn8nmEYXlQJqaXmQhDfA+fSHZ
         nXPVXKOpgVzg4gf25uIIEb6MtDdMjp6raoQkqGfrT+aht9N6EevG3QGO3gmue2C1ZDxL
         UE7UG5lrCHqZQiqcYpDX4LJkP9wFGUfJ+QBElrRKvAcIdHq4Zlo23sAhCLj4K2F6dDOZ
         VrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h74FlqMCzevL0NWt5YLJSOuU0/HUp2gkHFAS40/XbmE=;
        b=j/hiF47/RqfjEttgXRZnZcd9gmr943OxP6ke4fX72LaMiBiwpulsTJdlt48T5ZpOCa
         G5fH4+rlVzrvarWog6oUes1rqWgHyLhA/nDVskCB5aRSzy2DvXkINNLABO0uQNeTXhU1
         qcor0L6mnDvNOQyyGV9CGIMp9B67Or0sFecW0+bnm1yNWizBB6YKwHb/R6wIpinL/ElE
         NiHE1BksO1TRea6mihLMGwYQL1Sg4SAIUQg8gABBABnsFiu56Kq443OCTydAyhI7pBzv
         AyGZLs/fqTevkFXFXr9vUVEAiCzzbNC2UFglaugyCMuCALE3R17cHAxuTvl5bQU+cMfn
         7Jww==
X-Gm-Message-State: AOAM531Ze5h9gtGxUrLDdLwK9FLqppHUx6ayQVtondcauEzhq4XPZ8Uz
        u8GUh9u0sFFzX+77go2fcVqv7X407U3CeT22kWk=
X-Google-Smtp-Source: ABdhPJwcqZ2Gr0157XRHgeEWFfWEgXO5c0CSjq6oKpNpinvkPGxcG4g4QwCfdtNQPd7hZJsbzXKT8IRHe8mepiEviwk=
X-Received: by 2002:aca:2111:: with SMTP id 17mr260303oiz.139.1604420160020;
 Tue, 03 Nov 2020 08:16:00 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT6Q2-fC5Zo-dmjt9FJEt6ADmy1rijYX41aBmWwtO6Dp6Q@mail.gmail.com>
 <20201103153005.GB27442@casper.infradead.org>
In-Reply-To: <20201103153005.GB27442@casper.infradead.org>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 08:15:48 -0800
Message-ID: <CAE1WUT43_MT3p0B5S6sE9hcXQENGidDvQiWk31OKZH39jE8U7g@mail.gmail.com>
Subject: Re: befs: TODO needs updating
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 3, 2020 at 7:30 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 03, 2020 at 06:58:55AM -0800, Amy Parker wrote:
> > The current TODO in fs/befs/TODO is horrendously out of date. The last
> > time it was updated was with the merge of 2.6.12-rc2 back in 2005.
>
> Probably a good idea to cc the listed maintainers ... no idea if they
> subscribe to linux-fsdevel.

I see you've now CCed the maintainers. I just went to the maintainer list when I
noticed you did so. Thank you for adding them!

Best regards,
Amy Parker
(they/them)

>
> > Some examples of points in the TODO that need a glance (I have no clue
> > if these have been resolved as no one has updated the TODO in 20
> > years):
> >
> > > Befs_fs.h has gotten big and messy. No reason not to break it up into smaller peices.
> > On top of the spelling fix, fs/befs/Befs_fs.h no longer exists. When
> > did this last exist?
> >
> > > See if Alexander Viro's option parser made it into the kernel tree. Use that if we can. (include/linux/parser.h)
> > This parser is now at include/linux/fs_parser.h. It did make it in. Is
> > such a shift still needed? Such header is never included in any files
> > in fs/befs.
> >
> >
> > Best regards,
> > Amy Parker
> > (they/them)
