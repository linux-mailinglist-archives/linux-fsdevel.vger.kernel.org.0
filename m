Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB796168627
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgBUSKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:10:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46075 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBUSKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:10:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so2780971otp.12;
        Fri, 21 Feb 2020 10:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qELWbZ3OME+eawe8woS99jFnT/ZWJQ9RWB1O2eshdZI=;
        b=D0jVYgTJoNaNoh1mzedHxmFllaxGztLRgy/MAXKGcIB3bo0RjTflVa5SjRywnr1kDX
         oMWNuNqpcL1GiuDg9yQ9HBQa+7405BMCf/nweBlMRwrEFjzCZFwOgmIG/0OtVBT1x6xQ
         jKXCSrtU7EkiuSRCB5YtURWXLBOleNpP/DL15Fw5zRm3e+i98EwlxIJiyslHWwVlBqCK
         xY0txbIPdg09rQ8fMtb+VfdyoySRSSpr0SSyZV/vDJb/X48XQEQ9W/ZEctHEfWpdzOJQ
         j9z5IGaP866h9DGZzIVFbJr9AUTPSrzcECYw8Sdc2xLIzAerqExSTMRtC+DjcZeV9aXk
         CdHQ==
X-Gm-Message-State: APjAAAUqCgmLWZ10rkUgbKqpVi8u0KK9qIhhFsYaYiTojSDMwtuDeaAw
        DKOfFsQUhaD97paX0J8vsGLlPEsnz5pxGZ79IPw=
X-Google-Smtp-Source: APXvYqxb9cV0wG/g8cyygeZEQ7pZMeU5TFO075xmmuOHqr2e/W1z8hmDsMW9M4REXAbbE3WfdgCvPdrCl0BGKC6R8Ro=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr29710943otm.297.1582308646955;
 Fri, 21 Feb 2020 10:10:46 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204551308.3299825.11782813238111590104.stgit@warthog.procyon.org.uk> <20200221145114.satmwy7u6mqfluzs@wittgenstein>
In-Reply-To: <20200221145114.satmwy7u6mqfluzs@wittgenstein>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Feb 2020 19:10:35 +0100
Message-ID: <CAMuHMdX2zjj6CXm9j-+ORAQfLb=VBM_dOsb4wNDzPECzqiXzYQ@mail.gmail.com>
Subject: Re: [PATCH 02/19] fsinfo: Add syscalls to other arches [ver #16]
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        mszeredi@redhat.com, Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 3:52 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Tue, Feb 18, 2020 at 05:05:13PM +0000, David Howells wrote:
> > Add the fsinfo syscall to the other arches.
>
> Over the last couple of kernel releases we have established the
> convention that we wire-up a syscall for all arches at the same time and
> not e.g. x86 and then the other separately.

Indeed.

> > Signed-off-by: David Howells <dhowells@redhat.com>
> > ---
> >
> >  arch/alpha/kernel/syscalls/syscall.tbl      |    1 +
> >  arch/arm/tools/syscall.tbl                  |    1 +
> >  arch/arm64/include/asm/unistd.h             |    2 +-
> >  arch/arm64/include/asm/unistd32.h           |    2 +-
> >  arch/ia64/kernel/syscalls/syscall.tbl       |    1 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |    2 ++

Suspicious diffstat...

> >  arch/microblaze/kernel/syscalls/syscall.tbl |    1 +
> >  arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 +
> >  arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 +
> >  arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |    1 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |    1 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |    1 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |    1 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |    1 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |    1 +
> >  16 files changed, 17 insertions(+), 2 deletions(-)

> > --- a/arch/m68k/kernel/syscalls/syscall.tbl
> > +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> > @@ -437,3 +437,5 @@
> >  435  common  clone3                          __sys_clone3
> >  437  common  openat2                         sys_openat2
> >  438  common  pidfd_getfd                     sys_pidfd_getfd
> > +# 435 reserved for clone3

Indeed, bogus line above (bad rebase?).

> > +439  common  fsinfo                          sys_fsinfo

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
