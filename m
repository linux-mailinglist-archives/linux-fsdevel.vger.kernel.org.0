Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D09867936
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2019 10:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfGMIIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jul 2019 04:08:35 -0400
Received: from verein.lst.de ([213.95.11.211]:43961 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfGMIIf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jul 2019 04:08:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 77F8B68B02; Sat, 13 Jul 2019 10:08:30 +0200 (CEST)
Date:   Sat, 13 Jul 2019 10:08:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
Message-ID: <20190713080829.GA17920@lst.de>
References: <20190712053631.9814-1-bauerman@linux.ibm.com> <20190712053631.9814-4-bauerman@linux.ibm.com> <20190712150912.3097215e.pasic@linux.ibm.com> <20190712140812.GA29628@lst.de> <20190712165153.78d49095.pasic@linux.ibm.com> <20190712151129.GA30636@lst.de> <20190712174249.33b74535.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712174249.33b74535.pasic@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 05:42:49PM +0200, Halil Pasic wrote:
> 
> Will do! I guess I should do the patch against the for-next branch of the
> dma-mapping tree. But that branch does not have the s390 support patches (yet?).
> To fix it I need both e67a5ed1f86f and 64e1f0c531d1 "s390/mm: force
> swiotlb for protected virtualization" (Halil Pasic, 2018-09-13). Or
> should I wait for e67a5ed1f86f landing in mainline?

I've rebased the dma-mapping for-next branch to latest mainline as of
today that has both commits.
