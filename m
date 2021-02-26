Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36343261D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 12:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBZLPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 06:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhBZLOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:14:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB2C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Feb 2021 03:14:10 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k66so7460074wmf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Feb 2021 03:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=y49VM4vxrIluoWZYygAbeWpFWX4C8YemeYTsHwW6ByM=;
        b=e0z0W3vusltMyQI2YMbnnSAP9ts5ejDyxbUXibTlDhVQEuFd1yh80IHICiq8g32yZ7
         DkZDHKMfgs3WjRwE6r2Oflb06pgFUKwgeigFKZIwY0kmdr+9A9EkCNsNE6pM6Mr15Msh
         +WRFsDxvpNNLkZYG52bbJOe501lFywxKV6mT1AIORD+Pr2Eg8gxW9OeN+nX8qFwYMtwO
         ChebSgA5u2RbIJBsDPtjd/sBdi/t668rjGRvRONCVFyze7lpUI91IlEx2jBfem1w6eXM
         +CcnkmHE0o+kXrqgIRmsR/YWX5EN2CzTK0yyNoDrfIWnsl6btUCe7pDqhdzM20S5oWoe
         i/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=y49VM4vxrIluoWZYygAbeWpFWX4C8YemeYTsHwW6ByM=;
        b=QFDadyyx1Z3c2H8TJM1rtLUF7CyKHCxE7ER+UOoc4GCyOo9fY287J/6kni8ZBXNKKb
         0FGYlTyqiG0RvObzghhffz3rGfa9jv4NeLcN4BIx/lFY1YTwnT4d7xJwdR8fZpt+LV0Z
         kwh5AbP5WBUQjwSfVCt8blTD2eUgv6S8Yg0oBVFSwhzjnZacB/1GXydyGjqo/WgP6++x
         fsm1FztG5xB/Y8rxz9Kt1oC7R6ipUKAxNKtYu9t6qe3tqrRGJvQhycOSvokqjkDWO76M
         otlwwD8x8qdnKCRjUZ644EC6oJHpyf99T5aVvtOoTa9XSACzqVulb7Zo+BsfJaut7zKn
         PKyw==
X-Gm-Message-State: AOAM533QsdwIiTtFHwZUp9Zd75DXPUxIIHqE7RyxqhdabON1MDcipW3v
        E5jvbGK3FgJSBqeHOqDLWOmc0g==
X-Google-Smtp-Source: ABdhPJwCfNGIDUxCyYbBE+DNvq9cfNw0MP1Excp4gOjjTHDYnSTRaf31JOdRW4YErP21q1J/j3BhJQ==
X-Received: by 2002:a05:600c:4f07:: with SMTP id l7mr2288044wmq.141.1614338049188;
        Fri, 26 Feb 2021 03:14:09 -0800 (PST)
Received: from ?IPv6:2a01:e34:ec4b:6d50:b813:aeab:baca:27d? ([2a01:e34:ec4b:6d50:b813:aeab:baca:27d])
        by smtp.gmail.com with ESMTPSA id h19sm10623401wmq.47.2021.02.26.03.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 03:14:08 -0800 (PST)
Message-ID: <d2ca20d40dfe23304072815f4733ffc25b7967cb.camel@freebox.fr>
Subject: Re: [BUG] KASAN: global-out-of-bounds in
 __fuse_write_file_get.isra.0+0x81/0xe0
From:   Marios Makassikis <mmakassikis@freebox.fr>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Date:   Fri, 26 Feb 2021 12:14:08 +0100
In-Reply-To: <CAJfpegsJ0kWcGS1Si1dWHmpORKk3c7PUNO2tJdh3_W2YWmY5gg@mail.gmail.com>
References: <CAF6XXKWCwqSa72p+iQjg4QSBmAkX4Y5DxGrRR1tW1ar2uthd=w@mail.gmail.com>
         <CAJfpegsJ0kWcGS1Si1dWHmpORKk3c7PUNO2tJdh3_W2YWmY5gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-02-22 at 11:43 +0100, Miklos Szeredi wrote:
> On Sun, Feb 21, 2021 at 2:30 AM Marios Makassikis
> <mmakassikis@freebox.fr> wrote:
> > Hello,
> > 
> > I hope this is the correct list to report this bug I've been
> > seeing.
> > 
> > Background: I am testing a kernel SMB server implementation
> > ("ksmbd": https://github.com/cifsd-team/cifsd).
> > 
> > As part of my tests, I tried having a Windows client store a backup
> > on a SMB
> > share that is backed by an NTFS formatted disk. In doing so, the
> > kernel
> > reports a BUG and locks up (either immediately, or after a few
> > minutes).
> 
> Seems like fi->write_files list gets corrupted.
> 
> Is list debugging turned on?
> 
> Can you get a crashdump, and see if the rest of the fi structure is
> okay?
> 
> Thanks,
> Miklos

Hello Miklos,

I managed to get a crashdump, but couldn't get the crash utility to
work (I fed it the kernel and the crashdump but it exited without any
error message and I didn't get a chance to figure out what was wrong).

Meanwhile, a fix was committed on ksmbd with which I cannot reproduce
the issue [1]. Previously, the i_mutex lock was not held in
set_file_basic_info(): I'm guessing this is what caused the list
corruption.

Marios

[1] 
https://github.com/cifsd-team/cifsd/commit/5e929125e519acaf48abc4c42f8389caa26c4d5a

