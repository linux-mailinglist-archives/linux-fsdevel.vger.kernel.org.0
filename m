Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2E54AAEED
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 12:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiBFLBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 06:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBFLBU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 06:01:20 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5687BC06173B;
        Sun,  6 Feb 2022 03:01:19 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id m10so14051610oie.2;
        Sun, 06 Feb 2022 03:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Sp9dIjaCT2IKnU+vS6s3zWbzVi8x53Aaun+Jmt04oA=;
        b=jOL1qgSLQBXElk0ZvqY+lTvvIOTiEGXCo3dPN84XYFRYSlCWr5jnwoaFY3wJgioI85
         hEFTzkZrvmo7CPRfqAzZNVARjzHe+1acVsC01R7Xv3TsPHA5dI6iQAobHoI6X9Vmm0VZ
         sb28E63NY9uInT6z/s4+aPHiQ5TX9EXvnrxLwypBw9ZjJEsKmPWDr1jyv6/EzoJ14/cH
         bA/GLbdK+Suu0Db84qA2pCc9/D6gms2D8IQa2xOhHaPDtVhkMQYNF3YdQs3ReJf1EFlS
         xS3y4N8nBYY5d4SLDrQPcHfDb+ZmOL05BUGwn+hmUm45oiXiDUrGx08aPCWEr97aZvbA
         Bv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Sp9dIjaCT2IKnU+vS6s3zWbzVi8x53Aaun+Jmt04oA=;
        b=p5MJOrPMUBHA2+5tQZoqrCFGqy12w8uJ8pYt9IuhQEbstvgZn7YaS19t2VepWJsIVU
         rOv2iMhLVbcfSVm7LIUSdvZHbkzwFif/jQ3OrTQwxL4Pmp5rsecxRBpgia2E52k9XdwR
         e66etS5nIenHDn7+NzjfuSHiBNhy0g64BQVh2Pu5RXQBdJrom+o8EN8GYJ7zgW8tjiAY
         LXjQl9yDTYMSCab0mFni/m9IX3DgBshsL/jpMNkB/ZxVAYTJk2tjPSBgxf+F4EAldDom
         EU9sBBDdgT/rmEmXGc8YRcc9EUyYlyUdQd8ge3DrtMEzW/3+idtxzQRsiuZJsXPS4lkB
         bXrw==
X-Gm-Message-State: AOAM530L8sTpwJ8zyCLdVEdeyQtNNBjaPMvRZX8pEKJdpT1F8Uo+kamW
        MLzmw6uon9XDx02f3MUUJQqcfhSGIhqIGyejJ+c=
X-Google-Smtp-Source: ABdhPJxcyv4L9qJpG07h88L2ljsvcgV7ux9MJmFjtbbAJ31JH0H7RGHDdhax4Vt2PQ/lmbSzIe4+sAtCd8vVC8e0RwY=
X-Received: by 2002:a05:6808:191a:: with SMTP id bf26mr5196454oib.111.1644145278655;
 Sun, 06 Feb 2022 03:01:18 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSwfTEaJ_O9Bv1CkLRnLWYoZ7NSS=5pzuQz4mUBE-PXQ5A@mail.gmail.com>
 <YfrX1BVIlIwiVYzs@casper.infradead.org> <CAOE4rSz1OTRYQPa4PUrQ-=cwSM3iVY977Uz_d77E2j-kH0G3rA@mail.gmail.com>
In-Reply-To: <CAOE4rSz1OTRYQPa4PUrQ-=cwSM3iVY977Uz_d77E2j-kH0G3rA@mail.gmail.com>
From:   FMDF <fmdefrancesco@gmail.com>
Date:   Sun, 6 Feb 2022 12:01:02 +0100
Message-ID: <CAPj211uKvndvR40Vjh9WAf4wRbaV5MSnmUsvDAEAKv3Q+2tDkA@mail.gmail.com>
Subject: Re: How to debug stuck read?
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, BTRFS <linux-btrfs@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 2, 2022 at 10:50 PM D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>=
 wrote:
>
> tre=C5=A1d., 2022. g. 2. febr., plkst. 21:13 =E2=80=94 lietot=C4=81js Mat=
thew Wilcox
> (<willy@infradead.org>) rakst=C4=ABja:
> >
> > On Wed, Feb 02, 2022 at 07:15:14PM +0200, D=C4=81vis Mos=C4=81ns wrote:
> > > I have a corrupted file on BTRFS which has CoW disabled thus no
> > > checksum. Trying to read this file causes the process to get stuck
> > > forever. It doesn't return EIO.
> > >
> > > How can I find out why it gets stuck?
> >
> > > $ cat /proc/3449/stack | ./scripts/decode_stacktrace.sh vmlinux
> > > folio_wait_bit_common (mm/filemap.c:1314)
> > > filemap_get_pages (mm/filemap.c:2622)
> > > filemap_read (mm/filemap.c:2676)
> > > new_sync_read (fs/read_write.c:401 (discriminator 1))
> >
> > folio_wait_bit_common() is where it waits for the page to be unlocked.
> > Probably the problem is that btrfs isn't unlocking the page on
> > seeing the error, so you don't get the -EIO returned?
>
>
> Yeah, but how to find where that happens.
> Anyway by pure luck I found memcpy that wrote outside of allocated
> memory and fixing that solved this issue but I still don't know how to
> debug this properly.
>
There is no special recipe for debugging "this properly" :)

You wrote that "by pure luck" you found a memcpy() that wrote beyond the
limit of allocated memory. I suppose that you found that faulty memcpy()
somewhere in one of the function listed in the stack trace.

That's the right approach! You read the calls chain and find out where some=
thing
looks wrong and then fix it. This is why stack traces are so helpful.

It was not "pure luck". I think that you did what developers usually do aft=
er
decoding a stack trace. If not, how did you find that faulty memcpy() burie=
d
somewhere in 40 millions lines of code?

it seems that you've found the right way to figure out the problems in code
that (probably) you had not ever worked on or read before you hit that bug.

Have you sent a patch to the LKML? If not, please do it.

Regards,

Fabio M. De Francesco
