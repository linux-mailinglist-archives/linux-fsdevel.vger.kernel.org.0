Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1338893F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 09:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfHJHqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Aug 2019 03:46:08 -0400
Received: from verein.lst.de ([213.95.11.211]:32862 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfHJHqH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:46:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1E91468B02; Sat, 10 Aug 2019 09:46:02 +0200 (CEST)
Date:   Sat, 10 Aug 2019 09:46:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     mpe@ellerman.id.au
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
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v4 0/6] Remove x86-specific code from generic headers
Message-ID: <20190810074601.GA23926@lst.de>
References: <20190806044919.10622-1-bauerman@linux.ibm.com> <87sgqasdr6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgqasdr6.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 09, 2019 at 10:51:41PM +1000, mpe@ellerman.id.au wrote:
> I need to take this series via the powerpc tree because there is another
> fairly large powerpc specific series dependent on it.
> 
> I think this series already has pretty much all the acks it needs, which
> almost never happens, amazing work!
> 
> I'll put the series in a topic branch, just in case there's any bad
> conflicts and other folks want to merge it later on. I'll then merge the
> topic branch into my next, and so this series will be tested in
> linux-next that way.

Sounds good to me, I don't expect conflicts from the dma-mapping tree.
