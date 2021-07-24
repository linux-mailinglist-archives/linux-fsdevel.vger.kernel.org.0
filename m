Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4503D49B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 21:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhGXTMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 15:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhGXTMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:12:22 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625ABC061757
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jul 2021 12:52:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l17so6125482ljn.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jul 2021 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpee2uSXjqYzurXDPtFtjsJbLcrcS7+O9pSXA980Af4=;
        b=MaXZzTxCAJIwowsCCE6Fdt5US9OP43caVSTixXGxGUe+EmHdqYjF8ACbPwZmUFZzTq
         ODWJwVvcv34qH8KZtMP1sfKtg9N4icSPWeZzKNUlGyB0noOzVBAqOVDZWwi0Ng2nf+r3
         4fEBuRnwf4eViJa+iNl8/P/Lcmilq1BHRdFNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpee2uSXjqYzurXDPtFtjsJbLcrcS7+O9pSXA980Af4=;
        b=mzAEZBLfBsOoJGnEJYgNo36B7X7ZMsB1qE1qw4HoSNlA42g4KhD0gGqE+MDXwQ3dcX
         SxwJ8+Y0b0ZDFthI+XXTtRJJhDe68UmvZT1AYXB7rOJsXFERjE5AkOhGbRRSMdQeAQ0i
         kq9YbdQROVn/nGwaWull3VL0D5xNGGtanezpwnypokU0igqyY6++sMz4PXt1Pha3F1/V
         h9B25SZsyUPAIBgYDZGE1U5i14C6CqGbWstmrKx0wEZ+XTXKIwLYAsh4VCP3dbp/amCH
         AfdQQJd7lKCmxVbCoqUx/PWgP9UuxlrQF4ngGi2sAMtpBHJceE7KZ93DKv23ZbRFlY9+
         N+Xw==
X-Gm-Message-State: AOAM532Cutsl9NeaRDZ0/T9ygohOOyzjxHyMaBGTDPWVIVSRH/CsGERa
        UAEyXycqhlYL9sTrnYmYKGiGsZREq3qlRhNX
X-Google-Smtp-Source: ABdhPJy9bZXLok6UNRmxveSLWX8iZ9h7/iBZnMgYgNFpRhzYoh9WpNxrqiXb0yNyvgS1gquk/KkjXg==
X-Received: by 2002:a05:651c:2105:: with SMTP id a5mr7376092ljq.259.1627156371679;
        Sat, 24 Jul 2021 12:52:51 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id d18sm3608007ljc.64.2021.07.24.12.52.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 12:52:50 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id a26so7925159lfr.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jul 2021 12:52:50 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr7023206lfa.421.1627156370007;
 Sat, 24 Jul 2021 12:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210724193449.361667-1-agruenba@redhat.com> <20210724193449.361667-2-agruenba@redhat.com>
In-Reply-To: <20210724193449.361667-2-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Jul 2021 12:52:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com>
Message-ID: <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable helper
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 24, 2021 at 12:35 PM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> +int iov_iter_fault_in_writeable(const struct iov_iter *i, size_t bytes)
> +{
...
> +                       if (fault_in_user_pages(start, len, true) != len)
> +                               return -EFAULT;

Looking at this once more, I think this is likely wrong.

Why?

Because any user can/should only care about at least *part* of the
area being writable.

Imagine that you're doing a large read. If the *first* page is
writable, you should still return the partial read, not -EFAULT.

So I think the code needs to return 0 if _any_ fault was successful.
Or perhaps return how much it was able to fault in. Because returning
-EFAULT if any of it failed seems wrong, and doesn't allow for partial
success being reported.

The other reaction I have is that you now only do the
iov_iter_fault_in_writeable, but then you make fault_in_user_pages()
still have that "bool write" argument.

We already have 'fault_in_pages_readable()', and that one is more
efficient (well, at least if the fault isn't needed it is). So it
would make more sense to just implement fault_in_pages_writable()
instead of that "fault_in_user_pages(, bool write)".

                 Linus
