Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB41C212DBE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 22:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGBUSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 16:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGBUSL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:18:11 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC50C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 13:18:10 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k15so16967993lfc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKAvQ3x/jWOWfzX8imS+F5oUhVjtLTNjNSuHV7D48w8=;
        b=DbkIc3d98XP5MNyq8UNDBoqdCdN6zpg0tDrAIVNEKlHBrkulQdNCWA1kMFQ1JWAhdY
         D9gz+IcXmp0gFrT7uBcGwZNLc4wUtGiSlpOL0zA548LxhAFt3suKnCpuLomExQY2ykrW
         cglfpMCov0y4JxtIPrn8/cPBQMpAcOqVZ5MUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKAvQ3x/jWOWfzX8imS+F5oUhVjtLTNjNSuHV7D48w8=;
        b=AyU1trfj1uHCl1a8em9rrDFSS/Q4ikCDRS6aeqWMBIzVhpghBaNjIh3ema285jOEiP
         XA4mdDB8Vh7ScjIOcfT4fQKpirnb7oTbctaM6HI8TF7p02+ZQiBrXADSr3G8wjOFWN8U
         YRXoQI/gPOcWeQoT0zNx7Wog5Wdth8Rc3C2YGe1i7eNRFjQ7WyhUGz8w3933j20XWw6W
         LEv4nD8mO6ixi8AH2UR87m+XSvr+En76uSPnvEtHE/IEnpX95eHXhhoWXzdwCIytqgd6
         e5OBYTaAmThNuvOItjc76grFvvjtHVPmAwqkenBo2j5EjtF3CgPDC+rL1cDS0gLUK01m
         b6TQ==
X-Gm-Message-State: AOAM530Srj7S9TEFEeVsPBArRGdvRHYb5NGdnAjQONvjLgqcHxnpcY8h
        AxMq7rj+VZoqwLhSrFXf/NJgg0JUvlY=
X-Google-Smtp-Source: ABdhPJwXc7hsgNIOOYaUzKCMd9tON7Y/089sGLHUNHQLpAJfavwHaX5aN21YgZYy20pFr06C9isajg==
X-Received: by 2002:a19:a8c:: with SMTP id 134mr19701964lfk.128.1593721089084;
        Thu, 02 Jul 2020 13:18:09 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id s4sm3757344lfc.71.2020.07.02.13.18.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 13:18:08 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id k17so4204490lfg.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 13:18:08 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr19422159lfd.31.1593721087764;
 Thu, 02 Jul 2020 13:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com> <20200702165120.1469875-3-agruenba@redhat.com>
 <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com> <CAHc6FU5_JnK=LHtLL9or6E2+XMwNgmftdM_V71hDqk8apawC4A@mail.gmail.com>
In-Reply-To: <CAHc6FU5_JnK=LHtLL9or6E2+XMwNgmftdM_V71hDqk8apawC4A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 13:17:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDA9wm09e1aOSwqq9=e5iTEP5ncheux=C=p62h7dWvbA@mail.gmail.com>
Message-ID: <CAHk-=wiDA9wm09e1aOSwqq9=e5iTEP5ncheux=C=p62h7dWvbA@mail.gmail.com>
Subject: Re: [RFC 2/4] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 2, 2020 at 12:58 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> > Of course, if you want to avoid both new reads to be submitted _and_
> > avoid waiting for existing pending reads, you should just set both
> > flags, and you get the semantics you want. So for your case, this may
> > not make any difference.
>
> Indeed, in the gfs2 case, waiting for existing pending reads should be
> fine. I'll send an update after some testing.

Do note that "wait for pending reads" very much does imply "wait for
those reads to _complete_".

And maybe the IO completion handler itself ends up having to finalize
something and take the lock to do that?

So in that case, even just "waiting" will cause a deadlock. Not
because the waiter itself needs the lock, but because the thing it
waits for might possibly need it.

But in many simple cases, IO completion shouldn't need any filesystem
locks. I just don't know the gfs2 code at all, so I'm not even going
to guess. I just wanted to mention it.

               Linus
