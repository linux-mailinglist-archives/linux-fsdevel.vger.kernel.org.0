Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9E46D0AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 11:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhLHKQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 05:16:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50718 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhLHKQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:16:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5277DB82058;
        Wed,  8 Dec 2021 10:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39A2C00446;
        Wed,  8 Dec 2021 10:12:53 +0000 (UTC)
Date:   Wed, 8 Dec 2021 11:12:50 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@kernel.org>
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
Subject: Re: [RFC 3/3] headers: repurpose linux/fs_types.h
Message-ID: <20211208101250.ndtt53bybrwgklad@wittgenstein>
References: <20211207150927.3042197-1-arnd@kernel.org>
 <20211207150927.3042197-4-arnd@kernel.org>
 <20211208100514.7egjy5hraziu4pme@wittgenstein>
 <CAK8P3a1zD=FY39vqWAjZH2yYYtvQMzFOCRayXuDae4H6sCWs1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1zD=FY39vqWAjZH2yYYtvQMzFOCRayXuDae4H6sCWs1w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 11:10:26AM +0100, Arnd Bergmann wrote:
> On Wed, Dec 8, 2021 at 11:05 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Tue, Dec 07, 2021 at 04:09:27PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > linux/fs_types.h traditionally describes the types of file systems we
> > > deal with, but the file name could also be interpreted to refer to
> > > data types used for interacting with file systems, similar to
> > > linux/spinlock_types.h or linux/mm_types.h.
> > >
> > > Splitting out the data type definitions from the generic header helps
> > > avoid excessive indirect include hierarchies, so steal this file
> > > name and repurpose it to contain the definitions for file, inode,
> > > address_space, super_block, file_lock, quota and filename, along with
> > > their respective callback operations, moving them out of linux/fs.h.
> > >
> > > The preprocessed linux/fs_types.h is now about 50KB, compared to
> > > over 1MB for the traditional linux/fs.h, and can be included from
> > > most other headers that currently rely on type definitions from
> > > linux/fs.h.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> >
> > I tried to apply the series to take a closer look but it fails to apply
> > cleanup down to v5.15 and any release after that. What's the base I
> > should use for this?
> 
> It is based on yesterday's linux-next plus additional patches I used
> for testing. Sorry about the extra troubles, but this was the most

No no, that's perfectly fine!

> convenient way for me, as it lets me find build regressions in random
> configs more easily when I have a base tree that builds randconfig
> warning-free.
> 
> The patches are at the top of my randconfig tree [1] at the moment,
> so you can try out that tree, or rebase the patches from there.
> 
>         Arnd
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=randconfig-5.17-next

Thanks for pointing me in the right direction.

Christian
