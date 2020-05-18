Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1988A1D7946
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgERNEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 09:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgERNEw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 09:04:52 -0400
Received: from linux-8ccs.fritz.box (p57a239f2.dip0.t-ipconnect.de [87.162.57.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD592207D3;
        Mon, 18 May 2020 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589807091;
        bh=bQOel0Owh5Jsy7D7It/KRrP7k71oDOZIFpOrOzQ9AhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqZBNW7MWDqiTSCxmly8oMsUsg4WN7C2JY9aDcakJBGzWq/UP00eyjCdLpfBridZ5
         yEWjvi7dzrZTtKaXjd/2d6IuYc59csAsUVZSfRs5jq7Rr7rdKAsQZJF1Mc/s+At7dk
         CA/eN9nd7O70bEOB0H0VqgRfIrUmH9kT0XamFLi8=
Date:   Mon, 18 May 2020 15:04:44 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 29/29] module: move the set_fs hack for
 flush_icache_range to m68k
Message-ID: <20200518130444.GA21096@linux-8ccs.fritz.box>
References: <20200515143646.3857579-1-hch@lst.de>
 <20200515143646.3857579-30-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200515143646.3857579-30-hch@lst.de>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+++ Christoph Hellwig [15/05/20 16:36 +0200]:
>flush_icache_range generally operates on kernel addresses, but for some
>reason m68k needed a set_fs override.  Move that into the m68k code
>insted of keeping it in the module loader.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>---
> arch/m68k/mm/cache.c | 4 ++++
> kernel/module.c      | 8 --------
> 2 files changed, 4 insertions(+), 8 deletions(-)

Thanks for cleaning this up. For module.c:

Acked-by: Jessica Yu <jeyu@kernel.org>

