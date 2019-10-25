Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3EEE4703
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 11:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438394AbfJYJWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 05:22:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39904 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfJYJWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:22:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id r141so1248177wme.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PfqliZqABV3UsTDy2zU07vmRMCPw1vao/MUlumm510w=;
        b=RfYNgqIjvxtbeNB6ezmyTbjhf2mFiK/aXcfRNtqPd+JjyF1Raw+WuF1mxB2sZ+itH4
         hV61UjIqYM6Cc7qsoQthLgsubenanLk/M6sYbN+y9GVnQBzFmukconFRKE/2HaORQmUx
         Dc+c5+slGSqm78s3KtFPcyiwrvCFoLMFBWhtfX1kl0J8TKneVYgf29scaeaV/n2xFv0t
         v0OeefTvYuRGhDnaqDANuqAntaBeigZ9Oc4xMBsD16OzP40y+tA9mtpsS6BKBnUCiQ3q
         IgQ9LrSyHRKgjAVijCSEk+UIsv3OQK8yc0ZjMIAJuFIhUHsYlKZHoJhPuAFMUovyqWko
         Qpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PfqliZqABV3UsTDy2zU07vmRMCPw1vao/MUlumm510w=;
        b=AHA+LZakpOHmdh0WdjiaR+Nwf7qOf0IsY2nKny6FmwUkgUPhFiswogPx5eBInc3t3J
         oR9YFjjHPMZZwor3uVZVL0Y4z6NZQHUO3fR3YNdEJV9mvAPWiBQo9sFwdQOvCosAptFq
         3efBbL4gcvFAU2pm/H6HneuszNK1iByb6uapueaZWNR5zi6KbhrH2vnu9vLFvAvEQSlV
         37m7IpsfoQ3hp1AYtO6SN9ao7gOtZAFwUg7c9Ds3h1iuxzEihMlUAWov+Go6n2GxIbw7
         qsqXOU2wFuFGnbmmFns3B60j+EW+Kd9GgaLhdsNHpOeDeQhM6pTMza9w4KchmMISLxB/
         PCUA==
X-Gm-Message-State: APjAAAWwZoU/L01Igr0jmn2kK9llS+2hcp58YILGYTawW3gxL1iIL878
        9+ZgzxoW1mwGVgfyTzD++U+GxmLqvMRwtSzc9uR3e71uHam4Ww==
X-Google-Smtp-Source: APXvYqwgFVIKJC+2BncS+mpp23JfPKBXSi5fImtlBQXMRiPvrQBLa0tYwutbxl59AeHn/y1k9Q+eutnzEMyI5sFEuJc=
X-Received: by 2002:a7b:c416:: with SMTP id k22mr593736wmi.106.1571995358868;
 Fri, 25 Oct 2019 02:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <20191023171611.qfcwfce2roe3k3qw@pali> <CAFLxGvxCVNy0yj8SQmtOyk5xcmYag1rxe3v7GtbEj8fF1iPp5g@mail.gmail.com>
 <CAJCQCtTEN50uNmuSz9jW5Kk51TLmB2jfbNGxceNqnjBVvMD9ZA@mail.gmail.com>
 <CAFLxGvwDraUwZOeWyGfVAOh+MxHgOF--hMu6P4J=P6KRspGsAA@mail.gmail.com>
 <CAJCQCtQhCRPG-UV+pcraCLXM5cVW887uX1UoymQ8=3Mk56w1Ag@mail.gmail.com>
 <854944926.38488.1571955377425.JavaMail.zimbra@nod.at> <CAJCQCtSsLRVPV3dn-XN1QgidVUC6pUrXDWDbtE2XhobKUo6fqA@mail.gmail.com>
 <1758125728.38509.1571956392152.JavaMail.zimbra@nod.at>
In-Reply-To: <1758125728.38509.1571956392152.JavaMail.zimbra@nod.at>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 25 Oct 2019 11:22:17 +0200
Message-ID: <CAJCQCtTU3NXrg=yVosYcj6F6NQLQ21hO3Xd=ta=JCZWjRUh8QQ@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
To:     Richard Weinberger <richard@nod.at>
Cc:     Chris Murphy <lists@colorremedies.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 25, 2019 at 12:33 AM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> >> U-boot, for example. Of course it does not so for any filesystem, but =
whe=3D
> > re
> >> it is needed and makes sense.
> >
> > Really? uboot does journal replay on ext3/4? I think at this point the
> > most common file system on Linux distros is unquestionably ext4, and
> > the most common bootloader is GRUB and for sure GRUB is no doing
> > journal replay on anything, including ext4.
>
> For ext4 it does a replay when you start to write to it.

That strikes me as weird. The bootloader will read from the file
system before it writes, and possibly get the wrong view of the file
system's true state because journal replay wasn't done.

> > Yeah that's got its own difficulties, including the way distro build
> > systems work. I'm not opposed to it, but it's a practical barrier to
> > adoption. I'd almost say it's easier to make Btrfs $BOOT compulsory,
> > make static ESP compulsory, and voila!
>
> I really don't get your point. I thought you are designing a "sane"
> system which can tolerate powercuts down an update.
> Why care about distros?
> The approach with Linux being a "bootloader" is common for embedded/secur=
e
> systems.

I want something as generic as possible, so as many use cases have
reliable kernel/bootloader updates as possible, so that fewer users
experience systems face planting following such updates. Any system
can experience an unscheduled, unclean shutdown. Exceptions to the
generic case should be rare and pretty much be about handling hardware
edge cases.


--=20
Chris Murphy
