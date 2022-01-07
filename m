Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D27E487659
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 12:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347031AbiAGLUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 06:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237721AbiAGLUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:20:11 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ADFC061245;
        Fri,  7 Jan 2022 03:20:11 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t32so5201871pgm.7;
        Fri, 07 Jan 2022 03:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5V2o61eWDAqOXcsRe6/XgMQ5T1T2V+4fY1qcRTcYrWA=;
        b=dmel9QbML+hRkxqAxsjXKi/G1CKnpFHxOh41J9gB+etNt4UfC2Q7EqVpHguXdfIYea
         jo0e05LRR6HnCnMgFoTI6yTSCLKbAKEEWhXAcEcSZMI9MBtUK18W0D2udvo19LmNLBux
         3ADjKMUAAhEPEc+qd2QfFCdElPzR4L2s/My9txaygB+BgAJLltTa6EKcmljGN2qnYy2c
         8ziwEQPgbhwrCOoHQvOjPtWKhqsh2/jpq3iSMXAhYQTCWf3uDUGg9vflKV6V9Z+69ZqW
         4YYRr/2oSZXPE3O5c9P0XSgZjGkMUeLzOScd7uHlGRhpWDPahaYkZTTUoOSobycgwprh
         z9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5V2o61eWDAqOXcsRe6/XgMQ5T1T2V+4fY1qcRTcYrWA=;
        b=2J/V9hdW4Xj16DD13dXw+H6/hJVxORTjbA9pwTKa7SPYn2XjI9+SHgIFKm/+9SHNC8
         b3ki0rwfrr0/s5l8fdWPL9DrvT2XIiVfWpF2lxb1AUlHEHNe5vmIlwU0DREud1YVZ8Aj
         G9hTmpsdn2Yo7L4H/zLup3WjHA+ua9DZ33CLdy+YjarokvwmaJ+SACbZyZyPP7KfTH3d
         n7zO5uy1FnTSCULizZ2EhHsh+JDm4QNPIvleOu6IN+K/BfnbTgQM0G4Q52q6SEl7pQzl
         iO4JC4XV5y6a/Tv9WBywqgWLBR5lwsAbjZ2jbwmoEqtlCKpQH+XnQeAJ1yL/tFgdl1aL
         10AA==
X-Gm-Message-State: AOAM530UdvwPe/rGNkDSsLvtfgEy+kkFUzRlaA63Dl21rgHkWrsfXAUw
        2vMNfAY1nMbrP5s+45wVXC0=
X-Google-Smtp-Source: ABdhPJwS8i6iyuX0/y+5MDM+0BNxr5UYrpsDhUf3e+diuS5EI3aS4hNwaNwH24cHMs9oCTeskUODRA==
X-Received: by 2002:a62:7a42:0:b0:4ba:5289:1f18 with SMTP id v63-20020a627a42000000b004ba52891f18mr63745171pfc.54.1641554410613;
        Fri, 07 Jan 2022 03:20:10 -0800 (PST)
Received: from gmail.com (113x33x71x97.ap113.ftth.ucom.ne.jp. [113.33.71.97])
        by smtp.gmail.com with ESMTPSA id m14sm5312821pff.151.2022.01.07.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 03:20:10 -0800 (PST)
Date:   Fri, 7 Jan 2022 20:20:05 +0900
From:   Akira Kawata <akirakawata1@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 RESEND 0/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF
 files
Message-ID: <20220107112005.gdvtvjvgqfs6umha@gmail.com>
References: <20220106232513.143014-1-akirakawata1@gmail.com>
 <CAKXUXMwzULZHmfx5T74cjG++gd8mFKVOR7Z4aS8RabKnXWGOdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMwzULZHmfx5T74cjG++gd8mFKVOR7Z4aS8RabKnXWGOdQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 07, 2022 at 07:40:50AM +0100, Lukas Bulwahn wrote:
> On Fri, Jan 7, 2022 at 12:25 AM Akira Kawata <akirakawata1@gmail.com> wrote:
> >
> >  These patches fix a bug in AT_PHDR calculation.
> >
> >  We cannot calculate AT_PHDR as the sum of load_addr and exec->e_phoff.
> >  This is because exec->e_phoff is the offset of PHDRs in the file and the
> >  address of PHDRs in the memory may differ from it. These patches fix the
> >  bug by calculating the address of program headers from PT_LOADs
> >  directly.
> >
> >  Sorry for my latency.
> >
> >  Changes in v4
> >  - Reflecting comments from Lukas, add a refactoring commit.
> >
> 
> Thanks for removing the dead store with your refactoring as a small
> stylistic change, but I really think that Kees Cook's comment that you
> simply removed an important feature is much more important to address.
> There was no reply to that and it seems that Kees hypothesis that the
> feature has been removed, was not questioned by anyone.
> 
> Lukas
> 

Thank you for your comments.

I will try to understand Kees Cook's comment again although I couldn't
it the last year.

Akira

> >  Changes in v3:
> >  - Fix a reported bug from kernel test robot.
> >
> >  Changes in v2:
> >  - Remove unused load_addr from create_elf_tables.
> >  - Improve the commit message. *** SUBJECT HERE ***
> >
> > Akira Kawata (2):
> >   fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
> >   fs/binfmt_elf: Refactor load_elf_binary function
> >
> >  fs/binfmt_elf.c | 36 +++++++++++++++++++++---------------
> >  1 file changed, 21 insertions(+), 15 deletions(-)
> >
> >
> > base-commit: 4eee8d0b64ecc3231040fa68ba750317ffca5c52
> > --
> > 2.25.1
> >
