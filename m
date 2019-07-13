Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6745D678FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2019 09:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfGMH1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jul 2019 03:27:21 -0400
Received: from verein.lst.de ([213.95.11.211]:43722 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfGMH1V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jul 2019 03:27:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 241B668B02; Sat, 13 Jul 2019 09:27:18 +0200 (CEST)
Date:   Sat, 13 Jul 2019 09:27:17 +0200
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
Subject: Re: [PATCH 1/3] x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to
 arch/Kconfig
Message-ID: <20190713072717.GB17589@lst.de>
References: <20190713044554.28719-1-bauerman@linux.ibm.com> <20190713044554.28719-2-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713044554.28719-2-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 13, 2019 at 01:45:52AM -0300, Thiago Jung Bauermann wrote:
> powerpc is also going to use this feature, so put it in a generic location.

Looks good,

even without a third arch using it we should never habe symbols defined
under arch/$(ARCH) that are used in common code to start with.

Reviewed-by: Christoph Hellwig <hch@lst.de>
