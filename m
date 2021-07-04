Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8213BAF0C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 22:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGDUot (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 16:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGDUos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 16:44:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7782FC061762
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jul 2021 13:42:11 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u25so21686795ljj.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksLHrWRSt1VNjvN6bc4/KOwJ4T3qDcXRPZ+IP2o5+QE=;
        b=QD+ir9k0F2OONnvTr+UhKJ/sIggattJ7zVPZJl47DjBfvS3pHKa4toN+gcL3pK14pv
         H/CQq49jDcTxGqwfSwbICgN6GoYwjpm/aQsz7b8xm2SxSTtVIX1WiywveZbxFy0EjBTW
         O3f3pAVnZSTbWVQPlRP9iKBXrE5lrWtRyiKho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksLHrWRSt1VNjvN6bc4/KOwJ4T3qDcXRPZ+IP2o5+QE=;
        b=s7ByfZ+qkbM42sEc0xYjB/28Fh+BYXq6eMkmCfcLyhTiE0Wa9N2dqyK3wJpMQwwa/h
         2XehBNLNCL1V7QGuhsk9c4TUQ/xmYoSjf6m61xrMadv2Zyz5eO6ZuRrjfe1wwsaIK7Zr
         gWaO5vgf+44VzQC2/hr3+p67jmAMtuRMK8cDPFVuXIyl6CfCJEP2SfKb77gNACjOFoVq
         ScBZvO3nlgMNGP9xnMJYnpO961gpvFcqShDFVHMF3qH0tEncJpKfw5BT8kpeew6uJBB1
         Q2lzlg0hyzNCjSDykI8qcsuUouuav2bMhvxeP0QUdEuQqbBUoAsfaAuczPPQrIyNQY7r
         06Eg==
X-Gm-Message-State: AOAM531evnxzBrGeU5RtxkdLVRq5ZBKEvi9zbtzE1ULDZV4TYKi8cMC2
        oJ84UsU4ONIaIGN3kC35czoMXaKaRcXhqHvt
X-Google-Smtp-Source: ABdhPJxMgJPD7X72Hk4FqEO73kObTmJDFjbgqMODnPn73eXB2iPxUHb1x6uqSuWQSzvsAUDwpQ36lw==
X-Received: by 2002:a05:651c:1254:: with SMTP id h20mr8662962ljh.430.1625431329617;
        Sun, 04 Jul 2021 13:42:09 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id v12sm1103053ljv.65.2021.07.04.13.42.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 13:42:08 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id a18so28608227lfs.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 13:42:08 -0700 (PDT)
X-Received: by 2002:ac2:4903:: with SMTP id n3mr7674859lfi.487.1625431327793;
 Sun, 04 Jul 2021 13:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210704172948.GA1730187@roeck-us.net> <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
 <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net> <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
 <19689998-9dfe-76a8-30d4-162648e04480@roeck-us.net>
In-Reply-To: <19689998-9dfe-76a8-30d4-162648e04480@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 13:41:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0Q8R_3AxZO-34Gp2sEQAGUKhw7t6g4QtsnSxJTxb7WA@mail.gmail.com>
Message-ID: <CAHk-=wj0Q8R_3AxZO-34Gp2sEQAGUKhw7t6g4QtsnSxJTxb7WA@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 4, 2021 at 1:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Turns out that, at least on m68k/nommu, USER_DS and KERNEL_DS are the same.
>
> #define USER_DS         MAKE_MM_SEG(TASK_SIZE)
> #define KERNEL_DS       MAKE_MM_SEG(0xFFFFFFFF)

Ahh. So the code is fine, it's just that "uaccess_kernel()" isn't
something that can be reliably even tested for, and it will always
return true on those nommu platforms.

And we don't have a "uaccess_user()" macro that would test if it
matches USER_DS (and that also would always return true on those
configurations), so we can't just change the

        WARN_ON_ONCE(uaccess_kernel());

into a

        WARN_ON_ONCE(!uaccess_user());

instead.

Very annoying. Basically, every single use of "uaccess_kernel()" is unreliable.

There aren't all that many of them, and most of them are irrelevant
for no-mmu anyway (like the bpf tracing ones, or mm/memory.c). So this
iov_iter.c case is likely the only one that would be an issue.

That warning is something that should go away eventually anyway, but I
_like_ that warning for now, just to get coverage. But apparently it's
just not going to be the case for these situations.

My inclination is to keep it around for a while - to see if it catches
anything else - but remove it for the final 5.14 release because of
these nommu issues.

Of course, I will almost certainly not remember to do that unless
somebody reminds me...

The other alternative would be to just make nommu platforms that have
KERNEL_DS==USER_DS simply do

    #define uaccess_kernel() (false)

and avoid it that way, since that's closer to what the modern
non-CONFIG_SET_FS world view is, and is what include/linux/uaccess.h
does for that case..

               Linus
