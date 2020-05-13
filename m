Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8C21D071C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 08:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgEMGXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 02:23:24 -0400
Received: from verein.lst.de ([213.95.11.211]:44438 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728913AbgEMGXY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 02:23:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E27C468C65; Wed, 13 May 2020 08:23:18 +0200 (CEST)
Date:   Wed, 13 May 2020 08:23:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, zippel@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        monstr@monstr.eu, jeyu@kernel.org, linux-ia64@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 19/31] riscv: use asm-generic/cacheflush.h
Message-ID: <20200513062318.GA24133@lst.de>
References: <20200510075510.987823-20-hch@lst.de> <mhng-8adbedbc-0f91-4291-9471-2df5eb7b802b@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-8adbedbc-0f91-4291-9471-2df5eb7b802b@palmerdabbelt-glaptop1>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 04:00:26PM -0700, Palmer Dabbelt wrote:
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> Were you trying to get these all in at once, or do you want me to take it into
> my tree?

Except for the small fixups at the beginning of the series this needs
to go in together.  I'll have to do at least another resend, and after
that I hope Andrew is going to pick it up.
