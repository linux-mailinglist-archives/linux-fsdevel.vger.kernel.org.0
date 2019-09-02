Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADBB2A4D6A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 05:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfIBDHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 23:07:30 -0400
Received: from ozlabs.org ([203.11.71.1]:39887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfIBDHa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:07:30 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46MFPW6NYNz9sDQ; Mon,  2 Sep 2019 13:07:27 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0c9c1d56397518eb823d458b00b06bcccd956794
In-Reply-To: <20190806044919.10622-2-bauerman@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>, x86@kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-s390@vger.kernel.org, Lianbo Jiang <lijiang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 1/6] x86, s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig
Message-Id: <46MFPW6NYNz9sDQ@ozlabs.org>
Date:   Mon,  2 Sep 2019 13:07:27 +1000 (AEST)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-08-06 at 04:49:14 UTC, Thiago Jung Bauermann wrote:
> powerpc is also going to use this feature, so put it in a generic location.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Series applied to powerpc topic/mem-encrypt, thanks.

https://git.kernel.org/powerpc/c/0c9c1d56397518eb823d458b00b06bcccd956794

cheers
