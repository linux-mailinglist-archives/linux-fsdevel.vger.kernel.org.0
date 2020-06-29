Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1811820E5CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgF2Vl6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgF2Sh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547C3C033C36
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 11:29:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so19253169ljg.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dhvDgleJHHO6BJC9vWh9omDNPlG72DDBtGZ6h3AXGQ=;
        b=QG5+6qRC7nsdPcUZTLfS+NEfHK62YgjdIwfMGtYPHzfLaI4jEbzvOeQZzTdHo9hNak
         LckQojrFpUDhJ5X7+nsWLEKLjTAbP7X0XvFHCHDH8Rgwq9O5cIeAFY+lp4mLYcKtWp2g
         Yx3pvKuQpLIVMdrWZr5Woiwbrm+vUS5+GpPNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dhvDgleJHHO6BJC9vWh9omDNPlG72DDBtGZ6h3AXGQ=;
        b=cggUc7HNphfcYZtRNeXaFsKK7IiIzZAnfMYOappY6gQVS1SGPoFp7ghKgNY7KmtoEA
         Nqdha2ynNJreTv1buaVqlIrzKM+het66nl4o+2xcCselKaDUK1QchQSFeeIq/ru5zQXX
         WTKtju9iQc8xidGBo1/0rtkOWb4KLrzwcUMAaWiLUcuZd24e5T9J3FlzKCzvtwwVYkEa
         O2R6G+VtH7OufaTLRh59EB6YxYv5LE5uyuCfYegEHPLMQZuZrki8WR0ZPSCc2Gu8Y1Vv
         7qPMXuJllmgYFedlJS58sdlPsW+O8UkDn7bNgdLzUDgJjnIcwf5MphDTuz5QyPcal47p
         JZcQ==
X-Gm-Message-State: AOAM533EweWjmVPY4L72R3yl2qMh4/ald56pshrTzOERfBDq2H4w3Bf4
        Xdb0KCF1TXqjqtwEI73w47p4cEXXf98=
X-Google-Smtp-Source: ABdhPJyygiEz4rE34kbMCpDr/dmQPXaxdWuLYcHlnt/k4mqgFv4gAWyhP8wcJF7Ze8KQOVHY9mbsxw==
X-Received: by 2002:a2e:541b:: with SMTP id i27mr7950755ljb.118.1593455380164;
        Mon, 29 Jun 2020 11:29:40 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id x64sm99774lff.14.2020.06.29.11.29.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 11:29:39 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id h22so12123656lji.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 11:29:38 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr3886392lji.70.1593455378379;
 Mon, 29 Jun 2020 11:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
 <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com> <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com>
 <20200629152912.GA26172@lst.de> <CAHk-=wj_Br5dQt0GnMjHooSvBbVXwtGRVKQNkpCLwWjYko-4Zw@mail.gmail.com>
 <20200629180730.GA4600@lst.de>
In-Reply-To: <20200629180730.GA4600@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Jun 2020 11:29:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzz81Cjfn+SNbLT8WvRxfQYbiAemKrQ5jpNAgxxDQhZA@mail.gmail.com>
Message-ID: <CAHk-=whzz81Cjfn+SNbLT8WvRxfQYbiAemKrQ5jpNAgxxDQhZA@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:07 AM Christoph Hellwig <hch@lst.de> wrote:
>
> One issue is that a lot setsockopt calls are in the fast path, and
> even have micro-optimizations like putting an int on stack for the
> fast path to avoid the memory allocation.

Yeah., An the RFC patch I posted could easily be updated to do exactly
that for small optlen values (say, avoid the kmalloc and use a stack
buffer for oplen smaller than 16 bytes or whatever).

Most of the setsockopt's I'm aware of are just a single integer, so if
that's the bulk of them, then we'd never actually need to do the
kmalloc() in those cases, and only fall back to the kmalloc for the
(hopefully quite unusual) bigger options..

> I'd love to be able to do that.  And now that we want through this
> whole mess than Nth time I have another idea:
>
>  - we assume optlen is correct, which should cover about 90% of
>    the protocols
>  - but to override that a new setsockopt_len method is added that
>    returns the correct length for all the messy ones.
>
> Let me try if that works out.

Doing a quick grep, there's about 100 different ".setsockopt" function
initializers, but a quarter of them are just setting it to
'sock_no_setsockopt'.

A number of others are using 'sock_common_setsockopt'.

Which leaves something like 50 different implementations of the
.setsockopt functions.  But I didn't go any deeper than that - maybe
they then have hundreds of different option cases each and this is all
a nightmare.

Looking at a couple of them, the "int val" situation does seem to be
the most common one by _far_, and is often handled by a common
"get_user()" thing, so converting them to just getting the thing as a
kernel pointer doesn't look _too_ nasty, because even when they have a
lot of subcases, the actual optval accesses are much fewer.

Which is not to say that it looks all that much fun, but it doesn't
look entirely undoable either.

The good news (I guess) is that any missed transformation will be
fairly obvious (ie somebody uses a "get_user()" on what is now a
kernel pointer, and returns -EFAULT. So it shouldn't cause any subtle
failures, and it shouldn't cause any security issues.

I didn't look at the compat cases, but if anything I'd expect those to
become simpler by having kernel pointers. And there doesn't actually
seem to be that many of them (possibly because the "int" case si so
common that it all ends up being the same?)

              Linus
