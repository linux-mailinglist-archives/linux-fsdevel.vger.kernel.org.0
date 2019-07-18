Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FAB6CB0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 10:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbfGRImc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 04:42:32 -0400
Received: from verein.lst.de ([213.95.11.211]:57833 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGRImc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:42:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7AC8568B05; Thu, 18 Jul 2019 10:42:30 +0200 (CEST)
Date:   Thu, 18 Jul 2019 10:42:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v3 3/6] dma-mapping: Remove dma_check_mask()
Message-ID: <20190718084230.GB24562@lst.de>
References: <20190718032858.28744-1-bauerman@linux.ibm.com> <20190718032858.28744-4-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718032858.28744-4-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:28:55AM -0300, Thiago Jung Bauermann wrote:
> sme_active() is an x86-specific function so it's better not to call it from
> generic code. Christoph Hellwig mentioned that "There is no reason why we
> should have a special debug printk just for one specific reason why there
> is a requirement for a large DMA mask.", so just remove dma_check_mask().
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
