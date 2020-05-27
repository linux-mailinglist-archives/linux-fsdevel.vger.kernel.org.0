Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3496D1E37C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 07:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgE0FKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 01:10:19 -0400
Received: from verein.lst.de ([213.95.11.211]:48230 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgE0FKS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 01:10:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 627CA68B02; Wed, 27 May 2020 07:10:12 +0200 (CEST)
Date:   Wed, 27 May 2020 07:10:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     hch@lst.de, akpm@linux-foundation.org, arnd@arndb.de,
        jeyu@kernel.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-fsdevel@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, monstr@monstr.eu,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        x86@kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] media: omap3isp: Shuffle cacheflush.h and include mm.h
Message-ID: <20200527051011.GB16317@lst.de>
References: <20200515143646.3857579-7-hch@lst.de> <20200527043426.3242439-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527043426.3242439-1-natechancellor@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 26, 2020 at 09:34:27PM -0700, Nathan Chancellor wrote:
> After mm.h was removed from the asm-generic version of cacheflush.h,
> s390 allyesconfig shows several warnings of the following nature:

Hmm, I'm pretty sure I sent the same fix a few days ago in response to
a build bot report.  But if that didn't get picked up I'm fine with
your version of it as well of course:

Acked-by: Christoph Hellwig <hch@lst.de>
