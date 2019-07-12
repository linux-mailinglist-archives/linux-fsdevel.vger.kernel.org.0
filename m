Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6FE067101
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 16:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfGLOIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 10:08:16 -0400
Received: from verein.lst.de ([213.95.11.211]:38487 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfGLOIQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:08:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DF601227A81; Fri, 12 Jul 2019 16:08:12 +0200 (CEST)
Date:   Fri, 12 Jul 2019 16:08:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
Message-ID: <20190712140812.GA29628@lst.de>
References: <20190712053631.9814-1-bauerman@linux.ibm.com> <20190712053631.9814-4-bauerman@linux.ibm.com> <20190712150912.3097215e.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712150912.3097215e.pasic@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 03:09:12PM +0200, Halil Pasic wrote:
> This is the implementation for the guys that don't
> have ARCH_HAS_MEM_ENCRYPT.
> 
> Means sev_active() may not be used in such code after this
> patch. What about 
> 
> static inline bool force_dma_unencrypted(void)
> {
>         return sev_active();
> }
> 
> in kernel/dma/direct.c?

FYI, I have this pending in the dma-mapping tree:

http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/e67a5ed1f86f4370991c601f2fcad9ebf9e1eebb
