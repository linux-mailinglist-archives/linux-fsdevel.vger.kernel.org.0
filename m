Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF446D0A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 11:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhLHKOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 05:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhLHKOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:14:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747BC061746;
        Wed,  8 Dec 2021 02:10:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62437B8205A;
        Wed,  8 Dec 2021 10:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F739C341CD;
        Wed,  8 Dec 2021 10:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638958244;
        bh=OT+9Lch1JWqZwRccKmltklPXiQoLJCDosH5rT/lTSYU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CVtOyTH2Do4jQ8PReXxDHLrvU8c9RKZboTjMn/xT1W+182DjQhGvH3llmvz1ikQzp
         XqFJhbj07g5opNagd5y+n0nUC+cK1zDkfsClH8wCCeZAlAVbAUJfhMlrUM0Gy2aGot
         Ou6XS1gp/qVeLYhbAXM89jkc84XiJzm7Bgf6kdzevSpSvvPU49dUE/mHSMo0PPIzVF
         QBJhOo7v+I+ixNQIAqw4axPHA/zf0+dKQ5WhYGhpQeCInBLzs9KQyZpKqCxpic1pGn
         F7BhJTiaOT7eRuNUW2vhFO5msMExidrpy6M83epbhfnWQSRIUGePopFRBUFpeo9XeC
         5xzpi0bcAOUBg==
Received: by mail-wr1-f41.google.com with SMTP id a9so3117460wrr.8;
        Wed, 08 Dec 2021 02:10:44 -0800 (PST)
X-Gm-Message-State: AOAM530FJ7eIZptzRZoZonwDHVUrgL2ibRcwLDZ62eI0vaXoyioepnUw
        oFu5biBayQIC/EwOlKGzmeWv98pBtIFYw0WPg2A=
X-Google-Smtp-Source: ABdhPJxdcfE70fMjqC/LaTNmzXxGIcgZ39NJv8BbMprp0FSg5nCkJQQDL8Vsv2rrcLb1UlsXL3cowah1KZHpbW1d/54=
X-Received: by 2002:a5d:4107:: with SMTP id l7mr57730315wrp.209.1638958242470;
 Wed, 08 Dec 2021 02:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20211207150927.3042197-1-arnd@kernel.org> <20211207150927.3042197-4-arnd@kernel.org>
 <20211208100514.7egjy5hraziu4pme@wittgenstein>
In-Reply-To: <20211208100514.7egjy5hraziu4pme@wittgenstein>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 8 Dec 2021 11:10:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1zD=FY39vqWAjZH2yYYtvQMzFOCRayXuDae4H6sCWs1w@mail.gmail.com>
Message-ID: <CAK8P3a1zD=FY39vqWAjZH2yYYtvQMzFOCRayXuDae4H6sCWs1w@mail.gmail.com>
Subject: Re: [RFC 3/3] headers: repurpose linux/fs_types.h
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, kernelci@groups.io,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 8, 2021 at 11:05 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Dec 07, 2021 at 04:09:27PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > linux/fs_types.h traditionally describes the types of file systems we
> > deal with, but the file name could also be interpreted to refer to
> > data types used for interacting with file systems, similar to
> > linux/spinlock_types.h or linux/mm_types.h.
> >
> > Splitting out the data type definitions from the generic header helps
> > avoid excessive indirect include hierarchies, so steal this file
> > name and repurpose it to contain the definitions for file, inode,
> > address_space, super_block, file_lock, quota and filename, along with
> > their respective callback operations, moving them out of linux/fs.h.
> >
> > The preprocessed linux/fs_types.h is now about 50KB, compared to
> > over 1MB for the traditional linux/fs.h, and can be included from
> > most other headers that currently rely on type definitions from
> > linux/fs.h.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
>
> I tried to apply the series to take a closer look but it fails to apply
> cleanup down to v5.15 and any release after that. What's the base I
> should use for this?

It is based on yesterday's linux-next plus additional patches I used
for testing. Sorry about the extra troubles, but this was the most
convenient way for me, as it lets me find build regressions in random
configs more easily when I have a base tree that builds randconfig
warning-free.

The patches are at the top of my randconfig tree [1] at the moment,
so you can try out that tree, or rebase the patches from there.

        Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=randconfig-5.17-next
