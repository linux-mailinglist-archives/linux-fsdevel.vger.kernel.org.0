Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39252B2D0F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 13:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKNMPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 07:15:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgKNMPY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 07:15:24 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D4BE221EB;
        Sat, 14 Nov 2020 12:15:20 +0000 (UTC)
Date:   Sat, 14 Nov 2020 12:15:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH v2 09/13] arm, arm64: move free_unused_memmap() to
 generic mm
Message-ID: <20201114121516.GA2837@gaia>
References: <20201101170454.9567-1-rppt@kernel.org>
 <20201101170454.9567-10-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101170454.9567-10-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 01, 2020 at 07:04:50PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> ARM and ARM64 free unused parts of the memory map just before the
> initialization of the page allocator. To allow holes in the memory map both
> architectures overload pfn_valid() and define HAVE_ARCH_PFN_VALID.
> 
> Allowing holes in the memory map for FLATMEM may be useful for small
> machines, such as ARC and m68k and will enable those architectures to cease
> using DISCONTIGMEM and still support more than one memory bank.
> 
> Move the functions that free unused memory map to generic mm and enable
> them in case HAVE_ARCH_PFN_VALID=y.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
