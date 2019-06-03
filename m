Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A930E336F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 19:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfFCRkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 13:40:08 -0400
Received: from foss.arm.com ([217.140.101.70]:56880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfFCRkI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:40:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81C7280D;
        Mon,  3 Jun 2019 10:40:07 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BC373F5AF;
        Mon,  3 Jun 2019 10:40:04 -0700 (PDT)
Date:   Mon, 3 Jun 2019 18:40:01 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 05/14] arm64, mm: Make randomization selected by
 generic topdown mmap layout
Message-ID: <20190603174001.GL63283@arrakis.emea.arm.com>
References: <20190526134746.9315-1-alex@ghiti.fr>
 <20190526134746.9315-6-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526134746.9315-6-alex@ghiti.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:47:37AM -0400, Alexandre Ghiti wrote:
> This commits selects ARCH_HAS_ELF_RANDOMIZE when an arch uses the generic
> topdown mmap layout functions so that this security feature is on by
> default.
> Note that this commit also removes the possibility for arm64 to have elf
> randomization and no MMU: without MMU, the security added by randomization
> is worth nothing.

Not planning on this anytime soon ;).

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
