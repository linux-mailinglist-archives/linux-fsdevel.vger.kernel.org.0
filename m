Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D35B2A4B0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 17:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgKCQUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 11:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgKCQUp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:20:45 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7649C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 08:20:45 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id l36so8482166ota.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfHKNEfHAycTuNeGSyfvVUrAbgf1eEXAewlPTf8XLYs=;
        b=K5/Ki8bV5UQXTZWjxXvupKBBt3l+kWP3mIPF/tkfigvTNSWB+gy0msQG0OGvRxRbe3
         zbp5RTSquIwBiGnluDKYQi0vZUwNJbtVkp001XC7+PAi9MgaDFcI8hDrmh3hpYc9xlLj
         H7rXR5qpaoPMgF+gfkQPuCGHia2nx3DyvZGys4i4W0iy0hscIQlAr/uu4cZDWhWfumqj
         5orXOkQh4s7eLDp2TG7IRLi2SpSHy2gy7csae4HCPLn1Q5VXmkyunvBwyYrx2nZWRIGD
         xKKjbGOaF1cC4hXwZRoa75EWyce5PVlNBuH5iID4tiaZ7qYJRmhpY0GFX/NQ+Pivv6rl
         kQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfHKNEfHAycTuNeGSyfvVUrAbgf1eEXAewlPTf8XLYs=;
        b=Qvbe2U+kjCzowt8uvjXhKUcvYQuyJweAq+9zK6Jh8xaKUca9fkcIKrvsLGDtHYHc4B
         jk7Nlmb8dbOhnrFXdBaPr1QJ3B9Rqn9uf3aOIG4BnvKBGEcjBomHDwG8Y5jsthdda87Z
         ZoDp4B7w6mOUPvKpHNVdCgzw7nvCBRDL8YjXPUT9aNXENTZHFyY3ly8uFwJYdsxqY9o1
         pY1PlT26ebey4i0XOYhMtqiKTANpK69rKms4OBSsutq/nW85Zekf8gEEXXymE4nQ6JyT
         OUlZI9oBGAaBI6KJWS5vadW/p0Ney9/S5PTapEuh6W9vmvRcv3blSS1ZZK9UgVf23zkQ
         BBkw==
X-Gm-Message-State: AOAM532BSGI5ukgGs86/u2v60kDL66dmH3BdS7rTwlmCFNxytIw9Pf2n
        /06tP6AoEUmLYPlRcBEddyPCxFxZy+Fy/VMK2no=
X-Google-Smtp-Source: ABdhPJxBw/eVBzeb7Cv/V4AsXkBa9pK+gwn5ESrR5wm3d12ZhSkHu78Ay4yyXasxExpRRwmIwXc4OdZOGM4gImj0eY4=
X-Received: by 2002:a9d:1b2:: with SMTP id e47mr10661508ote.45.1604420445292;
 Tue, 03 Nov 2020 08:20:45 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT6Q2-fC5Zo-dmjt9FJEt6ADmy1rijYX41aBmWwtO6Dp6Q@mail.gmail.com>
 <20201103153005.GB27442@casper.infradead.org> <CAE1WUT43_MT3p0B5S6sE9hcXQENGidDvQiWk31OKZH39jE8U7g@mail.gmail.com>
In-Reply-To: <CAE1WUT43_MT3p0B5S6sE9hcXQENGidDvQiWk31OKZH39jE8U7g@mail.gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 08:20:33 -0800
Message-ID: <CAE1WUT7OChDF8iGnZ5kdXPeBbesFmHpu8Cqw3h3EeNY1otWT0Q@mail.gmail.com>
Subject: Re: befs: TODO needs updating
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis's email appears to be broken right now. The mailer daemon
indicated an error on its end:

> <luis@other.computer> (expanded from <luisbg@kernel.org>): unable to look up
>     host other.computer: Name or service not known

Is this occurring for you as well?

On Tue, Nov 3, 2020 at 8:15 AM Amy Parker <enbyamy@gmail.com> wrote:
>
> On Tue, Nov 3, 2020 at 7:30 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Nov 03, 2020 at 06:58:55AM -0800, Amy Parker wrote:
> > > The current TODO in fs/befs/TODO is horrendously out of date. The last
> > > time it was updated was with the merge of 2.6.12-rc2 back in 2005.
> >
> > Probably a good idea to cc the listed maintainers ... no idea if they
> > subscribe to linux-fsdevel.
>
> I see you've now CCed the maintainers. I just went to the maintainer list when I
> noticed you did so. Thank you for adding them!
>
> Best regards,
> Amy Parker
> (they/them)
>
> >
> > > Some examples of points in the TODO that need a glance (I have no clue
> > > if these have been resolved as no one has updated the TODO in 20
> > > years):
> > >
> > > > Befs_fs.h has gotten big and messy. No reason not to break it up into smaller peices.
> > > On top of the spelling fix, fs/befs/Befs_fs.h no longer exists. When
> > > did this last exist?
> > >
> > > > See if Alexander Viro's option parser made it into the kernel tree. Use that if we can. (include/linux/parser.h)
> > > This parser is now at include/linux/fs_parser.h. It did make it in. Is
> > > such a shift still needed? Such header is never included in any files
> > > in fs/befs.
> > >
> > >
> > > Best regards,
> > > Amy Parker
> > > (they/them)
