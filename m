Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9722CB7A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 09:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgLBIrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 03:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgLBIrX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:47:23 -0500
Date:   Wed, 2 Dec 2020 10:46:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606898802;
        bh=94peQvlH+hBFkVhR76D4mRi8ZR8/1ByW5biEamqyO8s=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=1XZ7zFaSliwlhII5xQGL58UEHcgfPl8ifWpLC21d9PiWt4Wn3VXYJdDyTj7w6X2md
         MpEirP7K0tuFRH3KcKitN19wAtelsrSZ5rdCzaeG4E+3Ff5fyjI5EWx3soQLa3xorR
         5oFJO77KbWQEaUSdt6fw028ASy22qWkQXEsiIexg=
From:   Mike Rapoport <rppt@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux MM <linux-mm@kvack.org>, Will Deacon <will@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>, Meelis Roos <mroos@linux.ee>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Matt Turner <mattst88@gmail.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
Message-ID: <20201202084628.GE751215@kernel.org>
References: <20201117062316.GB370813@kernel.org>
 <a7d01146-77f9-d363-af99-af3aee3789b4@physik.fu-berlin.de>
 <20201201102901.GF557259@kernel.org>
 <e3d5d791-8e4f-afcc-944c-24f66f329bd7@physik.fu-berlin.de>
 <20201201121033.GG557259@kernel.org>
 <49a2022c-f106-55ec-9390-41307a056517@physik.fu-berlin.de>
 <20201201135623.GA751215@kernel.org>
 <59351dbb-96cc-93b2-f2ec-b8968e935845@kernel.dk>
 <CAMuHMdWRc8W7U0LKyH9u1hdMuN515PCZiTEJ12FrDaCx-eTdaQ@mail.gmail.com>
 <20201202084326.GA26573@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202084326.GA26573@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 08:43:26AM +0000, Christoph Hellwig wrote:
> On Tue, Dec 01, 2020 at 04:33:01PM +0100, Geert Uytterhoeven wrote:
> > > That's a lot of typos in that patch... I wonder why the buildbot hasn't
> > > complained about this. Thanks for fixing this up! I'm going to fold this
> > > into the original to avoid the breakage.
> > 
> > Does lkp@intel.com do ia64 builds? Yes, it builds zx1_defconfig.
> 
> I've never got results.  Which is annoying, as debian doesn't ship an
> ia64 cross toolchain either, and I can't find any pre-built one that
> works for me.

Arnd publishes a bunch of cross compilers here:

https://mirrors.edge.kernel.org/pub/tools/crosstool/


-- 
Sincerely yours,
Mike.
