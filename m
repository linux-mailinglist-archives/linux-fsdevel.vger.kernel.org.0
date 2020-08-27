Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67A254981
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgH0PcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:32:00 -0400
Received: from verein.lst.de ([213.95.11.211]:38724 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgH0Pb7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:31:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9011468BEB; Thu, 27 Aug 2020 17:31:55 +0200 (CEST)
Date:   Thu, 27 Aug 2020 17:31:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v2
Message-ID: <20200827153155.GA8661@lst.de>
References: <20200827150030.282762-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827150030.282762-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Diffstat:

Actually no diffstat here as David Howells pointed out.  Here we go:

 arch/Kconfig                           |    3 
 arch/alpha/Kconfig                     |    1 
 arch/arc/Kconfig                       |    1 
 arch/arm/Kconfig                       |    1 
 arch/arm64/Kconfig                     |    1 
 arch/c6x/Kconfig                       |    1 
 arch/csky/Kconfig                      |    1 
 arch/h8300/Kconfig                     |    1 
 arch/hexagon/Kconfig                   |    1 
 arch/ia64/Kconfig                      |    1 
 arch/m68k/Kconfig                      |    1 
 arch/microblaze/Kconfig                |    1 
 arch/mips/Kconfig                      |    1 
 arch/nds32/Kconfig                     |    1 
 arch/nios2/Kconfig                     |    1 
 arch/openrisc/Kconfig                  |    1 
 arch/parisc/Kconfig                    |    1 
 arch/powerpc/include/asm/processor.h   |    7 -
 arch/powerpc/include/asm/thread_info.h |    5 -
 arch/powerpc/include/asm/uaccess.h     |   78 ++++++++-----------
 arch/powerpc/kernel/signal.c           |    3 
 arch/powerpc/lib/sstep.c               |    6 -
 arch/riscv/Kconfig                     |    1 
 arch/s390/Kconfig                      |    1 
 arch/sh/Kconfig                        |    1 
 arch/sparc/Kconfig                     |    1 
 arch/um/Kconfig                        |    1 
 arch/x86/ia32/ia32_aout.c              |    1 
 arch/x86/include/asm/page_32_types.h   |   11 ++
 arch/x86/include/asm/page_64_types.h   |   38 +++++++++
 arch/x86/include/asm/processor.h       |   60 ---------------
 arch/x86/include/asm/thread_info.h     |    2 
 arch/x86/include/asm/uaccess.h         |   26 ------
 arch/x86/kernel/asm-offsets.c          |    3 
 arch/x86/lib/getuser.S                 |   28 ++++---
 arch/x86/lib/putuser.S                 |   21 +++--
 arch/xtensa/Kconfig                    |    1 
 drivers/misc/lkdtm/bugs.c              |    4 +
 drivers/misc/lkdtm/usercopy.c          |    4 +
 fs/read_write.c                        |   69 ++++++++++-------
 fs/splice.c                            |  130 +++------------------------------
 include/linux/fs.h                     |    2 
 include/linux/uaccess.h                |   18 ++++
 lib/test_bitmap.c                      |   10 ++
 44 files changed, 235 insertions(+), 316 deletions(-)
