Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012922B3AD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 01:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgKPAeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 19:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgKPAeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 19:34:20 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076ABC0613CF;
        Sun, 15 Nov 2020 16:34:20 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 81so3039080pgf.0;
        Sun, 15 Nov 2020 16:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K49blno/leH6jbGpd9F7WZwDQAl1Nwo/ZCkhX0FppDQ=;
        b=eweI/c81G681zHjBwP9UksLl6bAXnpfnYDfjT11Gmg0FwHWgR1zfBjB8nhxFvYxCZY
         ZGg7IBD3FgsK19By9Df1bmP1akKWCFfJ4kpeDMhHQ/fa0mm6WhQUU7UwJoZegj6UjKbR
         0cljAQ13Hum5DVncHMj1wMgaAzqTm4wH6hkwuACFEBdiBaZsnSL1YoBTqj4aaFlqdXNL
         V4eyYx7DtGZUZ3XpC8Wtnp7C+aPg04l8RwKmQ3hk2JRxEjTlVHUYdKIKFh4lVXGSWnoz
         a+NQuDF9hlpIGZO6E+FpOiKWeFJqjLgkFMXagIBCX8Zr5MMGWNaeFnRntGGAAg099DFG
         6ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K49blno/leH6jbGpd9F7WZwDQAl1Nwo/ZCkhX0FppDQ=;
        b=InG4/lo25B5UnXCxP9b9Dro9tVe/5n/w8KWtxJOoaEZXAxnZvjHPKNKppRuZn77Wel
         ohjYR4oCBWDhezJ1FBtY5i+BLshbsXs1paPLFtcVDvKIJNOwzEzNnrL7XmrQJ0Y/ni3z
         vn8ykGzJIbhsCQLN2X7kNeNbeu/4vDGo4a980Hy36TsJs/Z4FwL+lAC71o3aFs5LeGAt
         b6MTJEvAI7X5tXZviO6KJe2tqaZzNJvXmjDYUFBqWDha88Qg4uWbUWEoboLi77XHepOz
         29umUoWYQe5S7sTauP1pmAO+AOs4Y+1hgN8MZ1ZZJwHJyFIt6cj0M9WWbbnpU1xnNI0L
         0e/A==
X-Gm-Message-State: AOAM532mubb1nlHA/1oZ2hXONR71fXxnH6csL8WZvdrosqrCg27/EGRH
        vipB5+wxyf0sRwSYElQGlJg=
X-Google-Smtp-Source: ABdhPJyX/cQQwrkaKlrAvK1GzQe0piQKVIOFSPPWqX025AbQpVzOoID8luNHxj2pmDPQDLIk7Zyqeg==
X-Received: by 2002:a17:90a:fa8c:: with SMTP id cu12mr13256882pjb.127.1605486859425;
        Sun, 15 Nov 2020 16:34:19 -0800 (PST)
Received: from Ryzen-9-3900X.localdomain (ip68-98-75-144.ph.ph.cox.net. [68.98.75.144])
        by smtp.gmail.com with ESMTPSA id f21sm14278948pga.32.2020.11.15.16.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 16:34:18 -0800 (PST)
Date:   Sun, 15 Nov 2020 17:34:16 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201116003416.GA345@Ryzen-9-3900X.localdomain>
References: <20201114041420.GA231@Ryzen-9-3900X.localdomain>
 <20201114055048.GN3576660@ZenIV.linux.org.uk>
 <20201114061934.GA658@Ryzen-9-3900X.localdomain>
 <20201114070025.GO3576660@ZenIV.linux.org.uk>
 <20201114205000.GP3576660@ZenIV.linux.org.uk>
 <20201115155355.GR3576660@ZenIV.linux.org.uk>
 <20201115214125.GA317@Ryzen-9-3900X.localdomain>
 <20201115233814.GT3576660@ZenIV.linux.org.uk>
 <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116002513.GU3576660@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:25:13AM +0000, Al Viro wrote:
> On Sun, Nov 15, 2020 at 04:51:49PM -0700, Nathan Chancellor wrote:
> > Looks good to me on top of d4d50710a8b46082224376ef119a4dbb75b25c56,
> > thanks for quickly looking into this!
> > 
> > Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> OK... a variant with (hopefully) better comments and cleaned up
> logics in the second loop (
>                 if (seq_has_overflowed(m) || err) {
>                         m->count = offs;
>                         if (likely(err <= 0))
>                                 break;
>                 }
> replaced with
>                 if (err > 0) {          // ->show() says "skip it"
>                         m->count = offs;
>                 } else if (err || seq_has_overflowed(m)) {
>                         m->count = offs;
>                         break;
>                 }
> ) follows.  I'm quite certain that it is an equivalent transformation
> (seq_has_overflowed() has no side effects) and IMO it's slightly
> more readable that way.  Survives local beating; could you check if
> it's still OK with your testcase?  Equivalent transformation or not,
> I'd rather not slap anyone's Tested-by: on a modified variant of
> patch...

Still good.

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> BTW, is that call of readv() really coming from init?  And if it
> is, what version of init are you using?

I believe that it is but since this is WSL2, I believe that /init is a
proprietary Microsoft implementation, rather than systemd or another
init system:

https://wiki.ubuntu.com/WSL#Keeping_Ubuntu_Updated_in_WSL

So I am not sure how possible it is to see exactly what is going on or
getting it improved.

Cheers,
Nathan
