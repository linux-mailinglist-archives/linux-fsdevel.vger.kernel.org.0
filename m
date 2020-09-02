Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22D725B34C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 20:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgIBSCy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 14:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBSCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:02:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3A4C061244
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2020 11:02:44 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so271443lfi.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2020 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Bg5CH27blnlQEY7ZbxyRfRPKR4l4nMrtwYSLut004w=;
        b=e/XkK5a4GY2Tn3MbbkgTERsousdPaUdiykBfWX/XJUbDL2HXb1RusFjSc4NyV3OXh2
         wUI1X7pU3VNBI/2kfCnv8Y0VVuJ6ZzYVOMPrfytgciQOG+JtztPD9+Ld3/lP8gGs2rXX
         TPmC3FG6W1QBLPFZmovrW+3ivTUJBX+tEcPl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Bg5CH27blnlQEY7ZbxyRfRPKR4l4nMrtwYSLut004w=;
        b=R/0px1qsqm7CiU9mIwxN5xgNzdwdCbUUo+zYp50FQscXu1CfH9v3IC6pKSHN7Q/EY1
         wTOkW0/eDQ08Z5pHj5uGI960hhZZBxU7mkLK5ZhwR0+HwOWkkIvcpWfsS4BMPUq8Jffe
         U4ZocAn+PYSzKy15VrkIjdATEY5dd/9GwVKgPMWtG+yDfABK307hNzyb2qw3FFB3vxKq
         ly8oa1Cf+Nt49R9qGzR268keCnzWnNl/i2AKuy5tNL/jnXRuOXyfYDKcry9Ikin93jSJ
         eV8GSJ1ruQNeHYgTA3Z5pE0ytNWc5DdVsTu9YwvGbN4TuiPQicuSMzzRldnsXgBFL0sJ
         dFSg==
X-Gm-Message-State: AOAM533unRx6YOqeC9y7hsp+b5FY8NUc56qFZFPRrl84IwmSzQGudfx+
        UMu9Px7UAr9HoIXIuRejPKg0JmuiryinDw==
X-Google-Smtp-Source: ABdhPJzGAX7Jnvt2ZKMEZhciserTuzZcp+IPeyfoe3guHaj3RTsBZGRaaPEziJL828eMcc/GBeFVvQ==
X-Received: by 2002:ac2:5597:: with SMTP id v23mr942049lfg.5.1599069761241;
        Wed, 02 Sep 2020 11:02:41 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id h19sm10072lfp.39.2020.09.02.11.02.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 11:02:39 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h19so169951ljg.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2020 11:02:38 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr3727925lju.102.1599069758523;
 Wed, 02 Sep 2020 11:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-11-hch@lst.de>
 <8974838a-a0b1-1806-4a3a-e983deda67ca@csgroup.eu> <20200902123646.GA31184@lst.de>
 <d78cb4be-48a9-a7c5-d9d1-d04d2a02b4c6@csgroup.eu>
In-Reply-To: <d78cb4be-48a9-a7c5-d9d1-d04d2a02b4c6@csgroup.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Sep 2020 11:02:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDCcxuHgENo3UtdFi2QW9B7yXvNpG5CtF=A6bc6PTTgA@mail.gmail.com>
Message-ID: <CAHk-=wiDCcxuHgENo3UtdFi2QW9B7yXvNpG5CtF=A6bc6PTTgA@mail.gmail.com>
Subject: Re: [PATCH 10/10] powerpc: remove address space overrides using set_fs()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 2, 2020 at 8:17 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
> With this fix, I get
>
> root@vgoippro:~# time dd if=/dev/zero of=/dev/null count=1M
> 536870912 bytes (512.0MB) copied, 6.776327 seconds, 75.6MB/s
>
> That's still far from the 91.7MB/s I get with 5.9-rc2, but better than
> the 65.8MB/s I got yesterday with your series. Still some way to go thought.

I don't see why this change would make any difference.

And btw, why do the 32-bit and 64-bit checks even differ? It's not
like the extra (single) instruction should even matter. I think the
main reason is that the simpler 64-bit case could stay as a macro
(because it only uses "addr" and "size" once), but honestly, that
"simplification" doesn't help when you then need to have that #ifdef
for the 32-bit case and an inline function anyway.

So why isn't it just

  static inline int __access_ok(unsigned long addr, unsigned long size)
  { return addr <= TASK_SIZE_MAX && size <= TASK_SIZE_MAX-addr; }

for both and be done with it?

The "size=0" check is only relevant for the "addr == TASK_SIZE_MAX"
case, and existed in the old code because it had that "-1" thing
becasue "seg.seg" was actually TASK_SIZE-1.

Now that we don't have any TASK_SIZE-1, zero isn't special any more.

However, I suspect a bigger reason for the actual performance
degradation would be the patch that makes things use "write_iter()"
for writing, even when a simpler "write()" exists.

For writing to /dev/null, the cost of setting up iterators and all the
pointless indirection is all kinds of stupid.

So I think "write()" should just go back to default to using
"->write()" rather than "->write_iter()" if the simpler case exists.

                   Linus
