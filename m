Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA0329633F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 19:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902228AbgJVRA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 13:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902209AbgJVRA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:00:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9558AC0613DA
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 10:00:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j7so1290751pgk.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPq1xxojTLCMg9dkpihVuEy7NB86hVAVpi/132X7kAw=;
        b=FaZk1syk0YMG3iZb8SLWxC2V/X6x12JUTFYfL5Y4vorI7cxebKk0A4wGmpbUSoSX7r
         Hs46zZ8QPE3GLHjpbq58EcQYAjpUsLiFd7rIWVJJucFcvXO83HQmjrAvVcsSpWuzKmDn
         Ir7y+Hx076Ra7VE3qkMs0wIP4MuvMyPqFMZD7ErBK/erglmryprKfIJjlK9s4TEK+eV0
         zi9+rcSPkS3oUdnHJUbiyp5gMYyTX6WkcGQdAuWCh4z6o6XxBzLh/IQ3EqBPjn/4zA8/
         /ycOC8rWbYoFZIzXS+kSVT0mB240mCkdd7OfRPndvUPHV4Kpd/AlMGehp4EnqX4ufYBk
         bELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPq1xxojTLCMg9dkpihVuEy7NB86hVAVpi/132X7kAw=;
        b=VCN/xFoIBXEtDJ3h7f7ojdceMjyaqdzQcOHXPXDxbqOYdIGYU4SRkFCdb8N6/MIk6p
         40isrgGIvR7kNJTkwi11aDr4Z90wolfM/EeIhEtwirU8r4hYASNCGzVYiQKw4NSe1+VY
         nnPfOWyDmApERpz/WKBUCxqpftfA9oTxsx8AyuaDOAKpcSW7Fus397JO5A1+2rkqCClA
         dMZ0andZib9X3phryio7WnwcEEJ1CID17o9kJ3xOKY0cMgiG13P9/3rs7VTk4HYRwhux
         suxaDHkUU1yxVDgLbqs0lObT5NKwc1gACTTH/rTomLdJ6StTENQKezOAD2teTHMIfqYj
         A7Tg==
X-Gm-Message-State: AOAM53371iy2FVSgKErK7xkaeBzQRBs9VV96GEtbRWLOTNhVBAdCHl+v
        M27RlqAWPANTqqQHP0ZP6FbRofppJY1CaQ6jOu9tfg==
X-Google-Smtp-Source: ABdhPJzMoyVci79YwTV4KRMhMNBvKksmGgmX62puAUjhkzpwpVCVuG2Q30QHXgEacyFzXNHAtggJkv+M7hW6xpUief0=
X-Received: by 2002:a62:6408:0:b029:154:dde2:a5eb with SMTP id
 y8-20020a6264080000b0290154dde2a5ebmr3767384pfb.30.1603386055586; Thu, 22 Oct
 2020 10:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <80a2e5fa-718a-8433-1ab0-dd5b3e3b5416@redhat.com>
 <5d2ecb24db1e415b8ff88261435386ec@AcuMS.aculab.com> <df2e0758-b8ed-5aec-6adc-a18f499c0179@redhat.com>
 <20201022090155.GA1483166@kroah.com> <e04d0c5d-e834-a15b-7844-44dcc82785cc@redhat.com>
 <a1533569-948a-1d5b-e231-5531aa988047@redhat.com> <bc0a091865f34700b9df332c6e9dcdfd@AcuMS.aculab.com>
 <5fd6003b-55a6-2c3c-9a28-8fd3a575ca78@redhat.com> <20201022132342.GB8781@lst.de>
 <8f1fff0c358b4b669d51cc80098dbba1@AcuMS.aculab.com> <20201022164040.GV20115@casper.infradead.org>
In-Reply-To: <20201022164040.GV20115@casper.infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Oct 2020 10:00:44 -0700
Message-ID: <CAKwvOdnq-yYLcF_coo=jMV-RH-SkuNp_kMB+KCBF5cz3PwiB8g@mail.gmail.com>
Subject: Re: Buggy commit tracked to: "Re: [PATCH 2/9] iov_iter: move
 rw_copy_check_uvector() into lib/iov_iter.c"
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 9:40 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Oct 22, 2020 at 04:35:17PM +0000, David Laight wrote:
> > Wait...
> > readv(2) defines:
> >       ssize_t readv(int fd, const struct iovec *iov, int iovcnt);
>
> It doesn't really matter what the manpage says.  What does the AOSP
> libc header say?

Same: https://android.googlesource.com/platform/bionic/+/refs/heads/master/libc/include/sys/uio.h#38

Theoretically someone could bypass libc to make a system call, right?

>
> > But the syscall is defined as:
> >
> > SYSCALL_DEFINE3(readv, unsigned long, fd, const struct iovec __user *, vec,
> >                 unsigned long, vlen)
> > {
> >         return do_readv(fd, vec, vlen, 0);
> > }
>


-- 
Thanks,
~Nick Desaulniers
