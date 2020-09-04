Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD325E13D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 19:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgIDR6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 13:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIDR62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 13:58:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B48FC061244;
        Fri,  4 Sep 2020 10:58:27 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n22so6978444edt.4;
        Fri, 04 Sep 2020 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xWrD3MuyolikZBdkT5ghr88RwiH+oj1SGO1EEE8/fK8=;
        b=fgQCIgRWO9koqQpJSZq0UUVMNjWdYYuTIm3HfndnOr8ei7WofSr0zy+yG8x0XPPYry
         syRVhzehT0ZIjLtJNng03oQjHxaMO3BEcdNUzsIkeTxfqetWTO2vTELR3ZpcuRrRZ5/L
         N1ZVac6a1zcGtBy3wgfNZYi9YASM4WHZtCE19VizJ1ypdJt7bMP1VGdbHtj/8jZHkrE/
         aMvFV3CsEjbwtu9wLUvO6dR+NlU9QQRfxsV5TjzRLcrBr4zIp6ijB35Q9TVuFQsjDP9E
         C9RKR7D19nIk6CCoFvQeImizIc1LJbdyP/98edlFpfyTem8uTC/SzpqJKf/5pt2FEhOI
         qBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xWrD3MuyolikZBdkT5ghr88RwiH+oj1SGO1EEE8/fK8=;
        b=J1PqSVAnaw9+4j7Fdyqz1/9nK0lCuA4fH24FkfzRCIroHRGjPquAst3C3XRRpeUhEA
         FToZwygNu7yBuqBMZSmfzksgEq5G2R7Al/rOeNcKtX4wkCEpm/JrzK6PKa79KDqxD9Oq
         bRRjTAId1z/2gHv1nzQq7b5FP2n2hGJAkwvQXrwh5biLHgnZZnQV/LRRfCoB0bPqSIYJ
         Lw43P/K+KnA2iKjFvRpqnykM3m6pfm/OfepdU7MnWRGpJfC+AAkjXbHCQitRGFDicDXM
         SJNIGSzbM5GDpp28DQydefuYEKED989UQHohsaC60edMQFVBqTFbHGGbAei3hL+xCSg9
         dCEg==
X-Gm-Message-State: AOAM531oYq72g/rGr3GEyIo7Q907FPMBCUb/zztj4tg/F3I2bQukul2Y
        Soqaorr2jhEpIKC37WycWA==
X-Google-Smtp-Source: ABdhPJwmF6eKN6yrdWqMeDA6ZaWPrS1RLQwm+PEUIDVhPMvcR0xkr1YXtb5BAvLBd7cgo66vO8NUpA==
X-Received: by 2002:aa7:d043:: with SMTP id n3mr9504016edo.243.1599242306081;
        Fri, 04 Sep 2020 10:58:26 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.136])
        by smtp.gmail.com with ESMTPSA id lo25sm6546522ejb.53.2020.09.04.10.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 10:58:25 -0700 (PDT)
Date:   Fri, 4 Sep 2020 20:58:23 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Message-ID: <20200904175823.GA500051@localhost.localdomain>
References: <20200903142242.925828-1-hch@lst.de>
 <20200904060024.GA2779810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200904060024.GA2779810@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 08:00:24AM +0200, Ingo Molnar wrote:
> * Christoph Hellwig <hch@lst.de> wrote:
> > this series removes the last set_fs() used to force a kernel address
> > space for the uaccess code in the kernel read/write/splice code, and then
> > stops implementing the address space overrides entirely for x86 and
> > powerpc.
> 
> Cool! For the x86 bits:
> 
>   Acked-by: Ingo Molnar <mingo@kernel.org>

set_fs() is older than some kernel hackers!

	$ cd linux-0.11/
	$ find . -type f -name '*.h' | xargs grep -e set_fs -w -n -A3
	./include/asm/segment.h:61:extern inline void set_fs(unsigned long val)
	./include/asm/segment.h-62-{
	./include/asm/segment.h-63-     __asm__("mov %0,%%fs"::"a" ((unsigned short) val));
	./include/asm/segment.h-64-}
