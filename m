Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE221F1AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 14:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgGNMlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 08:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGNMlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:41:00 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A085C061755;
        Tue, 14 Jul 2020 05:41:00 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id h16so14006954ilj.11;
        Tue, 14 Jul 2020 05:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=CQxvrB4Ck+AM0oxmbx8eCSq9nhQ1PCpNHzf0lmr96vg=;
        b=ga0CTMGTwJDVmPUhlnhcQSfJKHbC4PWnapFc/JS7c4VfXoyeP/5lJJT9abB3RmqUL3
         /FfcIdUWEhD3fb3i2d1KAey+Ld2JEo4I1wRZPUJVj64JoADUY5fht3ELiu37EN0aD8Ga
         WPjiWIcF63MHGUa7/48r9JXnCOXhI5JbonZB20KhyHdVW4m8ue3jJs3js3/eTiUzEqQJ
         HwSUfIkDrZI8dVcvxEHnSbnhUpn4FckMpY2CmK6SXLR0b20lnQ2MsY/6krYaN6iVFLbu
         A4PE07ZL04tWrUKIkTOAZckq6eYUY7GYV5FFL5JPhQvq0VKxWZ+2JFoYQwv6pdZFoDRu
         JtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=CQxvrB4Ck+AM0oxmbx8eCSq9nhQ1PCpNHzf0lmr96vg=;
        b=Ps0sbfvXET8lsHyDdiMpYpQ0HXmHws3vmQtOcfMdd7uUa49a8CIVQb9K3UHDOnrsdV
         I3XI8xVg+vS43kCUy0/7JOSeAGkeSAHpdBfYoN/M/v4lNFLcU1DKxgeGNJlBJpmMfZzy
         kPfcQxl5BWoaEm6nRN/MKit80sz6wWbZ5ebn1bqVmntiV0mB+m4gifPTGgGyX5s8I+D1
         d5LGIvfJcZQ002kUzTQ+VKMOEHgDQynHysf1Adn8nShpyn/Grgk2fujI55lnIszegvdW
         iQCWARpA1x9/dpEotocSZjBomUDwTGmeXIQynrLJOTAcyTz1gH0R+byJNG28OpWy0Iy5
         ypbA==
X-Gm-Message-State: AOAM530+rTUfPGOwK4y4VBHTH7UjVsqsCuTks9x5TTAmnB7bBHhfz3NO
        RiNtHrWhA0re7o2xFnSmlw1sVHrFZ1HXsgxWSuQ/iZB+
X-Google-Smtp-Source: ABdhPJyg9ZaTVjh6vZ4UADzqTQ+qZ6bmDOHwvz/El17YlTw1wCLH3Ue9zzVnJXc9mX5mvm3mLBC02UAz3C/t3TrMOnQ=
X-Received: by 2002:a92:290a:: with SMTP id l10mr4829633ilg.204.1594730459517;
 Tue, 14 Jul 2020 05:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
 <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com> <CAJfpegupeWA_dFi5Q4RBSdHFAkutEeRk3Z1KZ5mtfkFn-ROo=A@mail.gmail.com>
 <8da94b27-484c-98e4-2152-69d282bcfc50@virtuozzo.com> <CAJfpegvU2JQcNM+0mcMPk-_e==RcT0xjqYUHCTzx3g0oCw6RiA@mail.gmail.com>
In-Reply-To: <CAJfpegvU2JQcNM+0mcMPk-_e==RcT0xjqYUHCTzx3g0oCw6RiA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 14:40:47 +0200
Message-ID: <CA+icZUXtYt6LtaB4Fc3UWS0iCOZPV1ExaZgc-1-cD6TBw29Q8A@mail.gmail.com>
Subject: Re: [PATCH] fuse_writepages_fill() optimization to avoid WARN_ON in tree_insert
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vasily Averin <vvs@virtuozzo.com>, linux-fsdevel@vger.kernel.org,
        Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 6:16 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Jul 13, 2020 at 10:02 AM Vasily Averin <vvs@virtuozzo.com> wrote:
> >
> > On 7/11/20 7:01 AM, Miklos Szeredi wrote:
> > > On Thu, Jun 25, 2020 at 11:02 AM Vasily Averin <vvs@virtuozzo.com> wrote:
> > >>
> > >> In current implementation fuse_writepages_fill() tries to share the code:
> > >> for new wpa it calls tree_insert() with num_pages = 0
> > >> then switches to common code used non-modified num_pages
> > >> and increments it at the very end.
> > >>
> > >> Though it triggers WARN_ON(!wpa->ia.ap.num_pages) in tree_insert()
> > >>  WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
> > >>  RIP: 0010:tree_insert+0xab/0xc0 [fuse]
> > >>  Call Trace:
> > >>   fuse_writepages_fill+0x5da/0x6a0 [fuse]
> > >>   write_cache_pages+0x171/0x470
> > >>   fuse_writepages+0x8a/0x100 [fuse]
> > >>   do_writepages+0x43/0xe0
> > >>
> > >> This patch re-works fuse_writepages_fill() to call tree_insert()
> > >> with num_pages = 1 and avoids its subsequent increment and
> > >> an extra spin_lock(&fi->lock) for newly added wpa.
> > >
> > > Looks good.  However, I don't like the way fuse_writepage_in_flight()
> > > is silently changed to insert page into the rb_tree.  Also the
> > > insertion can be merged with the search for in-flight and be done
> > > unconditionally to simplify the logic.  See attached patch.
> >
> > Your patch looks correct for me except 2 things:
>
> Thanks for reviewing.
>
> > 1) you have lost "data->wpa = NULL;" when fuse_writepage_add() returns false.
>
> This is intentional, because this is in the !data->wpa branch.
>
> > 2) in the same case old code did not set data->orig_pages[ap->num_pages] = page;
>
> That is also intentional, in this case the origi_pages[0] is either
> overwritten with the next page or discarded due to data->wpa being
> NULL.
>
> I'll write these up in the patch header.
>

Did you sent out a new version of your patch?
If yes, where can I get it from?

- Sedat -
