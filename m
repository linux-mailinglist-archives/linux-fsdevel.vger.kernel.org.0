Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2C13CF82D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbhGTKD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237147AbhGTKAY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:00:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5868861164;
        Tue, 20 Jul 2021 10:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777662;
        bh=4s1TWTt76qRpgxqGLG3ECURvPwDdmde2L0cc0V1Nzl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjTycZ7NrG/8A653VSiTI9QzOUgubyNpeVz8ztAnXS3/sD+TsdymCG5YBFngHjko/
         0vU1hiHB8yINU1COiLepq4MbCkgTmKIWY8FfJ0H+POLFYCKEnQrRlZiLduxvn5cpg2
         Aa7iybfoRMX2f77TU/NBYdek6pqPbWSC2PiUnqCUWx/HVsBwwKlG/LEAjyBC1i7h6S
         jP0WcsBWpoi/GVrDr1Dc0etIWTFRi3zr5qEDw2RxN31bxTlYP4LyDg1wB51gxfOovx
         UNZp5FuwPuibM7MzcEc7Fj1+0qJvIXY6+7KMD3XHBzVipjdREOWh+Dkiw5z0Zf/XiN
         blTR8T0zlJG2Q==
Date:   Tue, 20 Jul 2021 13:40:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 004/138] mm/vmstat: Add functions to account folio
 statistics
Message-ID: <YPaoN/pAUYsNZJnE@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-5-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:50AM +0100, Matthew Wilcox (Oracle) wrote:
> Allow page counters to be more readily modified by callers which have
> a folio.  Name these wrappers with 'stat' instead of 'state' as requested
> by Linus here:
> https://lore.kernel.org/linux-mm/CAHk-=wj847SudR-kt+46fT3+xFFgiwpgThvm7DJWGdi4cVrbnQ@mail.gmail.com/
> No change to generated code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/vmstat.h | 107 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

