Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967751CDE77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 17:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgEKPL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 11:11:27 -0400
Received: from verein.lst.de ([213.95.11.211]:36580 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbgEKPL1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 11:11:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2865568BFE; Mon, 11 May 2020 17:11:21 +0200 (CEST)
Date:   Mon, 11 May 2020 17:11:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>,
        Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        the arch/x86 maintainers <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 31/31] module: move the set_fs hack for
 flush_icache_range to m68k
Message-ID: <20200511151120.GA28634@lst.de>
References: <20200510075510.987823-1-hch@lst.de> <20200510075510.987823-32-hch@lst.de> <CAMuHMdU_OxNoKfO=i903kx0mgk0-i2h4u2ase3m9_dn6oFh_5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU_OxNoKfO=i903kx0mgk0-i2h4u2ase3m9_dn6oFh_5g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 09:40:39AM +0200, Geert Uytterhoeven wrote:
> On Sun, May 10, 2020 at 9:57 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > flush_icache_range generally operates on kernel addresses, but for some
> > reason m68k needed a set_fs override.  Move that into the m68k code
> > insted of keeping it in the module loader.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Btw, do you know what part of flush_icache_range relied on set_fs?
Do any of the m68k maintainers have an idea how to handle that in
a nicer way when we can split the implementations?
