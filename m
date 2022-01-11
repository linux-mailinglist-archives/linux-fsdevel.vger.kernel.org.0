Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED20848A5CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 03:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbiAKCoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 21:44:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57324 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244189AbiAKCoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:44:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD9F8B8181E;
        Tue, 11 Jan 2022 02:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B632C36AF3;
        Tue, 11 Jan 2022 02:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641869045;
        bh=ZU/rHB8FnpSXUsKne+pbLzZ+noAo0MmMuqR+JolfoEE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FIXZmAOcNHXQ7ZM8JZhHkhdBWZszVi+ECpPOUMS7Q2uAMUWdtSKJgKxm4iPtpaQ5x
         I21P4xp3+iDmYip4C+ATD3Hqnxzlkk/Y+fOC3iOZWcI+MAk1G6A6JbeyITPek/lmAz
         pnP/Qdgpq7CWUIHiMFxdqzslfvavEROTb5R2s9RhCijilg8mEIkXGHdcQroc6CN9GY
         MmBTswGCNQ7Dcolsem3eW0EaTRnKzPoPSa0G+/Xhq2TnZaSOhdNbMk8usIMM9zp34/
         iYYC2acRHzBNo+XfhlJmI0nEozUnX/UaLGUcwGJVd5qv1KqMl88lPx4k3JUHzNSEpi
         SMbg8w1JgJPaw==
Received: by mail-vk1-f174.google.com with SMTP id g5so5638757vkg.0;
        Mon, 10 Jan 2022 18:44:05 -0800 (PST)
X-Gm-Message-State: AOAM533rcPavlSW2iwxEo9a1OxPETZTFaQD1rGmfFnynYx4zW1kUZTAe
        nYWH/9yWVOgD/fkF1P0IRFP/KnZD6lDZqMnr5cM=
X-Google-Smtp-Source: ABdhPJxiL77rGTLuws5g7KGQ/X9mfhysvv2bOJP9MXedX7dnBC1sSY9bwxU9DL7TLgPk3W1o87rBKfppwaCBYGQoNO8=
X-Received: by 2002:a1f:e243:: with SMTP id z64mr1284031vkg.28.1641869044562;
 Mon, 10 Jan 2022 18:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20211228143958.3409187-1-guoren@kernel.org> <20211228143958.3409187-4-guoren@kernel.org>
 <CAK8P3a2zn9M6X09WsjJ9HYiS9WnO_YPCvJLSBk+HaH+yZHQqfA@mail.gmail.com>
In-Reply-To: <CAK8P3a2zn9M6X09WsjJ9HYiS9WnO_YPCvJLSBk+HaH+yZHQqfA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 11 Jan 2022 10:43:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTzUV1teCh0Avw7rTsrd=50atKGCdpQsVyEeUus1TeGjA@mail.gmail.com>
Message-ID: <CAJF2gTTzUV1teCh0Avw7rTsrd=50atKGCdpQsVyEeUus1TeGjA@mail.gmail.com>
Subject: Re: [PATCH V2 03/17] asm-generic: fcntl: compat: Remove duplicate definitions
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 10, 2022 at 9:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Dec 28, 2021 at 3:39 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Remove duplicate F_GETLK64,F_SETLK64,F_SETLKW64 definitions in
> > arch/*/include/asm/compat.h.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
>
> Unfortunately, this one does not look correct to me:
>
> > @@ -116,7 +116,7 @@
> >  #define F_GETSIG       11      /* for sockets. */
> >  #endif
> >
> > -#ifndef CONFIG_64BIT
> > +#if !defined(CONFIG_64BIT) || defined(CONFIG_COMPAT)
> >  #ifndef F_GETLK64
> >  #define F_GETLK64      12      /*  using 'struct flock64' */
> >  #define F_SETLK64      13
>
> The problem here is that include/uapi/ headers cannot contain checks for
> CONFIG_* symbols because those may have different meanings in user space
> compared to kernel.
>
> This is a preexisting problem in the header, but I think the change
> makes it worse.
>
> With the current behavior, user space will always see the definitions,
> unless it happens to have its own definition for CONFIG_64BIT already.
> On 64-bit parisc, this has the effect of defining the macros to the
> same values as F_SETOWN/F_SETSIG/F_GETSIG, which is potentially
> harmful. On MIPS, it uses values that are different from the 32-bit numbers
> but are otherwise unused. Everywhere else, we get the definition from
> the 32-bit architecture in user space, which will do nothing in the kernel.
>
> The correct check for a uapi header would be to test for
> __BITS_PER_LONG==32. We should probably do that here, but
> this won't help you move the definitions, and it is a user-visible change
> as the incorrect definition will no longer be visible. [Adding Jeff and Bruce
> (the flock mainainers) to Cc for additional feedback on this]
>
> For your series, I would suggest just moving the macro definitions to
> include/linux/compat.h along with the 'struct compat_flock64'
> definition, and leaving the duplicate one in the uapi header unchanged
> until we have decided on a solution.
Okay.

>
>         Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
