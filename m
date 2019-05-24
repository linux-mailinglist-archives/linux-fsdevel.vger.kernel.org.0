Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C3629E39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391575AbfEXSjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 14:39:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53754 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391503AbfEXSjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 14:39:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id 198so10335086wme.3;
        Fri, 24 May 2019 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XPIocXIouKTkDsq9ddFn0FmCiChIBO5fjAM9DzsJTdI=;
        b=JR5MiP/3E9KQlEPkbf3bVjuNDWCTim/dDnUDdeHtj2t23smeutLwGwSM82p0foiJjC
         zd1+4hVWxyUapvHWgRprJF5R53gBjY1sgDNyHM/hX/4tJ+/qlYVANvxOc1cz7zj8vR0H
         iuJXjY4cP56w8cXy3zZ/DdHqqvu7MAtiov6k2uZNqAgoV1tjiBn1MjYwq4sxDNU+28Fp
         isNJ5YtPNkpf/RiavhKB/dnqbbXxALqkSyanZBYu8MrX5oaw284o9tttcvcslU8v/12U
         4mm/zz69dt/Q/quPJBgQm+K1FKEi0pgn1qTmn6+1o7YSBkd64aJ8NCPgPFndCrrbVSGp
         uAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XPIocXIouKTkDsq9ddFn0FmCiChIBO5fjAM9DzsJTdI=;
        b=nt40z6z/hJOHQpb07nJJEL5NxsMh9t02uHVzaz8eXGfEZvMNjkTpQF7/75rBUqjDjJ
         9G7TA1Jyv95lkKL1jPbVm4VKyHOIC72W44Qo2eB6KKmA6s5YyM1k/N8vV9BPqnlnlfG/
         OIscNSehDP0flqohmqZqDXEo3Tmk16X6Vnvrx+qmjvGCBEduffjcor5VCj2e5FvodqeM
         qLemgx55R/pEYlHOLdqJO2wpduwvnoKiZioytTIBD6ZZy2/z5BlOZx/35grFSd4OJEld
         cjxtFz5h8Bw2Kbk3bbDxIiZ7UqCORhFpa/2eMXPGvRmJD2nX16TI0Hxw+Wjuf58esOUJ
         46Cg==
X-Gm-Message-State: APjAAAWXqn9iNSMgQOLmKc99KTpprfAncsmHl0uPOA/DzZcVPG8jNjHz
        GfWtGtyi/s91iK9bBf7CYfLB84I=
X-Google-Smtp-Source: APXvYqzabLjPZ3fgjYT9Ndl6TZFvmbx3G+FBLsYHbNLV3ZwNQt2+22w9Cnb2H9ePWUaT5qnzR/Hf/Q==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr974343wmc.130.1558723147084;
        Fri, 24 May 2019 11:39:07 -0700 (PDT)
Received: from avx2 ([46.53.250.220])
        by smtp.gmail.com with ESMTPSA id u2sm7748190wra.82.2019.05.24.11.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 11:39:06 -0700 (PDT)
Date:   Fri, 24 May 2019 21:39:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] close_range()
Message-ID: <20190524183903.GB2658@avx2>
References: <20190523182152.GA6875@avx2>
 <CAHk-=wj5YZQ=ox+T1kc4RWp3KP+4VvXzvr8vOBbqcht6cOXufw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj5YZQ=ox+T1kc4RWp3KP+4VvXzvr8vOBbqcht6cOXufw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 02:34:31PM -0700, Linus Torvalds wrote:
> On Thu, May 23, 2019 at 11:22 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > > This is v2 of this patchset.
> >
> > We've sent fdmap(2) back in the day:
> 
> Well, if the main point of the exercise is performance, then fdmap()
> is clearly inferior.

This is not true because there are other usecases.

Current equivalent is readdir() where getdents is essentially bulk fdmap()
with pretty-printing. glibc does getdents into 32KB buffer.

There was a bulk taskstats patch long before meltdown fiasco.

Unfortunately closerange() only closes ranges.
This is why I didn't even tried to send closefrom(2) from OpenBSD.

> Sadly, with all the HW security mitigation, system calls are no longer cheap.
> 
> Would there ever be any other reason to traverse unknown open files
> than to close them?

This is what lsof(1) does:

3140  openat(AT_FDCWD, "/proc/29499/fd", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 4
3140  fstat(4, {st_mode=S_IFDIR|0500, st_size=0, ...}) = 0
3140  getdents(4, /* 6 entries */, 32768) = 144
3140  readlink("/proc/29499/fd/0", "/dev/pts/4", 4096) = 10
3140  lstat("/proc/29499/fd/0", {st_mode=S_IFLNK|0700, st_size=64, ...}) = 0
3140  stat("/proc/29499/fd/0", {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 4), ...}) = 0
3140  openat(AT_FDCWD, "/proc/29499/fdinfo/0", O_RDONLY) = 7
3140  fstat(7, {st_mode=S_IFREG|0400, st_size=0, ...}) = 0
3140  read(7, "pos:\t0\nflags:\t02002\nmnt_id:\t24\n", 1024) = 31
3140  read(7, "", 1024)                 = 0
3140  close(7)
	...

Once fdmap(2) or equivalent is in, more bulk system calls operating on
descriptors can pop up. But closefrom() will remain closefrom().
