Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1C5401F33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbhIFRgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 13:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244123AbhIFRgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:36:12 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2CC061757
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Sep 2021 10:35:07 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id k124so2445165vke.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Sep 2021 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LAfMLMOCaNonQ9SvddUMtvbENytC7XW6k6EZsxVhBI=;
        b=oMu7GUXSq0YOKQAjYITOgbfYqsI7zghUU9ZouIIdtELgSYIB57fydrfCpKbtk0Jdyq
         DN9JNkdQSRaRfBY7/yNllcXCPjDziR5T3++AUUMXs3UjrvClSIqyNPf0p1E7fT8AV/Wv
         QzxwVq6M5VFp1isqss7uJZIRULDgEhK+7DhR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LAfMLMOCaNonQ9SvddUMtvbENytC7XW6k6EZsxVhBI=;
        b=QupBSoM18eLKUMY+H74CSvuViBzJ9dUDUZPjUYBaODWQlT0Skzht6eBDgi1TxZCBKz
         EK0aSMWLXqND0ydtYUx+RSqAznis3uVui9vt9+mLaokVDS6v+66Aa6QIkvSGcGFsfWwY
         GjwxwN9JYvj+vF2GfaUrVwzOI0lHiPGOkMA+n+SlArBk+BEX2Q++nqYOZ8m7P+hlHxvC
         Y2SvzrG5hIr9rIm5hrBEER1f51niisC5o+Ds6cFmlxVf02ZpVF9obSCZw2/Tbi4oW/0p
         L6DR0Wi5B/pG1DaaVtiQCuJNAAffNPYEHKkk2fP18pdCNJUKhiIeVF9kyfa9jYBaI1NW
         78zw==
X-Gm-Message-State: AOAM532pAkqMQZfK0wYT63F6KEEwKOLU9O3YVHhW36hAbeOVnvFTg1PJ
        dyPZJYyDljhMljxI658be9xcwV6d5mdDBcA0NoD4nw==
X-Google-Smtp-Source: ABdhPJyNU/8wBBVNNyV8HJ29LvMOtBG8HPAneZNfDZggv7Bdx7meb4TzuRuQH4PeZRI/mfqCr/7hpzqOcBlJpokYoyA=
X-Received: by 2002:a1f:46c4:: with SMTP id t187mr6123228vka.10.1630949706116;
 Mon, 06 Sep 2021 10:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bc92ac05cb4ead3e@google.com> <CAJfpeguqH3ukKeC9Rg66pUp_jWArn3rSBxkZozTVPmTnCf+d6g@mail.gmail.com>
 <CANpmjNM4pxRk0=B+RZzpbtvViV8zSJiamQeN_7mPn-NMxnYX=g@mail.gmail.com>
In-Reply-To: <CANpmjNM4pxRk0=B+RZzpbtvViV8zSJiamQeN_7mPn-NMxnYX=g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 Sep 2021 19:34:55 +0200
Message-ID: <CAJfpegvzgVwN_4a-ghtHSf-SCV5SEwv4aeURvK_qDzMmU2nA4Q@mail.gmail.com>
Subject: Re: [syzbot] linux-next test error: KASAN: null-ptr-deref Read in fuse_conn_put
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+b304e8cb713be5f9d4e1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Sept 2021 at 18:59, Marco Elver <elver@google.com> wrote:
>
> On Mon, 6 Sept 2021 at 13:56, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > Thanks,
> >
> > Force pushed fixed commit 660585b56e63 ("fuse: wait for writepages in
> > syncfs") to fuse.git#for-next.
> >
> > This is fixed as far as I'm concerned, not sure how to tell that to syzbot.
>
> Thanks -- we can let syzbot know:
>
> #syz fix: fuse: wait for writepages in syncfs
>
> (The syntax is just "#syz fix: <commit title>".)

Yeah, but that patch has several versions, one of which is broken.
Syzbot can't tell the difference just based on the title.

Thanks,
Miklos
