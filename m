Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D6B1CDEA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgEKPPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 11:15:39 -0400
Received: from verein.lst.de ([213.95.11.211]:36633 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbgEKPPj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 11:15:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 919CD68BFE; Mon, 11 May 2020 17:15:35 +0200 (CEST)
Date:   Mon, 11 May 2020 17:15:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        james.morse@arm.com, Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>,
        Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/31] arm64: fix the flush_icache_range arguments in
 machine_kexec
Message-ID: <20200511151535.GC28634@lst.de>
References: <20200510075510.987823-1-hch@lst.de> <20200510075510.987823-3-hch@lst.de> <20200511075115.GA16134@willie-the-truck> <20200511110014.GA19176@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511110014.GA19176@gaia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 12:00:14PM +0100, Catalin Marinas wrote:
> Anyway, I think Christoph's patch needs to go in with a fixes tag:
> 
> Fixes: d28f6df1305a ("arm64/kexec: Add core kexec support")
> Cc: <stable@vger.kernel.org> # 4.8.x-
> 
> and we'll change these functions/helpers going forward for arm64.
> 
> Happy to pick this up via the arm64 for-next/fixes branch.

Please do, there are no dependencies on it in this series (I originally
planned to switch flush_icache_range to pass a kernel pointer + len
instead of the strange unsigned long start and end.  That still looks
very useful, but the series already is way too large, so I'm going to
defer that change for another merge window).
